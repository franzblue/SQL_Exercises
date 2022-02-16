USE classicmodels;

-- Write a query to display each customer’s name (as “Customer Name”) alongside the name of the employee who is responsible for that customer’s orders. 
-- The employee name should be in a single “Sales Rep” column formatted as “lastName, firstName”. 
-- The output should be sorted alphabetically by customer name.

SELECT c.customerName AS `Customer Name`, CONCAT(e.lastName, ", ", e.firstName) AS `Sale Rep` 
FROM customers c 
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber 
ORDER BY `Customer Name`;



-- Determine which products are most popular with our customers. 
-- For each product, list the total quantity ordered along with the total sale generated (total quantity ordered * priceEach) for that product. 
-- The column headers should be “Product Name”, “Total # Ordered” and “Total Sale”. List the products by Total Sale descending.

SELECT p.productName AS`Product Name`, o.quantityOrdered AS `Total # Ordered`,  Sum(o.quantityOrdered*o.priceEach) AS `Total Sale` 
FROM products p 
JOIN orderdetails o ON p.productCode = o.productCode 
GROUP BY p.productCode 
ORDER BY `Total Sale` DESC;



-- Write a query which lists order status and the # of orders with that status. 
-- Column headers should be “Order Status” and “# Orders”. Sort alphabetically by status.

SELECT o.status AS `Order Status`, COUNT(o.status) AS `# Orders` 
FROM orders o 
GROUP BY o.status
ORDER BY o.status;



-- Write a query to list, for each product line, the total # of products sold from that product line. 
-- The first column should be “Product Line” and the second should be “# Sold”. Order by the second column descending.

SELECT p.productLine AS `Product Line`, SUM(o.quantityOrdered) AS `# Sold` 
FROM products p  
JOIN orderdetails o ON p.productCode = o.productCode 
GROUP BY p.productLine 
ORDER BY `# Sold` DESC;



-- For each employee who represents customers, output the total # of orders that employee’s customers have placed alongside the total sale amount of those orders. 
-- The employee name should be output as a single column named “Sales Rep” formatted as “lastName, firstName”. 
-- The second column should be titled “# Orders” and the third should be “Total Sales”. 
-- Sort the output by Total Sales descending. 
-- Only (and all) employees with the job title ‘Sales Rep’ should be included in the output, and if the employee made no sales the Total Sales should display as “0.00”.

SELECT 
	IF(e.jobTitle = "Sales Rep", CONCAT(e.lastName, ", ", e.firstName), "NOT A SALES REP") AS `Sales Rep`, COUNT(o.orderNumber) AS `# Orders`, 
	IF(SUM(od.quantityOrdered * od.priceEach) IS NULL, "0.00", SUM(od.quantityOrdered * od.priceEach)) AS `Total Sales` 
FROM employees e  
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber 
LEFT JOIN orders o ON c.customerNumber = o.customerNumber 
LEFT JOIN orderdetails od on o.orderNumber = od.orderNumber WHERE e.jobTitle = 'Sales Rep' 
GROUP BY `Sales Rep` 
ORDER BY `Total Sales` DESC;


-- Your product team is requesting data to help them create a bar-chart of monthly sales since the company’s inception. 
-- Write a query to output the month (January, February, etc.), 4-digit year, and total sales for that month. 
-- The first column should be labeled ‘Month’, the second ‘Year’, and the third should be ‘Payments Received’. 
-- Values in the third column should be formatted as numbers with two decimals – for example: 694,292.68.

SELECT MONTHNAME(o.orderDate) AS `Month`, YEAR(o.orderDate) AS `Year`, FORMAT(SUM(od.quantityOrdered * od.priceEach), 2) AS `Payments Received` 
FROM orders o 
JOIN orderdetails od ON o.orderNumber = od.orderNumber 
GROUP BY `MONTH`, `YEAR` 
ORDER BY o.orderDate;


select * from payments p ORDER BY p.paymentDate ;


