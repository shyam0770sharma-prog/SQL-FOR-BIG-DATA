use sakila;
show tables ;

select * from payment;
select count(*) from payment where amount= 2.99;
select amount ,count(*) from payment group by amount;
select customer_id, sum(amount) from payment group by customer_id;
-- Q. i need to find the total amount spend by each customer but the amount spend
-- should be > 3 doller
select customer_id, sum(amount) from payment where amount>3
 group by customer_id;
-- Q. you need to find the total transaction done by each customer in the month of may
select customer_id ,count(amount) from payment where month(payment_date)=5
group by customer_id;
-- Q. you need to find out the maximem amount of transaction the avg. amount and the
-- total amount of transction done through each staff 
select * from payment;
-- answer
select staff_id ,max(amount),avg(amount),sum(amount) from payment
group by staff_id;
-- you need to find out max,avg ,total by each staff only for even number of customer
select staff_id ,max(amount),avg(amount),sum(amount) from payment where customer_id%2=0
group by staff_id;
-- get the amount and total transction done for each amount only for the payment
-- done through by staff_id one and where total tranction should be> 30
-- answer
select amount,count(*) from payment where staff_id=1 
group by amount having count(*)>30;
-- find out the number of customer serve alog with avg amount and total amount spend
-- in each month  for staff_id 1 or 2
-- 2. avg total number of customer serve done for each year or each month
select * from payment;
select extract(month from payment_date),count(customer_id),avg(amount)
,sum(amount)  from payment where staff_id=1 or staff_id=2 
group by extract(month from payment_date) ;
-- 2
select extract(year from payment_date),extract(month from payment_date),
count(customer_id),avg(amount)
,sum(amount)  from payment where staff_id=1 or staff_id=2 
group by extract(year from payment_date), extract(month from payment_date);

select * from payment order by customer_id,amount;
select * from payment order by customer_id,amount desc;

-- questions
-- 1. find the total amount collected by each staff member
-- 2. find the number of payments made by each customer.

-- answer
select staff_id ,sum(amount) from payment group by staff_id;

-- 2.
select customer_id , count(payment_id) from payment group by customer_id;
select count(payment_id) from payment where customer_id=1;

-- 3. questions
-- find all staff members whose total collection is greater than 30000.
-- 4. find the average payment amount for each staff member.
-- 5. find customer who made more than 20 payments.
-- Answer
-- 3. 
select staff_id ,sum(amount) from payment group by staff_id having sum(amount) > 30000;
-- 4.
select staff_id ,avg(amount) from payment group by staff_id;
-- 5.
select customer_id,count(payment_id) from payment group by customer_id having count(payment_id)>20;
-- questions
-- 6. find the total amount collected in each month.
-- 7. find the total amount spent by each customer ,but only for amounts greater than 5 
-- 8. find the months where the total collection exceeded 15000
-- 9. find the number of unique customer served by each staff member
-- 10. find staff member who served more then 300 unique customers.
-- answer
-- 6.
select extract(month from payment_date),sum(amount) from payment group by extract(month from payment_date);
-- 7
select customer_id , sum(amount) from payment where amount > 5 group by customer_id;
-- 8
select extract(month from payment_date),sum(amount) from payment group by
 extract(month from payment_date) having sum(amount) > 15000;
 -- 9
select staff_id ,count(distinct(customer_id))  from payment group by staff_id;
-- 10
select staff_id,count(distinct(customer_id)) from payment group by staff_id 
having count(distinct(customer_id)) > 300;

