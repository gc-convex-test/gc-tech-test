/* Create tables in RAW for snowpipe. 
   Grant relevant privs on tables. */ 

USE ROLE loader;

CREATE TABLE raw_db.snowpipe.transactions (
    transactions_json variant
);

USE ROLE loader;

GRANT INSERT, SELECT ON raw_db.snowpipe.transactions TO ROLE loader;
GRANT SELECT ON raw_db.snowpipe.transactions TO ROLE transformer;
