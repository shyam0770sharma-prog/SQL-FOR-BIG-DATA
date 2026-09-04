DROP DATABASE IF EXISTS SalesDB;
CREATE DATABASE SalesDB;
USE SalesDB;
CREATE TABLE customers (
    id INT,
    first_name VARCHAR(50),
    country VARCHAR(50),
    score INT
);

INSERT INTO customers VALUES
(1, 'Maria', 'Germany', 350),
(2, ' John', 'USA', 900),
(3, 'Georg', 'UK', 750),
(4, 'Martin', 'Germany', 500),
(5, 'Peter', 'USA', 0);
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    sales INT
);

INSERT INTO orders VALUES
(1001, 1, '2025-01-01', 100),
(1002, 2, '2025-01-05', 200),
(1003, 3, '2025-01-10', 150),
(1004, 2, '2025-02-01', 300),
(1005, 1, '2025-02-05', 250);
INSERT INTO customers (id,first_name, country,score)
VALUES 
    (6, 'Vanshika', 'INDIA', '200'),
    (7, 'Shyam', 'INDIA', '950');
select *
from customers 
where country = 'Germany';

select *
from customers 
where country != 'Germany';

select *
from customers
where score > 500;

select *
from customers
where score >= 500;

select * 
from customers 
where score <= 500;

select * 
from customers
where country = 'INDIA' AND score > 500;

select * 
from customers
where country = 'INDIA' OR score > 500;

select * 
from customers
where not score < 500;

select * 
from customers
where score between 100 and 600;

select * 
from customers
where country IN ('INDIA','USA') ;

select * 
from customers
where country NOT IN ('INDIA','USA') ;

select * 
from customers
where country like 'I%';

select * 
from customers
where country like '%A';

select * 
from customers
where country like '_____';

select * 
from customers
where country like '%D%';

select * 
from customers
where first_name like '%shi%';