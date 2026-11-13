/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables
    if they already exist.
    Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

CREATE SCHEMA bronze;
GO

USE DataWarehouse;
GO

DROP TABLE IF EXISTS bronze.crm_prd_info;
GO

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
);

CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);

USE master;
GO
DROP TABLE IF EXISTS bronze.crm_cust_info, bronze.crm_prd_info, bronze.crm_sales_details;
DROP SCHEMA IF EXISTS bronze;
GO

USE DataWarehouse;
GO
USE DataWarehouse;
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'bronze')
    EXEC('CREATE SCHEMA bronze');
GO

DROP TABLE IF EXISTS bronze.crm_cust_info;
DROP TABLE IF EXISTS bronze.crm_prd_info;
DROP TABLE IF EXISTS bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
);
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);
GO

USE DataWarehouse;
GO

DROP TABLE IF EXISTS bronze.erp_loc_a101;
DROP TABLE IF EXISTS bronze.erp_cust_az12;
DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);
GO

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);

USE DataWarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
     DECLARE @start_time DATETIME, @end_time DATETIME;
     BEGIN TRY
PRINT '================================================';
PRINT 'Loading Bronze Layer';
PRINT '================================================';

PRINT '------------------------------------------------';
PRINT 'Loading CRM Tables';
PRINT '------------------------------------------------';
SET @start_time = GETDATE() ;
PRINT '>> Truncating Table: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;

PRINT '>> Inserting Data Into: bronze.crm_cust_info'
    BULK INSERT bronze.crm_cust_info
    FROM 'C:\Users\HP\OneDrive\Desktop\Sql-final-project\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
SET @end_time = GETDATE();
PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
PRINT '>> -------------';

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;
PRINT '>> Inserting Data Into: bronze.crm_prd_info';
    BULK INSERT bronze.crm_prd_info
    FROM 'C:\Users\HP\OneDrive\Desktop\Sql-final-project\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

SET @end_time = GETDATE();
PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
PRINT '>> -------------';


SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;
PRINT '>> Inserting Data Into: bronze.crm_sales_details';
    BULK INSERT bronze.crm_sales_details
    FROM 'C:\Users\HP\OneDrive\Desktop\Sql-final-project\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
SET @end_time = GETDATE();
PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
PRINT '>> -------------';



PRINT '------------------------------------------------';
PRINT 'Loading ERP Tables';
PRINT '------------------------------------------------';
SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;

PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
    BULK INSERT bronze.erp_loc_a101
    FROM 'C:\Users\HP\OneDrive\Desktop\Sql-final-project\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
SET @end_time = GETDATE();
PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
PRINT '>> -------------';


SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;
PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
    BULK INSERT bronze.erp_cust_az12
    FROM 'C:\Users\HP\OneDrive\Desktop\Sql-final-project\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
SET @end_time = GETDATE();
PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
PRINT '>> -------------';

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
    BULK INSERT bronze.erp_px_cat_g1v2
    FROM 'C:\Users\HP\OneDrive\Desktop\Sql-final-project\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
SET @end_time = GETDATE();
PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
PRINT '>> -------------';



END TRY
BEGIN CATCH
        PRINT '=========================================';
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message' + ERROR_MESSAGE();
        PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '========================================='
END CATCH
END;
GO

EXEC bronze.load_bronze;
GO

EXEC bronze.load_bronze;
