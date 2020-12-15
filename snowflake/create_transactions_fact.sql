-- Create table as

USE ROLE transformer;
USE DATABASE raw_db;
USE SCHEMA snowpipe;
USE WAREHOUSE transforming_wh;

-- If doing in dbt best practice 
-- would be to do any casting
-- and renaming in a staging model.

CREATE OR REPLACE TABLE analytics_db.presentation.transactions_fact AS
SELECT
  transactions_json :customer_id :: STRING AS customer_id,
  transactions_json :date_of_purchase :: date AS date_of_purchase,
  b.value :price :: STRING AS price,
  b.value :product_id :: STRING AS product_id
FROM
  transactions,
  LATERAL FLATTEN(
    input => transactions_json :basket
  ) b;
