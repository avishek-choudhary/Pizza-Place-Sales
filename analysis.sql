-- Q1. How many customers do we have each day? Are there any peak hours?

SELECT ROUND(COUNT(order_id)) AS num_of_orders, DATE_PART('DAY', date) AS day
FROM orders
GROUP BY 2
ORDER BY 1 DESC;

SELECT ROUND(COUNT(order_id)) AS num_of_orders, EXTRACT(HOUR FROM time) AS hour
FROM orders
GROUP BY 2
ORDER BY 1 DESC;

-- Q2. How many pizzas are typically in an order? Do we have any bestsellers?

SELECT quantity, COUNT(*) AS orders
FROM order_details 
GROUP BY quantity 
ORDER BY 2 DESC;

SELECT order_details.pizza_id, pizza_types.name, COUNT(*) AS orders 
FROM order_details 
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 1;

-- Q3. How much money did we make this year? Can we indentify any seasonality in the sales?

SELECT ROUND(SUM(price*od.quantity)) AS amount
FROM pizza
JOIN order_details od ON pizzas.pizza_id = od.pizza_id;

SELECT ROUND(COUNT(order_id)) AS num_of_orders, DATE_PART('QUARTER', date) AS quarter
FROM orders
GROUP BY 2
ORDER BY 1 DESC;

-- Q4. Are there any pizzas we should take of the menu, or any promotions we could leverage?

SELECT order_details.pizza_id, pizza_types.name, COUNT(*) AS orders 
FROM order_details 
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY 1, 2
ORDER BY 3 
LIMIT 5;
