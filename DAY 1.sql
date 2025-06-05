--  Question 2: Analyze patient distribution by gender & age group
SELECT
	gender,
	CASE
		WHEN age < 18 THEN 'Child'
		WHEN age BETWEEN 18 and 35 THEN 'Young_Adult'
		WHEN age BETWEEN 36 AND 60 THEN 'Adult'
		ELSE 'Senior'
	END AS age_group,
	COUNT(*) as total_patients
FROM
	healthcare_appointments
GROUP BY 
	gender,age_group
ORDER BY 
	total_patients DESC;



-- Question 3: Identify neighborhoods with the highest patient volumes


SELECT
	neighbourhood,
	COUNT(*) as total_patients
FROM
	healthcare_appointments
GROUP BY 
	neighbourhood
ORDER BY 
	total_patients DESC;











