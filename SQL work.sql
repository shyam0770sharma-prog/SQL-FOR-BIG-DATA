show databases;
create database tata;
use tata;
show tables;
create table 1nexon( price int , color char(20) );
show tables;







use world;
show tables;
describe country;
select * from country;
select name ,region,population from country;
select name ,region, population ,population-500 from country;
select * from country where continent='Asia';
select * from country where indepyear=1991;
select name ,continent , indepyear from country  where indepyear=1981;
select * from country where continent in ('Africa','asia');
select * from country where indepyear in (1960,1991);
select * from country where indepyear between 1960 and 1991;

select name country, continent from country where region  != 'South Europe' ;
select name ,population ,population *0.1 + population from country;
 select * from country where LifeExpectancy in (75.1,77.4,63.7);
 select name,population ,region from country where population
 not between 5000 and 300000 ;
 
 select name, upper(name),lower(name) from country;
 -- this is conact 
 select name, code, concat(name,'-',code,' ','shyam') from country;
 -- this is concat_ws function ws mean with a seprator
 select name , code,concat_ws('  ',name,code,'ram') from country;
 
 select name,region, continent from country 
  where region like concat('%',continent);
  
 select name ,continent,population from country where left(continent,1)=left(name,1);
 
 select name , substr(name,2) from country;
 select name, substr(name,2,4) from country;
 select name, substr(name,-4) from country;
select name, substr(name,-4,2) from country; 
 -- get the country and population where starting of the country is alg
 select name, population ,substr(name,1,1)
,substr(population,1,1) from country where
 substr(name,1,3)='ALG'  ;
 
 select name ,continent from country where substr(name,1,1)= substr(continent,1,1);
 
 select name, instr(name,'e') from country;
 select name ,char_length(name) from country;
 
 select char_length('        shyyam      ');
  select char_length (trim('        shyyam      ') );
  select char_length (rtrim('        shyyam      ') );
  select char_length (ltrim('        shyyam      ') );
 
 select name ,trim(both 'A' from name) from country;
 -- lpad and rpad
 -- when we want to define a column with fixed size 
 select name population ,lpad(population ,9,0) from country;
 -- replace function replace the word
 select name ,replace(name,'a','1') from country;
 
 select round(456.456,-1),round(456.98,1);
 select truncate(508.78,2);
 select mod(10,3), ceil(4.0000000001), floor(5.999999999), pow(2,4);
 
 -- date function 
 select now() , current_timestamp(), current_date(), current_time() ;
 select now() , adddate( now() , 2), adddate(now() ,interval 2 year) ;
 
 select now(), extract(year from now()), date_format(now(), 'year is %Y');
 
-- get the total country nad the total region along with avg life expectency
 -- and total populatin for the country who have got the indepndence after 1947 and before 1998
 
 select * from country;
 select name,region,population,indepYear from country where IndepYear
 between 1947 and 1998;
 -- answer 
 select count(name), count(region), avg(LifeExpectancy), sum(population) 
 from country where indepYear >1947 and indepYear<1998;
 -- get the total number of country and the uniqe region alon with total population and highest
 -- life expectancy with total capital for the countrys starting with A and D
-- answer 
 select  count(name) , sum(population),max(lifeexpectancy),sum(capital)
 ,count(distinct region) from
 country where name like 'a%' or name like 'd%';
 
 select count(name) from country where continent='Asia';
 select count(name) from country where continent='Africa';
 
 -- group by statement ( similar data or values of cllection in a group)
 select continent , count(name) from country group by continent;
 -- you need to find out total countrys and total population for each indepandend year 
 
 select indepYear ,count(name),sum(population) from country group by indepYear;
 
 select sum(population) from country; 
 select continent ,count(name) from country group by continent;
 select continent ,count(name) from country where indepyear> 1950 group by continent;
 select continent ,count(name) from country group by
 continent having count(name) >30;
 
 select continent , sum(population) from country group by continent
 having sum(population) > 30401150;
 
 select indepyear , count(name) from country group by indepyear;
 
 select indepyear , count(name)  from country where indepyear > 1930 group by indepyear
 having count(name) >2;
 
 select * from country;
-- 1 you need to get GovernmentForm and the total number of counry for each GovernmentForm
-- from where the total number of country should be > 20
-- 2  you need to get GovernmentForm and the total number of counrys where country
-- should have capital > 30 
 -- 3 get the total number of countrys and the region and the total population where
 -- lifrexpectancy > 38 and the population in each continent > 300000 
 -- 1
 select GovernmentForm , count(name) from country group by GovernmentForm
  having count(name) > 20;
 -- 2 
  select GovernmentForm , count(name) from country where capital > 30 
  group by GovernmentForm;
  -- 3
  select continent , count(name),count(region),sum(population) from country
  where LifeExpectancy > 38 group by continent having sum(population) > 300000;
  
  
  select * from country ;
  select * from country order by continent desc,Region;
  
  
  
  
  use regex;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    major VARCHAR(50)
);

INSERT INTO students (student_id, student_name, major) VALUES
(1, 'Aarav', 'Computer Science'),
(2, 'Bhavya', 'Mathematics'),
(3, 'Chetan', 'Physics'),
(4, 'Diya', 'Computer Science'),
(5, 'Esha', 'Mathematics'),
(6, 'Farhan', 'Physics'),
(7, 'Gauri', 'Computer Science'),
(8, 'Harsh', 'Mathematics'),
(9, 'Isha', 'Physics'),
(10, 'Jay', 'Computer Science'),
(11, 'Kiran', 'Mathematics'),
(12, 'Leena', 'Physics'),
(13, 'Manav', 'Computer Science'),
(14, 'Neha', 'Mathematics'),
(15, 'Om', 'Physics'),
(16, 'Pooja', 'Computer Science'),
(17, 'Qadir', 'Mathematics'),
(18, 'Riya', 'Physics'),
(19, 'Sahil', 'Computer Science'),
(20, 'Tina', 'Mathematics');


CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_name VARCHAR(50),
    credits INT
);

INSERT INTO enrollments (enrollment_id, student_id, course_name, credits) VALUES
(101, 1, 'Data Structures', 4),
(102, 1, 'Algorithms', 4),
(103, 2, 'Linear Algebra', 3),
(104, 3, 'Quantum Mechanics', 4),
(105, 4, 'Operating Systems', 4),
(106, 5, 'Statistics', 3),
(107, 6, 'Electromagnetism', 4),
(108, 7, 'Databases', 4),
(109, 8, 'Probability', 3),
(110, 9, 'Thermodynamics', 4),
(111, 10, 'Computer Networks', 4),
(112, 11, 'Calculus II', 3),
(113, 12, 'Optics', 4),
(114, 13, 'Machine Learning', 4),
(115, 14, 'Discrete Math', 3),
(116, 15, 'Nuclear Physics', 4),
(117, 16, 'Software Engineering', 4),
(118, 17, 'Numerical Methods', 3),
(119, 18, 'Solid State Physics', 4),
(120, 1, 'Artificial Intelligence', 4);
  
  select * from students;
  select * from enrollments;
 -- we need to find out student_id ,student_name, course_name,enrollment_id
  select s.student_id,s.student_name,e.enrollment_id,e.course_name from students as s
  join enrollments as e
  on s.student_id=e.student_id;
  -- list all students along with their enrolled courses including students who have not 
  -- enrolled in any courses
  select s.student_id,s.student_name,e.enrollment_id ,e.course_name from students as s
 left join enrollments as e 
 on s.student_id=e.student_id;
  -- find which students who have not enrolled in any course
 select s.student_id,s.student_name,e.enrollment_id ,e.course_name from students as s
 left join enrollments as e 
 on s.student_id=e.student_id where course_name is null;
-- how many courses a perticular students has enrolled;
select s.student_id,s.student_name ,count(enrollment_id) from students as s
join enrollments as e 
 on s.student_id=e.student_id group by s.student_id,s.student_name;
-- find students who are enrolled in more then 2 courses;
select s.student_id,s.student_name ,count(enrollment_id) from students as s
join enrollments as e 
 on s.student_id=e.student_id group by s.student_id,s.student_name
 having count(enrollment_id)> 2;
  -- find the number of students in each major;
  select * from students;
  select major ,count(student_id) from students group by major;
  -- display each student name and the total number of course enrolled,
  -- including students with zero enrollments;
  SELECT s.student_id,s.student_name,
       COUNT(e.enrollment_id) FROM students as s
LEFT JOIN enrollments as e ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name;
 -- find total cradits from each major;
  select * from students;
  select * from enrollments;
  select s.major ,sum(e.credits) from students as s
  join enrollments as e 
  on s.student_id=e.student_id group by s.major;
  -- query to group students by the length of their names and show the count
  -- of students in each group;
  select char_length(student_name),count(student_id) from students
  group by char_length(student_name);
  -- find out in each group how many students have inrolled in the courses
  select char_length(s.student_name),count(e.enrollment_id) from students as s
  join enrollments as e on s.student_id=e.student_id
  group by char_length(student_name);
  select * from enrollments;
  select * from students;
  -- i need to print that particular group name with the number of charactar
  -- which has got the highest number of enrollment;
  select char_length(s.student_name),count(e.enrollment_id) from students as s
  join enrollments as e on s.student_id=e.student_id
  group by char_length(student_name) 
  order by count(e.enrollment_id) desc limit 1;