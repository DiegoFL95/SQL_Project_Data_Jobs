/* 
Question: What skills are required for the top-payinbg jobs?
- Use the top 10 highest-paying Data Analyst and Business Analyst jobs from the first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
        helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        name AS company_name,
        job_title_short AS job_title,
       -- job_work_from_home AS remote,
        salary_year_avg AS salary_year
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
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
Inner JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year DESC;




--skills_job_dim overview
SELECT *
FROM skills_job_dim
LIMIT 5;

--skills_dim overview
SELECT *
FROM skills_dim
LIMIT 5;


/*
💡 Big takeaway:
The most valuable core skills in this dataset are:
SQL + Python + Tableau
These three form the foundation of most data analytics roles.
Interpretation
SQL, Python, and Tableau dominate the dataset.
These represent the typical data stack:
SQL → data extraction
Python/R → data analysis
Tableau/Power BI → visualization

Results

[
  {
    "job_id": 552322,
    "company_name": "AT&T",
    "job_title": "Data Analyst",
    "salary_year": "255829.5",
    "skills": "sql"
  },
  {
    "job_id": 552322,
    "company_name": "AT&T",
    "job_title": "Data Analyst",
    "salary_year": "255829.5",
    "skills": "python"
  },
  {
    "job_id": 552322,
    "company_name": "AT&T",
    "job_title": "Data Analyst",
    "salary_year": "255829.5",
    "skills": "r"
  },
  {
    "job_id": 552322,
    "company_name": "AT&T",
    "job_title": "Data Analyst",
    "salary_year": "255829.5",
    "skills": "azure"
  },
  {
    "job_id": 552322,
    "company_name": "AT&T",
    "job_title": "Data Analyst",
    "salary_year": "255829.5",
    "skills": "databricks"
  },
  {
    "job_id": 552322,
    "company_name": "AT&T",
    "job_title": "Data Analyst",
    "salary_year": "255829.5",
    "skills": "aws"
  },
  {
    "job_id": 552322,
    "company_name": "AT&T",
    "job_title": "Data Analyst",
    "salary_year": "255829.5",
    "skills": "pandas"
  },
  {
    "job_id": 552322,
    "company_name": "AT&T",
    "job_title": "Data Analyst",
    "salary_year": "255829.5",
    "skills": "pyspark"
  },
  {
    "job_id": 552322,
    "company_name": "AT&T",
    "job_title": "Data Analyst",
    "salary_year": "255829.5",
    "skills": "jupyter"
  },
  {
    "job_id": 552322,
    "company_name": "AT&T",
    "job_title": "Data Analyst",
    "salary_year": "255829.5",
    "skills": "excel"
  },
  {
    "job_id": 552322,
    "company_name": "AT&T",
    "job_title": "Data Analyst",
    "salary_year": "255829.5",
    "skills": "tableau"
  },
  {
    "job_id": 552322,
    "company_name": "AT&T",
    "job_title": "Data Analyst",
    "salary_year": "255829.5",
    "skills": "power bi"
  },
  {
    "job_id": 552322,
    "company_name": "AT&T",
    "job_title": "Data Analyst",
    "salary_year": "255829.5",
    "skills": "powerpoint"
  },
  {
    "job_id": 99305,
    "company_name": "Pinterest Job Advertisements",
    "job_title": "Data Analyst",
    "salary_year": "232423.0",
    "skills": "sql"
  },
  {
    "job_id": 99305,
    "company_name": "Pinterest Job Advertisements",
    "job_title": "Data Analyst",
    "salary_year": "232423.0",
    "skills": "python"
  },
  {
    "job_id": 99305,
    "company_name": "Pinterest Job Advertisements",
    "job_title": "Data Analyst",
    "salary_year": "232423.0",
    "skills": "r"
  },
  {
    "job_id": 99305,
    "company_name": "Pinterest Job Advertisements",
    "job_title": "Data Analyst",
    "salary_year": "232423.0",
    "skills": "hadoop"
  },
  {
    "job_id": 99305,
    "company_name": "Pinterest Job Advertisements",
    "job_title": "Data Analyst",
    "salary_year": "232423.0",
    "skills": "tableau"
  },
  {
    "job_id": 502610,
    "company_name": "Noom",
    "job_title": "Business Analyst",
    "salary_year": "220000.0",
    "skills": "sql"
  },
  {
    "job_id": 502610,
    "company_name": "Noom",
    "job_title": "Business Analyst",
    "salary_year": "220000.0",
    "skills": "python"
  },
  {
    "job_id": 502610,
    "company_name": "Noom",
    "job_title": "Business Analyst",
    "salary_year": "220000.0",
    "skills": "excel"
  },
  {
    "job_id": 502610,
    "company_name": "Noom",
    "job_title": "Business Analyst",
    "salary_year": "220000.0",
    "skills": "tableau"
  },
  {
    "job_id": 502610,
    "company_name": "Noom",
    "job_title": "Business Analyst",
    "salary_year": "220000.0",
    "skills": "looker"
  },
  {
    "job_id": 502610,
    "company_name": "Noom",
    "job_title": "Business Analyst",
    "salary_year": "220000.0",
    "skills": "chef"
  },
  {
    "job_id": 1021647,
    "company_name": "Uclahealthcareers",
    "job_title": "Data Analyst",
    "salary_year": "217000.0",
    "skills": "sql"
  },
  {
    "job_id": 1021647,
    "company_name": "Uclahealthcareers",
    "job_title": "Data Analyst",
    "salary_year": "217000.0",
    "skills": "crystal"
  },
  {
    "job_id": 1021647,
    "company_name": "Uclahealthcareers",
    "job_title": "Data Analyst",
    "salary_year": "217000.0",
    "skills": "oracle"
  },
  {
    "job_id": 1021647,
    "company_name": "Uclahealthcareers",
    "job_title": "Data Analyst",
    "salary_year": "217000.0",
    "skills": "tableau"
  },
  {
    "job_id": 1021647,
    "company_name": "Uclahealthcareers",
    "job_title": "Data Analyst",
    "salary_year": "217000.0",
    "skills": "flow"
  },
  {
    "job_id": 112859,
    "company_name": "Uber",
    "job_title": "Business Analyst",
    "salary_year": "214500.0",
    "skills": "python"
  },
  {
    "job_id": 168310,
    "company_name": "SmartAsset",
    "job_title": "Data Analyst",
    "salary_year": "205000.0",
    "skills": "sql"
  },
  {
    "job_id": 168310,
    "company_name": "SmartAsset",
    "job_title": "Data Analyst",
    "salary_year": "205000.0",
    "skills": "python"
  },
  {
    "job_id": 168310,
    "company_name": "SmartAsset",
    "job_title": "Data Analyst",
    "salary_year": "205000.0",
    "skills": "go"
  },
  {
    "job_id": 168310,
    "company_name": "SmartAsset",
    "job_title": "Data Analyst",
    "salary_year": "205000.0",
    "skills": "snowflake"
  },
  {
    "job_id": 168310,
    "company_name": "SmartAsset",
    "job_title": "Data Analyst",
    "salary_year": "205000.0",
    "skills": "pandas"
  },
  {
    "job_id": 168310,
    "company_name": "SmartAsset",
    "job_title": "Data Analyst",
    "salary_year": "205000.0",
    "skills": "numpy"
  },
  {
    "job_id": 168310,
    "company_name": "SmartAsset",
    "job_title": "Data Analyst",
    "salary_year": "205000.0",
    "skills": "excel"
  },
  {
    "job_id": 168310,
    "company_name": "SmartAsset",
    "job_title": "Data Analyst",
    "salary_year": "205000.0",
    "skills": "tableau"
  },
  {
    "job_id": 168310,
    "company_name": "SmartAsset",
    "job_title": "Data Analyst",
    "salary_year": "205000.0",
    "skills": "gitlab"
  }
]
*/
