CREATE DATABASE Sales;
USE Sales;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Country VARCHAR(50),
    Score INT
);

INSERT INTO Customers (CustomerID, Name, Country, Score)
VALUES
(1, 'Rahul', 'India', 80),
(2, 'Amit', 'India', 90),
(3, 'John', 'USA', 75),
(4, 'Priya', 'India', 85),
(5, 'David', 'USA', 90),
(6, 'Neha', 'UK', 70),
(7, 'Karan', 'India', 75),
(8, 'Emma', 'UK', 95);

SELECT * FROM Customers;

CREATE INDEX idx_country
ON Customers (Country);

CREATE INDEX idx_country_score
ON Customers (Country, Score);

SHOW INDEX FROM Customers;

-- Query 1: Search by Country
SELECT * FROM Customers
WHERE Country = 'India';

-- Query 2: Search by Country and Score
SELECT * FROM Customers
WHERE Country = 'India'
AND Score = 90;

-- Query 3: Search by Score only
SELECT * FROM Customers
WHERE Score = 90;

-- Step 1 — Create an index for searching customers by country.
CREATE INDEX idx_country
ON Customers (Country);


SELECT *
FROM Customers
WHERE Country = 'India';

EXPLAIN
SELECT *
FROM Customers
WHERE Country = 'India';

SELECT VERSION();

CREATE UNIQUE INDEX idx_unique_email
ON Customers (Email);

ALTER TABLE Customers
ADD COLUMN Email VARCHAR(100);

INSERT INTO Customers
(CustomerID, Name, Country, Score, Email)
VALUES
(9, 'Rohan', 'India', 88, 'rohan@gmail.com');

INSERT INTO Customers
(CustomerID, Name, Country, Score, Email)
VALUES
(10, 'Mohit', 'India', 78, 'rohan@gmail.com');

SELECT *
FROM Customers;
SELECT *
FROM Customers
WHERE Email = 'rohan@gmail.com';

SHOW INDEX FROM Customers;
