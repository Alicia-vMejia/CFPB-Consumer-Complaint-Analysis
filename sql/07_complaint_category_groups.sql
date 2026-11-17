-- Query 07: Complaint Category Groups
-- Purpose: Group financial products into broder complaint categories using CASE WHEN 

SELECT
CASE
WHEN LOWER(product) LIKE '%credit report%' THEN 'Credit Reporting'
WHEN LOWER(product) LIKE '%debt collection%' THEN 'Debt Collection'
WHEN LOWER(product) LIKE '%mortgage%' THEN 'Mortgage'
WHEN LOWER(product) LIKE '%credit card%' THEN 'Credit Card'
WHEN LOWER(product) LIKE '%student loan%' THEN 'Student Loan'
ELSE 'Other'
END AS complaint_category,
COUNT(*) AS complaint_count
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
WHERE product IS NOT NULL
GROUP BY complaint_category
ORDER BY complaint_count DESC;  