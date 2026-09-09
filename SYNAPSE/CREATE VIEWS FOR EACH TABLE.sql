--- customers_data view 
CREATE VIEW gold.customers_data
AS
SELECT * from 
OPENROWSET(
    BULK 'https://ecommercedatastorage007.dfs.core.windows.net/silver/customers_data/',
    FORMAT='PARQUET'
)AS query1

--- order_items view

CREATE VIEW gold.order_items
AS
SELECT * from 
OPENROWSET(
    BULK 'https://ecommercedatastorage007.dfs.core.windows.net/silver/order_items/',
    FORMAT='PARQUET'
)AS order_items

--- order_reviews_data
CREATE VIEW gold.order_reviews_data
AS
SELECT * from 
OPENROWSET(
    BULK 'https://ecommercedatastorage007.dfs.core.windows.net/silver/order_reviews_data/',
    FORMAT='PARQUET'
)AS order_reviews_data

--- orders_data
CREATE VIEW gold.orders_data
AS
SELECT * from 
OPENROWSET(
    BULK 'https://ecommercedatastorage007.dfs.core.windows.net/silver/orders_data/',
    FORMAT='PARQUET'
)AS orders_data

--- payments_data

CREATE VIEW gold.payments_data
AS
SELECT * from 
OPENROWSET(
    BULK 'https://ecommercedatastorage007.dfs.core.windows.net/silver/payments_data/',
    FORMAT='PARQUET'
)AS payments_data


--- product_category_name_translation


CREATE VIEW gold.product_category_name_translation
AS
SELECT * from 
OPENROWSET(
    BULK 'https://ecommercedatastorage007.dfs.core.windows.net/silver/product_category_name_translation/',
    FORMAT='PARQUET'
)AS product_category_name_translation


--- sellers_data

CREATE VIEW gold.sellers_data
AS
SELECT * from 
OPENROWSET(
    BULK 'https://ecommercedatastorage007.dfs.core.windows.net/silver/sellers_data/',
    FORMAT='PARQUET'
)AS sellers_data

SELECT * FROM gold.sellers_data



