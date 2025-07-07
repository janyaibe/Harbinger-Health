
-- ✅ Confirm Snowpipe is working

-- 1. List files in stage
LIST @harbinger_s3_stage;

-- 2. Show pipe status
SHOW PIPES;

-- 3. Query ingested data
SELECT * FROM silver.patient_data
ORDER BY ingestion_timestamp DESC
LIMIT 100;
