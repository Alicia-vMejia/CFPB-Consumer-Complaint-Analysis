-- Query 06: Companies with the Most Complaints
-- Purpose: Identify companies the highest number of consumer complaints 

SELECT
company_name,
COUNT(*) AS complaint_count
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
WHERE company_name IS NOT NULL
GROUP BY company_name
ORDER BY complaint_count DESC
LIMIT 20;