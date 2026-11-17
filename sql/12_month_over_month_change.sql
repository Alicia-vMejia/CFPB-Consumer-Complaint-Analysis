-- Query 12: Month-over-Month Complaint Change
-- Purpose: Calculate the numeric and percentage change in complaints from the previous month

WITH monthly_complaints AS (
  SELECT
  DATE_TRUNC(date_received, MONTH) AS complaint_month,
  COUNT(*) AS complaint_count
  FROM `bigquery-public-data.cfpb_complaints.complaint_database`
GROUP BY complaint_month
),

monthly_comparison AS (
  SELECT
  complaint_month,
  complaint_count,
  LAG(complaint_count) OVER (
    ORDER BY complaint_month
  ) AS previous_month_count
  FROM monthly_complaints
  )

  SELECT
  complaint_month,
  complaint_count,
  previous_month_count,
  complaint_count - previous_month_count AS complaint_change,
  ROUND(
    SAFE_DIVIDE(complaint_count - previous_month_count,
    previous_month_count
  )* 100,
  2
) AS percent_change
FROM monthly_comparison
ORDER BY complaint_month;