use sakila ;
show tables;
select * from payment;
-- i need to find payment_id 5 amount equal to payment_ids;
select amount from payment where payment_id= 5;
select * from payment where amount=9.99;
select * from payment where amount=
(select amount from payment where payment_id= 5);
-- Q. get the payment_id and amount where the amount is not 
-- equel to the amount of payment_id 23
select payment_id, amount from payment where amount <> 
(select amount from payment where payment_id=23);
select amount from payment where payment_id=23;
-- Q. get the payment_id ,customer_id,amount and payment_date
-- where the month of payment should be same as of payment_id=6
select payment_id,customer_id,amount,payment_date from payment where month(payment_date)=
(select month(payment_date) from payment where payment_id=6);
select * from payment;
select month(payment_date) from payment where payment_id=6;
-- get all the column from payment table where the staff serving the customer
-- should be same as of payment_id = 7
select * from payment where staff_id =
 (select staff_id from payment where payment_id=7);
 -- Q. get all the payment information where the amount is same as of
 -- the highest amount from the payment table;
 select * from payment where amount =(select max(amount) from payment);
 -- Q.get the amount and the total number of payments done for each amount
 -- only for those payments who's amount is less  then amount of rental_id
 -- 1725
 select amount,count(payment_id) from payment where amount <
 (select amount from payment where rental_id=1725 )
 group by amount;
 -- get the month and the total amount spend only for those customer
 -- who's month of payment is greter then customer_id=1 and payment_id=3;
 SELECT MONTH(payment_date) ,SUM(amount) FROM payment WHERE MONTH(payment_date) >
(SELECT MONTH(payment_date)FROM payment WHERE customer_id = 1 AND payment_id = 3)
GROUP BY MONTH(payment_date);
 

