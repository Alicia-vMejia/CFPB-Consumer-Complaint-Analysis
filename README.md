# CFPB Consumer Complaint Analysis

## Project Overview

For this project, I used SQL and Google BigQuery to explore consumer complaints submitted to the Consumer Financial Protection Bureau (CFPB).

I wanted to better understand the patterns behind consumer complaints, including which financial companies received the most complaints, how complaint volumes were distributed, and what trends could be identified in the data.

This project gave me an opportunity to practice working with a large, real-world dataset, strengthen my SQL skills, and turn the results into something easier to understand using Excel.

## Tools Used

- **Google BigQuery:** Querying and analyzing the dataset
- **SQL:** Exploring, filtering, grouping, and analyzing complaint records
- **Microsoft Excel:** Creating visualizations and summarizing findings
- **GitHub:** Organizing and documenting the project

## My Approach

I developed 23 SQL queries to explore the CFPB consumer complaint database from different perspectives.

Throughout the analysis, I practiced SQL techniques including:

- Common Table Expressions (CTEs)
- CASE statements
- Aggregate functions
- Date functions
- Window functions
- Ranking and percentage calculations

After completing the SQL analysis, I exported selected results to Excel, created a visualization of the top 10 companies by complaint volume, and documented my findings.

## Key Findings

### 1. Complaints Were Concentrated Among Three Companies

Equifax, TransUnion, and Experian accounted for approximately 47.36% of all complaints in the analyzed dataset.

This stood out to me because nearly half of the recorded complaints were associated with just three companies.

### 2. The Top 10 Companies Accounted for 64.08% of Complaints

The 10 companies with the highest complaint volumes represented approximately 64.08% of all complaints.

This showed how complaint volume was concentrated among a relatively small number of financial companies.

### 3. Credit Reporting Companies Led in Complaint Volume

The three companies with the highest complaint counts were:

| Company | Complaint Count |
|---|---:|
| Equifax | 619,370 |
| TransUnion | 526,785 |
| Experian | 492,153 |

These results highlighted credit reporting as an area worth exploring further.

## Analysis Limitations

Complaint volume alone does not tell us whether a company provides better or worse service than another.

Larger companies may receive more complaints simply because they serve more customers. Reporting practices, financial products, and consumer behavior can also affect complaint totals.

The findings reflect the data available at the time of analysis, and further research would be needed to make more meaningful comparisons between companies.

## Project Files

- **SQL:** Contains the 23 SQL queries used throughout the analysis.
- **results:** Contains the Excel workbook with the complaint volume visualization, key findings, and analysis limitations.

## Data Source

Consumer Financial Protection Bureau (CFPB) Consumer Complaint Database.

Data accessed through Google BigQuery:

`bigquery-public-data.cfpb_complaints.complaint_database`

## What I Learned

Working on this project helped me become more comfortable writing SQL queries, breaking down analytical questions, and interpreting results.

One of my biggest takeaways was understanding that identifying a pattern is only part of the process. It's just as important to consider the limitations of the data and communicate findings without making assumptions the numbers cannot support.

As I continue transitioning into data analytics, projects like this allow me to build my technical skills while gaining more experience working with real-world information.
