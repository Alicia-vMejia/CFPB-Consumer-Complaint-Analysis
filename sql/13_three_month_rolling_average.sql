-- Query 13: Three-Month Rolling Average
-- Purpose: Calculate a rolling average to identify Longer-term complaint trends

WITH monthly_complaints AS(
  SELECT
  DATE_TRUNC(date_received, MONTH) AS complaint_month,
  COUNT(*) AS complaint_count
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
GROUP BY complaint_month
)

SELECT
complaint_month,
complaint_count,
ROUND(
  AVG(complaint_count) OVER (
    ORDER BY complaint_month
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
  ),
  2
) AS three_month_rolling_avg
FROM monthly_complaints
ORDER BY complaint_month;