-- Query 23: Top Companies' Share of All Complaints
-- Purpose: Measure how much of total complaints volume is concentrated among the top companies 

WITH company_complaints AS (
  SELECT
    company_name,
    COUNT(*) AS complaint_count
  FROM `bigquery-public-data.cfpb_complaints.complaint_database`
  WHERE company_name IS NOT NULL
  GROUP BY company_name
),
ranked_companies AS (
  SELECT
    company_name,
    complaint_count,
    ROW_NUMBER() OVER (
      ORDER BY complaint_count DESC, company_name
    ) AS company_rank
  FROM company_complaints
),
total_complaints AS (
  SELECT
    SUM(complaint_count) AS overall_complaints
  FROM company_complaints
)
SELECT
  r.company_rank,
  r.company_name,
  r.complaint_count,
  ROUND(
    SAFE_DIVIDE(
      r.complaint_count,
      t.overall_complaints
    ) * 100,
    2
  ) AS complaint_share_percent,
  ROUND(
    SAFE_DIVIDE(
      SUM(r.complaint_count) OVER (
        ORDER BY r.company_rank
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
      ),
      t.overall_complaints
    ) * 100,
    2
  ) AS cumulative_share_percent
FROM ranked_companies AS r
CROSS JOIN total_complaints AS t
WHERE r.company_rank <= 10
ORDER BY r.company_rank;