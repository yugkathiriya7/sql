-- 1: Do patients with certain chronic conditions (like diabetes or hypertension) tend to miss appointments more often?
SELECT 
	diabetes,
	hipertension,
	COUNT(*) as total,
	COUNT(*) FILTER (WHERE no_show = 'Yes') as missed_appointments,
	ROUND(COUNT(*) FILTER (WHERE no_show = 'Yes') * 100 / COUNT(*),2) AS missed_percentage
FROM
	healthcare_appointments
GROUP BY
	diabetes,hipertension
ORDER BY
	missed_percentage DESC;

	

-- 2: What are the no-show rates by appointment hour (morning vs. afternoon vs. evening)?
SELECT
  CASE
    WHEN EXTRACT(HOUR FROM appointmentday) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM appointmentday) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_slot,
  COUNT(*) AS total,
  COUNT(*) FILTER (WHERE no_show = 'Yes') AS missed_appointments,
  ROUND(COUNT(*) FILTER (WHERE no_show = 'Yes') * 100.0 / COUNT(*), 2) AS missed_percentage
FROM
  healthcare_appointments
GROUP BY
  time_slot
ORDER BY
  missed_percentage DESC;

  

 -- 3: Among scholarship holders, are no-show rates higher or lower?
 SELECT
 	scholarship,
	COUNT(*) as total,
	COUNT(*) FILTER (WHERE no_show = 'Yes') as missed,
	ROUND(COUNT(*) FILTER (WHERE no_show = 'Yes') * 100 / COUNT(*),2) as missed_percentage
FROM
	healthcare_appointments
GROUP BY
	scholarship;



	