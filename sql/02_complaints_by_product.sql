-- Query 02: Complaints by Financial Product
-- Purpose: Identify which financial products receive the most consumer complaints 

SELECT
product,
COUNT(*) AS complaint_count
FROM`bigquery-public-data.cfpb_complaints.complaint_database`
GROUP BY product
ORDER BY complaint_count DESC