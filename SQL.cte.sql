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











