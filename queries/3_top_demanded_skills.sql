/*
Question: What are the most in-demand skills for data analysts?
- Join job posting to inner join table similar to query 2
- Identify the top 5 in-demand skills for data analysts.
- Focus on all job postings.
- Why? Retrives top 5 skills with the highest demand in the job market,
which can help data analysts understand which skills are most valuable for their career development and job prospects.
        providing insight into the most valuable skills for job seekers.

*/  

SELECT *
FROM   job_postings_fact
INNER JOIN skills_job_dim ON job_posting_fact.job_id = skills_job_dim.job_id
Inner JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
LIMIT 5

SELECT * 
FROM job_postings_fact
LIMIT 5;
