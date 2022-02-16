USE mockdb;

-- Create a query to return all orders made by users with the first name of “Marion"

SELECT o.* 
FROM orders o 
JOIN users u ON o.user_id = u.user_id 
WHERE FIRST_NAME = "Marion";


-- Create a query to select all users that have not made an order

SELECT u.* 
FROM users u 
LEFT JOIN orders o ON u.USER_ID = o.USER_ID 
WHERE o.USER_ID IS NULL;


-- Create a Query to select the names and prices of all items that have been part of 2 or more separate orders.

SELECT i.NAME, i.PRICE
FROM items i 
JOIN order_items oi ON i.ITEM_ID = oi.ITEM_ID 
GROUP BY i.NAME  
HAVING COUNT(oi.ORDER_ID) > 1;



-- Create a query to return the Order Id, Item name, Item Price, and Quantity from orders
-- made at stores in the city “New York”. Order by Order Id in ascending order.

SELECT oi.ORDER_ID, i.NAME, i.PRICE, oi.QUANTITY 
FROM order_items oi 
JOIN items i ON oi.ORDER_ID = i.ITEM_ID 
JOIN orders o ON oi.ORDER_ID = o.ORDER_ID 
JOIN stores s ON o.STORE_ID = s.STORE_ID 
WHERE s.CITY = "New York" 
ORDER BY oi.ORDER_ID; 



-- Your boss would like you to create a query that calculates the total revenue generated
-- by each item. Revenue for an item can be found as (Item Price * Total Quantity
-- Ordered). Please return the first column as ‘ITEM_NAME’ and the second column as ‘REVENUE’.

SELECT i.NAME AS 'ITEM_NAME', SUM(i.PRICE * oi.QUANTITY) AS 'REVENUE' 
FROM items i 
JOIN order_items oi ON i.ITEM_ID = oi.ITEM_ID 
GROUP BY i.NAME;



-- Create a query with the following output:
	
	-- a. Column 1 - Store Name
		-- i. The name of each store
	
	-- b. Column 2 - Order Quantity
		-- i. The number of times an order has been made in this store
	
	-- c. Column 3 - Sales Figure
-- 		i. If the store has been involved in more than 3 orders, mark as ‘High’
-- 		ii. If the store has been involved in less than 3 orders but more than 1 order, mark as ‘Medium’
-- 		iii. If the store has been involved with 1 or less orders, mark as ‘Low’
	
	-- d. Should be ordered by the Order Quantity in Descending Order

SELECT s.NAME AS 'Store Name', COUNT(DISTINCT o.ORDER_ID) AS 'Order Quantity', 
CASE
    WHEN COUNT(DISTINCT o.ORDER_ID) > 3 THEN 'High'
    WHEN COUNT(DISTINCT o.ORDER_ID)  <= 3 AND COUNT(DISTINCT o.ORDER_ID) > 1 THEN 'Medium'
    ELSE 'Low'
END AS 'Sales Figure'
FROM stores s 
JOIN orders o ON s.STORE_ID = o.STORE_ID 
GROUP BY `Store Name` 
ORDER BY `Order Quantity` DESC;
