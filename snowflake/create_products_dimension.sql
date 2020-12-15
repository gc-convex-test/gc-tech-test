-- Create table as

USE ROLE transformer;
USE DATABASE raw_db;
USE SCHEMA snowpipe;
USE WAREHOUSE transforming_wh;

-- If doing in dbt best practice would be TO DO ANY casting 
-- and renaming IN A staging model.

CREATE OR REPLACE TABLE analytics_db.presentation.products_dimension AS
SELECT
  product_id,
  CASE
    WHEN product_category LIKE 'house%' THEN 'H'
    WHEN product_category LIKE 'clothes%' THEN 'C'
    WHEN product_category LIKE 'fruit_veg%' THEN 'FV'
    WHEN product_category LIKE 'sweets%' THEN 'S'
    WHEN product_category LIKE 'food%' THEN 'F'
  END AS product_category,
  product_category AS full_product_category,
  product_description
FROM
  products;
