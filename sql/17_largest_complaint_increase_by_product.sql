-- Query 17: Largest Year-over_Year Increase by Product
-- Purpose: Identify the year with the Largest annual complaint increase for each financial product

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
    complaint_count - previous_year_count AS complaint_change
  FROM yearly_comparison
  WHERE previous_year_count IS NOT NULL
),
  ranked_changes AS (
    SELECT
    complaint_year,
    product,
    complaint_count,
    previous_year_count,
    complaint_change,
    ROW_NUMBER() OVER (
      PARTITION BY product
      ORDER BY complaint_change DESC, complaint_year
    ) AS increase_rank
    FROM yearly_changes
  )

  SELECT
  complaint_year,
  product,
  complaint_count,
  previous_year_count,
  complaint_change
  FROM ranked_changes
  WHERE increase_rank = 1
  ORDER BY complaint_change DESC;