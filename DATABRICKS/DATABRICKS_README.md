
# Silver Layer Transformation — Notebook Documentation
 
 
## 1. Data Loading (Bronze → DataFrames)
 
All 8 Olist Bronze CSV files are read into separate Spark DataFrames using `spark.read.format("csv")` with `header=true` and `inferSchema=true`, sourced from `abfss://bronze@<your-storage-account>.dfs.core.windows.net/`:
 
- `customers_data`
- `order_items`
- `order_reviews_data`
- `orders_data`
- `payments_data`
- `product_category_name_translation`
- `products_data`
- `sellers_data`
## 2. Data Transformation & Quality Checks
 
A table-by-table data quality audit is performed before promoting data to Silver.
 
| Table | Checks Performed |
|---|---|
| **customers_data** | Null/blank scan, duplicate `customer_id` / `customer_unique_id` check, full-row duplicate check, city/state distribution, validated `customer_state` against Brazil's 27 official state codes |
| **order_items** | Cast `price` / `freight_value` to `decimal(12,2)`, null scan, duplicate `(order_id, order_item_id)` check, negative/zero price & freight detection, blank ID checks |
| **order_reviews_data** | Cast `review_score` to integer, parse date/timestamp columns, dropped rows with null `order_id` (analyzed useful vs. fully-empty rows first), filtered invalid review scores (e.g. stray values outside the valid 1–5 range), checked for review-answer dates occurring before creation dates |
| **orders_data** | Null scan on delivery/approval timestamps grouped by `order_status` (distinguishing expected nulls for non-delivered orders from real gaps), duplicate `order_id` check, order-status distribution, timestamp sequencing checks (delivery before purchase, approval before purchase, carrier date before approval, etc.) |
| **payments_data** | Null scan, `payment_type` distribution (flagging `not_defined`), invalid installment/negative value checks, duplicate `(order_id, payment_sequential)` check, referential check against `orders_data` (orphaned payments via `left_anti` join), and a **reconciliation check** comparing `order_items` (price + freight) totals against `payments_data` totals per order |
| **product_category_name_translation** | Null/blank scan, duplicate category-name checks (Portuguese and English) |
| **products_data** | Null scan, duplicate `product_id` check, negative-value checks across dimension/weight columns, dropped rows with `product_weight_g == 0`, referential check against the category translation table for orphaned categories |
| **sellers_data** | Null scan, `seller_id` uniqueness check, whitespace/casing normalization on `seller_city` (detecting near-duplicate city names), regex check for suspicious characters (digits, unusual punctuation) in city names |
 
**Highlights worth calling out:**
- Referential integrity checks (orphaned foreign keys via `left_anti` joins)
- Financial reconciliation (payments vs. item totals)
- Text normalization and near-duplicate detection on categorical fields
## 3. Save to Silver
 
Each cleaned DataFrame is written as **Parquet**, in `append` mode, to:
```
abfss://silver@<your-storage-account>.dfs.core.windows.net/<table_name>/
```
`customers_data` is also registered as a temp view for a quick SQL row-count validation.
 
--
