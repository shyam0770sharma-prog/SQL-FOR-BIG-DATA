CREATE DATABASE IF NOT EXISTS SalesDB;

USE SalesDB;

-- =========================================
-- 1. CUSTOMERS
-- =========================================

DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Score INT
);

INSERT INTO Customers
(CustomerID, FirstName, LastName, Country, Score)
VALUES
(1, 'Jossef', 'Goldberg', 'Germany', 350),
(2, 'Kevin', 'Brown', 'USA', 900),
(3, 'Mary', NULL, 'USA', 750),
(4, 'Mark', 'Schwarz', 'Germany', 500),
(5, 'Anna', 'Adams', 'USA', NULL),
(6, 'Vanshika','Upadhyay', 'INDIA', 800),
(7, 'Shyam','Sharma','INDIA', 950);


-- =========================================
-- 2. EMPLOYEES
-- =========================================

DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Department VARCHAR(100),
    BirthDate DATE,
    Gender CHAR(1),
    Salary INT,
    ManagerID INT
);

INSERT INTO Employees
(EmployeeID, FirstName, LastName, Department, BirthDate, Gender, Salary, ManagerID)
VALUES
(1, 'Frank', 'Lee', 'Marketing', '1988-12-05', 'M', 55000, NULL),
(2, 'Kevin', 'Brown', 'Marketing', '1972-11-25', 'M', 65000, 1),
(3, 'Mary', NULL, 'Sales', '1986-01-05', 'F', 75000, 1),
(4, 'Michael', 'Ray', 'Sales', '1977-02-10', 'M', 90000, 2),
(5, 'Carol', 'Baker', 'Sales', '1982-02-11', 'F', 55000, 3),
(6, 'Vanshika','Upadhyay','IT','2005-11-22', 'F',85000,null),
(7, 'Shyam','Sharma','IT', '2002-11-26','M',90000,6);
-- =========================================
-- 3. PRODUCTS
-- =========================================

DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Product VARCHAR(50),
    Category VARCHAR(50),
    Price INT
);

INSERT INTO Products
(ProductID, Product, Category, Price)
VALUES
(101, 'Bottle', 'Accessories', 10),
(102, 'Tire', 'Accessories', 15),
(103, 'Socks', 'Clothing', 20),
(104, 'Caps', 'Clothing', 25),
(105, 'Gloves', 'Clothing', 30);


-- =========================================
-- 4. ORDERS
-- =========================================

DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    SalesPersonID INT,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus VARCHAR(50),
    ShipAddress VARCHAR(255),
    BillAddress VARCHAR(255),
    Quantity INT,
    Sales INT,
    CreationTime DATETIME
);

INSERT INTO Orders
(OrderID, ProductID, CustomerID, SalesPersonID,
 OrderDate, ShipDate, OrderStatus, ShipAddress,
 BillAddress, Quantity, Sales, CreationTime)
VALUES
(1, 101, 2, 3, '2025-01-01', '2025-01-05',
 'Delivered', '9833 Mt. Dias Blv.', '1226 Shoe St.', 1, 10,
 '2025-01-01 12:34:56'),

(2, 102, 3, 3, '2025-01-05', '2025-01-10',
 'Shipped', '250 Race Court', NULL, 1, 15,
 '2025-01-05 23:22:04'),

(3, 101, 1, 5, '2025-01-10', '2025-01-25',
 'Delivered', '8157 W. Book', '8157 W. Book', 2, 20,
 '2025-01-10 18:24:08'),

(4, 105, 1, 3, '2025-01-20', '2025-01-25',
 'Shipped', '5724 Victory Lane', '', 2, 60,
 '2025-01-20 05:50:33'),

(5, 104, 2, 5, '2025-02-01', '2025-02-05',
 'Delivered', NULL, NULL, 1, 25,
 '2025-02-01 14:02:41'),

(6, 104, 3, 5, '2025-02-05', '2025-02-10',
 'Delivered', '1792 Belmont Rd.', NULL, 2, 50,
 '2025-02-06 15:34:57'),

(7, 102, 1, 1, '2025-02-15', '2025-02-27',
 'Delivered', '136 Balboa Court', '', 2, 30,
 '2025-02-16 06:22:01'),

(8, 101, 4, 3, '2025-02-18', '2025-02-27',
 'Shipped', '2947 Vine Lane', '4311 Clay Rd', 3, 90,
 '2025-02-18 10:45:22'),

(9, 101, 2, 3, '2025-03-10', '2025-03-15',
 'Shipped', '3768 Door Way', '', 2, 20,
 '2025-03-10 12:59:04'),

(10, 102, 3, 5, '2025-03-15', '2025-03-20',
 'Shipped', NULL, NULL, 0, 60,
 '2025-03-16 23:25:15');


-- =========================================
-- 5. ORDERS ARCHIVE
-- =========================================

DROP TABLE IF EXISTS OrdersArchive;

CREATE TABLE OrdersArchive (
    OrderID INT,
    ProductID INT,
    CustomerID INT,
    SalesPersonID INT,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus VARCHAR(50),
    ShipAddress VARCHAR(255),
    BillAddress VARCHAR(255),
    Quantity INT,
    Sales INT,
    CreationTime DATETIME
);

INSERT INTO OrdersArchive
(OrderID, ProductID, CustomerID, SalesPersonID,
 OrderDate, ShipDate, OrderStatus, ShipAddress,
 BillAddress, Quantity, Sales, CreationTime)
VALUES
(1, 101, 2, 3, '2024-04-01', '2024-04-05',
 'Shipped', '123 Main St', '456 Billing St', 1, 10,
 '2024-04-01 12:34:56'),

(2, 102, 3, 3, '2024-04-05', '2024-04-10',
 'Shipped', '456 Elm St', '789 Billing St', 1, 15,
 '2024-04-05 23:22:04'),

(3, 101, 1, 4, '2024-04-10', '2024-04-25',
 'Shipped', '789 Maple St', '789 Maple St', 2, 20,
 '2024-04-10 18:24:08'),

(4, 105, 1, 3, '2024-04-20', '2024-04-25',
 'Shipped', '987 Victory Lane', '', 2, 60,
 '2024-04-20 05:50:33'),

(4, 105, 1, 3, '2024-04-20', '2024-04-25',
 'Delivered', '987 Victory Lane', '', 2, 60,
 '2024-04-20 14:50:33'),

(5, 104, 2, 5, '2024-05-01', '2024-05-05',
 'Shipped', '345 Oak St', '678 Pine St', 1, 25,
 '2024-05-01 14:02:41'),

(6, 104, 3, 5, '2024-05-05', '2024-05-10',
 'Delivered', '543 Belmont Rd.', NULL, 2, 50,
 '2024-05-06 15:34:57'),

(6, 104, 3, 5, '2024-05-05', '2024-05-10',
 'Delivered', '543 Belmont Rd.', '3768 Door Way', 2, 50,
 '2024-05-07 13:22:05'),

(6, 101, 3, 5, '2024-05-05', '2024-05-10',
 'Delivered', '543 Belmont Rd.', '3768 Door Way', 2, 50,
 '2024-05-12 20:36:55'),

(7, 102, 3, 5, '2024-06-15', '2024-06-20',
 'Shipped', '111 Main St', '222 Billing St', 0, 60,
 '2024-06-16 23:25:15');

SELECT
     EXTRACT(YEAR FROM OrderDate) AS year,
     SUM(Sales) AS total_sales
 FROM orders
 GROUP BY EXTRACT(YEAR FROM OrderDate);

SELECT *
 FROM orders
 WHERE EXTRACT(MONTH FROM OrderDate) = 2
;

select
 OrderID,
 CreationTime,
 day(CreationTime) day,
 month(CreationTime) as month,
 year(CreationTime) as year
 from Orders;

select
 OrderID,
 CreationTime,
 dayname(CreationTime)
 from Orders;

select
 OrderID,
 CreationTime,
 monthname(CreationTime)
 from Orders;

select
 Year(OrderDate),
 count(*) NrofOrders
 from Orders
 group by Year(OrderDate);

select
 monthname(OrderDate),
 count(*) NrofOrders
 from Orders
 group by monthname(OrderDate);
 
 
 
select 
 *
 from Orders
 where month(OrderDate) = 2;
 
SELECT
     OrderID,
     CreationTime,
     DAYNAME(CreationTime) AS dd
 FROM Orders;


SELECT 
     OrderID,
     OrderDate,
     DATE_ADD(OrderDate, INTERVAL 2 month) AS TwoYearsLater
 FROM Orders;

select
 OrderID,
 OrderDate CurrentOrderDate,
 LAG(OrderDate) over(order by OrderDate) PreviousOrderDate
 from Orders;


select
 OrderID,
 OrderDate CurrentOrderDate,
 LAG(OrderDate) over(order by OrderDate) PreviousOrderDate,
 OrderDate - LAG(OrderDate) over(order by OrderDate) as Datediff
 from Orders;

SELECT
     OrderID,
     OrderDate AS CurrentOrderDate,
     LAG(OrderDate) OVER(ORDER BY OrderDate) AS PreviousOrderDate,
     DATEDIFF(
         OrderDate,
         LAG(OrderDate) OVER(ORDER BY OrderDate)
     ) AS DateDiff
 FROM Orders;
 
SELECT STR_TO_DATE('2026-09-15', '%Y-%m-%d') as date;

SELECT 
CustomerID,
Score,
COALESCE(Score,0) Score2,
AVG(Score)over() Avg_Score,
AVG(COALESCE(Score,0)) over() AVG_Score2
from Customers;

SELECT 
CustomerID,
FirstName,
LastName,
concat(FirstName,' ',coalesce(LastName,'')) as FullName,
Score,
coalesce(Score,0) +10 as ScoreBonus
FROM Customers;

SELECT
CustomerID,
Score,
coalesce(Score,9999999)
FROM Customers
ORDER BY coalesce(Score,9999999);

SELECT
CustomerID,
Score
FROM Customers
ORDER BY case when Score is null then 1 else 0 end,Score;

select 
OrderID,
Sales,
Quantity,
Sales / nullif(Quantity,0) as price
from Orders;

select 
*
from Customers
where Score is null;

select 
*
from Customers
where Score is not null;

select 
c.* ,
o.OrderID 
from 
Customers c 
left join Orders as o
on c.CustomerID = o.CustomerID
where o.CustomerID is null;

-- Case Statement
select FirstName,Score,
 case
			when Score > 700 then 'High'
            when Score >= 500 then 'Medium'
            else 'low'
 end as score
	from Customers ;	
select 
Category,
sum(Sales) as TotalSales
from(
	select 
	OrderID,
	Sales,
	case
		when Sales > 50 then 'High'
		when Sales > 20 then 'Medium'
		else 'Low'
	end Category
	from Orders
)t 
group by Category
order by TotalSales desc;

select 
EmployeeID,
FirstName,
LastName,
Gender,
case
	when Gender = 'F' then 'Female'
    when Gender = 'M' then 'Male'
    else 'Not Avaiable'
end GenderFull
from Employees;

select 
CustomerID,
FirstName,
LastName,
Country,
case
	when Country = 'Germany' then 'DE'
    when Country = 'USA' then 'US'
    when Country = 'INDIA' then 'IN'
    else 'n/a'
end as ShortName
from Customers;


-- Quick form
select 
CustomerID,
FirstName,
LastName,
Country,
case Country
	when  'Germany' then 'DE'
    when 'USA' then 'US'
    when 'INDIA' then 'IN'
    else 'n/a'
end as ShortName
from Customers;

select 
CustomerID,
LastName,
Score,
case
	when Score is null then 0
    else  Score
end ScoreClean,
avg(case
	when Score is null then 0
    else  Score
	end) over() AvgCustomerClean,

AVG(Score) over() AVGCustomer
from Customers;

select 
	CustomerID,
    sum(case
		when Sales > 30 then 1
        else 0
	end ) TotalOrderHighSales,
    count(*) TotalOrders
    
from Orders
group by CustomerID
;
-- Aggregate Functions

select 
count(*) as total_nr_orders
from Orders;

select 
sum(Sales) as total_sales
from Orders;

select 
avg(Sales) as avg_sales
from Orders;

select 
max(Sales) as Highest_sales
from Orders;

select 
min(Sales) as lowest_sales
from Orders;

select 
CustomerID,
count(*) as total_nr_orders,
sum(Sales) as total_sales,
avg(Sales) as avg_sales,
max(Sales) as Highest_sales,
min(Sales) as lowest_sales
from Orders
group by  CustomerID;

-- Window Basics

select
sum(Sales) TotalSales
from Orders;
-- find total sales for each product
select 
OrderID,
OrderDate,
ProductID,
sum(Sales) over(partition by ProductID) as total
from Orders; 

 select 
 OrderID,
 OrderDate,
 ProductID,
 OrderStatus,
 Sales,
 sum(Sales) over() TotalSales,
 sum(Sales) over(partition by ProductID) SalesByProducts,
 sum(sales) over(partition by ProductID,OrderStatus) SalesByProductAndStatus
 from Orders;
 
 select 
  OrderID,
  OrderDate,
  rank() over(order by Sales) RankSales
from Orders;

 select 
 OrderID,
 OrderDate,
 OrderStatus,
 Sales,
 sum(Sales) over(partition by OrderStatus order by OrderDate
 rows between current row and 2 following) TotaleSales
 from Orders;
 
  select 
 OrderID,
 OrderDate,
 OrderStatus,
 Sales,
 sum(Sales) over(partition by OrderStatus order by OrderDate
 rows between 2 preceding and current row) TotaleSales
 from Orders;
 
  select 
 OrderID,
 OrderDate,
 OrderStatus,
 Sales,
 sum(Sales) over(partition by OrderStatus order by OrderDate
 rows unbounded preceding) TotaleSales
 from Orders;
 -- Rank Customer base on their total sales
 select 
   CustomerID,
   sum(Sales) TotalSales,
   rank() over(order by sum(Sales) desc) RankCustomers
from Orders
group by CustomerID;

-- Window Aggregate Func. 

select
 OrderID,
 OrderDate,
count(*) over() TotalOrders
from Orders;

select
 OrderID,
 OrderDate,
 CustomerID,
count(*) over() TotalOrders,
count(*) over(partition by CustomerID) OrderByCustomers
from Orders;

select 
*,
count(*) over() totalCustomersStar,
count(1) over() totalCustomersone,
count(Score) over() totalScore,
count(Country) over() totalCountries
from Customers;
