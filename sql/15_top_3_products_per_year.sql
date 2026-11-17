-- Query 15: Top 3 Complaint Products Per Year
-- Purpose: Identify the three financial products with the most complaints each year

WITH yearly_complaints AS (
  SELECT
  EXTRACT(YEAR FROM date_received) AS complaint_year,
  product,
  COUNT(*) AS complaint_count
  FROM `bigquery-public-data.cfpb_complaints.complaint_database`
WHERE product IS NOT NULL GROUP BY complaint_year, product
),

product_ranking AS (
  SELECT
  complaint_year,
  product,
  complaint_count,
  RANK() OVER (
    PARTITION BY complaint_year
    ORDER BY complaint_count DESC
  ) AS product_rank
  FROM yearly_complaints
)

SELECT
complaint_year,
product,
complaint_count,
product_rank
FROM product_ranking
WHERE product_rank <= 3
ORDER BY complaint_year, product_rank;    