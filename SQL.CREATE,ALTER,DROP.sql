-- DDL 
-- CREATE, ALTER , DROP

DROP DATABASE IF EXISTS Sales;
CREATE DATABASE Sales;
 use sales;
CREATE TABLE person(
   id INT NOT NULL,
   person_name VARCHAR(50) NOT NULL,
   birth_date DATE,
   phone VARCHAR(15) NOT NULL,
   CONSTRAINT pk_person PRIMARY KEY (id)
);


select * from person;

 -- ALTTER 
 
 ALTER  TABLE  person
 ADD email VARCHAR(50) NOT NULL ;
 
 SELECT * FROM 	person; 

ALTER TABLE person 
DROP COLUMN phone;

SELECT * FROM person ; 

INSERT INTO person (id,person_name,birth_date,phone)
SELECT
id,
first_name,
NULL,
'Unknown'
from customers;
select * from person;
-- DML ,UPDATE