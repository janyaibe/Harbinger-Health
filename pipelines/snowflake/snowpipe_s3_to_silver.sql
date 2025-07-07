
-- Create the target table in Silver Layer
CREATE OR REPLACE TABLE silver.patient_data (
    patient_id STRING,
    enrollment_date DATE,
    site_id STRING,
    source_file STRING,
    ingestion_timestamp TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Create stage for S3 bucket
CREATE OR REPLACE STAGE harbinger_s3_stage
  URL='s3://harbinger-cdms-data/staging/'
  STORAGE_INTEGRATION = harbinger_s3_integration
  FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

-- Create Snowpipe
CREATE OR REPLACE PIPE load_patient_data_pipe AS
  COPY INTO silver.patient_data
  FROM @harbinger_s3_stage
  FILE_FORMAT = (TYPE = 'CSV')
  PATTERN='.*patient_data.*[.]csv';
