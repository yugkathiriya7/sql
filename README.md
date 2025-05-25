# 7-Day SQL Healthcare Analytics Challenge

This project is a 7-day deep dive into real-world SQL use cases using a mock healthcare appointments dataset. Each day focused on solving a practical data problem using increasingly advanced SQL concepts—from segmentation and aggregation to window functions and trend analysis.

## Dataset
- **Healthcare Appointments**: Simulated records including patient IDs, appointment dates, attendance status, registration dates, and communication preferences.

---

## Objectives

- Apply SQL to solve real-world business questions
- Build logic with `GROUP BY`, `CASE`, `JOIN`, `FILTER`, and CTEs
- Learn and implement window functions like `LAG()`, `LEAD()`, `RANK()`, and `ROW_NUMBER()`
- Identify patient behavior trends, delays, and no-show patterns

---

## Day-wise Breakdown

### ✅ Day 1: Patient Segmentation
- Classified patients by age group and gender
- Identified high-volume neighborhoods
- Used `CASE`, `GROUP BY`, and `DISTINCT`

---

### ✅ Day 2: No-Show Behavior
- Calculated overall missed appointment rate
- Compared no-show rates with and without SMS reminders
- Applied `FILTER`, `ROUND`, and grouped analysis

---

### ✅ Day 3: Repeat Behavior & Conditions
- Counted total and missed appointments by gender and chronic illness
- Used conditional aggregation and comparison logic

---

### ✅ Day 4: Intermediate JOINs
- Created a `patients` table and joined it with appointments
- Identified inactive patients who still showed up
- Applied `JOIN`, `HAVING`, `DISTINCT`, and subqueries

---

### ✅ Day 5: Time-Based Insights
- Identified no-show trends by weekday
- Calculated avg. delay between registration and first appointment using CTE
- Found neighborhoods with longest onboarding delays

---

### ✅ Day 6: Ranking and Rolling Analysis
- Learned `ROW_NUMBER()`, `RANK()`, and `COUNT() OVER()`
- Ranked patients by no-shows per neighborhood
- Identified first appointments and repeat visit counts

---

### ✅ Day 7: Visit Gap & Predictive Trends
- Used `LAG()` to calculate gaps between appointments
- Applied `LEAD()` to track next appointments
- Flagged patients with 15+ day drop-offs and predicted follow-up behavior

---

## Key Concepts Practiced

- `GROUP BY`, `ORDER BY`, `CASE WHEN`
- `JOIN`, `DISTINCT`, `HAVING`, subqueries
- Common Table Expressions (CTEs)
- Window Functions: `ROW_NUMBER()`, `RANK()`, `LAG()`, `LEAD()`, `OVER()`
- Interval & Date calculations

---

## Tools Used

- PostgreSQL
- pgAdmin
- Jupyter Notebooks (for visualization & walkthroughs)
- GitHub (for daily tracking)

---

## Reflections

This challenge significantly improved my ability to structure business-driven queries, interpret patient behavior from raw data, and use SQL to tell compelling stories. From writing simple aggregations to debugging window logic, it taught me not just how to code, but how to **think like an analyst**.

---

## Contributors

Inspired by:
- [Mo Chen](https://www.linkedin.com/in/mo-chen1/)
- [Walter Shields](https://www.linkedin.com/in/waltershields/)
- [Rishabh Mishra](https://www.linkedin.com/in/rishabh-mishra/)
- [Ankit Bansal](https://www.linkedin.com/in/ankitbansal24/)
- Guided by [ChatGPT](https://openai.com/chatgpt)

---

## License

This project is open for educational and non-commercial use. Credit the author if reused.
