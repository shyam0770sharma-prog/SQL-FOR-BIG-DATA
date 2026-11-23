/*
===============================================================================
Quality Checks: Silver Layer
===============================================================================
Script Purpose:
    This script runs data quality checks on the 'silver' schema:
    - Null or duplicate primary keys
    - Unwanted spaces in string fields
    - Data standardization and consistency
    - Invalid date ranges and orders
    - Data consistency between related fields
Usage Notes:
    Run after loading the Silver Layer (EXEC silver.load_silver;).
    Expectation: No results, unless a comment says otherwise.
===============================================================================
*/

-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for unwanted Spaces
-- Expectation: No Results
SELECT cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

-- Data Standardization & Consistency
-- Expectation: Single / Married / n/a and Female / Male / n/a
SELECT DISTINCT cst_marital_status FROM silver.crm_cust_info;
SELECT DISTINCT cst_gndr FROM silver.crm_cust_info;

-- ====================================================================
-- Checking 'silver.crm_prd_info'
-- ====================================================================
-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT prd_id, COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted Spaces
-- Expectation: No Results
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for NULLs or Negative Values in Cost
-- Expectation: No Results
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT prd_line FROM silver.crm_prd_info;

-- Check for Invalid Date Orders (Start Date > End Date)
-- Expectation: No Results
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- Check that every product category exists in the category table
-- Expectation: No Results
SELECT *
FROM silver.crm_prd_info
WHERE cat_id NOT IN (SELECT DISTINCT id FROM silver.erp_px_cat_g1v2);

-- ====================================================================
-- Checking 'silver.crm_sales_details'
-- ====================================================================
-- Check for Invalid Dates in Bronze (source of the silver conversion)
-- Expectation: No Results
SELECT NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0
   OR LEN(sls_due_dt) != 8
   OR sls_due_dt > 20500101
   OR sls_due_dt < 19000101;

-- Check for Invalid Date Orders (Order Date > Shipping/Due Dates)
-- Expectation: No Results
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

-- Check Data Consistency: Sales = Quantity * Price
-- Values must not be NULL, zero, or negative.
-- Expectation: No Results
SELECT DISTINCT sls_sales, sls_quantity, sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
   OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- ====================================================================
-- Checking 'silver.erp_cust_az12'
-- ====================================================================
-- Identify Out-of-Range Dates
-- Expectation: Birthdates between 1924-01-01 and Today
SELECT DISTINCT bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE();

-- Data Standardization & Consistency
SELECT DISTINCT gen FROM silver.erp_cust_az12;

-- ====================================================================
-- Checking 'silver.erp_loc_a101'
-- ====================================================================
-- Data Standardization & Consistency
SELECT DISTINCT cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

-- ====================================================================
-- Checking 'silver.erp_px_cat_g1v2'
-- ====================================================================
-- Check for unwanted Spaces
-- Expectation: No Results
SELECT *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance);

-- Data Standardization & Consistency
SELECT DISTINCT maintenance FROM silver.erp_px_cat_g1v2;
