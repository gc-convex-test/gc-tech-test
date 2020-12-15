-- Create table as

USE ROLE transformer;
USE DATABASE analytics_db;
USE SCHEMA presentation;
USE WAREHOUSE transforming_wh;

/* If doing in dbt would use date
   spline to generator date dimension. */

CREATE OR REPLACE TABLE date_dimension AS WITH date AS 
(
    SELECT dateadd(day, seq4(), '2016-01-01 00:00:00') AS date
    FROM TABLE(generator(rowcount=>5000))
)

SELECT
    to_date(date) AS date,
    year(date) AS year,
    month(date) AS month,
    monthname(date) AS month_name,
    day(date) AS day,
    dayofweek(date) AS day_week,
    weekofyear(date) AS week_year,
    dayofyear(date) AS day_year
FROM date