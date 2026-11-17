-- Query 09: Refined Complaint Catergories
-- Purpose: Improve product categorization based on findings from Query 08

SELECT
CASE
WHEN LOWER(product) LIKE '%credit reports%' THEN 'Credit Reporting'
WHEN LOWER(product) LIKE '%debt collection%' THEN 'Debt Collection'
WHEN LOWER(product) LIKE '%mortgage%' THEN 'Mortgage'
WHEN LOWER(product) LIKE '%credit card%' THEN 'Credit Card'
WHEN LOWER(product) LIKE '%student loan%' THEN 'Student Loan'
WHEN LOWER(product) LIKE '%checking%'
OR LOWER(product) LIKE '%bank account%' THEN 'Banking Accounts'
WHEN LOWER(product) LIKE '%money transfer%'
OR LOWER(product) LIKE '%virtual currency%' THEN 'Money Transfer & Virtual Currency'
ELSE 'Other'
END AS complaint_catergory,
COUNT(*) AS complaint_count
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
WHERE product IS NOT NULL
GROUP BY complaint_catergory
ORDER BY complaint_count DESC;