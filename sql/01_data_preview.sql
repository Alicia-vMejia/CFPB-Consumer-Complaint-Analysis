-- Query 01: Data Preview
-- Purpose : Inspect Key Fields in the CFPB Consumer Complaint Database

SELECT
date_received,
product,
subproduct,
issue
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
LIMIT 1000;