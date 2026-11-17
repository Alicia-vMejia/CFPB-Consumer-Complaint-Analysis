-- Query 21: Complaint Response Timeliness by Company
-- Purpose: Analyze timely response rates for the top 10 companies

WITH top_companies AS (
  SELECT
    company_name,
    COUNT(*) AS total_complaints
  FROM `bigquery-public-data.cfpb_complaints.complaint_database`
  WHERE company_name IS NOT NULL
  GROUP BY company_name
  ORDER BY total_complaints DESC
  LIMIT 10
),

response_summary AS (
  SELECT
    company_name,
    COUNT(*) AS total_complaints,
  COUNTIF(timely_response IS TRUE) AS timely_responses,
COUNTIF(timely_response IS FALSE) AS late_responses 
  FROM `bigquery-public-data.cfpb_complaints.complaint_database`
  WHERE company_name IN (
    SELECT company_name
    FROM top_companies
  )
  GROUP BY company_name
)

SELECT
  company_name,
  total_complaints,
  timely_responses,
  late_responses,
  ROUND(
    SAFE_DIVIDE(timely_responses, total_complaints) * 100,
    2
  ) AS timely_response_rate
FROM response_summary
ORDER BY timely_response_rate DESC;