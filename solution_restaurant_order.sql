-- find the number of items on the menu
SELECT COUNT(*) FROM menu_items;

-- What are the most expensive items on the menu?
SELECT item_name, price FROM menu_items
ORDER BY price DESC ;

-- What are the least expensive items on the menu?
SELECT item_name, price FROM menu_items
ORDER BY price ;

-- How many Italian dishes are on the menu? 
SELECT category, COUNT(*) AS num_items
FROM menu_items 
WHERE category = 'Italian' 
GROUP BY category

-- What are the most expensive Italian dishes on the menu?
SELECT item_name, Price FROM menu_items 
WHERE category = 'Italian' 
ORDER BY price DESC

-- What are the least expensive Italian dishes on the menu?
SELECT item_name, Price FROM menu_items 
WHERE category = 'Italian' 
ORDER BY price 

-- How many dishes are in each category? 
SELECT category, COUNT(*) AS num_items FROM menu_items
GROUP BY category

-- What is the average dish price within each category?
SELECT category, ROUND(AVG(price),2) AS avg_price FROM menu_items
GROUP BY category

-- View the order_details table
SELECT * FROM order_details;

-- What is the date range of the table?
SELECT MIN(order_date), MAX(order_date) FROM order_details

-- How many orders were made within this date range?
SELECT DISTINCT COUNT(order_details_id) FROM order_details

-- How many items were ordered within this date range?
SELECT COUNT(item_id) FROM order_details

-- Which orders had the most number of items?
SELECT order_id, COUNT(item_id) AS num_items FROM order_details 
GROUP BY order_id
ORDER BY num_items DESC

-- How many orders had more than 12 items?
SELECT COUNT (*) FROM (SELECT order_id, COUNT(item_id) AS num_items FROM order_details 
GROUP BY order_id
HAVING COUNT(item_id) > 12
ORDER BY num_items DESC) AS num_orders


-- Combine the menu_items and order_details tables into a single table
SELECT * FROM order_details o  
JOIN menu_items m
ON m.menu_item_id = o.item_id;

-- What were the most ordered items? What categories were they in?
SELECT item_name, category, COUNT(order_id) AS num_ord 
FROM menu_items m 
JOIN order_details o ON m.menu_item_id = o.item_id
GROUP BY item_name, category
ORDER BY num_ord DESC

-- What were the least ordered items? What categories were they in?
SELECT item_name, category, COUNT(order_id) 
AS num_ord FROM menu_items m 
JOIN order_details o
ON m.menu_item_id = o.item_id
GROUP BY item_name, category
ORDER BY num_ord

-- What were the top 5 orders that spent the most money?
SELECT order_id, SUM(price) AS total_amt 
FROM menu_items m JOIN order_details o 
ON m.menu_item_id = o.item_id
GROUP BY order_id ORDER BY total_amt DESC LIMIT 5

-- View the details of the highest spend order. Which specific items were purchased?
SELECT category, COUNT(item_id) AS num_item 
FROM menu_items m JOIN order_details o 
ON m.menu_item_id = o.item_id
WHERE order_id = 440 GROUP BY category ORDER BY num_item DESC

-- View the details of the top 5 highest spend orders
SELECT order_id, category, COUNT(item_id) AS num_item 
FROM menu_items m JOIN order_details o 
ON m.menu_item_id = o.item_id
WHERE order_id IN (440, 2075, 1957,330,2675)
GROUP BY order_id, category ORDER BY num_item DESC

-- How much was the most expensive order in the dataset? 
-- Type numbers only (no currency symbols) to two decimal points
SELECT ROUND(MAX(order_total), 2) AS most_expensive_order
FROM (SELECT od.order_id, SUM(mi.price) AS order_total
    FROM order_details od JOIN menu_items mi 
	ON od.item_id = mi.menu_item_id
    GROUP BY od.order_id) AS order_totals;



