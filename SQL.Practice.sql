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

select * from customers;
select * from orders;

select * 
 from customers
 where country = 'Germany';

select 
first_name,
country
from customers
where country = 'Germany';

select * 
from customers
order by score asc;
 
SELECT *
FROM customers
ORDER BY score DESC;

SELECT *
FROM customers
ORDER BY country ASC, score DESC;

select 
	country,
    sum(score) as sum
	from customers 
group by country;

select 
	country,
    sum(score) as sum,
    count(id) as customer
	from customers 
group by country;

select 
	country,
    sum(score) as sum
	from customers
where score>400
group by country
having sum(score)>800;

select 
	country,
    avg(score) as avg_score
	from customers
where score !=0
group by country
having avg(score) > 430;

select 
	distinct country
from customers;

select *
from customers
order by score desc limit 3;

select *
from customers
order by score asc limit 2;

select *
from orders 
order by order_date desc limit 2;

