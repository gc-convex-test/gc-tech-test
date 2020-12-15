-- Create file format for CSV

USE ROLE loader;
USE DATABASE raw_db;
USE SCHEMA snowpipe;

CREATE OR REPLACE file format csv
  TYPE = 'CSV'
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1;