--Create all schemas to be used.

USE ROLE dba;

CREATE SCHEMA raw_db.snowpipe COMMENT = 'Snowpipe Schema for data landed in RAW DB by Snowpipe.';

CREATE SCHEMA analytics_db.presentation COMMENT = 'Presentation Schema for presentation layer.';
