/* Grant the required privileges
   on the database objects. */

USE ROLE dba;

-- Grant the loader role the relevant privileges 
GRANT usage ON warehouse loading_wh TO ROLE loader;
GRANT usage ON database raw_db TO ROLE loader;
GRANT usage ON schema raw_db.snowpipe TO ROLE loader;
GRANT CREATE TABLE, CREATE external TABLE, CREATE stage, CREATE file format, CREATE PIPE ON schema raw_db.snowpipe TO ROLE loader;

-- Grant the transformer role the relevant privileges 
GRANT usage ON warehouse transforming_wh TO ROLE transformer;
GRANT usage ON database analytics_db TO ROLE transformer;
GRANT usage ON database raw_db TO ROLE transformer;
GRANT usage ON schema raw_db.snowpipe TO ROLE transformer;
GRANT usage ON schema analytics_db.presentation TO ROLE transformer;
GRANT SELECT ON ALL tables IN schema raw_db.snowpipe TO ROLE transformer;
GRANT CREATE TABLE, CREATE VIEW ON schema analytics_db.presentation TO ROLE transformer;
GRANT usage ON database analytics_db TO ROLE datascience;
GRANT usage ON schema analytics_db.presentation TO ROLE datascience;

/* this assumes presentation schema will only contain modelled data that meet DQ and DG standards
   and will be available to all.*/

USE ROLE accountadmin;

GRANT SELECT ON future tables IN schema analytics_db.presentation TO ROLE datascience;
