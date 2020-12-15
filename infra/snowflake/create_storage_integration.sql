/* Create Storage Integration for Ext. Stage.
   Enter the [role_arn] for STORAGE_AWS_ROLE_ARN
   and the s3 [bucket_name]
   as per the format below.
  
  CREATE STORAGE INTEGRATION s3_integration
  TYPE = EXTERNAL_STAGE
   STORAGE_PROVIDER = S3
   ENABLED = TRUE
   STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::99999999999:role/snowpipe-role'
   STORAGE_ALLOWED_LOCATIONS = ('s3://convex123456/'); */


USE ROLE accountadmin;
  
CREATE STORAGE INTEGRATION s3_integration
  TYPE = external_stage
  STORAGE_PROVIDER = S3
  ENABLED = true
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::[account_no]:role/snowpipe-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://[bucket_name]/');

  GRANT usage ON integration s3_integration TO ROLE loader;  