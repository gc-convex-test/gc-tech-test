/* Create relevant users.
   If creating IRL would force a password change on first logon.*/

USE ROLE securityadmin;

CREATE USER transformer_user PASSWORD = 'p@ssw0rd!23' COMMENT = 'Data Transformer User' LOGIN_NAME = 'TRANSFORMER_USER' DISPLAY_NAME = 'TRANSFORMER_USER' DEFAULT_ROLE = "TRANSFORMER" DEFAULT_WAREHOUSE = 'TRANSFORMING_WH' MUST_CHANGE_PASSWORD = FALSE;

CREATE USER datascience_user PASSWORD = 'p@ssw0rd!23' COMMENT = 'Data Science User' LOGIN_NAME = 'DATA_SCIENTIST' DISPLAY_NAME = 'DATA_SCIENTIST' DEFAULT_ROLE = "DATASCIENCE" DEFAULT_WAREHOUSE = 'DATASCIENCE_WH' MUST_CHANGE_PASSWORD = FALSE;

CREATE USER snowpipe PASSWORD = 'p@ssw0rd!23' COMMENT = 'Snowpipe user' LOGIN_NAME = 'SNOWPIPE' DISPLAY_NAME = 'SNOWPIPE' DEFAULT_ROLE = "LOADER" DEFAULT_WAREHOUSE = 'LOADING_WH' MUST_CHANGE_PASSWORD = FALSE;
