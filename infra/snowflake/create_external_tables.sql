-- Create external tables.

USE ROLE loader;
USE DATABASE raw_db;
USE SCHEMA snowpipe;

CREATE OR REPLACE EXTERNAL TABLE customers 
  (
    customer_id VARCHAR AS (VALUE :c1 :: VARCHAR), 
    loyalty_score NUMBER AS (VALUE :c2 :: NUMBER)) 
    WITH LOCATION = @s3_convex_customers/ 
    FILE_FORMAT = (FORMAT_NAME = 'csv'
    );

CREATE OR REPLACE EXTERNAL TABLE products 
  (
    product_id VARCHAR AS (VALUE :c1 :: VARCHAR), 
    product_description VARCHAR AS (VALUE :c2 :: VARCHAR), 
    product_category VARCHAR AS (VALUE :c3 :: VARCHAR)) 
    WITH LOCATION = @s3_convex_products/ 
    FILE_FORMAT = (format_name = 'csv'
);

GRANT SELECT ON raw_db.snowpipe.customers TO ROLE transformer;
GRANT SELECT ON raw_db.snowpipe.products TO ROLE transformer;