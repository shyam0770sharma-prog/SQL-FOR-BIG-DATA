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

-- Check whether the table 'orders' contains any duplicate rows

select 
OrderID,
count(*) over(partition by OrderID) CheckPK
from Orders;

select 
 OrderID,
 count(*) over(partition by OrderID) checkPK
from OrdersArchive;

select 
*
from (
       select 
 OrderID,
 count(*) over(partition by OrderID) checkPK
from OrdersArchive
) t where checkPK > 1;

-- sum () windows
select
	OrderID,
	OrderDate,
	Sales,
	ProductID,
	sum(Sales) over () totalsales,
	sum(Sales) over(partition by ProductID) SalesByProducts
from Orders;

select
 OrderID,
 ProductID,
 Sales,
 sum(Sales) over() totalSales,
 round(cast(Sales as float) / sum(Sales) over() * 100,2) PercentageofTotal
from Orders;
-- find the average score of customers
select
	OrderID,
	OrderDate,
	Sales,
	ProductID,
	avg(Sales) over () Avg_sales,
	avg(coalesce(Sales,0)) over(partition by ProductID) AvgSalesByProducts
from Orders;

-- whith null values 
select
 CustomerID,
 LastName,
 Score,
coalesce(Score,0) CustomerScore,
 avg(Score) over () AvgScore,
 avg(coalesce(Score,0)) over() AvgScoreWithoutNull
from Customers;
-- find all orders where sales are higher then the average sales across all orders

select
* 
from (
      select
		   OrderID,
		   ProductID,
		   Sales,
		   avg(Sales) over() AvgSales
	  from Orders
)t where Sales > AvgSales;

/*
find the highest and lowest sales of all orders
find the highest and lowest sales for each product
provide details as orderid and order date*/
select
OrderID,
	OrderDate,
	ProductID,
	Sales,
	max(Sales) over() HighestSales,
	min(Sales) over() LowestSales,
	max(Sales) over(partition by ProductID) HighestSaleByProduct,
	min(Sales)over(partition by  ProductID)  LowestSalesByProduct
from Orders;

-- show the employee who have the highest salaries
select
*
from(
select
*,
max(Salary) over() HighestSalary
from Employees
)t where Salary = HighestSalary;

-- find the deviation of each sales from the minimum and maximum sales amount
select
  OrderID,
  OrderDAte,
  ProductID,
  Sales,
  max(sales) over() HighestSales,
  min(Sales) over() LowestSales,
  Sales -  min(Sales) over() DeviationFromMin,
  max(sales) over() - Sales DeviationFromMax
from Orders;

-- Running & Rolling Total

-- Calculate moving average of sales for each product over time
-- including only the next order
select 
  OrderID,
  ProductID,
  OrderDate,
  Sales,
  avg(Sales) over(partition by ProductID) AvgByProduct,
  avg(Sales) over(partition by ProductID order by OrderDate) MovingAvg,
  avg(Sales) over(partition by ProductID order by OrderDate 
  rows between current row and 1 following) RollingAvg
from Orders;

select 
  OrderID,
  ProductID,
  OrderDate,
  Sales,
  sum(Sales) over(order by OrderID)
from Orders;
  
select 
  OrderID,
  ProductID,
  OrderDate,
  Sales,
  sum(Sales) over(partition by ProductID)
  from Orders;
  
  -- Ranking window Function
select
  OrderID,
  ProductID,
  Sales,
  row_number() over(order by Sales desc) SalesRank_row
from Orders;

select
  OrderID,
  ProductID,
  Sales,
  rank() over(order by Sales desc) SalesRank_row
from Orders;

select
  OrderID,
  ProductID,
  Sales,
  dense_rank() over(order by Sales desc) SalesRank_row
from Orders;

-- Find the top highest sales for each product

select
*
from(
select
	OrderID,
	ProductID,
	Sales,
	row_number() over(partition by ProductID order by Sales desc) RankByProduct
from Orders)t
where RankByProduct = 1 ;

-- find the lowest 2 customers based on their total sales

select *
from(
select 
      CustomerID,
      sum(Sales) TotleSales,
      row_number () over (order by sum(Sales)) RankCustomers
from Orders
group by 
CustomerID
)t where RankCustomers <= 2;

select
*,
row_number () over(order by OrderID, OrderDate) UniqueID
from
 OrdersArchive;
 
 -- Identify duplicate rows in the table 'Orders Archive'
 -- and return a clean result without any duplicates
 select *
 from(
 select *,
 row_number() over (partition by OrderID order by CreationTime desc) rn 
 from  OrdersArchive
 )t where rn = 1;
 
 -- ntile()
  
  select
  OrderID,
  Sales,
  ntile(2) over (order by Sales desc) secondBucket
  from Orders;
  
    select
  OrderID,
  Sales,
  ntile(1) over (order by Sales desc) OneBucket
  from Orders;
  
    select
  OrderID,
  Sales,
  ntile(3) over (order by Sales desc) ThardBucket
  from Orders;
  
    select
  OrderID,
  Sales,
  ntile(4) over (order by Sales desc) ForthBucket
  from Orders;
  
  -- Segment all orders into 3 Category : high, medium and low Sales
  
  select
  *,
  case when Buckets = 1 then 'High'
	   when Buckets = 2 then 'Medium'
       when Buckets = 3 then 'Low'
end SalesSegmentations
from (
      select 
           OrderID,
           Sales,
           ntile(3) over (order by Sales desc) Buckets
	  from Orders
)t ;
-- In orders to export the data , divide the orders into 2 groups

select
*,
ntile(4) over (order by OrderID)
from Orders;

-- Percentage - Based Ranking
-- Percent_RANK
-- CUME_DIST
-- Find the products that fall within the highest 40% of the prices
SELECT 
*,
CONCAT(DistRank * 100,'%') DistPerc
FROM(
	SELECT
	  Product,
	  Price,
	  CUME_DIST() OVER (ORDER BY Price DESC ) DistRank
	FROM Products
)t
WHERE DistRank <= 0.4;

SELECT 
*,
CONCAT(DistRank * 100,'%') DistPerc
FROM(
	SELECT
	  Product,
	  Price,
	  PERCENT_RANK() OVER (ORDER BY Price DESC ) DistRank
	FROM Products
)t
WHERE DistRank <= 0.4;

-- Window Value functions
 -- Analyze the month-over-month performance by finding the percentage change
 -- in Sales between the current and previous months
 SELECT
 *,
 CurrentMonthSales - PreviousMonthSales as MoM_Change,
 ROUND(CAST((CurrentMonthSales - PreviousMonthSales) as FLOAT)/PreviousMonthSales * 100,1) as MoM_Perc
 FROM(
 SELECT
      MONTH(OrderDate) OrderMonth,
      SUM(Sales)  CurrentMonthSales,
      LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
FROM Orders
GROUP BY 
      MONTH(OrderDate)
)t;
    
 -- In order to analyze customer loyalty,
-- rank customers based on the average days between their orders

SELECT
    CustomerID,
    AVG(DaysUntilNextOrder) AS AvgDays,
    RANK() OVER (
        ORDER BY COALESCE(AVG(DaysUntilNextOrder), 999999)
    ) AS RankAvg
FROM (
    SELECT
        OrderID,CustomerID,
        OrderDate AS CurrentOrder,
        LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate
        ) AS NextOrder,
        DATEDIFF(
            LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate),
            OrderDate) AS DaysUntilNextOrder
    FROM Orders
) t
GROUP BY CustomerID;

-- Find the lowest and highest sales for each product
-- Find the difference in sales between the current and the lowest sales

SELECT
    OrderID,
    ProductID,
    Sales,
    FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) LowestSales,
    LAST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales,
    Sales - FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) AS SalesDifference
FROM Orders;


-- subquery
-- Singale Value
SELECT
AVG(Sales)
FROM Orders;
-- Row Subquery
SELECT 
CustomerID
from Customers;
-- Table Subquery
SELECT 
OrderID,
OrderDate
FROM Orders;

-- Find the products that have a price 
--  higher than average price of all products

SELECT
*
FROM
     (SELECT
     ProductID,
     Price,
     AVG(Price) OVER () AvgPrice
     FROM Products)t
WHERE Price > AvgPrice;

-- Rank Customers based on their total amount of sales
SELECT
*,
RANK() OVER(ORDER BY TotalSales DESC) CustomerRank
FROM 
      (SELECT
      CustomerID,
      SUM(Sales) TotalSales
      FROM Orders
      GROUP BY CustomerID)t
;
-- Show the product ID's product names,prices,and the total number of orders
SELECT
    ProductID,
    Product,
    Price,
    (SELECT COUNT(*) FROM Orders) AS Totalorders
FROM Products; 

-- Show all Customer details and find the total orders of each customer
SELECT
c.*,
o.TotalOrders
FROM Customers c 
LEFT JOIN (
      SELECT 
      CustomerID,
      COUNT(*) TotalOrders
      FROM Orders
      GROUP BY CustomerID) o 
ON c.CustomerID = o.CustomerID;

-- Find the products that have a price higher then the average price of all products
  SELECT 
  ProductID,
  Price
  FROM Products
  WHERE Price > (SELECT AVG(Price) FROM Products)
  ;
  
  -- show the details of orders made by customers in germany
SELECT
* 
FROM Orders
WHERE CustomerID IN 
                    (SELECT
					CustomerID
                    FROM Customers
                    WHERE Country = 'Germany');
                    
SELECT
* 
FROM Orders
WHERE CustomerID NOT IN 
                    (SELECT
					CustomerID
                    FROM Customers
                    WHERE Country = 'Germany');
                    
-- Find feamel employees whose salaries are geater 
-- then the salaries of any male employees

SELECT 
      EmployeeID,
      FirstName,
      Salary
FROM Employees
WHERE Gender = 'F'
AND Salary > any 
(SELECT Salary FROM Employees where Gender = 'M');

-- Find feamel employees whose salaries are geater 
-- then the salaries of all male employees
SELECT 
      EmployeeID,
      FirstName,
      Salary
FROM Employees
WHERE Gender = 'F'
AND Salary > all 
(SELECT Salary FROM Employees where Gender = 'M');

-- Correlated Subquery
-- Show all customer details and find the total orders of each customer

SELECT
*,
(SELECT COUNT(*) FROM Orders o 
WHERE o.CustomerID = c.CustomerID) TotalSales
FROM Customers c ;

-- show the details of orders made by customers in Germany
 
 SELECT 
 *
 FROM Orders o 
 WHERE EXISTS (SELECT 1
               FROM Customers c
               WHERE Country = 'Germany'
               AND o.CustomerID = c.CustomerID);
               
               
  -- NOT MADE BY GERMANY             
 SELECT 
 *
 FROM Orders o 
 WHERE NOT EXISTS (SELECT 1
               FROM Customers c
               WHERE Country = 'Germany'
               AND o.CustomerID = c.CustomerID);
               
-- CTE (COMMON TABLE EXPRESSION)
-- Step1: find the total sales per customer
-- Standalone CTE
WITH CTE_Total_Sales AS 
(
SELECT 
      CustomerID,
      SUM(Sales) AS TotalSales
FROM Orders
GROUP BY CustomerID
)
-- Main query
SELECT 
c.CustomerID,
c.FirstName,
c.LastName,
cts. TotalSales
FROM Customers c 
LEFT JOIN CTE_Total_Sales cts
ON  cts.CustomerID = c.CustomerID;

-- Multiple Standalone CTE
-- Step1: find the total sales per customer
WITH CTE_Total_Sales AS 
(
SELECT 
      CustomerID,
      SUM(Sales) AS TotalSales
FROM Orders
GROUP BY CustomerID
)
-- step2: find the last order date fro each customer 
-- Main query
, CTE_Last_Order AS
(SELECT 
       CustomerID,
       MAX(OrderDate) AS Last_Order
FROM Orders
GROUP BY CustomerID
)
SELECT 
c.CustomerID,
c.FirstName,
c.LastName,
cts. TotalSales,
clo.Last_Order
FROM Customers c 
LEFT JOIN CTE_Total_Sales cts
ON  cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
ON clo.CustomerID = c.CustomerID;

-- Nested - CTE
-- Step1: find the total sales per customer
WITH CTE_Total_Sales AS 
(
SELECT 
      CustomerID,
      SUM(Sales) AS TotalSales
FROM Orders
GROUP BY CustomerID
)
-- step2: find the last order date fro each customer 
-- Main query
, CTE_Last_Order AS
(SELECT 
       CustomerID,
       MAX(OrderDate) AS Last_Order
FROM Orders
GROUP BY CustomerID
)
-- Step 3: rank Customers based on total sales Per Customer
, CTE_Customer_Rank as
(
SELECT 
CustomerID,
TotalSales,
RANK() OVER (ORDER BY TotalSales DESC) AS CustomerRank
FROM CTE_Total_Sales
)
-- Main Query
SELECT 
c.CustomerID,
c.FirstName,
c.LastName,
cts. TotalSales,
clo.Last_Order,
ccr.CustomerRank
FROM Customers c 
LEFT JOIN CTE_Total_Sales cts
ON  cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
ON clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank ccr
ON ccr.CustomerID = c.CustomerID;

-- Step4 : segment customers based on their total sales(Nested CTE)
-- Step1: find the total sales per customer
WITH CTE_Totale_Sales AS 
(
SELECT 
      CustomerID,
      SUM(Sales) AS TotaleSales
FROM Orders
GROUP BY CustomerID
)
-- step2: find the last order date fro each customer 
-- Main query
, CTE_Last_Order AS
(SELECT 
       CustomerID,
       MAX(OrderDate) AS Last_Order
FROM Orders
GROUP BY CustomerID
)
-- Step 3: rank Customers based on total sales Per Customer
, CTE_Customer_Rank as
(
SELECT 
CustomerID,
TotaleSales,
RANK() OVER (ORDER BY TotaleSales DESC) AS CustomerRank
FROM CTE_Totale_Sales
)
 -- Step4 : segment customers based on their total sales
  , CTE_Customer_Segments AS 
  (
  SELECT
  CustomerID,
  CASE WHEN TotaleSales > 100 THEN 'HIGH'
       WHEN TotaleSales > 80 THEN 'MEDIUM'
       ELSE 'LOW'
  END CustomerSegments
  FROM CTE_Totale_Sales
  )
-- Main Query
SELECT 
c.CustomerID,
c.FirstName,
c.LastName,
cts. TotaleSales,
clo.Last_Order,
ccr.CustomerRank,
ccs.CustomerSegments
FROM Customers c 
LEFT JOIN CTE_Totale_Sales cts
ON  cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
ON clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank ccr
ON ccr.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segments ccs
ON ccs.CustomerID = c.CustomerID;


-- genrate a Sequence of Number from 1 to 20

WITH RECURSIVE numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 20
)
SELECT *
FROM numbers;

-- show the employee hierarchy by displaying each employee's
-- level within the organization. 

WITH RECURSIVE CTE_Emp_Hierarchy AS
(
   SELECT
        EmployeeID,
        FirstName,
        ManagerID,
        1 as Level
	FROM Employees
    WHERE ManagerID IS NULL
    
    UNION ALL
    
    SELECT
		e.EmployeeID,
        e.FirstName,
        e.ManagerID,
        Level +1
	FROM Employees AS e
    INNER JOIN CTE_Emp_Hierarchy ceh
    ON e.ManagerID = ceh.EmployeeID
)
select 
* 
from CTE_Emp_Hierarchy ;


-- FIND THE RUNNING  TOTAL OF SALES EACH MONTH

-- VIEW 
WITH CTE_Monthly_Summery AS (
SELECT 
  EXTRACT(MONTH from OrderDate) as OrderMonth,
  sum(Sales) TotalSales,
  COUNT(OrderID) AS TOTALORDERS,
  SUM(Quantity) TOTALQUANTITIES
  from Orders
  group by  EXTRACT(MONTH from OrderDate)
  )
SELECT 
OrderMonth,
TotalSales,
SUM(TotalSales) OVER(ORDER BY OrderMonth) AS RunningTotal
FROM CTE_Monthly_Summery;

-- Provide a View that combines details from orders,products, customers
-- and employees
drop view V_Orders_Details;

CREATE VIEW V_Orders_Details AS (
  select
   OrderID,
   o.OrderDate,
   p.Product,
   p.Category,
   coalesce(concat(c.FirstName,'',c.LastName),'') CustomerName,
   c.Country CustomerCountry,
   coalesce(concat(e.FirstName,'',e.LastName),'') SalesName,
   e.Department,
   o.Sales,
   o.Quantity
   from Orders o 
   left join Products p 
   on p.ProductID = o.ProductID
   left join Customers c 
   on c.CustomerID = o.CustomerID
   left join Employees e
   on e.EmployeeID = o.SalesPersonID
   );
  
-- Provide a view for EU Sales Team
-- that combain details from all tables
-- and excludes Data related to the USA

drop view V_Orders_Details_EU;

CREATE VIEW V_Orders_Details_EU AS (
  select
   OrderID,
   o.OrderDate,
   p.Product,
   p.Category,
   coalesce(concat(c.FirstName,'',c.LastName),'') CustomerName,
   c.Country CustomerCountry,
   coalesce(concat(e.FirstName,'',e.LastName),'') SalesName,
   e.Department,
   o.Sales,
   o.Quantity
   from Orders o 
   left join Products p 
   on p.ProductID = o.ProductID
   left join Customers c 
   on c.CustomerID = o.CustomerID
   left join Employees e
   on e.EmployeeID = o.SalesPersonID
   where c.Country != 'USA'
   );

-- CTAS
drop table MonthlyOrders ;

CREATE TABLE MonthlyOrders AS
(
    SELECT
        monthname(OrderDate) AS OrderMonth,
        COUNT(OrderID) AS TotalOrders
    FROM Orders
    GROUP BY monthname(OrderDate)
);

SELECT * FROM MonthlyOrders;
  
  
  -- TEMP Table
  
  CREATE TEMPORARY TABLE temp_name AS
SELECT *
FROM Orders
;

select 
* 
from temp_name;

SET SQL_SAFE_UPDATES = 0;

delete from temp_name
where OrderStatus = 'Delivered';

select 
* 
from temp_name;

select 
* 
from temp_name;

delete from temp_name
where ProductID = 102;

delete from temp_name
where Quantity = 2;



CREATE TEMPORARY TABLE OrdersTest AS
SELECT *
FROM Orders
;

-- Step 1: Write a query 
-- For us customers  find yhe total number  of customers the avegare score

select 
  count(*)  Totalcustomers,
  avg(score) AvgScore
from Customers
where Country = 'USA';

-- Step 2 : Turning the query into stored procedure

DELIMITER //

CREATE PROCEDURE GetCustomerSummary()
BEGIN
    SELECT
        COUNT(*) AS TotalCustomers,
        AVG(score) AS AvgScore
    FROM Customers
    WHERE Country = 'USA';
END //

DELIMITER ;

-- sTEP 3: EXECUTE the Stored Procedure
CALL GetCustomerSummary();

-- For German Customers Find the Total Number of Customers and the Average

DELIMITER //

CREATE PROCEDURE GetCustomerSummaryGermany(IN p_Country VARCHAR(50))
BEGIN
    SELECT
        COUNT(*) AS TotalCustomers,
        AVG(score) AS AvgScore
    FROM Customers
    WHERE Country = p_Country;
END //

DELIMITER ;

CALL GetCustomerSummaryGermany('Germany');

CALL GetCustomerSummaryGermany('USA');

CALL GetCustomerSummaryGermany('INDIA');

drop PROCEDURE GetCustomerSummaryGermany;

-- find the total Nr. of Orders and Total Sales
select 
count(OrderID) TotalOrders,
sum(Sales) TotalSales
from Orders o 
join Customers c 
on c.CustomerID = o.CustomerID
where C.Country = 'USA';
DELIMITER //

CREATE PROCEDURE Get_Customer_SummaryGermany(IN p_Country VARCHAR(50))
BEGIN    
-- find the total Nr. of Orders and Total Sales
select 
count(OrderID) TotalOrders,
sum(Sales) TotalSales
from Orders o 
join Customers c 
on c.CustomerID = o.CustomerID
where c.Country = p_Country ;
END //

DELIMITER ;

call Get_Customer_SummaryGermany('Germany');
call Get_Customer_SummaryGermany('USA');

drop procedure Get_Customer_SummaryGermany ;



DELIMITER //

CREATE PROCEDURE GetCustomer__Summary(
    IN p_Country VARCHAR(50)
)
BEGIN

    DECLARE TotalCustomers INT;
    DECLARE AvgScore FLOAT;

    -- Prepare & Cleanup Data
    IF EXISTS (
        SELECT 1
        FROM Customers
        WHERE Score IS NULL
          AND Country = p_Country
    ) THEN

        SELECT 'Updating NULL Scores to 0' AS Message;

        UPDATE Customers
        SET Score = 0
        WHERE Score IS NULL
          AND Country = p_Country;

    ELSE

        SELECT 'No NULL Scores found' AS Message;

    END IF;
SET SQL_SAFE_UPDATES = 0;

UPDATE Sales.Customers
SET Score = 0
WHERE Score IS NULL
  AND Country = p_Country;

    -- Generating Reports
    SELECT
        COUNT(*) AS TotalCustomers,
        AVG(Score) AS AvgScore
    FROM Sales.Customers
    WHERE Country = p_Country;

END //

DELIMITER ;

CALL GetCustomer__Summary('USA');

CALL GetCustomer__Summary('INDIA');
CALL GetCustomer__Summary('Germany');
DROP PROCEDURE GetCustomer__Summary;




SET SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS GetCustomer_Summary;

DELIMITER //

CREATE PROCEDURE GetCustomer_Summary(
    IN p_Country VARCHAR(50)
)
BEGIN

    DECLARE TotalCustomers INT;
    DECLARE AvgScore FLOAT;

    -- Prepare & Cleanup Data
    IF EXISTS (
        SELECT 1
        FROM Customers
        WHERE Score IS NULL
          AND Country = p_Country
    ) THEN

        SELECT 'Updating NULL Scores to 0' AS Message;

        UPDATE Customers
        SET Score = 0
        WHERE Score IS NULL
          AND Country = p_Country;

    ELSE

        SELECT 'No NULL Scores found' AS Message;

    END IF;

    -- Generating Reports
    SELECT
        COUNT(*) AS TotalCustomers,
        AVG(Score) AS AvgScore
    FROM Customers
    WHERE Country = p_Country;

END //

DELIMITER ;

CALL GetCustomer_Summary('USA');

CALL GetCustomer_Summary('INDIA');

CALL GetCustomer_Summary('Germany');

SELECT *
FROM Customers;



DELIMITER //

CREATE PROCEDURE GetCustomerSummary(
    IN p_Country VARCHAR(50)
)
BEGIN

    DECLARE ErrorMessage VARCHAR(500);
    DECLARE ErrorNumber INT;

    -- Error Handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN

        GET DIAGNOSTICS CONDITION 1
            ErrorMessage = MESSAGE_TEXT,
            ErrorNumber = MYSQL_ERRNO;

        SELECT 'An error occured.' AS Message;

        SELECT CONCAT('Error Message: ', ErrorMessage) AS Message;

        SELECT CONCAT('Error Number: ', ErrorNumber) AS Message;

    END;


    -- Main Code
    BEGIN

        SELECT
            COUNT(o.OrderID) AS TotalOrders,
            SUM(o.Sales) AS TotalSales,
            1 / 0
        FROM Sales.Orders o
        JOIN Sales.Customers c
            ON c.CustomerID = o.CustomerID
        WHERE c.Country = p_Country;

    END;

END //

DELIMITER ;

drop procedure GetCustomerSummary;
CALL GetCustomerSummary('USA');

-- Triggers
 /*                ┌─────────────────┐
                 │   TABLE EVENT   │
                 └────────┬────────┘
                          │
             ┌────────────┼────────────┐
             ↓            ↓            ↓
          INSERT        UPDATE       DELETE
             │            │            │
             └────────────┼────────────┘
                          ↓
                    ┌───────────┐
                    │  TRIGGER  │
                    └─────┬─────┘
                          │
                ┌─────────┴─────────┐
                ↓                   ↓
             BEFORE               AFTER
                │                   │
                ↓                   ↓
          Before event         After event
          
                              TRIGGERS
                       │
          ┌────────────┴────────────┐
          │                         │
       BEFORE                      AFTER
          │                         │
    ┌─────┼─────┐             ┌─────┼─────┐
    ↓     ↓     ↓             ↓     ↓     ↓
 INSERT UPDATE DELETE       INSERT UPDATE DELETE
 
 */ 

USE Sales;

CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeName VARCHAR(100)
);

DELIMITER //

CREATE TRIGGER trg_AfterInsertEmployee
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN

    INSERT INTO EmployeeLogs
        (EmployeeID, LogMessage, LogDate)
    VALUES
        (
            NEW.EmployeeID,
            CONCAT('New Employee Added = ', CAST(NEW.EmployeeID AS CHAR)),
            NOW()
        );

END //

DELIMITER ;

INSERT INTO Employees (EmployeeName)
VALUES ('Shyam');

SELECT * FROM Employees;

SELECT * FROM EmployeeLogs;


-- index 

USE Sales;

CREATE TABLE salesdb AS
SELECT *
FROM employees
;

SHOW TABLES;

SELECT * FROM salesdb;

create index idx_salesdb_EmployeeID
on salesdb (EmployeeID);

Drop index idx_salesdb_EmployeeID on salesdb;