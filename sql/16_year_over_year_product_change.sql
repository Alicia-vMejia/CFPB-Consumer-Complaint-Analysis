-- Query 16: Year_over_Year Complaint Change by Product
-- Purpose: Measure annual changes in complaint volume for each financial product

WITH yearly_product_complaints AS (
  SELECT
  EXTRACT(YEAR FROM date_received) AS complaint_year,
  product,
  COUNT(*) AS complaint_count
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
WHERE product IS NOT NULL
GROUP BY complaint_year, product
),
yearly_comparison AS (
  SELECT
  complaint_year,
  product,
  complaint_count,
  LAG(complaint_year) OVER (
    PARTITION BY product
    ORDER BY complaint_year
  ) AS previous_year,
  LAG(complaint_count) OVER (
    PARTITION BY product
    ORDER BY complaint_year
  ) AS previous_year_count
  FROM yearly_product_complaints
  )

SELECT
complaint_year,
product,
complaint_count,
previous_year_count,
CASE
WHEN previous_year = complaint_year -1
THEN complaint_count - previous_year_count
END AS complaint_change,
CASE
WHEN previous_year = complaint_year -1
THEN ROUND(
  SAFE_DIVIDE(complaint_count - previous_year_count,
  previous_year_count
  )* 100,
  2
)

END AS percent_change
FROM yearly_comparison
ORDER BY product, complaint_year;