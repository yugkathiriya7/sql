-- 1. Overall Missed Appointment Rate
SELECT
	COUNT(*) FILTER (WHERE no_show = 'Yes') as missed,   -- Only count rows where appointment was missed
	COUNT(*) as total,  -- Total number of all appointments
	ROUND(COUNT(*) FILTER (WHERE no_show = 'Yes') * 100 / COUNT(*),2 ) as missed_percentage -- round the results to 2 decimal
FROM
	healthcare_appointments;






	

-- 2. Are SMS reminders effective in reducing no-shows?
select * from healthcare_appointments
SELECT 
	sms_received,   -- forgot to add the coma
	COUNT(*) as total_appointments,
	COUNT(*) FILTER (WHERE no_show = 'Yes') as missed,
	ROUND(COUNT(*) FILTER (WHERE no_show = 'Yes') * 100 / COUNT(*),2 ) as missed_percentage
FROM 
	healthcare_appointments
GROUP BY
	sms_received;








	

-- 3. Which patients missed appointments despite not receiving SMS?

SELECT 
	*
FROM 
	healthcare_appointments
WHERE
	sms_received = false
AND 
	no_show = 'Yes';