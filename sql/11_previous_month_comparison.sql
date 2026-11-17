-- Query 11: Previous Month Complaint Comparison
-- Purpose: Use LAG() to compare monthly complaint volume with the previous month

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
LAG(complaint_count) OVER (
  ORDER BY complaint_month
) AS previous_month_count
FROM monthly_complaints
ORDER BY complaint_month