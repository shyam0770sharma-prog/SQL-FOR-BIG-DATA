-- Joins multipale table
 DROP DATABASE IF EXISTS SalesDB;
CREATE DATABASE SalesDB;
USE SalesDB;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Shyam'),
(2, 'Vanshika'),
(3, 'Rachit'),
(4, 'Akshita'),
(5, 'Rahul'),
(6, 'Priya');


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10,2)
);

INSERT INTO orders VALUES
(101, 1, 500),
(102, 1, 750),
(103, 2, 1200),
(104, 3, 400),
(105, 3, 900),
(106, 4, 650),
(107, 2, 300),
(108, 10, 800);

select *
from customers;

select * 
from orders;

SELECT 
    c.customer_name, c.customer_id, o.order_id, o.order_amount
FROM
    customers AS c
        INNER JOIN
    orders AS o ON c.customer_id = o.customer_id;
    

SELECT 
    c.customer_name, c.customer_id, o.order_id, o.order_amount
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.customer_id = o.customer_id;    
    
    
SELECT 
    c.customer_name, o.customer_id, o.order_id, o.order_amount
FROM
    customers AS c
        RIGHT JOIN
    orders AS o ON c.customer_id = o.customer_id;


SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id

UNION

SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customer_id = o.customer_id;

SELECT 
    *
FROM
    customers AS c
        RIGHT JOIN
    orders AS o ON c.customer_id = o.customer_id
    where c.customer_id is null  ;

select *
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.customer_id = o.customer_id
    where o.customer_id is null  ;

select *
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.customer_id = o.customer_id
    where o.customer_id is not null  ;


select *
FROM
    customers  
        CROSS JOIN
    orders ;