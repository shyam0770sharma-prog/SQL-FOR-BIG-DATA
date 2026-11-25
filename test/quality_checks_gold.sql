/*
===============================================================================
Quality Checks: Gold Layer
===============================================================================
Script Purpose:
    This script runs quality checks on the Gold layer views:
    - Uniqueness of surrogate keys in the dimension views
    - Referential integrity between the fact view and the dimension views
    - Consistency of sales, quantity and price in the fact view
    - Valid values in key descriptive columns

Usage Notes:
    Run after creating the Gold views (ddl_gold.sql).
    Expectation: No results, unless a comment says otherwise.
===============================================================================
*/

-- ====================================================================
-- Checking 'gold.dim_customers'
-- ====================================================================
-- Check for Uniqueness of Customer Key
-- Expectation: No results
SELECT
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- Check for duplicate customers after joining the ERP tables
-- Expectation: No results
SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Data Standardization & Consistency
-- Expectation: Male / Female / n/a
SELECT DISTINCT gender
FROM gold.dim_customers;

-- Expectation: Single / Married / n/a
SELECT DISTINCT marital_status
FROM gold.dim_customers;

-- Customers without a country
-- Expectation: No results (or only 'n/a')
SELECT *
FROM gold.dim_customers
WHERE country IS NULL;

-- ====================================================================
-- Checking 'gold.dim_products'
-- ====================================================================
-- Check for Uniqueness of Product Key
-- Expectation: No results
SELECT
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- Check for duplicate products after joining the category table
-- Expectation: No results
SELECT
    product_number,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_number
HAVING COUNT(*) > 1;

-- Products without a matching category
-- Expectation: No results
SELECT *
FROM gold.dim_products
WHERE category IS NULL;

-- Data Standardization & Consistency
-- Expectation: Mountain / Road / Other Sales / Touring / n/a
SELECT DISTINCT product_line
FROM gold.dim_products;

-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Check the data model connectivity between fact and dimensions
-- Expectation: No results
SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL;

-- Check for Invalid Date Orders (Order Date > Shipping/Due Dates)
-- Expectation: No results
SELECT *
FROM gold.fact_sales
WHERE order_date > shipping_date OR order_date > due_date;

-- Check Data Consistency: Sales = Quantity * Price
-- Expectation: No results
SELECT DISTINCT
    sales_amount,
    quantity,
    price
FROM gold.fact_sales
WHERE sales_amount != quantity * price
   OR sales_amount IS NULL OR quantity IS NULL OR price IS NULL
   OR sales_amount <= 0 OR quantity <= 0 OR price <= 0;

-- Row count of the fact view must match the silver sales table
-- Expectation: Both counts are equal (fact joins must not lose or duplicate rows)
SELECT
    (SELECT COUNT(*) FROM gold.fact_sales)           AS gold_rows,
    (SELECT COUNT(*) FROM silver.crm_sales_details)  AS silver_rows;
