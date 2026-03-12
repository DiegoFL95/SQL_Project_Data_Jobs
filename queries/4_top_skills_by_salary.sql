/* 
Answer: What are the top skills based on salary?
- lokk at the average salary associated with each skill for Data Analyst
- Focus on roles with specific salaries, regardless of location
- Why? It reveal hoe different skills impact salary levels for Data Analysis and
    helps identify the most financially rewarding skills to acquire or improve.
*/ 


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