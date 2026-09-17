CREATE DATABASE IF NOT EXISTS InterviewDB;
USE InterviewDB;

DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary INT,
    ManagerID INT,
    JoiningDate DATE
);

INSERT INTO Employees
(EmployeeID, FirstName, LastName, Department, Salary, ManagerID, JoiningDate)
VALUES
(1,  'Frank',    'Lee',       'Marketing', 55000, NULL, '2020-01-10'),
(2,  'Kevin',    'Brown',     'Marketing', 65000, 1,    '2021-03-15'),
(3,  'David',    'Smith',     'Marketing', 65000, 1,    '2019-06-20'),

(4,  'Mary',     'Jones',     'Sales',     75000, 3,    '2020-08-10'),
(5,  'Michael',  'Ray',       'Sales',     90000, 3,    '2022-02-10'),
(6,  'Carol',    'Baker',     'Sales',     55000, 4,    '2021-01-05'),
(7,  'John',     'Wilson',    'Sales',     75000, 3,    '2019-04-15'),

(8,  'Anna',     'Adams',     'HR',        40000, NULL, '2020-05-10'),
(9,  'Robert',   'Taylor',    'HR',        60000, 8,    '2021-07-20'),
(10, 'Lisa',     'Martin',    'HR',        60000, 8,    '2019-03-10'),

(11, 'Vanshika', 'Upadhyay',  'IT',        70000, NULL, '2020-02-15'),
(12, 'Shyam',    'Sharma',    'IT',        85000, 11,   '2019-01-20');


select * from employees;

/*
Q1: Second-highest unique salary
Q2: Employees earning more than department average
Q3: Employees having same department and salary
Q4: Highest-paid employee in every department
Q5: Employees who joined before their manager*/

select * 
from Employees;

select max(Salary)
from Employees
where Salary < (select max(Salary)
from Employees);

SELECT EmployeeID, FirstName, Department, Salary
FROM Employees
WHERE Salary > (
    SELECT AVG(e2.Salary)
    FROM Employees e2
    WHERE e2.Department = Employees.Department
);
-- Q3: Employees having same department and salary
SELECT Department, Salary, COUNT(*)
FROM Employees
GROUP BY Department, Salary
HAVING COUNT(*) > 1;

-- Q4: Highest-paid employee in every department
SELECT e.Department, e.FirstName, e.Salary
FROM Employees e
JOIN (
    SELECT Department, MAX(Salary) AS MaxSalary
    FROM Employees
    GROUP BY Department
) m
ON e.Department = m.Department
AND e.Salary = m.MaxSalary;

-- Q5: Employees who joined before their manager
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.JoiningDate,
    m.FirstName AS ManagerName,
    m.JoiningDate AS ManagerJoiningDate
FROM Employees e
JOIN Employees m
    ON e.ManagerID = m.EmployeeID
WHERE e.JoiningDate < m.JoiningDate;