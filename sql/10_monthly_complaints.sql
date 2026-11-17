-- Query 10: Monthly Complaint Growth
-- Purpose : Use a CTE To Calculate monthly complaint totals and compare changes over time 

WITH monthly_complaints AS (
  SELECT
  DATE_TRUNC(date_received, MONTH) AS complaint_month,
  COUNT(*) AS complaint_count
  FROM `bigquery-public-data.cfpb_complaints.complaint_database`
GROUP BY complaint_month
)

SELECT
complaint_month,
complaint_count,
FROM monthly_complaints
ORDER BY complaint_month;