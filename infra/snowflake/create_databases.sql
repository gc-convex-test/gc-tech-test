-- Create relevant databases

USE ROLE dba;

CREATE database raw_db COMMENT = 'Raw database for unmodelled raw data.';
CREATE database analytics_db COMMENT = 'Analytics database for modelled data be used for reporting and analytics.';
