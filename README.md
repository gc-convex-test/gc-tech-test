# Snowflake Data Engineer Tech Test

IW Repo has been cloned rather than forked.

## Implementation Steps

### Pre-requisites

* awscli is installed.
* SnowSQL installed.
* the main_data_generator.py has been fixed and the CSV's and JSON generated.

### Snowflake Warehouse Build

This assumes you have completed registration for a Snowflake account.

To build out Snowflake please use the .sql files found in directory infra\snowflake.

**For full IaC and automation (not done here because of time) it would be advisable to use Terraform and the CZI Snowflake Provider.**

The .sql scripts for the initial WH build should be run in the following order but could have been wrapped in a script.

```sql
1. create_roles.sql
2. create_warehouses.sql
3. create_resource_monitors.sql
4. create_databases.sql
5. create_schemas.sql
5. grant_piviliges.sql
6. create_file_formats.sql
```

### AWS Build

This assumes you have setup an AWS account.

IRL we would not be using the AWS root user. 

We would : 
* Enable MFA for the root user.
* Delete the root users access keys.
* Create an IAM user.
* Give the IAM user relevant admin permissions.
* Enable MFA for the IAM user.
* Login to the AWS Web Console as your IAM User.
* Create a set of Access Keys for your IAM User.
* Save those Access Keys to your password manager and use these when setting up your AWS CLI.

To keep to the time constraints I have used the root account.

Login to AWS and on the navigation bar on the upper right, choose your account name or number (please take note of this as it will be referred to in this document as **[account_no]**) and then choose My Security Credentials.

Expand the Access keys (access key ID and secret access key) section.

Choose Create New Access Key.

When prompted, choose Show Access Key or Download Key File. This is your only opportunity to save your secret access key.

Now on the command line run the below and enter the relevant details saved from above and your region:

```markdown
C:\>aws configure
AWS Access Key ID [****************123]:
AWS Secret Access Key [****************23]:
Default region name [None]: eu-west-1
Default output format [None]:
```

**Ideally you would create all the AWS infrastructure using Terraform if the option were available, you could use the Cloudposse AWS modules to speed dev time up or develop from scratch.**

To keep things as simple and as quick as possible I am using the awscli.

When running the below take care to name the **[bucket_name]** and **[region_name]** as appropriate.

```markdown
aws s3api create-bucket --bucket [bucket_name] --region [region_name] --create-bucket-configuration LocationConstraint=[region_name]
```

Ensure the bucket has public access restricted and we could also enable SSE but I have not done so here.

```markdown
aws s3api put-public-access-block --bucket [bucket_name] --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
```

From within the repo's infra\aws directory, create a bucket policy called *snowflake_s3* using the command below and the *s3_bucket_iam_policy.json* which you will have to edit to add your **[bucket_name]**

```markdown
aws iam create-policy --policy-name snowflake_s3 --policy-document file://s3_bucket_iam_policy.json 
```

Make a note of the S3 access policy ("PolicyName": "snowflake_s3") Arn which will be referred to in this doc as the **[snowflake_s3_arn]**.

For JSON file ingestion i'm going to use Snowpipe but this could be seen as using a sledgehammer to crack a nut as data only needs to be delivered weekly and size of data is small, we do not know full daily sizes and number of files so it could be one solution.

The *create_storage_integration.sql* script found in the infra\snowflake will need editing and the relevant **[account_no]** will need entering.

In Snowflake via the GUI or via SnowSQL run: 

```sql
create_storage_integration.sql 
```

Now run: 

```sql
describe_storage_integration.sql 
```

Note the **[storage_aws_iam_user_arn]** and **[storage_aws_external_id]**

The *snowflake_trust_policy.json* file found in the infra\aws will need editing and the relevant **[storage_aws_iam_user_arn]** and **[storage_aws_external_id]** will need entering from the /*desc integration s3_integration*/ command.

You can now create an IAM Role named *snowpipe-role*:

aws iam create-role --role-name snowpipe-role --assume-role-policy-document file://snowflake_trust_policy.json

Attach the **[snowflake_s3_arn]**  (this was outputted by the *aws iam create-policy* command run previously).

aws iam attach-role-policy --policy-arn [snowflake_s3_arn] --role-name snowpipe-role.

Via SnowSQL or the Snowflake GUI please run the below.

Create_stages.sql will need to be filled with the [bucket_name].

Please note the **[notification_channel]** when running *show_pipes.sql*.

```sql
1. create_stages.sql
2. create_tables.sql
3. create_snowpipes.sql
4. show_pipes.sql
5. create_external_tables.sql
```

Modify the *s3_bucket_event_notification.json* in infra\aws and add the **[notification_channel]** found in *show_pipes.sql*.

We prefer For auto ingestion we will also need to enable S3 event notifications.

Please enter the **[bucket_name]** in the awscli command below.

```markdown
aws s3api put-bucket-notification-configuration --bucket [bucket_name] --notification-configuration file://s3_bucket_event_notification.json
```

We can now transfer the files to the s3 bucket. 

I've moved the customer and products into their own directory locally before doing this.

Change directory to the input_data\starter directory where CSV and JSON files were generated and run.

```markdown
aws s3 sync ./ s3://[bucket_name]/
```

This could be run via a crontab job to meet the requirements of the user story.

### Model Build

In SnowSQL or the Snowflake GUI run the following

```sql
1. create_customer_dimensions.sql
2. create_product_dimensions.sql
3. create_transactions_fact.sql
4. create_purchases_count_v.sql
```

**Ideally we would have these built in DBT whereupon we can run relevant dbt tests, generate documentation and integrate with our CI pipeline eg: DBT Cloud with Github integration on PR's (via webhooks) running the DBT job each day to capture the new data.**

**We could also build out a history / SCD2 using DBT snapshots for customers and products or could look at Snowflake Streams and Tasks for doing something similar.**

### Acceptance Criteria States

product_category as per TASKS.md looks to be a mapping I would check with a BA to confirm the mapping are as follows:

| full_product_category | product_category |
| --------------------- | ---------------- |
| house         		| H                |      
| clothes         		| C                |      
| fruit_veg         	| FV               |      
| sweets         		| S                |      
| food         			| F                |

AC says to ```markdown "Create a VIEW in Snowflake to output information for every customer"``` but does not include any date to slice by in the view shown. The User Story says ```markdown"I want to be able to consume a data source that contains information about how many times each of our customers buys our products in a given period"```

I'd recommend adding a date dimension and date to the view. I have included a basic date dimension for future use. 

```sql
1. create_date_dimension.sql
```


