-- Query 18: Largest Percentage Increase by Product
-- Purpose: Identify each product's largest year-over-year percentage increase in complaints

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
),

yearly_changes AS (
  SELECT
  complaint_year,
  product,
  complaint_count,
  previous_year_count,
  ROUND(
    SAFE_DIVIDE(
      complaint_count - previous_year_count,
      previous_year_count
    ) * 100,
    2
    ) AS percent_change
    FROM yearly_comparison
WHERE previous_year = complaint_year -1
AND previous_year_count > 0
  ),
ranked_changes AS (
  SELECT
  complaint_year,
  product,
  complaint_count,
  previous_year_count,
  percent_change,
RANK() OVER (
  PARTITION BY product
  ORDER BY percent_change DESC
) AS increase_rank
FROM yearly_changes
)

SELECT
complaint_year,
product,
complaint_count,
previous_year_count,
ranked_changes.percent_change
FROM ranked_changes
WHERE increase_rank =1
ORDER BY percent_change DESC;