-- Create Resource Monitors for all Warehouses
-- should also create at account level for too but have not done so here to save time.
USE ROLE accountadmin;

CREATE RESOURCE MONITOR loading_rm WITH CREDIT_QUOTA = 1
frequency = 'DAILY', start_timestamp = 'IMMEDIATELY', end_timestamp = null 
 TRIGGERS 
 ON 100 PERCENT DO SUSPEND 
 ON 110 PERCENT DO SUSPEND_IMMEDIATE 
 ON 50 PERCENT DO NOTIFY 
 ON 75 PERCENT DO NOTIFY 
 ON 95 PERCENT DO NOTIFY;
ALTER WAREHOUSE loading_wh SET RESOURCE_MONITOR = loading_rm;

CREATE RESOURCE MONITOR transforming_rm WITH CREDIT_QUOTA = 1
frequency = 'DAILY', start_timestamp = 'IMMEDIATELY', end_timestamp = null
 TRIGGERS 
 ON 100 PERCENT DO SUSPEND 
 ON 110 PERCENT DO SUSPEND_IMMEDIATE 
 ON 50 PERCENT DO NOTIFY 
 ON 75 PERCENT DO NOTIFY 
 ON 95 PERCENT DO NOTIFY;
ALTER WAREHOUSE transforming_wh SET RESOURCE_MONITOR = transforming_rm;

CREATE RESOURCE MONITOR datascience_rm WITH CREDIT_QUOTA = 1
frequency = 'DAILY', start_timestamp = 'IMMEDIATELY', end_timestamp = null
 TRIGGERS 
 ON 100 PERCENT DO SUSPEND 
 ON 110 PERCENT DO SUSPEND_IMMEDIATE 
 ON 50 PERCENT DO NOTIFY 
 ON 75 PERCENT DO NOTIFY 
 ON 95 PERCENT DO NOTIFY;
ALTER WAREHOUSE datascience_wh SET RESOURCE_MONITOR = datascience_rm;
