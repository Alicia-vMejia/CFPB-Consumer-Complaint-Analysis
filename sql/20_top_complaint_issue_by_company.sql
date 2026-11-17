-- Query 20: Top Complaint Issue for Each Top Company
-- Purpose: Identify the most frequently reported issue for each of the top 10 companies

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
issue_complaints AS (
  SELECT
  company_name,
  issue,
  COUNT(*) AS issue_complaints
  FROM `bigquery-public-data.cfpb_complaints.complaint_database`
WHERE company_name IN (SELECT company_name FROM top_companies)
  AND issue IS NOT NULL
GROUP BY company_name, issue
),
ranked_issues AS (
  SELECT
    company_name,
    issue,
  ic.issue_complaints,
    ROW_NUMBER() OVER (
  PARTITION BY company_name
ORDER BY ic.issue_complaints DESC, issue
) AS issue_rank
FROM issue_complaints AS ic
)
SELECT
  company_name,
  issue,
  issue_complaints
FROM ranked_issues
WHERE issue_rank = 1
ORDER BY issue_complaints DESC;