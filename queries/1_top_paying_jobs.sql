/* 
Question to answer: What are the top-paying data analyst and business analyst jobs?
-Identify the top 10 highest-paying data analyst and business analyst that are remote
-Focus on job postings with specific salaries ignore NULL values
-why? Highlight the top-payin opportunities for Data Analyst and BA, offering insight
*/

SELECT
    job_id,
    name AS company_name,
    job_title_short AS job_title,
    job_location AS location,
    job_work_from_home AS remote,
    salary_year_avg AS salary_year,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    (job_title_short LIKE '%Data Analyst%' 
    OR job_title_short LIKE '%Business Analyst%')
    AND job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;


--company_dim overview
SELECT *
FROM company_dim
LIMIT 10;
