# Data_insights_in_Pizza_sales_through_SQL

Leveraged **SQL** to extract valuable insights to fuel data-driven business strategies.

**Tasks**
--------------------------------------------------------------------------------------------------------------------------

1.) Retrieve the total number of orders placed.

2.) Calculate the total revenue generated from pizza sales.

3.) Identify the highest-priced pizza.

4.) Identify the most common pizza size ordered.

5.) List the top 5 most ordered pizza types along with their quantities.

6.) Join the necessary tables to find the total quantity of each pizza category ordered.

7.) Determine the distribution of orders by hour of the day.

8.) Join relevant tables to find the category-wise distribution of pizzas.

9.) Group the orders by date and calculate the average number of pizzas ordered per day.

10.) Determine the top 3 most ordered pizza types based on revenue.

11.) Calculate the percentage contribution of each pizza type to total revenue.

12.) Analyze the cumulative revenue generated over time.

13.) Determine the top 3 most ordered pizza types based on revenue for each pizza category.

**Analysis**
--------------------------------------------------------------------------------------------------------------------------

1.)  **Retrieve the total number of orders placed.**

-- Count the total number of orders in the 'orders' table

-- This query calculates the total number of rows in the 'orders' table by counting the 'order_id' field, and displays the result as 'total_orders'

**SELECT 
    COUNT**(order_id) **AS** total_orders
    
**FROM**
    orders;

![image](https://github.com/user-attachments/assets/d58014b2-2301-492b-a306-32f3fbeee632)


---------------------------------------------------------------------------------------------------------------------------------------------------------

2.) **Calculate the total revenue generated from pizza sales.**

-- Calculate the total revenue from pizza orders, rounded to 2 decimal places

-- This query calculates the total revenue by multiplying the quantity of each pizza (from 'order_details') by its price (from 'pizzas')

-- The result is then summed up for all orders and rounded to 2 decimal places, with the result displayed as 'total_revenue'

**SELECT 
    ROUND(SUM**(order_details.quantity * pizzas.price),
            2) **AS** total_revenue
            
**FROM**
    order_details
        **JOIN**
    pizzas **ON** pizzas.pizza_id = order_details.pizza_id;


![image](https://github.com/user-attachments/assets/2a698e9b-bfc6-4ad6-9508-296fa87c47e5)


---------------------------------------------------------------------------------------------------------------------------------------------------------

3.) **Identify the highest-priced pizza.**

-- Select the most expensive pizza type and its price

-- This query retrieves the name of the pizza type and the price of the pizza by joining the 'pizza_types' and 'pizzas' tables

-- The results are ordered by price in descending order, and the query limits the result to the most expensive pizza (LIMIT 1)


**SELECT** 
    pizza_types.name, pizzas.price
    
**FROM**
    pizza_types
        **JOIN**
    pizzas **ON** pizza_types.pizza_type_id = pizzas.pizza_type_id
**ORDER BY** 2 **DESC**
**LIMIT** 1;

![image](https://github.com/user-attachments/assets/233e4ba4-f980-4b5f-abe6-76ab2753fad1)


---------------------------------------------------------------------------------------------------------------------------------------------------------

4.) **Identify the most common pizza size ordered.**

-- Select the pizza size with the highest number of orders

-- This query counts the number of times each pizza size has been ordered by joining the 'pizzas' and 'order_details' tables

-- The results are grouped by pizza size, ordered by the count of orders in descending order, and limited to show only the size with the most orders
   (LIMIT 1)

**SELECT** 
    pizzas.size,
    **COUNT**(order_details.order_details_id) **AS** order_count
    
**FROM**
    pizzas
        **JOIN**
    order_details **ON** pizzas.pizza_id = order_details.pizza_id
**GROUP BY** pizzas.size
**ORDER BY** order_count **DESC**
**LIMIT** 1;

![image](https://github.com/user-attachments/assets/68d35a93-50d2-4612-9cdc-cbaffd92fb1e)


----------------------------------------------------------------------------------------------------------------------------------------------------------

5.) **List the top 5 most ordered pizza types along with their quantities.**

-- Select the top 5 most ordered pizza types along with their ordered quantities

-- This query calculates the total quantity ordered for each pizza type by joining the 'pizza_types', 'pizzas', and 'order_details' tables

-- The results are grouped by pizza type name, ordered by the total quantity in descending order, and limited to show only the top 5 pizza types (LIMIT 5)

**SELECT** 
    pizza_types.name,
    **SUM**(order_details.quantity) **AS** ordered_quantity
    
**FROM**
    pizza_types
        **JOIN**
    pizzas **ON** pizza_types.pizza_type_id = pizzas.pizza_type_id
        **JOIN**
    order_details ON order_details.pizza_id = pizzas.pizza_id
**GROUP BY** pizza_types.name
**ORDER BY** ordered_quantity **DESC**
**LIMIT** 5;

![image](https://github.com/user-attachments/assets/b8d1d3be-c058-4f32-be5c-6e65e072ddcc)


----------------------------------------------------------------------------------------------------------------------------------------------------------

6.) **Join the necessary tables to find the total quantity of each pizza category ordered.**

-- Select the total quantity of pizzas ordered per category

-- This query calculates the total quantity ordered for each pizza category by joining the 'pizza_types', 'pizzas', and 'order_details' tables

-- The results are grouped by pizza category, and ordered by the total quantity in descending order

**SELECT**
    pizza_types.category,
    **SUM**(order_details.quantity) **AS** quantity_per_category
    
**FROM**
    pizza_types
        **JOIN**
    pizzas **ON** pizza_types.pizza_type_id = pizzas.pizza_type_id
        **JOIN**
    order_details **ON** order_details.pizza_id = pizzas.pizza_id
**GROUP BY** pizza_types.category
**ORDER BY** quantity_per_category **DESC**;

![image](https://github.com/user-attachments/assets/dedcdf7a-34f4-4c2d-b076-8e4093766ebb)


----------------------------------------------------------------------------------------------------------------------------------------------------------

7.) **Determine the distribution of orders by hour of the day.**

-- Count the number of orders placed during each hour of the day

-- This query extracts the hour from the 'order_time' column and counts the number of orders for each hour

-- The results are grouped by hour, providing insight into order volume throughout the day

**SELECT** 
    **HOUR**(order_time) **AS** hour, **COUNT**(order_id) **AS** order_count
    
**FROM**
    orders
    
**GROUP BY** **HOUR**(order_time);

![image](https://github.com/user-attachments/assets/1e118b93-4252-42c7-99c7-58a114728217)


----------------------------------------------------------------------------------------------------------------------------------------------------------

8.) **Join relevant tables to find the category-wise distribution of pizzas.**

-- Count the number of pizza types in each category

-- This query counts the number of entries in the 'pizza_types' table for each pizza category

-- The results are grouped by the 'category' field to show how many pizza types belong to each category

**SELECT** 
    category, **COUNT**(name)
    
**FROM**
    pizza_types
    
**GROUP BY** category;

![image](https://github.com/user-attachments/assets/4dab57ab-3d52-4415-ad39-789b21cc2e96)


----------------------------------------------------------------------------------------------------------------------------------------------------------

9.) **Group the orders by date and calculate the average number of pizzas ordered per day.**

-- Calculate the average number of pizzas ordered per day, rounded to the nearest whole number

-- This query first aggregates the total quantity of pizzas ordered for each order date by summing the quantities in the 'order_details' table

-- It then computes the average of these daily quantities and rounds the result to 0 decimal places, displaying it as 'avg_pizzas_ordered_per_day'

**SELECT 
    ROUND(AVG**(quantity), 0) **AS** avg_pizzas_ordered_per_day
    
**FROM
    (SELECT** 
        orders.order_date, **SUM**(order_details.quantity) **AS** quantity        
    **FROM**
        orders
    **JOIN** order_details **ON** orders.order_id = order_details.order_id
    **GROUP BY** orders.order_date) **AS** order_quantity;

![image](https://github.com/user-attachments/assets/3d5384ae-9348-49e6-8b31-14bdc220ff12)


----------------------------------------------------------------------------------------------------------------------------------------------------------

10.) **Determine the top 3 most ordered pizza types based on revenue.**

-- Select the top 3 pizza types by revenue generated from orders

-- This query calculates the total revenue for each pizza type by multiplying the quantity ordered (from 'order_details') by the price of each 
   pizza (from 'pizzas')
   
-- The results are grouped by pizza type name, ordered by total revenue in descending order, and limited to the top 3 pizza types (LIMIT 3)

**SELECT** 
    pizza_types.name,
    **SUM**(order_details.quantity * pizzas.price) **AS** revenue
    
**FROM**
    pizza_types
        **JOIN**
    pizzas **ON** pizzas.pizza_type_id = pizza_types.pizza_type_id
        **JOIN**
    order_details **ON** order_details.pizza_id = pizzas.pizza_id
    
**GROUP BY** pizza_types.name
**ORDER BY 2 DESC**
**LIMIT** 3;

![image](https://github.com/user-attachments/assets/3235faac-c6e2-4bb9-aff5-4398613b3208)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------

11.) **Calculate the percentage contribution of each pizza type to total revenue.**

-- Calculate the percentage contribution of each pizza category to the total revenue

-- This query computes the total revenue for each pizza category by summing the product of quantity ordered (from 'order_details') and the price (from 'pizzas')

-- It then divides this category revenue by the overall total revenue (calculated in a subquery) and multiplies by 100 to get the percentage contribution

-- The result is rounded to 2 decimal places and is grouped by pizza category, ordered by percentage contribution in descending order

**SELECT** 
    pizza_types.category,
    **ROUND(SUM**(order_details.quantity * pizzas.price) / (**SELECT 
                    ROUND(SUM**(order_details.quantity * pizzas.price),
                                2) **AS** total_revenue
                **FROM**
                    order_details
                        **JOIN**
                    pizzas **ON** pizzas.pizza_id = order_details.pizza_id) * 100,
            2) **AS** percentage_contribution
            
**FROM**
    pizza_types
        **JOIN**
    pizzas **ON** pizza_types.pizza_type_id = pizzas.pizza_type_id
        **JOIN**
    order_details **ON** order_details.pizza_id = pizzas.pizza_id
**GROUP BY** pizza_types.category
**ORDER BY 2 DESC**;

![image](https://github.com/user-attachments/assets/06672b1b-3c70-4502-ad34-1597bed3f063)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------

12.) **Analyze the cumulative revenue generated over time.**

-- Calculate daily revenue and cumulative revenue from pizza orders

-- This Common Table Expression (CTE) named 'rolling_total' first computes the total revenue for each order date

-- by summing the product of quantity ordered (from 'order_details') and the price (from 'pizzas').

-- The outer query then selects the order date, daily revenue, and calculates the cumulative revenue

-- by summing the daily revenue ordered by order date, resulting in a rolling total of revenue over time.



**WITH** rolling_total **AS**

(
**SELECT** orders.order_date,

**SUM**(order_details.quantity * pizzas.price) **AS** revenue

**FROM** order_details **JOIN** pizzas

**ON** order_details.pizza_id = pizzas.pizza_id

**JOIN** orders

**ON** orders.order_id = order_details.order_id

**GROUP BY** orders.order_date)

**SELECT** order_date, revenue, **SUM**(revenue) **OVER**(**ORDER BY** order_date) **AS** cum_revenue

**FROM** rolling_total; 


<img width="258" alt="image" src="https://github.com/user-attachments/assets/fe069189-4f0c-46b0-a1d2-8f1e037b84cf">


-----------------------------------------------------------------------------------------------------------------------------------------------------------------

13.) **Determine the top 3 most ordered pizza types based on revenue for each pizza category.**

-- Select the top 3 pizzas by revenue for each category

-- This query consists of nested subqueries:

-- The innermost subquery calculates the total revenue for each pizza type by summing the product of quantity ordered (from 'order_details') and 
   the price (from 'pizzas').
   
-- It groups the results by pizza category and pizza name.

-- The middle subquery ranks the pizzas within each category based on their revenue using the RANK() window function.

-- The outer query then selects the category, pizza name, revenue, and the rank of each pizza,

-- filtering the results to include only the top 3 pizzas per category based on their revenue.




**SELECT** category, name, revenue,top_3_pizza_per_cat_based_on_revenue

**FROM**

(**SELECT** category, name, revenue,

**RANK**() **OVER(PARTITION BY** category **ORDER BY** revenue **DESC**) **AS** top_3_pizza_per_cat_based_on_revenue

**FROM**

(**SELECT** pizza_types.category, pizza_types.name,

**SUM**(order_details.quantity * pizzas.price) **AS** revenue

**FROM** pizza_types **JOIN** pizzas

**ON** pizza_types.pizza_type_id = pizzas.pizza_type_id

**JOIN** order_details

**ON** order_details.pizza_id = pizzas.pizza_id

**GROUP BY** pizza_types.category, pizza_types.name) **AS** a) **AS** b

**WHERE** top_3_pizza_per_cat_based_on_revenue <= 3;




<img width="432" alt="image" src="https://github.com/user-attachments/assets/d29dcae7-ee39-4a94-971e-aeb2a3016265">
