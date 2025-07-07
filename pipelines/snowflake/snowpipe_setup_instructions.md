
# 🧊 Snowpipe Setup Instructions for Harbinger Health

This guide walks through how to configure Snowpipe to automatically ingest data from an S3 staging bucket into the Snowflake Silver Layer.

---

## 1. Prerequisites

- An existing S3 bucket with CDMS-exported CSV files (e.g., `patient_data_*.csv`)
- A Snowflake account with:
  - A target schema/table in Silver layer
  - Access to create storage integrations and pipes
- An AWS IAM Role or Snowflake `STORAGE_INTEGRATION` with access to S3

---

## 2. Create Target Table

```sql
CREATE OR REPLACE TABLE silver.patient_data (
    patient_id STRING,
    enrollment_date DATE,
    site_id STRING,
    source_file STRING,
    ingestion_timestamp TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);
```

---

## 3. Create S3 External Stage

```sql
CREATE OR REPLACE STAGE harbinger_s3_stage
  URL='s3://harbinger-cdms-data/staging/'
  STORAGE_INTEGRATION = harbinger_s3_integration
  FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);
```

---

## 4. Create Snowpipe

```sql
CREATE OR REPLACE PIPE load_patient_data_pipe AS
  COPY INTO silver.patient_data
  FROM @harbinger_s3_stage
  FILE_FORMAT = (TYPE = 'CSV')
  PATTERN='.*patient_data.*[.]csv';
```

---

## 5. (Optional) Enable Auto-Ingest

1. Create an AWS SNS topic and S3 event trigger.
2. Subscribe Snowflake’s Snowpipe to receive notifications via SQS.
3. Update your Snowpipe with `AUTO_INGEST = TRUE`.

Documentation: https://docs.snowflake.com/en/user-guide/data-load-snowpipe-auto-s3.html

---

## ✅ Verification Queries

```sql
-- Check files staged
LIST @harbinger_s3_stage;

-- Confirm Snowpipe status
SHOW PIPES;

-- Query ingested records
SELECT * FROM silver.patient_data ORDER BY ingestion_timestamp DESC;
```
