DROP DATABASE IF EXISTS interview_sql;
CREATE DATABASE interview_sql;
USE interview_sql;

CREATE TABLE employee (
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    salary INT,
    department_name VARCHAR(30)
);

INSERT INTO employee (eid, ename, salary, department_name) VALUES
-- HR
(1,  'Amit',    35000, 'HR'),
(2,  'Neha',    42000, 'HR'),
(3,  'Rohit',   47000, 'HR'),
(4,  'Pooja',   47000, 'HR'),
(5,  'Karan',   52000, 'HR'),

-- IT
(6,  'Ankit',   60000, 'IT'),
(7,  'Sneha',   68000, 'IT'),
(8,  'Vikas',   72000, 'IT'),
(9,  'Riya',    72000, 'IT'),
(10, 'Arjun',   90000, 'IT'),

-- Finance
(11, 'Meera',   55000, 'Finance'),
(12, 'Nitin',   61000, 'Finance'),
(13, 'Kavya',   66000, 'Finance'),
(14, 'Rahul',   71000, 'Finance'),
(15, 'Simran',  85000, 'Finance'),

-- Sales
(16, 'Deepak',  30000, 'Sales'),
(17, 'Priya',   41000, 'Sales'),
(18, 'Sanjay',  45000, 'Sales'),
(19, 'Anjali',  50000, 'Sales'),
(20, 'Manoj',   62000, 'Sales'),

-- Marketing
(21, 'Ishita',  48000, 'Marketing'),
(22, 'Tarun',   53000, 'Marketing'),
(23, 'Nisha',   59000, 'Marketing'),
(24, 'Varun',   64000, 'Marketing'),
(25, 'Asha',    70000, 'Marketing');
select * from employee;

-- Correlated subquery questions (5)
-- Q1 Find employees whose salary is greater than the average salary of their own department.
select eid,ename,salary,department_name from employee as e1 where salary >
(select  avg(salary) from employee as e2 where e2.department_name=e1.department_name);
-- Q2 Find the highest-paid employee(s) in each department.
select * from employee as e1  where salary =
(select max(salary) from employee as e2 where e2.department_name=e1.department_name );
-- Q3 Find employees whose salary is less than at least one employee in the same department.
select * from employee as e1 where  Exists 
(select 1 from employee as e2 where e2.department_name=e1.department_name and e2.salary>e1.salary );
-- Q4 Find departments where every employee earns more than 40,000.
select distinct department_name from employee as e1 where not exists(select 1 from employee as e2 where
 e2.department_name=e1.department_name and e2.salary<=40000 );
-- Q5 Find employees who earn more than the average salary of all other departments combined (excluding their own department).
select * from employee e1 where e1.salary > (select avg(e2.salary)
from employee e2 where e2.department_name != e1.department_name);
-- Window function questions (5)
-- Q6 Rank employees by salary within each department using RANK(), and return all employees.
select *,rank() over(partition by department_name order by salary desc) from employee;
-- Q7 Return the top 2 highest-paid employees in each department.
select * from 
(select *, row_number() over(partition by department_name order by salary desc ) as temp from employee)
t where temp <=2;
-- Q8 For each employee, show the difference between their salary and the previous employee’s 
-- salary within the same department (ordered by salary).
select * , lag(salary)  over(partition by department_name order by salary ) as previous_salary ,salary
 - lag(salary)  over(partition by department_name order by salary ) as salary_diff from employee ;
 
with salary_cte as 
(select * , lag(salary)  over(partition by department_name order by salary ) as previous_salary from employee)
select * , salary - previous_salary as salary_diff from salary_cte;
 
-- Q9 Divide employees into 4 salary groups within each department using a window function.
select *, ntile(4) over(partition by department_name order by salary) as salary_group from employee;
-- Q10 For each employee, show their salary along with the running total of salaries within their
-- department ordered by salary, and also show the department’s total salary in the same result.
select *, sum(salary) over(partition by department_name order by salary) as running_total ,
sum(salary)over(partition by department_name)as department_sum  from employee;

with cte as
(select salary from employee where salary between 35000 and 70000)

select * from cte;
use sakila; 
select actor_id,first_name from sakila.actor where actor_id between 1 and 5
union
select actor_id, first_name from sakila.actor where actor_id between 3 and 5;

select actor_id,first_name from sakila.actor where actor_id between 1 and 5
union all
select actor_id, first_name from sakila.actor where actor_id between 3 and 5;

with recursive cte as (
select 10 as num -- assinging values to this num column(starting point)
union all
select num+1 from cte -- cte call karna
 where num<15 )    -- terminating condition (stop point)
 
 select * from cte;












