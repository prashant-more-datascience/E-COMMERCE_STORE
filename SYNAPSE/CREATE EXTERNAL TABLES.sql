---------------------------------------------------------------------------------------
CREATE EXTERNAL TABLE gold.customers_dataset
WITH
(
    LOCATION='customers_data',
    DATA_SOURCE =gold_layer,
    FILE_FORMAT=file_format_
)
AS
SELECT * FROM gold.customers_data

SELECT * FROM gold.customers_dataset

---------------------------------------------------------------------------------------

CREATE EXTERNAL TABLE gold.order_items_dataset
WITH
(
    LOCATION='order_items',
    DATA_SOURCE =gold_layer,
    FILE_FORMAT=file_format_
)
AS
SELECT * FROM gold.order_items

SELECT * FROM gold.order_items_dataset

---------------------------------------------------------------------------------------

CREATE EXTERNAL TABLE gold.order_reviews_dataset
WITH
(
    LOCATION='order_reviews_data',
    DATA_SOURCE =gold_layer,
    FILE_FORMAT=file_format_
)
AS
SELECT * FROM gold.order_reviews_data

SELECT * FROM gold.order_reviews_dataset
---------------------------------------------------------------------------------------

CREATE EXTERNAL TABLE gold.order_reviews_dataset
WITH
(
    LOCATION='order_reviews_data',
    DATA_SOURCE =gold_layer,
    FILE_FORMAT=file_format_
)
AS
SELECT * FROM gold.order_reviews_data

SELECT * FROM gold.order_reviews_dataset

---------------------------------------------------------------------------------------
CREATE EXTERNAL TABLE gold.orders_dataset
WITH
(
    LOCATION='orders_data',
    DATA_SOURCE =gold_layer,
    FILE_FORMAT=file_format_
)
AS
SELECT * FROM gold.orders_data

SELECT * FROM gold.orders_dataset
---------------------------------------------------------------------------------------
CREATE EXTERNAL TABLE gold.payments_dataset
WITH
(
    LOCATION='payments_data',
    DATA_SOURCE =gold_layer,
    FILE_FORMAT=file_format_
)
AS
SELECT * FROM gold.payments_data

SELECT * FROM gold.payments_dataset
---------------------------------------------------------------------------------------
CREATE EXTERNAL TABLE gold.product_category_name_translation_dataset
WITH
(
    LOCATION='product_category_name_translation',
    DATA_SOURCE =gold_layer,
    FILE_FORMAT=file_format_
)
AS
SELECT * FROM gold.product_category_name_translation

SELECT * FROM gold.product_category_name_translation_dataset
---------------------------------------------------------------------------------------
CREATE EXTERNAL TABLE gold.sellers_dataset
WITH
(
    LOCATION='sellers_data',
    DATA_SOURCE =gold_layer,
    FILE_FORMAT=file_format_
)
AS
SELECT * FROM gold.sellers_data
SELECT * FROM gold.sellers_dataset
---------------------------------------------------------------------------------------


