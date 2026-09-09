CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Prashantmore@123'

CREATE DATABASE SCOPED CREDENTIAL prashant_cred
WITH IDENTITY='MANAGED IDENTITY'

CREATE EXTERNAL DATA SOURCE sivler_layer
WITH 
(
    LOCATION = 'https://ecommercedatastorage007.dfs.core.windows.net/silver/',
    CREDENTIAL = prashant_cred
)

CREATE EXTERNAL DATA SOURCE gold_layer
WITH 
(
    LOCATION = 'https://ecommercedatastorage007.dfs.core.windows.net/gold/',
    CREDENTIAL = prashant_cred
)

CREATE EXTERNAL FILE FORMAT file_format_
WITH
(
    FORMAT_TYPE=PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)