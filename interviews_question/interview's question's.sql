
CREATE DATABASE SQLInterviewPractice;
GO


USE SQLInterviewPractice;
GO

-- 1. Customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE
);

-- 2. Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);

-- 3. Products
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- 4. Order Items
CREATE TABLE OrderItems (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    discount_pct DECIMAL(5,2),
    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
);

-- 5. Payments
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
);


INSERT INTO Customers VALUES
(1,'Rahul','Jaipur','India','2025-01-10'),
(2,'Priya','Delhi','India','2025-02-15'),
(3,'Amit','Mumbai','India','2025-03-20'),
(4,'Sneha','Jaipur','India','2025-04-05'),
(5,'Karan','Pune','India','2025-05-12'),
(6,'Neha','Delhi','India','2025-06-18'),
(7,'Rohit','Mumbai','India','2025-07-22'),
(8,'Anjali','Jaipur','India','2025-08-10');

INSERT INTO Orders VALUES
(101,1,'2025-09-01','Delivered'),
(102,2,'2025-09-02','Delivered'),
(103,1,'2025-09-05','Delivered'),
(104,3,'2025-09-07','Cancelled'),
(105,4,'2025-09-10','Delivered'),
(106,5,'2025-09-12','Pending'),
(107,2,'2025-09-15','Delivered'),
(108,6,'2025-09-18','Delivered'),
(109,3,'2025-09-20','Delivered'),
(110,7,'2025-09-22','Cancelled'),
(111,8,'2025-09-25','Delivered'),
(112,1,'2025-10-01','Delivered'),
(113,5,'2025-10-05','Delivered'),
(114,6,'2025-10-10','Pending'),
(115,4,'2025-10-15','Delivered');

INSERT INTO Products VALUES
(201,'Laptop','Electronics',60000),
(202,'Mobile','Electronics',25000),
(203,'Headphones','Accessories',2000),
(204,'Keyboard','Accessories',1500),
(205,'Monitor','Electronics',12000),
(206,'Mouse','Accessories',800),
(207,'Chair','Furniture',7000),
(208,'Desk','Furniture',10000);

INSERT INTO OrderItems VALUES
(1,101,201,1,5),
(2,101,203,2,0),
(3,102,202,1,10),
(4,102,206,2,0),
(5,103,205,2,5),
(6,104,201,1,0),
(7,105,207,1,0),
(8,106,204,3,5),
(9,107,202,2,10),
(10,108,203,3,0),
(11,109,208,1,5),
(12,110,207,2,0),
(13,111,206,5,0),
(14,112,201,1,10),
(15,113,205,1,0),
(16,114,204,2,0),
(17,115,202,1,5);

INSERT INTO Payments VALUES
(1,101,'2025-09-01',61000,'UPI','Success'),
(2,102,'2025-09-02',24300,'Card','Success'),
(3,103,'2025-09-05',22800,'UPI','Success'),
(4,104,'2025-09-07',60000,'Card','Failed'),
(5,105,'2025-09-10',7000,'Cash','Success'),
(6,106,'2025-09-12',4275,'UPI','Pending'),
(7,107,'2025-09-15',45000,'Card','Success'),
(8,108,'2025-09-18',6000,'UPI','Success'),
(9,109,'2025-09-20',9500,'Card','Success'),
(10,110,'2025-09-22',14000,'UPI','Failed'),
(11,111,'2025-09-25',4000,'Cash','Success'),
(12,112,'2025-10-01',54000,'Card','Success'),
(13,113,'2025-10-05',12000,'UPI','Success'),
(14,114,'2025-10-10',3000,'Card','Pending'),
(15,115,'2025-10-15',23750,'UPI','Success');

select * from Customers;

/*
Level 1: Basic SQL (1–8)
Beginner
1. Display all customers who belong to Jaipur.

2. Find all orders whose status is Delivered.

3. Display the top 3 most expensive products.

4. Find customers who signed up after 1 June 2025.

5. Count the total number of orders.

6. Find the average price of products in each category.

7. Display the number of customers in each city, ordered by highest count.

8. Find products whose price is between ₹2,000 and ₹15,000.
*/

-- 1. Display all customers who belong to Jaipur.
select * from Customers where city = 'Jaipur';

-- 2. Find all orders whose status is Delivered.
select * from Orders where order_status = 'Delivered';

-- 3. Display the top 3 most expensive products.
select * from Products;

select top(3) product_name,price from Products 
order by price  desc;

--4. Find customers who signed up after 1 June 2025.
select * from Customers;
select customer_id,customer_name from Customers 
where signup_date >= '2025-6-1';

-- 5. Count the total number of orders.
select * from Orders ;

select count(order_id) from Orders;

-- 6. Find the average price of products in each category.
select * from Products;

select category, cast(avg(price) as int) from Products 
 group by category;

 -- 7. Display the number of customers in each city, ordered by highest count.
 select * from Customers;

SELECT city, COUNT(customer_id) AS customer_count
FROM Customers
GROUP BY city
ORDER BY customer_count DESC;

/*
Level 2: Joins and Aggregations (9–16)
Intermediate
9. Display customer names along with their order IDs and order dates.

10. Find customers who have never placed an order.

11. Find the total number of orders placed by each customer.

12. Calculate the total revenue generated by each product.

13. Find customers who have placed more than 2 orders.

14. Find the total revenue generated by each city. Consider only successfully paid orders.

15. Display each order ID, customer name, product name, quantity, and product price.

16. Find the second-highest-selling product by total quantity sold.
*/

-- 9. Display customer names along with their order IDs and order dates.
select * from Customers;
select * from Orders;
select c.customer_name,o.order_id,o.order_date from Customers as c
inner join Orders as o on c.customer_id = o.customer_id;

-- 10. Find customers who have never placed an order.
select c.customer_id,c.customer_name from Customers as c
left join Orders as o  on c.customer_id = o.customer_id
where o.order_id is null;

-- 11. Find the total number of orders placed by each customer.
select c.customer_id,c.customer_name ,count(o.order_id) as total_orders
 from Customers as c left join Orders as o on c.customer_id = o.customer_id
 group by c.customer_id,c.customer_name order by count(o.order_id) desc ;

-- 12. Calculate the total revenue generated by each product.
select * from Products;
select * from OrderItems;
select product_name, sum(price)over(partition by product_name order by price desc) as total
from Products ;

SELECT
    p.product_name,
    SUM(p.price * oi.quantity) AS total_revenue
FROM Products AS p
INNER JOIN OrderItems AS oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;

-- 13. Find customers who have placed more than 2 orders.
select * from Customers;
select * from Orders;

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(o.order_id) > 2;

-- 14. Find the total revenue generated by each city. Consider only successfully paid orders.
select * from Customers;
select * from Payments;
select * from Orders;
select * from OrderItems;
select * from Products;

SELECT
    c.city,
    SUM(
        p.price * oi.quantity *
        (1 - oi.discount_pct / 100.0)
    ) AS total_revenue
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN OrderItems AS oi
    ON o.order_id = oi.order_id
INNER JOIN Products AS p
    ON oi.product_id = p.product_id
INNER JOIN Payments AS pa
    ON o.order_id = pa.order_id
WHERE pa.payment_status = 'Success'
GROUP BY c.city
ORDER BY total_revenue DESC;