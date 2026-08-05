
CREATE DATABASE IF NOT EXISTS window_fn_practice;
USE window_fn_practice;

CREATE TABLE employees (
  emp_id      INT PRIMARY KEY,
  full_name   VARCHAR(100) NOT NULL,
  department  VARCHAR(50) NOT NULL,
  city        VARCHAR(50) NOT NULL,
  salary      INT NOT NULL,
  hire_date   DATE NOT NULL
);

CREATE TABLE sales (
  sale_id     INT PRIMARY KEY,
  emp_id      INT NOT NULL,
  sale_date   DATE NOT NULL,
  amount      DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);


INSERT INTO employees (emp_id, full_name, department, city, salary, hire_date) VALUES
(101, 'Asha Nair',   'Sales',      'Mumbai',    65000, '2022-04-10'),
(102, 'Rohan Mehta', 'Sales',      'Pune',      72000, '2021-07-05'),
(103, 'Neha Singh',  'Sales',      'Delhi',     68000, '2023-01-15'),
(104, 'Kabir Rao',   'Engineering','Bengaluru', 120000,'2020-09-20'),
(105, 'Isha Verma',  'Engineering','Hyderabad', 110000,'2021-11-12'),
(106, 'Vikram Das',  'Engineering','Bengaluru', 125000,'2019-03-08'),
(107, 'Pooja Shah',  'HR',         'Mumbai',    60000, '2020-02-01'),
(108, 'Arjun Iyer',  'HR',         'Chennai',   58000, '2022-06-18');

INSERT INTO sales (sale_id, emp_id, sale_date, amount) VALUES
(1, 101, '2026-01-02', 12000.00),
(2, 101, '2026-01-05',  8000.00),
(3, 102, '2026-01-03', 15000.00),
(4, 102, '2026-01-09',  5000.00),
(5, 103, '2026-01-04',  7000.00),
(6, 103, '2026-01-10', 11000.00),
(7, 101, '2026-02-02', 14000.00),
(8, 102, '2026-02-03',  9000.00),
(9, 103, '2026-02-05', 13000.00),
(10,101, '2026-02-08',  6000.00),
(11,102, '2026-02-10', 16000.00),
(12,103, '2026-02-12',  4000.00);

select * from employees;
select * from sales;
select *,sum(salary) over(),
sum(salary)over(partition by department),
sum(salary)over(partition by department,city) from employees;
-- this is running  sum or cummalative sum of  salary
select*,
sum(salary)over(order by salary) from employees;
select*,
sum(salary)over(order by emp_id) from employees;
select*,
sum(salary)over(order by city) from employees;

select*,
sum(salary)over(order by month(hire_date)) from employees;
select*,
sum(salary)over(partition by department order by salary)  from employees;
-- row_number() => to define a unique values
select *,
row_number() over() from employees;
select *,
row_number() over(partition by department) from employees;
select *,
row_number() over(partition by department order by hire_date) from employees;
-- rank function
select *,
rank() over(order by salary desc) from employees;
select *,
dense_rank() over(order by city) from employees;
select *,
rank() over(order by city) from employees;
select *,
dense_rank() over(partition by department order by salary) from employees;

select *, lead(salary) over() from employees;
select *, lead(salary,2) over() from employees;
select *, lag(salary,1) over() from employees;

select*,lag(salary)over(partition by department order by hire_date), salary -
lag(salary)over(partition by department order by hire_date) from employees;

select*,lead(salary) over(order by salary desc),
lag(salary) over(order by salary desc ) from employees;
select *, sum(amount) over(order by sale_date) as total from sales; 

select*, sum(amount)over(partition by emp_id order by sale_date) from sales;

select* from sales;
select*, sum(amount) over() from sales;

select *, avg(salary) over(partition by department) from employees;
select * from
(select*, row_number() over(partition by department order by salary) as row_values 
from employees)tempdata where row_values<=2 ;

select*, avg(salary)over(partition by department), salary -
 avg(salary)over(partition by department) from employees;


select *,sum(salary) over(),
rank() over(order by salary),
percent_rank() over(order by salary)
from employees;
--
select * from employees;
select* from sales;
-- Q1. Rank employees by salary within each department
select full_name,department,salary ,rank() over(partition by department order by salary desc)
from employees; 
-- Q2. Find the second highest salary in each department
select * from
(select full_name, department,salary,dense_rank()over(partition by department order by salary
desc)
as highest_salary from employees) s_data where highest_salary =2;
-- Q3. Top 2 highest-paid employees in each department
select * from
(select full_name, department,salary,dense_rank()over(partition by department order by salary desc)
as highest_salary from employees) s_data where highest_salary <=2;
-- Q4. Show the previous employee’s salary based on hire date
select *, lag(salary) over(partition by department order by hire_date) 
from employees;
-- Q5. Show salary difference from the previous employee
select *,lag(salary)over(partition by department order by hire_date) , salary
- lag(salary)over(partition by department order by hire_date) from employees;
-- Q6. Running total of sales for each employee
select emp_id,sale_date,amount,sum(amount)over(partition by emp_id order by amount) from sales;
-- Q7. Show each sale with the employee’s total sales
select * from sales;
select *,sum(amount)over(partition by emp_id ) as toyal_sale from sales;
-- Q8. Compare each sale with the previous sale of the same employee
select*,lag(amount)over(partition by emp_id order by sale_date ) as prev_sale,amount -
lag(amount)over(partition by emp_id order by sale_date)as sale_diff from sales;

-- Q9. Rank employees by total sales
WITH totals AS
(SELECT emp_id,SUM(amount) AS total_sales FROM sales GROUP BY emp_id)
SELECT emp_id,total_sales,RANK() OVER (ORDER BY total_sales DESC) AS sales_rank FROM totals;
-- Q10. For each month, rank employees by their total monthly sales.
-- Expected output:
-- month
-- emp_id
-- full_name
-- monthly_sales
-- monthly_rank
WITH monthly_sales AS (SELECT emp_id,DATE_FORMAT(sale_date, '%Y-%m') AS month,
SUM(amount) AS monthly_sales FROM sales GROUP BY emp_id,DATE_FORMAT(sale_date, '%Y-%m'))
SELECT month,emp_id,monthly_sales, dense_RANK() OVER (PARTITION BY month ORDER BY monthly_sales DESC)
 AS monthly_rank FROM monthly_sales;
