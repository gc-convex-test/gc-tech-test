/* Create stages.
   Enter [bucket_name] into script.*/

USE ROLE loader;
USE DATABASE raw_db;
USE SCHEMA snowpipe;

CREATE OR REPLACE stage s3_convex_transactions
  URL = 's3://[bucket_name]/transactions/'
  STORAGE_INTEGRATION = s3_integration;

CREATE OR REPLACE stage s3_convex_customers
  URL = 's3://[bucket_name]/customers/'
  STORAGE_INTEGRATION = s3_integration;
  
CREATE OR REPLACE stage s3_convex_products
  URL = 's3://[bucket_name]/products/'
  STORAGE_INTEGRATION = s3_integration;

-- Validate stages are available.

ls @snowpipe.s3_convex_transactions;
ls @snowpipe.s3_convex_customers;
ls @snowpipe.s3_convex_products;