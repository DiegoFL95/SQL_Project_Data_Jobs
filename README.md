# Introduction
Quick dive into data from the jobs market for data related jobs, this project explores the skills demanded by the industry as well as answers which of this skills are better rewarded in terms of salary.
I will be focusing my analysis for the roles of Data Analyst and Business Analyst.

To check the SQL queries click here [queries](/queries/)

# Background
As I find myself navigating the current job market for data related jobs and also with the need to refresh my SQL skills, this project was born from the curiosity to find out what are the main skills demanded in the job market and also the pay related to these skills.

The data comes from Mr. Luke Barousse see [https://www.lukebarousse.com/sql]
The data contained gives us insight on: job titles, locations, salaries, top-paying jobs to name a few.

### The question I wanted to aswer through my SQL queries were:

1. What are the top-paying jobs for Data Analysts and Business Analyst?

2. What Skills are required for these top-paying jobs?

3. What are the most demanded skills for these roles?

4. Which skills are associated with higher salaries?

5. What are the most optimal skills to learn?

# Tools Used
For the dive in the database containing our data we used several tools:

- **SQL:** the backbone of my analysis, allowing me to query the database and find the insight within.
- **PostgresSQL:** The chosen database management system, ideal for handling the data. this election of database managemnt system is due to its popularity see [https://survey.stackoverflow.co/2025/technology#1-databases] this is a link to the stackoverflow 2025 survey to developers and the most used database management system was Postges making this a fitting choise for the project.
- **Visual Studio Code:** The most popular code editor at the moment, used for executing my queries.
- **Git & Github:** Great tool for version control and used to share with you the SQL scripts and analysis, ensuring collaboration and tracking.

# The Analysis
### 1. Top Paying Data Analyst and Business Analyst Jobs.

Question to answer: What are the top-paying data analyst and business analyst jobs?
- Identify the top 10 highest-paying data analyst and business analyst that are remote
- Focus on job postings with specific salaries ignore NULL values
- why? Highlight the top-payin opportunities for Data Analyst and BA

```sql
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
```
![Top Paying Roles](SQL_Project_Data_jobs\queries\assets\top_paying_jobs.png)

### 2. Skills required for these top-paying jobs.

Question: What skills are required for the top-payinbg jobs?
- Use the top 10 highest-paying Data Analyst and Business Analyst jobs from the first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries

```sql
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
```

### 3. Most demanded skills for these roles
Question: What are the most in-demand skills for data analysts?
- Join job posting to inner join table similar to query 2
- Identify the top 5 in-demand skills for data analysts.
- Identify the top 5 in-demand skills for business analyst.
- Focus on all job postings.
- Why? Retrives top 5 skills with the highest demand in the job market,
which can help data analysts understand which skills are most valuable for their career development and job prospects.providing insight into the most valuable skills for job seekers.

```sql
-- top 5 in demand skills for a data analyst
SELECT 
        Skills,
        COUNT(skills_job_dim.job_id) AS demand_count
FROM  job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
        job_title_short = 'Data Analyst'
GROUP BY
        skills
ORDER BY 
        demand_count DESC
LIMIT 5;
 
-- top 5 in demand skills for a business analyst
SELECT 
        Skills,
        COUNT(skills_job_dim.job_id) AS demand_count
FROM  job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
        job_title_short = 'Business Analyst'
GROUP BY
        skills
ORDER BY 
        demand_count DESC
LIMIT 5;
```
### 4. Skills associated with higher salaries
Answer: What are the top skills based on salary?
- lokk at the average salary associated with each skill for Data Analyst
- Focus on roles with specific salaries, regardless of location
- Why? It reveal hoe different skills impact salary levels for Data Analysis and helps identify the most financially rewarding skills to acquire or improve.

```sql
--top paying skills for data analyst
SELECT 
    Skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM  job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY 
        avg_salary DESC
LIMIT 25;

--top paying skills for business analyst
SELECT 
    Skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM  job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
        job_title_short = 'Business Analyst'
        AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY 
        avg_salary DESC
LIMIT 25;
```
### 5. Most optimal skills to learn
What are the most optimal skills to learn (Aka it's in high demand and high-paying skill)
- Identify skills in high demand and asociated with high average salaries for Data Analyst and Business Analyst
- Concentrates on remote positions for specific salaries
- Why? targets skills that offer job security (high demand) and financial benefits (hig salaries), offering strategic insight for career development in data analysis.

```sql
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.Skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM  job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM  job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
            job_title_short = 'Business Analyst'
            AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY   
   -- avg_salary DESC,
    demand_count DESC,
    avg_salary DESC
LIMIT 10;
```

# What I learned


# Conclusions
