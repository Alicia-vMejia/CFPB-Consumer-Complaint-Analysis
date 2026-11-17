-- Query 04: Complaints by Year
-- Purpose: Analyze how consumer complaints volume has changed over time 

SELECT
EXTRACT(YEAR FROM date_received) AS complaint_year,
COUNT(*) AS complaint_count
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
GROUP BY complaint_year
ORDER BY complaint_year