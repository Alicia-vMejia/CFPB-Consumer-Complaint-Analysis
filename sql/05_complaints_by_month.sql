-- Query 05: Complaints by Month
-- Purpose: Analyze monthly trends in cnsumer complaint volume

SELECT
DATE_TRUNC(date_received, MONTH) AS complaint_month,
COUNT(*) AS complaint_count
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
GROUP BY complaint_month
ORDER BY complaint_month;