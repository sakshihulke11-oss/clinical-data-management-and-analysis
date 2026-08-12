
DROP TABLE IF EXISTS clinical_data;

CREATE TABLE clinical_data (

    patient_id VARCHAR(20),

    enrollment_date VARCHAR(20),

    visit_type VARCHAR(50),

    visit_date VARCHAR(20),

    age INT,

    gender VARCHAR(10),

    systolic_bp NUMERIC,

    diastolic_bp NUMERIC,

    heart_rate NUMERIC,

    weight_kg NUMERIC,

    medication_name VARCHAR(100),

    dose_mg NUMERIC,

    compliance_percent NUMERIC,

    fasting_glucose_mg_dl NUMERIC,

    total_cholesterol_mg_dl NUMERIC,

    adverse_event VARCHAR(100),

    ae_severity VARCHAR(50),

    notes TEXT
);

 1. VIEW CLINICAL DATA

SELECT *
FROM clinical_data;


 2. TOTAL NUMBER OF RECORDS

SELECT COUNT(*) AS total_records
FROM clinical_data;


 3. TOTAL UNIQUE PATIENTS

SELECT COUNT(DISTINCT patient_id) AS total_patients
FROM clinical_data;


4. PATIENT COUNT BY GENDER

SELECT
    gender,
    COUNT(DISTINCT patient_id) AS total_patients
FROM clinical_data
GROUP BY gender
ORDER BY total_patients DESC;


 5. RECORDS BY VISIT TYPE

SELECT
    visit_type,
    COUNT(*) AS total_records
FROM clinical_data
GROUP BY visit_type
ORDER BY total_records DESC;


 6. MEDICATION USAGE SUMMARY

SELECT
    medication_name,
    COUNT(*) AS total_records
FROM clinical_data
GROUP BY medication_name
ORDER BY total_records DESC;


 7. AVERAGE CLINICAL VALUES

SELECT
    ROUND(AVG(age), 2) AS average_age,
    ROUND(AVG(systolic_bp), 2) AS average_systolic_bp,
    ROUND(AVG(diastolic_bp), 2) AS average_diastolic_bp,
    ROUND(AVG(heart_rate), 2) AS average_heart_rate
FROM clinical_data;


8. ADVERSE EVENT SUMMARY

SELECT
    adverse_event,
    COUNT(*) AS total_events
FROM clinical_data
WHERE adverse_event IS NOT NULL
  AND adverse_event <> 'None'
GROUP BY adverse_event
ORDER BY total_events DESC;

 9. AVERAGE BP BY VISIT TYPE

SELECT
    visit_type,
    ROUND(AVG(systolic_bp), 2) AS average_systolic_bp,
    ROUND(AVG(diastolic_bp), 2) AS average_diastolic_bp
FROM clinical_data
GROUP BY visit_type
ORDER BY visit_type;

 10. MEDICATION DOSE SUMMARY

SELECT
    medication_name,
    ROUND(AVG(dose_mg), 2) AS average_dose,
    MIN(dose_mg) AS minimum_dose,
    MAX(dose_mg) AS maximum_dose
FROM clinical_data
GROUP BY medication_name
ORDER BY average_dose DESC;

 11. PATIENTS WITH MULTIPLE VISITS

SELECT
    patient_id,
    COUNT(*) AS total_visits
FROM clinical_data
GROUP BY patient_id
HAVING COUNT(*) > 1
ORDER BY total_visits DESC;

 12. ADVERSE EVENTS BY SEVERITY

SELECT
    ae_severity,
    COUNT(*) AS total_events
FROM clinical_data
WHERE adverse_event IS NOT NULL
  AND adverse_event <> 'None'
GROUP BY ae_severity
ORDER BY total_events DESC;


 13. PATIENT LEVEL CLINICAL SUMMARY

SELECT
    patient_id,
    COUNT(*) AS total_visits,
    ROUND(AVG(systolic_bp), 2) AS average_systolic_bp,
    MAX(systolic_bp) AS highest_systolic_bp,
    MIN(systolic_bp) AS lowest_systolic_bp
FROM clinical_data
GROUP BY patient_id
ORDER BY highest_systolic_bp DESC;


 14. BLOOD PRESSURE CATEGORY USING CASE

SELECT
    patient_id,
    visit_type,
    systolic_bp,
    diastolic_bp,

    CASE
        WHEN systolic_bp >= 140
          OR diastolic_bp >= 90
        THEN 'High'

        WHEN systolic_bp >= 130
          OR diastolic_bp >= 80
        THEN 'Elevated'

        ELSE 'Normal'
    END AS bp_category

FROM clinical_data;


 15. PATIENTS WITH ABOVE AVERAGE SYSTOLIC BP
 

SELECT
    patient_id,
    ROUND(AVG(systolic_bp), 2) AS average_systolic_bp
FROM clinical_data
GROUP BY patient_id
HAVING AVG(systolic_bp) > (
    SELECT AVG(systolic_bp)
    FROM clinical_data
)
ORDER BY average_systolic_bp DESC;


 16. COUNT HIGH BP VISITS FOR EACH PATIENT

SELECT
    patient_id,

    COUNT(*) AS total_visits,

    COUNT(
        CASE
            WHEN systolic_bp >= 140
            THEN 1
        END
    ) AS high_bp_visits

FROM clinical_data
GROUP BY patient_id
ORDER BY high_bp_visits DESC;


 17. RANK PATIENT RECORDS BY SYSTOLIC BP

SELECT
    patient_id,
    visit_type,
    systolic_bp,

    RANK() OVER (
        ORDER BY systolic_bp DESC
    ) AS bp_rank

FROM clinical_data;


 18. NUMBER VISITS FOR EACH PATIENT

SELECT
    patient_id,
    visit_type,
    visit_date,

    ROW_NUMBER() OVER (
        PARTITION BY patient_id
        ORDER BY visit_date
    ) AS visit_number

FROM clinical_data;


 19. SIMPLE CTE FOR PATIENT SUMMARY

WITH patient_summary AS (

    SELECT
        patient_id,
        COUNT(*) AS total_visits,
        ROUND(AVG(systolic_bp), 2) AS average_systolic_bp,
        MAX(systolic_bp) AS highest_systolic_bp

    FROM clinical_data

    GROUP BY patient_id
)

SELECT *
FROM patient_summary
ORDER BY highest_systolic_bp DESC;




