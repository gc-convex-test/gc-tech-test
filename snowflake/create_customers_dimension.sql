-- Create table as

USE ROLE transformer;
USE DATABASE raw_db;
USE SCHEMA snowpipe;
USE WAREHOUSE transforming_wh;

CREATE OR REPLACE TABLE analytics_db.presentation.customers_dimension AS
SELECT
  customer_id,
  loyalty_score
FROM
  customers;
