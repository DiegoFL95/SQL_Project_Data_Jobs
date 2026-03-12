# Introduction
✈️ In the world of aviation, you never take off without a flight plan and a clear understanding of the weather ahead. The job market for data professionals is no different. Whether you are aiming for the cockpit of a Data Analyst role or navigating the strategic routes of a Business Analyst, knowing which skills to pack in your 'flight bag' is the difference between a smooth career ascent and getting grounded.

📊 This project is a data-driven expedition into the current hiring landscape. I’ve crunched the numbers to answer two critical questions: Which skills are the industry shouting for? And which of those skills actually put more fuel in your tank (in the form of a higher salary)? By focusing specifically on Data Analyst and Business Analyst roles, this analysis serves as a radar for anyone looking to optimize their career trajectory in the data space.

🔍  To check the SQL queries click here [queries](/queries/)

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
![Top Paying Roles](queries\assets\top_paying_jobs.png)

### 2. Skills required for these top-paying jobs.

Question: What skills are required for the top-payinbg jobs?
- Use the top 10 highest-paying Data Analyst and Business Analyst jobs from the first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries

Top demanded skills for Data Analyst
| skills   |   demand_count |
|:---------|---------------:|
| sql      |          92628 |
| excel    |          67031 |
| python   |          57326 |
| tableau  |          46554 |
| power bi |          39468 |

Top demanded skills for Business Analyst
| skills   |   demand_count |
|:---------|---------------:|
| sql      |          17372 |
| excel    |          17134 |
| tableau  |           9324 |
| power bi |           9251 |
| python   |           8097 |

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

Top 5 in demanded skills for a data analyst
| skills   |   demand_count |
|:---------|---------------:|
| sql      |          92628 |
| excel    |          67031 |
| python   |          57326 |
| tableau  |          46554 |
| power bi |          39468 |

```sql
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
 ```

 
Top 5 in demanded skills for a business analyst
| skills   |   demand_count |
|:---------|---------------:|
| sql      |          17372 |
| excel    |          17134 |
| tableau  |           9324 |
| power bi |           9251 |
| python   |           8097 |

```sql
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
- look at the average salary associated with each skill for Data Analyst
- Focus on roles with specific salaries, regardless of location
- Why? It reveal hoe different skills impact salary levels for Data Analysis and helps identify the most financially rewarding skills to acquire or improve.

Top paying skills for data analyst
| skills    | avg_salary   |
|:----------|:-------------|
| svn       | $400,000     |
| solidity  | $179,000     |
| couchbase | $160,515     |
| datarobot | $155,486     |
| golang    | $155,000     |
| mxnet     | $149,000     |
| dplyr     | $147,633     |
| vmware    | $147,500     |
| terraform | $146,734     |
| twilio    | $138,500     |

```sql
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
```

Top paying skills for business analyst
| skills   | avg_salary   |
|:---------|:-------------|
| chef     | $220,000     |
| numpy    | $157,500     |
| ruby     | $150,000     |
| hadoop   | $139,201     |
| julia    | $136,100     |
| airflow  | $135,410     |
| phoenix  | $135,248     |
| electron | $131,000     |
| c        | $123,329     |
| pytorch  | $120,333     |
```sql
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

Most optimal skills for both roles 
| skills     |   demand_count | avg_salary   |
|:-----------|---------------:|:-------------|
| sql        |           3083 | $95,292      |
| excel      |           2143 | $87,212      |
| python     |           1840 | $104,277     |
| tableau    |           1659 | $98,794      |
| r          |           1073 | $105,969     |
| power bi   |           1044 | $92,059      |
| word       |            527 | $87,075      |
| powerpoint |            524 | $88,182      |
| sas        |            500 | $100,308     |
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
Throught this project I have brushed up my skills on SQL and also learned to use some new tools such as Git and Github.

# Conclusions / Insight
## Insight 1: 🌎 The "Universal Language" of Data
Looking at both your DA and BA demand charts, SQL and Excel are the undisputed kings.

The Data: SQL had over 92,000 mentions for Data Analysts and 17,000 for Business Analysts.

HR Interpretation: These aren't just "skills"; they are "entry requirements." If you don't have these, you aren't even on the radar. However, because everyone has them, they don't necessarily drive the highest salaries—they just get you the interview.

## Insight 2: 💰 The High-Demand vs. High-Pay Paradox
There is a fascinating gap between what is popular and what is lucrative.

The Data: While Excel is in high demand, it doesn't appear on the "Top Paying" lists. Instead, we see niche tools like Solidity (Web3), Golang, and Couchbase for DAs, or Chef and Hadoop for BAs, commanding salaries between $130k and $400k.

HR Interpretation: High pay lives in Specialization. The market pays a premium for "rare" skills that are difficult to master or essential for specific high-growth industries (like Blockchain or Cloud Infrastructure).

## Insight 3: 🍬 The "Sweet Spot" (The Optimal Skills)

The Data: Python and Tableau show up with a perfect balance. Python has high demand (1,840) and a high average salary ($104,277).

HR Interpretation: If you want the best ROI (Return on Investment) for your study time, Python is your best bet. It is versatile enough for both DA and BA roles and moves you out of the "entry-level" salary bracket into the six-figure territory.

## Final conclusion
The DA Market is Significantly Larger: The demand numbers for Data Analysts (SQL ~92k) are nearly 5x higher than for Business Analysts (SQL ~17k). This suggests a much broader job market for DAs, though likely with more competition.

Tool Saturation: Visualization tools (Tableau vs. Power BI) are neck-and-neck in demand. For a candidate, it is less about which one you know and more about your ability to tell a story with data using either one.

The Path to Seniority: To move from a standard analyst to a high-earning specialist, you must pivot from "Generalist" tools (Excel/SQL) toward "Engineering" or "Advanced Analytics" tools (Python, R, or Cloud-based tech).