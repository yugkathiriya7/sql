-- 1.Which patients had more than 15 days of gap between two consecutive appointments?

SELECT 
	*
FROM 
	
(
	SELECT 
		p.patientid,
		a.appointmentday,
		LAG (a.appointmentday) OVER(
			PARTITION BY a.patientid
			ORDER BY a.appointmentday
		) as previous_appointment,
		a.appointmentday - LAG(a.appointmentday) OVER (
			PARTITION BY a.patientid
			ORDER BY a.appointmentday
		) as gap_between_appointment
	FROM
		patients as p 
	JOIN
		healthcare_appointments as a
	ON 
		p.patientid = a.patientid
) AS gap_data

WHERE 
	gap_between_appointment > '15 days':: interval;


--  2: Which patients had increasing appointment frequency over time?



-- Which patients are coming back faster for appointments?


SELECT
	patientid,
	appointmentday,
	LAG(appointmentday) OVER(
		PARTITION BY patientid
		ORDER BY appointmentday
	) as previous_day
FROM 
	healthcare_appointments;


-- show you patients who have multiple appointments.
SELECT 
	patientid,
	COUNT(*)
FROM
	healthcare_appointments
GROUP BY 
	patientid
ORDER BY 
	2 DESC
LIMIT 
	10;

SELECT
	patientid,
	appointmentday,
	LAG(appointmentday) OVER(   --  Looks at the previous appointment timestamp for the same patient
		PARTITION BY patientid   -- This resets the calculation per patient.
		ORDER BY appointmentday    -- Ensures it's sorted chronologically.
	) as gap_days 
FROM 
	healthcare_appointments
WHERE 
	patientid IN (11062,19435,75545,55543)
ORDER BY 
	patientid, appointmentday


-- We just want to see the next appointment date for each patient.
SELECT
	patientid,
	COUNT(*) as total_appointments
FROM
	healthcare_appointments
GROUP BY
	patientid
ORDER BY
	total_appointments DESC
LIMIT 10;





SELECT
	patientid,
	appointmentday,
	LEAD(appointmentday) OVER(     -- Look Ahead" It's a telescope helps you peek at the next row for the same patient.
		PARTITION BY patientid
		ORDER BY appointmentday
	) as next_appointment
FROM
	healthcare_appointments
WHERE
	patientid IN (1106222,19435,75545,55543)
ORDER BY
	patientid, appointmentday















