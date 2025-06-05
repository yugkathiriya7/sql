DROP TABLE IF EXISTS public.patients;

CREATE TABLE public.patients (
    patientid INTEGER PRIMARY KEY,
    gender VARCHAR(10),
    registration_date DATE,
    email_consent BOOLEAN,
    status VARCHAR(20)
);


-- JOINss

-- 1: How many appointments were made by patients who have not given email consent?
SELECT 
	p.patientid,
	p.email_consent,
	COUNT(a.patientid) as total_appointments
FROM 
	patients as p
JOIN
	healthcare_appointments as a
ON
	p.patientid = a.patientid
WHERE 
	p.email_consent = false
GROUP BY
	p.patientid, p.email_consent;



-- 2. Identify patients marked as 'Inactive' but still scheduled appointments
SELECT
	p.patientid,
	p.status,
	COUNT(*) as scheduled_appointments
FROM 
	patients as p
JOIN
	healthcare_appointments as a
ON
	p.patientid = a.patientid
WHERE 
	p.status = 'Inactive'
GROUP BY 
	p.patientid,p.status;


-- 3. Identify patients who made more than 3 appointments but haven't given email consent.
SELECT
	p.patientid,
	p.email_consent,
	COUNT(*) as total_appointments
FROM 
	patients as p
JOIN 
	healthcare_appointments as a
ON
	p.patientid = a.patientid
WHERE 
	p.email_consent = false
GROUP BY
	p.patientid, p.email_consent
HAVING
	COUNT(*) > 3;



--Using LEFT JOIN for data gaps:  Find patients who are registered but never booked any appointment
SELECT
	p.patientid,
	p.status
FROM 
	patients as p
LEFT JOIN 
	healthcare_appointments as a
ON
 	p.patientid = a.patientid
WHERE
	a.patientid IS NULL;





-- Which neighborhoods have the highest number of unique patients who gave email consent?
SELECT
	a.neighbourhood,
	COUNT(DISTINCT p.patientid) as unique_patients_withconsent
FROM 
	patients as p
JOIN 
	healthcare_appointments as a
ON
	p.patientid = a.patientid
WHERE 
	p.email_consent = true
GROUP BY 
	a.neighbourhood
ORDER BY 
	unique_patients_withconsent DESC;


-- 1: On which day of the week do patients miss the most appointments?
SELECT
	TO_CHAR(appointmentday,'FMDay') as weekday,
	COUNT(*) as total_patients
FROM
	healthcare_appointments 
WHERE 
	no_show = 'Yes'
GROUP BY 
	weekday
ORDER BY
	total_patients DESC;


-- 2.What’s the average number of days between registration and first appointment?
WITH first_appointments as 
(
		SELECT
			p.patientid,
			MIN(a.appointmentday) as first_appointment,
			p.registration_date
		FROM
			patients as p
		JOIN
			healthcare_appointments as a
		ON
			p.patientid = a.patientid
		GROUP BY 
			p.patientid, p.registration_date
)
	SELECT
		ROUND(AVG(DATE_PART('day', first_appointment - registration_date ))::numeric,2) as avg_days_first_appointment
	FROM
		first_appointments;


-- Which top 3 neighbourhoods had the longest average delay between registration and first appointment?
WITH patient_delay AS
(
	SELECT
		p.patientid,
		a.neighbourhood,
		MIN(a.appointmentday) as first_appointment,
		p.registration_date
	FROM
		patients as p
	JOIN 
		healthcare_appointments as a
	ON
		p.patientid = a.patientid
	GROUP BY 
		p.patientid, a.neighbourhood, p.registration_date
)
	SELECT
		neighbourhood,
		ROUND(AVG(DATE_PART('DAY', first_appointment - registration_date))::numeric,2) as avg_delays
	FROM
		patient_delay
	GROUP BY
		neighbourhood
	ORDER BY 
		avg_delays DESC ;
	
 




-- WINDOW FUNCTIONSS

-- What is the first appointment (chronologically) for each patient who gave email consent?
SELECT 
	p.patientid,
	a.appointmentday,
	p.email_consent,
	ROW_NUMBER() OVER(
		PARTITION BY p.patientid   -- restart the numbering for each patient.
		ORDER BY a.appointmentday  -- start counting from the earliest appointment
	) as appointment_rank
FROM
	patients as p
JOIN 
	healthcare_appointments as a
ON
	 p.patientid = a.patientid
WHERE 
	p.email_consent = true;



-- Who are the repeat patients?
SELECT
	p.patientid,
	a.appointmentday,
	COUNT(*) OVER(PARTITION BY p.patientid) as total_visits -- counts how many appointments each patient has, but without collapsing rows.
FROM 
	patients as p
JOIN 
	healthcare_appointments as a
ON
	p.patientid = a.patientid
WHERE 
	p.email_consent = true
ORDER BY 
	total_visits DESC;



-- Which neighbourhoods have the most no-shows ranked per patient.
SELECT
	p.patientid,
	a.neighbourhood,
	COUNT(*) FILTER (WHERE a.no_show = 'Yes') as missed_appointments,
	RANK() OVER(											--Ranks patients by missed appointments
		PARTITION BY a.neighbourhood						-- Groups ranking logic per neighbourhood
		ORDER BY COUNT(*) FILTER (WHERE a.no_show ='Yes') DESC  --Decides how to rank (DESC = more no-shows first)
	) AS no_show_rank
FROM
	patients as p
JOIN 
	healthcare_appointments as a
ON
	p.patientid = a.patientid
GROUP BY
	p.patientid, a.neighbourhood
ORDER BY
	a.neighbourhood, no_show_rank;











