-- Create relevant roles
-- and inital grants.

USE ROLE securityadmin;

CREATE ROLE dba COMMENT = 'DBA role.';
GRANT ROLE dba TO ROLE sysadmin;

CREATE ROLE transformer COMMENT = 'Transformer role can transform data from Raw DB.';
GRANT ROLE transformer TO ROLE dba;

CREATE ROLE datascience COMMENT = 'Datascience role can consume modelled data in Analytics DB';
GRANT ROLE datascience TO ROLE dba;

CREATE ROLE loader COMMENT = 'Loader role for loading of data into Raw DB';
GRANT ROLE loader TO ROLE dba;

-- Grant DBA role create WH
USE ROLE accountadmin;

GRANT CREATE WAREHOUSE ON ACCOUNT TO ROLE dba;
GRANT CREATE DATABASE ON ACCOUNT TO ROLE dba;