# Data Catalog for Gold Layer

## Overview
The Gold Layer is the business-level data representation, structured as a star schema for analytics and reporting. It consists of **dimension views** and a **fact view**.

---

### 1. gold.dim_customers
- **Purpose:** Stores customer details enriched with demographic and geographic data.
- **Source:** `silver.crm_cust_info`, `silver.erp_cust_az12`, `silver.erp_loc_a101`
- **Grain:** One row per customer.

| Column Name     | Data Type    | Description                                                                                   |
|-----------------|--------------|-----------------------------------------------------------------------------------------------|
| customer_key    | BIGINT       | Surrogate key uniquely identifying each customer record in the dimension.                     |
| customer_id     | INT          | Unique numerical identifier assigned to each customer in the CRM.                             |
| customer_number | NVARCHAR(50) | Alphanumeric identifier of the customer, used for tracking and joining (e.g., 'AW00011000').  |
| first_name      | NVARCHAR(50) | The customer's first name.                                                                    |
| last_name       | NVARCHAR(50) | The customer's last name.                                                                     |
| country         | NVARCHAR(50) | The customer's country of residence (e.g., 'Australia', 'United States', 'Germany').          |
| marital_status  | NVARCHAR(50) | The customer's marital status ('Married', 'Single', 'n/a').                                   |
| gender          | NVARCHAR(50) | The customer's gender ('Male', 'Female', 'n/a'). CRM is the master; ERP is used as fallback.  |
| birthdate       | DATE         | The customer's date of birth (YYYY-MM-DD). Future dates are set to NULL.                      |
| create_date     | DATE         | The date the customer record was created in the CRM.                                          |

---

### 2. gold.dim_products
- **Purpose:** Provides product details, including category, subcategory, and cost.
- **Source:** `silver.crm_prd_info`, `silver.erp_px_cat_g1v2`
- **Grain:** One row per current product (historical versions with an end date are excluded).

| Column Name    | Data Type    | Description                                                                          |
|----------------|--------------|--------------------------------------------------------------------------------------|
| product_key    | BIGINT       | Surrogate key uniquely identifying each product record in the dimension.             |
| product_id     | INT          | Unique numerical identifier assigned to the product in the CRM.                      |
| product_number | NVARCHAR(50) | Alphanumeric product code used for joining to sales (e.g., 'FR-R92B-58').            |
| product_name   | NVARCHAR(50) | Descriptive name of the product.                                                     |
| category_id    | NVARCHAR(50) | Identifier linking the product to its category (e.g., 'CO_RF').                      |
| category       | NVARCHAR(50) | Broad product classification (e.g., 'Bikes', 'Components').                          |
| subcategory    | NVARCHAR(50) | More detailed product classification within the category.                            |
| maintenance    | NVARCHAR(50) | Indicates whether the product requires maintenance ('Yes', 'No').                    |
| cost           | INT          | The cost or base price of the product. NULL costs are replaced with 0.               |
| product_line   | NVARCHAR(50) | The product line ('Mountain', 'Road', 'Other Sales', 'Touring', 'n/a').              |
| start_date     | DATE         | The date the product became available for sale.                                      |

---

### 3. gold.fact_sales
- **Purpose:** Stores transactional sales data for analytical purposes.
- **Source:** `silver.crm_sales_details`, joined to `gold.dim_products` and `gold.dim_customers`
- **Grain:** One row per product per order line.

| Column Name   | Data Type    | Description                                                                         |
|---------------|--------------|-------------------------------------------------------------------------------------|
| order_number  | NVARCHAR(50) | Unique alphanumeric identifier for each sales order (e.g., 'SO54496').              |
| product_key   | BIGINT       | Surrogate key linking the order to `gold.dim_products`.                             |
| customer_key  | BIGINT       | Surrogate key linking the order to `gold.dim_customers`.                            |
| order_date    | DATE         | The date the order was placed.                                                      |
| shipping_date | DATE         | The date the order was shipped to the customer.                                     |
| due_date      | DATE         | The date the order payment was due.                                                 |
| sales_amount  | INT          | The total monetary value of the sale for the line item (quantity x price).          |
| quantity      | INT          | The number of units of the product ordered.                                         |
| price         | INT          | The price per unit of the product for the line item.                                |

---

### Relationships
- `gold.fact_sales.product_key`  -> `gold.dim_products.product_key`
- `gold.fact_sales.customer_key` -> `gold.dim_customers.customer_key`
