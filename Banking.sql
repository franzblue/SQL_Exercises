
use Banking;
 

-- For each product, show the product name "Product" and the product type name "Type".

SELECT name AS 'Product', product_type_cd AS 'Type' 
FROM product;


-- For each branch, list the branch name and city, plus the last name and title of each employee who works in that branch.

SELECT b.name, b.city, e.last_name, e.title 
FROM branch AS b 
JOIN employee AS e;


-- Show a list of each unique employee title.

SELECT DISTINCT title 
FROM employee;


-- Show the last name and title of each employee, along with the last name and title of that employee's boss.

SELECT e.last_name AS 'Last Name', e.title AS 'Title', b.last_name AS "Boss's Last Name", b.title AS "Boss's Title" 
FROM employee AS e 
LEFT JOIN employee AS b ON e.superior_emp_id = b.emp_id;


-- For each account, show the name of the account's product, the available balance, and the customer's last name.

SELECT p.name AS 'Product Name', a.pending_balance AS 'Available Balance', c.last_name AS "Customer's Last Name" 
FROM account AS a 
JOIN product AS p ON a.product_cd = p.product_cd 
JOIN individual AS c ON a.cust_id = c.cust_id;


-- List all account transaction details for individual customers whose last name starts with 'T'.

SELECT a.*  
FROM account 
JOIN acc_transaction AS a ON account.account_id = a.account_id 
JOIN individual AS c ON account.cust_id = c.cust_id 
WHERE c.last_name LIKE 'T%';
