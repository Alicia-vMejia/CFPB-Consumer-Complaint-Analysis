-- Query 22: Complaint Response Timeliness by Product
-- Purpose: Compare timely response rates across financial products

WITH product_responses AS (
  SELECT
    product,
    COUNT(*) AS total_complaints,
    COUNTIF(timely_response IS TRUE) AS timely_responses,
    COUNTIF(timely_response IS FALSE) AS late_responses
  FROM `bigquery-public-data.cfpb_complaints.complaint_database`
  WHERE product IS NOT NULL
  GROUP BY product
)

SELECT
  product,
  total_complaints,
  timely_responses,
  late_responses,
  ROUND(
    SAFE_DIVIDE(timely_responses, total_complaints) * 100,
    2
  ) AS timely_response_rate
FROM product_responses
ORDER BY timely_response_rate DESC;