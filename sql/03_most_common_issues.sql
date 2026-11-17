-- Query 03: Most Common Consumer Issues
-- Purpose: Identify the most frequently reported issues in the CFPB complaint database

SELECT
issue,
COUNT(*) AS complaint_count
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
GROUP BY issue
ORDER BY complaint_count DESC
LIMIT 20;