-- Create snowpipe for each file.

USE ROLE loader;

CREATE PIPE raw_db.snowpipe.s3pipe_convex_transactions AUTO_INGEST=true as
  COPY INTO raw_db.snowpipe.transactions
  FROM @snowpipe.s3_convex_transactions
  FILE_FORMAT = (TYPE = 'JSON');