DROP DATABASE IF EXISTS `Parks_and_Recreation`;
CREATE DATABASE `Parks_and_Recreation`;
USE `Parks_and_Recreation`;






CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);

CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT
);


INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');


INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);



CREATE TABLE parks_departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name varchar(50) NOT NULL,
  PRIMARY KEY (department_id)
);

INSERT INTO parks_departments (department_name)
VALUES
('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');


select * from employee_demographics;
show tables;
select * from Parks_and_Recreation.employee_demographics;
select first_name,
last_name
birth_date,
age,(age+10) * 10 + 10
from Parks_and_Recreation.employee_demographics;
# PEMDAS
-- PARENTHESES,EXPONENT,MULTIPLICATION,DIVISION,ADDITION,SUBTRACTION
select distinct first_name
from Parks_and_Recreation.employee_demographics;

select  gender
from Parks_and_Recreation.employee_demographics;

select distinct gender
from Parks_and_Recreation.employee_demographics;

select distinct first_name,gender
from Parks_and_Recreation.employee_demographics;

select * from employee_salary where first_name = 'leslie';

select * from employee_salary where salary >= 50000;
select * from employee_salary where salary <= 50000;

select * from employee_demographics
where gender = 'Female';
select * from employee_demographics
where gender != 'Female';

select * from employee_demographics
where birth_date > '1985-01-01';

-- AND OR NOT -- LOGICAL OPERATORS

select * from employee_demographics
where birth_date > '1985-01-01' and gender= 'male';
 
select * from employee_demographics
where birth_date > '1985-01-01' or gender= 'male';
 
select * from employee_demographics
where birth_date > '1985-01-01' 
or not gender= 'male'
;
 select * from employee_demographics
where (first_name = 'leslie' and age=44) or age > 55
;
-- LIKE Statement
 select * from employee_demographics
 where first_name like '%er%'
;
 select * from employee_demographics
 where first_name like 'a%'
;
select * from employee_demographics
 where first_name like 'a___'
;
select * from employee_demographics
 where first_name like 'a___%'
;
select * from employee_demographics
 where birth_date like '1989%'
;
-- group by
select * from employee_demographics
;
select gender
 from employee_demographics
 group by gender
;
select first_name
 from employee_demographics
 group by first_name
;
select gender,avg(age)
 from employee_demographics
 group by gender
;
select occupation,salary
 from employee_salary
 group by occupation,salary
;
select gender, avg(age),max(age),min(age),count(age)
 from employee_demographics
 group by gender
;
-- ORDER BY
select *
 from employee_demographics
 order by first_name desc
;
select *
 from employee_demographics
 order by gender ,age desc
;
select *
 from employee_demographics
 order by 5,4
;
-- having vs where

select  gender ,avg(age)
from employee_demographics
group by gender
having avg(age)> 40
;
select occupation,avg(salary)
from employee_salary
group by occupation;

select occupation, avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 75000
;
-- LIMIT & Aliasing
USE `Parks_and_Recreation`;

select *
from employee_demographics
order by age desc
limit 5
;
select *
from employee_demographics
order by age desc
limit 3,1
;
-- Aliasing
select gender ,avg(age) as avg_age
from employee_demographics
group by gender
having avg_age > 40;
-- joins
select *
from employee_demographics;

select *
from employee_salary;

select *
from employee_demographics
join employee_salary
 on employee_demographics.employee_id = employee_salary.employee_id 
 ;
select *
from employee_demographics as d
join employee_salary as s
 on d.employee_id = s.employee_id 
 ;

-- outer joins
select *
from employee_demographics
right  join employee_salary
 on employee_demographics.employee_id = employee_salary.employee_id 
 ;
-- self join 
select * 
from employee_salary as e1
join employee_salary as e2
  on e1.employee_id + 1 = e2.employee_id
;

select e1.employee_id as emp_santa,
e1.first_name as first_name_santa,
e1.last_name as last_name_santa,
e2.employee_id as emp,
e2.first_name as first_name,
e2.last_name as last_name
from employee_salary as e1
join employee_salary as e2
  on e1.employee_id + 1 = e2.employee_id
;
-- joining multiple table together 
select *
from employee_demographics as d
join employee_salary as s
 on d.employee_id = s.employee_id 
 inner join parks_departments as pd
  on s.dept_id=pd.department_id
 ;
select * 
from parks_departments;
-- unions
select first_name ,last_name
from employee_demographics
union distinct
select first_name,last_name
from employee_salary;

select first_name ,last_name
from employee_demographics
union 
select first_name,last_name
from employee_salary;

select first_name ,last_name
from employee_demographics
union all
select first_name,last_name
from employee_salary
;
select first_name ,last_name
from employee_demographics
union all
select first_name,last_name
from employee_salary;

select first_name,last_name, 'old man' as label
from employee_demographics
where age > 40 and gender= 'male'
union
select first_name,last_name, 'old lady' as label
from employee_demographics
where age > 40 and gender = 'Female'
union
select first_name,last_name, 'Highly Paid Employee' as label
from employee_salary
where salary > 70000
order by first_name,last_name
;
-- String functions
select length('skyfall');

select first_name,length(first_name)
from employee_demographics
order by 2;

select upper('sky');
select lower('SKY');

select first_name,upper(first_name)
from employee_demographics
;

select trim('       sky        ');

select ltrim('       sky        ');
select rtrim('       sky        ');

select first_name ,
 left(first_name,4),
right(first_name,4)
from employee_demographics;

select first_name,
substring(first_name,3,2)
from employee_demographics;

select first_name,
substring(first_name,3,2),
birth_date,
substring(birth_date,6,2) as birth_month
from employee_demographics;

select first_name,replace(first_name,'a','z')
from employee_demographics;

select locate('a','Shyam')
;
select first_name,locate('An',first_name)
from employee_demographics;

select first_name, last_name,
concat(first_name,' ',last_name) as full_name
from employee_demographics;

-- Case Statements 
select first_name,
last_name,
age,
case
	when age <= 30 then 'young'
    when age between 31 and 50 then 'Old'
    when age >= 50 then "On Death's Door"
end as  age_Bracket
from employee_demographics;   

-- pay increase and Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- finance = 10% bonus
select first_name,last_name,salary,
case
	when salary < 50000 then salary * 1.05
    when salary > 50000 then salary * 1.07
end as New_salary,
case
	when dept_id = 6 then salary * .10
end as bonus
from employee_salary;
-- Subqueries

Select *
from employee_demographics
where employee_id in
                    (select employee_id
                       from employee_salary
                        where dept_id = 1)
;
select first_name,salary,
(select avg(salary)
from employee_salary)
from employee_salary ;

select gender, avg(age),max(age),min(age),count(age)
from employee_demographics
group by gender;

select avg(max_age),max(max_age),min(min_age)
from 
(select gender,
avg(age) as avg_age,
max(age) as max_age,
min(age) as min_age,
count(age) 
from employee_demographics
group by gender ) as agg_table
;
USE `Parks_and_Recreation`;
-- WINDOW FUNCTION

select gender,avg(salary) as avg_salary
from employee_demographics as dem
join employee_salary as sal
  on dem.employee_id = sal.employee_id
group by gender;


select gender,avg(salary) over()
from employee_demographics as dem
join employee_salary as sal
  on dem.employee_id = sal.employee_id
;

select gender,avg(salary) over(partition by gender)
from employee_demographics as dem
join employee_salary as sal
  on dem.employee_id = sal.employee_id
;
select dem.first_name,dem.last_name, gender,avg(salary) over(partition by gender)
from employee_demographics as dem
join employee_salary as sal
  on dem.employee_id = sal.employee_id
;

select dem.first_name,dem.last_name, gender,salary,
sum(salary) over(partition by gender order by dem.employee_id ) as Rolling_total
from employee_demographics as dem
join employee_salary as sal
  on dem.employee_id = sal.employee_id
;

select dem.employee_id, dem.first_name,dem.last_name, gender,salary,
row_number() over( partition by gender order by salary desc)
from employee_demographics as dem
join employee_salary as sal
  on dem.employee_id = sal.employee_id
;

select dem.employee_id, dem.first_name,dem.last_name, gender,salary,
row_number() over( partition by gender order by salary desc) as row_num,
rank()over( partition by gender order by salary desc) as rank_num
from employee_demographics as dem
join employee_salary as sal
  on dem.employee_id = sal.employee_id
;

select dem.employee_id, dem.first_name,dem.last_name, gender,salary,
row_number() over( partition by gender order by salary desc) as row_num,
rank()over( partition by gender order by salary desc) as rank_num,
 dense_rank()over( partition by gender order by salary desc) as dense_rank_num
from employee_demographics as dem
join employee_salary as sal
  on dem.employee_id = sal.employee_id
;

-- CTE
with cte_Exampale as
(SELECT gender,avg(salary) avg_sal,max(salary) max_sal,min(salary) min_sal, count(salary)
from employee_demographics dem
join employee_salary sal
   on dem.employee_id = sal.employee_id
group by gender)
select avg(avg_sal)
from cte_Exampale
;

select avg(avg_sal) from
(SELECT gender,avg(salary) avg_sal,max(salary) max_sal,min(salary) min_sal, count(salary)
from employee_demographics dem
join employee_salary sal
   on dem.employee_id = sal.employee_id
group by gender
) exampale_subquery
;


with cte_example as
(SELECT employee_id, gender,birth_date
from employee_demographics
where birth_date > '1985-01-01'
),
cte_example2 as 
(
select employee_id,salary
from employee_salary
where salary > 50000
)
select *
from cte_example
join cte_example2
on cte_example.employee_id = cte_example2.employee_id
;

with cte_Exampale (Gender,AVG_sal,MAX_sal,MIN_sal,COUNT_sal)  as
(SELECT gender,avg(salary),max(salary),min(salary), count(salary)
from employee_demographics dem
join employee_salary sal
   on dem.employee_id = sal.employee_id
group by gender)
select *
from cte_Exampale
;
-- Temporary Tables

CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

select *
from temp_table;
insert into temp_table
values('shyam','sharma','kung fu panda');

select * 
from temp_table;

create temporary table salary_over_50k
select *
from employee_salary
where salary > 50000;
select *
from salary_over_50k;

-- Stored Procedures

select * 
from employee_salary 
where salary>=50000; 

DELIMITER $$
create procedure large_salaries3()
BEGIN
	select * 
	from employee_salary 
	where salary>=50000;
	select * 
	from employee_salary 
	where salary>=10000; 
END $$
DELIMITER ;

CALL large_salaries3();

DELIMITER $$
create procedure large_salaries5(EMPLOYEE_ID INT)
BEGIN
	select salary
	from employee_salary 
    where employee_id = EMPLOYEE_ID
	;
END $$
DELIMITER ;

CALL large_salaries5(1); 













