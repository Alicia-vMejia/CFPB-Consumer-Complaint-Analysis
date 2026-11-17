-- Query 14: Product Ranking by Year
-- Purpose: Rank financial products by complaint volume within each year using PARTITION BY

WITH yearly_product_complaints AS (
  SELECT
  EXTRACT(YEAR FROM date_received) AS complaint_year,
  product,
  COUNT(*) AS complaint_count
  FROM `bigquery-public-data.cfpb_complaints.complaint_database`
WHERE product IS NOT NULL
GROUP BY complaint_year, product
)

SELECT
complaint_year,
product,
complaint_count,
RANK() OVER (
  PARTITION BY complaint_year
  ORDER BY complaint_count DESC
) AS product_rank
FROM yearly_product_complaints
ORDER BY complaint_year, product_rank;