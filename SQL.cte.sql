use regex1;
CREATE TABLE employees (
    employeeid INT PRIMARY KEY,
    name VARCHAR(50),
    managerid INT
);


INSERT INTO employees (employeeid, name, managerid) VALUES
(1, 'Alice', NULL),      -- CEO
(2, 'Bob', 1),           -- Reports to Alice
(3, 'Charlie', 2),       -- Reports to Bob
(4, 'Diana', 2),         -- Reports to Bob
(5, 'Eve', 3);           -- Reports to Charlie
select * from employees;
with recursive cte as(
select employeeid,name, name as hierarchy_path from employees where managerid is null
union all
select e.employeeid,e.name,concat(e.name, '->', cte.hierarchy_path) from
employees as e 
join cte on e.managerid=cte.employeeid and e.employeeid<6)
select * from cte;


WITH RECURSIVE ctes AS (
    -- Anchor query (top manager)
    SELECT employeeid, name, managerid, 1 AS level
    FROM employees
    WHERE managerid IS NULL

    UNION ALL

    -- Recursive query
    SELECT e.employeeid,
           e.name,
           e.managerid,
           ctes.level + 1
    FROM employees e
    JOIN ctes
      ON e.managerid = ctes.employeeid
    WHERE e.employeeid < 6
)
SELECT * FROM ctes;


WITH RECURSIVE cte AS (
    SELECT employeeid,
           name,
           name AS levels
    FROM employees
    WHERE managerid IS NULL

    UNION ALL

    SELECT e.employeeid,
           e.name,
           CONCAT(e.name, '->', cte.levels)
    FROM employees AS e
    JOIN cte
      ON e.managerid = cte.employeeid
    WHERE e.employeeid < 6
)
SELECT * FROM cte;



WITH RECURSIVE cte AS (
    SELECT employeeid,
           name,
           CAST(employeeid AS CHAR(100)) AS levels
    FROM employees
    WHERE managerid IS NULL

    UNION ALL

    SELECT e.employeeid,
           e.name,
           CONCAT(cte.levels, '->', e.employeeid)
    FROM employees AS e
    JOIN cte
      ON e.managerid = cte.employeeid
    WHERE e.employeeid < 6
)
SELECT * FROM cte;

-- Q1. Find employees who have at least one employee reporting directly to them.
select * from employees;
select * from employees as e1 
where exists 
(select 1 from employees as e2 
where e2.managerid = e1.employeeid);

SELECT *
FROM employees AS e1
WHERE EXISTS (
    SELECT 1
    FROM employees AS e2
    WHERE e2.managerid = e1.employeeid
);

-- Q2. Find employees who do not have any employee reporting directly to them.
select * from employees as e1 
where not exists(
select 1 
from employees as e2 
where e2.managerid = e1.employeeid);
-- Q3. Using a recursive CTE, display each employee's complete management 
-- hierarchy from the CEO to that employee.

select * from employees;
with recursive cte as (
select employeeid,name,name as levels from employees where managerid is null
union all
select e.employeeid,e.name,concat(cte.levels,'->',e.name) from 
employees as e join cte on e.managerid=cte.employeeid where e.employeeid < 5)
select * from cte;

with recursive cte as (
select employeeid,name,CAST(employeeid AS CHAR(100)) as levels from employees where managerid is null
union all
select e.employeeid,e.name,concat(cte.levels,'->',e.employeeid) from 
employees as e join cte on e.managerid=cte.employeeid )
select * from cte;
-- Q4. Using a window function, assign a row number to employees within each manager,
-- ordered by employeeid.

select *, row_number() over(partition by managerid order by employeeid) from employees;

-- Q5. Using a window function, calculate the number of employees reporting to each manager,
-- while still displaying every employee.
 select *, count(employeeid) over(partition by managerid) from employees;



