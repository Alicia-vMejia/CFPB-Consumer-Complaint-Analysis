-- Query 08: Investigate Other Product Categories 
-- Purpose: Identify products currently grouped into the Other category 

SELECT
product,
COUNT(*) AS complaint_count
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
WHERE product IS NOT NULL
AND LOWER(product) NOT LIKE '%credit report%'
AND LOWER(product) NOT LIKE '%debt collection'
AND LOWER(product) NOT LIKE '%mortgage%'
AND LOWER(product) NOT LIKE '%credit card%'
AND LOWER(product) NOT LIKE '%student loan%'
GROUP BY product
ORDER BY complaint_count DESC;