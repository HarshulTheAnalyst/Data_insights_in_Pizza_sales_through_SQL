create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id) );

select *
from orders;

create table order_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id) );

-- Questions

-- 1. Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- 2. Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
-- 3. Identify the highest-priced pizza.

select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by 2 desc limit 1;

-- 4. Identify the most common pizza size ordered.

select quantity, count(order_details_id)
from order_details group by quantity;

select pizzas.size, count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size order by order_count desc
limit 1;

-- 5. List the top 5 most ordered pizza types along with their quantities.

select pizza_types.name, sum(order_details.quantity) as ordered_quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by ordered_quantity desc
limit 5;

-- Intermediate

-- 6. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity_per_category
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity_per_category DESC;

-- 7. Determine the distribution of orders by hour of the day.

select hour(order_time) as hour, count(order_id) as order_count
from orders
group by hour(order_time);

-- 8. Join relevant tables to find the category-wise distribution of pizzas.

select category, count(name) from pizza_types
group by category;

-- 9. Group the orders by date and calculate the average number of pizzas ordered per day.

select round(avg(quantity),0) as avg_pizzas_ordered_per_day from
(select orders.order_date, sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.order_date) as order_quantity;

-- 10. Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by 2 desc limit 3;

-- Advanced

-- 11. Calculate the percentage contribution of each pizza type to total revenue.

