-- Query 19: Top Complaint Product for Each Top Company
-- Purpose: Identify the most complained-about product for each of the top 10 companies

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

company_product_complaints AS (
  SELECT
    company_name,
    product,
    COUNT(*) AS product_complaints
  FROM `bigquery-public-data.cfpb_complaints.complaint_database`
  WHERE company_name IS NOT NULL
    AND product IS NOT NULL
  GROUP BY company_name, product
),

ranked_products AS (
  SELECT
    c.company_name,
    c.total_complaints,
    p.product,
    p.product_complaints,
    RANK() OVER (
      PARTITION BY c.company_name
      ORDER BY p.product_complaints DESC
    ) AS product_rank
  FROM top_companies AS c
  INNER JOIN company_product_complaints AS p
    ON c.company_name = p.company_name
)

SELECT
  company_name,
  total_complaints,
  product,
  product_complaints
FROM ranked_products
WHERE product_rank = 1
ORDER BY total_complaints DESC;