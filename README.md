
<div align="center">

# 🏗️ SQL Server Data Warehouse Project

### End-to-End Data Warehouse with Medallion Architecture (Bronze → Silver → Gold)

![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![T-SQL](https://img.shields.io/badge/T--SQL-ETL-blue?style=for-the-badge)
![Architecture](https://img.shields.io/badge/Architecture-Medallion-orange?style=for-the-badge)
![Model](https://img.shields.io/badge/Model-Star%20Schema-success?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)

**Author: Shree Krishan Sharma**

</div>

---

## 📌 Project Overview

This project builds a modern **data warehouse in SQL Server** that consolidates sales data from two source systems (**CRM** and **ERP**) into a clean, analytics-ready **star schema**.

It covers the full data engineering flow:

- **Extract:** load raw CSV files into SQL Server using `BULK INSERT`.
- **Transform:** clean, standardize, deduplicate and enrich the data with T-SQL.
- **Load:** publish business-ready dimension and fact views for reporting.

---

## 🏛️ Architecture

```
┌──────────────┐     ┌────────────────┐     ┌────────────────┐     ┌────────────────┐
│   SOURCES    │     │    BRONZE      │     │    SILVER      │     │     GOLD       │
│              │     │  (Raw Data)    │     │ (Cleaned Data) │     │ (Business Data)│
│  CRM (CSV)   │ ──► │  Tables        │ ──► │  Tables        │ ──► │  Views         │
│  ERP (CSV)   │     │  Bulk Insert   │     │  Transform     │     │  Star Schema   │
└──────────────┘     └────────────────┘     └────────────────┘     └────────────────┘
                      Full load, no          Cleansing,             Integration,
                      transformation         standardization        aggregation-ready
```

| Layer | Object Type | Load Method | Transformations | Purpose |
|-------|-------------|-------------|-----------------|---------|
| **Bronze** | Tables | Truncate & Bulk Insert | None (as-is) | Raw copy of source files |
| **Silver** | Tables | Truncate & Insert | Cleansing, standardization, derived columns | Clean, consistent data |
| **Gold** | Views | n/a | Joins, business rules, surrogate keys | Analytics and reporting |

> 💡 Add your architecture diagram here: `docs/architecture.png`
>
> `![Architecture](docs/architecture.png)`

---

## 📂 Data Sources

| System | File | Description |
|--------|------|-------------|
| CRM | `cust_info.csv` | Customer master data |
| CRM | `prd_info.csv` | Product information with history |
| CRM | `sales_details.csv` | Transactional sales data |
| ERP | `cust_az12.csv` | Customer birthdate and gender |
| ERP | `loc_a101.csv` | Customer country |
| ERP | `px_cat_g1v2.csv` | Product categories |

---

## ⭐ Data Model (Gold Layer)

```
 ┌──────────────────┐         ┌──────────────────┐         ┌──────────────────┐
 │  dim_customers   │         │   fact_sales     │         │   dim_products   │
 ├──────────────────┤         ├──────────────────┤         ├──────────────────┤
 │ customer_key  PK │◄────────│ customer_key  FK │         │ product_key   PK │
 │ customer_id      │         │ product_key   FK │────────►│ product_id       │
 │ customer_number  │         │ order_number     │         │ product_number   │
 │ first_name       │         │ order_date       │         │ product_name     │
 │ last_name        │         │ shipping_date    │         │ category         │
 │ country          │         │ due_date         │         │ subcategory      │
 │ marital_status   │         │ sales_amount     │         │ maintenance      │
 │ gender           │         │ quantity         │         │ cost             │
 │ birthdate        │         │ price            │         │ product_line     │
 │ create_date      │         └──────────────────┘         │ start_date       │
 └──────────────────┘                                      └──────────────────┘
```

> 💡 Add your data model image here: `docs/data_model.png`

---

## 📁 Repository Structure

```
sql-data-warehouse-project/
│
├── datasets/                      # Raw CSV source files
│   ├── source_crm/
│   └── source_erp/
│
├── docs/
│   ├── architecture.png           # Architecture diagram
│   ├── data_model.png             # Star schema diagram
│   └── data_catalog.md            # Gold layer data dictionary
│
├── scripts/
│   ├── init_database.sql          # Create DataWarehouse database and schemas
│   ├── bronze/
│   │   ├── ddl_bronze.sql         # Create bronze tables
│   │   └── proc_load_bronze.sql   # Stored procedure: load bronze
│   ├── silver/
│   │   ├── ddl_silver.sql         # Create silver tables
│   │   └── proc_load_silver.sql   # Stored procedure: load silver
│   └── gold/
│       └── ddl_gold.sql           # Create gold views
│
├── tests/
│   ├── quality_checks_silver.sql  # Silver layer data quality checks
│   └── quality_checks_gold.sql    # Gold layer data quality checks
│
└── README.md
```

---

## 🧹 Data Cleansing Highlights (Silver Layer)

| Table | Transformation |
|-------|----------------|
| `crm_cust_info` | Removed duplicates (latest record kept), trimmed names, mapped `S/M` to Single/Married and `F/M` to Female/Male |
| `crm_prd_info` | Split `prd_key` into category ID and product key, replaced NULL cost with 0, mapped product line codes, calculated end date with `LEAD()` |
| `crm_sales_details` | Converted integer dates to `DATE`, fixed invalid dates, recalculated wrong sales and price values |
| `erp_cust_az12` | Removed `NAS` prefix from IDs, set future birthdates to NULL, standardized gender |
| `erp_loc_a101` | Removed `-` from IDs, normalized country codes (DE, US, USA) |
| `erp_px_cat_g1v2` | Loaded as-is after checking for unwanted spaces |

---

## 🚀 How to Run

**Prerequisites:** SQL Server and SQL Server Management Studio (SSMS).

1. **Clone the repository**
   ```bash
   git clone https://github.com/<your-username>/sql-data-warehouse-project.git
   ```
2. **Create the database and schemas** (`bronze`, `silver`, `gold`) using `init_database.sql`.
3. **Create bronze tables:** run `scripts/bronze/ddl_bronze.sql`.
4. **Update the file paths** inside `proc_load_bronze.sql` to point to your local `datasets` folder, then create the procedure.
5. **Load bronze:**
   ```sql
   EXEC bronze.load_bronze;
   ```
6. **Create silver tables and procedure:** run `ddl_silver.sql` and `proc_load_silver.sql`.
7. **Load silver:**
   ```sql
   EXEC silver.load_silver;
   ```
8. **Create gold views:** run `scripts/gold/ddl_gold.sql`.
9. **Run the quality checks** in the `tests/` folder. Most should return no rows.

---

## ✅ Data Quality Checks

- Null and duplicate primary keys
- Unwanted spaces in text fields
- Standardized and consistent values
- Invalid date ranges and date order
- Sales = Quantity x Price consistency
- Referential integrity between the fact and dimension views
- Row count match between silver and gold

---

## 🛠️ Skills Demonstrated

`SQL Server` · `T-SQL` · `ETL Pipelines` · `Data Cleansing` · `Data Modeling` · `Star Schema` · `Medallion Architecture` · `Stored Procedures` · `Window Functions` · `Data Quality Testing` · `Error Handling (TRY...CATCH)`

---

## 📖 Documentation

See the full Gold layer data dictionary in [`docs/data_catalog.md`](docs/data_catalog.md).

---

## 👤 Author

**Shree Krishan Sharma**

- 💼 LinkedIn: `https://linkedin.com/in/<linkedin.com/in/shree-krishan-sharma-bb4130399>`
- 🐙 GitHub: `https://github.com/<https://github.com/shyam0770sharma-prog>`
- 📧 Email: `<krishan0990sharma@gmail.com>`

---

<div align="center">

⭐ If you found this project useful, please give it a star! ⭐

</div>
Thank you for visiting my repository! 🚀
