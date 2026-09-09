# Olist E-Commerce Seller Growth Analytics Pipeline
 
An end-to-end Azure data engineering pipeline that ingests Olist's public e-commerce dataset (1M+ records) and serves it to analysts and business stakeholders for tracking seller growth performance.
 
![Architecture Diagram](./ARCHITECTURE_DIAGRAM.png)
 
## Overview
 
[Olist](https://olist.com/) is a Brazilian e-commerce platform that lets retail sellers list products across multiple marketplaces. This project builds a pipeline that ingests Olist's publicly released dataset, cleans and transforms it, and exposes it through a serverless SQL layer connected to Power BI — enabling business users to analyze seller growth without needing to touch raw data or write Spark code.
 
## Tech Stack
 
| Layer | Tool |
|---|---|
| Ingestion / Orchestration | Azure Data Factory |
| Storage | Azure Data Lake Storage Gen2 (Bronze, Silver) |
| Transformation | Azure Databricks (PySpark) |
| Serving Layer | Azure Synapse Analytics — Serverless SQL Pool |
| Visualization | Power BI |
 
## Architecture Flow
 
| Step | Stage | Description |
|---|---|---|
| 1 | **Ingest** | Azure Data Factory fetches raw data from Olist's public dataset repository via Copy Activity |
| 2 | **Bronze** | Raw, unprocessed data lands in the Bronze container of ADLS Gen2 |
| 3 | **Transform** | Azure Databricks reads from Bronze, runs data quality checks, cleans and transforms the data, and writes it to the Silver container |
| 4 | **Serve** | Azure Synapse Serverless SQL Pool creates external tables/views directly on Silver data — query-in-place, no data duplication |
| 5 | **Visualize** | Power BI connects to the Synapse Serverless SQL endpoint to build seller growth dashboards |
 
**Pattern:** Bronze → Silver → Synapse (Serverless SQL) → Power BI
 
> Serverless SQL Pool was chosen over a Dedicated Pool to avoid duplicating storage and compute cost — Synapse queries the Silver files directly instead of loading them into managed tables.
 
## Data Model (ER Diagram)
 
The Olist dataset is relational — orders sit at the center, linking customers, order items, payments, and reviews, while order items connect to products and sellers.
 
```mermaid
erDiagram
    CUSTOMERS ||--o{ ORDERS : places
    ORDERS ||--|{ ORDER_ITEMS : contains
    ORDERS ||--|{ ORDER_PAYMENTS : "paid via"
    ORDERS ||--o{ ORDER_REVIEWS : receives
    PRODUCTS ||--o{ ORDER_ITEMS : "sold as"
    SELLERS ||--o{ ORDER_ITEMS : fulfills
    PRODUCT_CATEGORY_TRANSLATION ||--o{ PRODUCTS : categorizes
 
    CUSTOMERS {
        string customer_id PK
        string customer_unique_id
        string customer_zip_code_prefix
        string customer_city
        string customer_state
    }
 
    ORDERS {
        string order_id PK
        string customer_id FK
        string order_status
        datetime order_purchase_timestamp
        datetime order_delivered_customer_date
        datetime order_estimated_delivery_date
    }
 
    ORDER_ITEMS {
        string order_id FK
        int order_item_id
        string product_id FK
        string seller_id FK
        float price
        float freight_value
    }
 
    ORDER_PAYMENTS {
        string order_id FK
        int payment_sequential
        string payment_type
        int payment_installments
        float payment_value
    }
 
    ORDER_REVIEWS {
        string review_id PK
        string order_id FK
        int review_score
        datetime review_creation_date
    }
 
    PRODUCTS {
        string product_id PK
        string product_category_name
        int product_weight_g
    }
 
    SELLERS {
        string seller_id PK
        string seller_zip_code_prefix
        string seller_city
        string seller_state
    }
 
    PRODUCT_CATEGORY_TRANSLATION {
        string product_category_name PK
        string product_category_name_english
    }
```
 
## Repository Structure
 
```
olist-ecommerce-data-pipeline/
├── README.md
├── ARCHITECTURE_DIAGRAM.png
├── adf/
│   └── pipeline_copy_olist_bronze.json
├── databricks/
│   └── 01_bronze_to_silver_transformation.py
└── powerbi/
    └── seller_growth_dashboard.pbix
```
 
## Data Source
 
[Olist Store E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — ~1M+ order, customer, and seller records released publicly for analytics use.
 
## Key Highlights
 
- Fully automated ingestion via Azure Data Factory Copy Activity
- Data quality checks and cleansing performed in Databricks before promotion to Silver
- Query-in-place serving layer (Serverless SQL) — no redundant data copies, lower cost
- Power BI dashboards built directly on top of Synapse views for seller growth analysis
## Author
 
**Prashant More**
Data Analyst / BI Analyst | [LinkedIn](#) · [GitHub](#)
