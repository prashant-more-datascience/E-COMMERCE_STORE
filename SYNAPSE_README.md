
### Synapse Serving Layer Setup
 
The serving layer is built in three ordered SQL scripts:
 
1. **External data source setup** — creates a database-scoped credential using Managed Identity (no storage keys stored), registers `silver_layer` and `gold_layer` as named external data sources, and defines a Parquet + Snappy file format used by later scripts.
2. **Views per table** — one `OPENROWSET`-based view per Silver table (`gold.customers_data`, `gold.orders_data`, etc.), giving analysts SQL access to Silver data with zero duplication.
3. **External tables (CETAS)** — each view is materialized into a Gold external table via `CREATE EXTERNAL TABLE AS SELECT`, physically writing curated Parquet into the Gold container. Power BI queries these Gold tables rather than the Silver views directly.
