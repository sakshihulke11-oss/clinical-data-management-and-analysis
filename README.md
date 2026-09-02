# Clinical Data Management Portfolio Project

**End-to-End Data Quality Assessment, CDISC Standards Mapping, and SQL Analysis**

## Project Overview

This portfolio demonstrates a complete clinical data management (CDM) workflow applied to synthetic clinical trial data. The project showcases competencies in data quality assessment, CDISC/SDTM standards implementation, SQL-based analysis, and Python-based data validation—core skills required for data analyst and clinical data coordinator roles in pharmaceutical and CRO environments.

**Project Scope:**
- 60 patient records across 3 clinical visits (Baseline, Week 4, Week 8)
- 18 clinical variables: demographics, vital signs (BP, heart rate), laboratory values (glucose, cholesterol), medication data, and adverse events
- Multi-stage quality assessment pipeline with automated issue flagging

---

## Repository Structure

```
├── Synthetic_Clinical_Data.csv          # Source clinical dataset (60 rows × 18 columns)
├── pyton_file.ipynb                     # Python data quality validation pipeline
├── CDM.sql                         # SQL analysis queries (19 queries)
├── CDISC_Mapping_CDASH_SDTM.txt        # CDISC standards documentation
├── CDM_Data_Quality_Report.txt          # Data quality assessment output
└── README.md                            # This file
```

---

## Key Deliverables

### 1. **Data Quality Assessment Pipeline** (Python)
**File:** `pyton_file.ipynb`

**Automated validation checks:**
- Missing value detection and completeness quantification (91.02% overall)
- Age range validation (18–100 years)
- Systolic BP range check (90–220 mmHg)
- Diastolic BP range check (60–120 mmHg)
- Logical BP consistency: Systolic > Diastolic validation
- Missing required fields flagged as high-severity issues

**Key Finding:** Identified 2 critical issues (missing Systolic BP values for PT002 Week 4, PT002 Week 4 lab results). Correctly classified missing Adverse Event/AE_Severity as non-issues (legitimate absence of events in 78.33% of records).

**Output:** Edit Clarification Log (CSV) for data review and correction workflow

---

### 2. **CDISC Standards Mapping** (Documentation)
**File:** `CDISC_Mapping_CDASH_SDTM.txt`

Comprehensive six-section mapping aligning raw CDASH (Case Report Form) variables to standardized SDTM (Study Data Tabulation Model) domains:

| CDASH Source | SDTM Domain | Mapping Notes |
|---|---|---|
| Patient_ID → DM.USUBJID | Demographics | Unique subject identifier |
| Systolic_BP/Diastolic_BP → VS.VSORRES | Vital Signs | Parameterized by VSCODE (SYSBP/DIABP) |
| Fasting_Glucose / Cholesterol → LB.LBORRES | Laboratory | Includes reference range thresholds |
| Medication_Name / Dose → EC.ECNAME / EC.ECDOSE | Drug Exposure | Includes compliance-derived flags |
| Adverse_Event / Severity → AE.AETERM / AE.AESEV | Adverse Events | MedDRA coding framework ready |
| Visit_Type + Visit_Date → VISIT + VISITDY | Timing | Imputed study day calculations |

**Regulatory-ready format:** Follows CDISC v1.7 and ICH-GCP guidelines for regulatory submissions.

---

### 3. **SQL Analysis Pipeline** (19 Queries)
**File:** `SQl_file.sql`

**Complexity Progression:**

| Query # | Type | Business Use |
|---|---|---|
| 1–7 | Basic SELECT, GROUP BY, aggregation | Patient counts, visit breakdown, medication usage |
| 8–12 | Filtering, CASE logic, ordering | Adverse event severity, BP categories, dose ranges |
| 13–16 | Window functions (RANK, ROW_NUMBER) | Ranked BP analysis, per-patient visit tracking |
| 17–19 | CTE (Common Table Expressions) | Complex patient-level summaries |

**Example Insights Generated:**
- Average systolic BP by visit type: Baseline 153.5 → Week 4 147.2 → Week 8 141.3 mmHg (treatment efficacy signal)
- High BP visits per patient (Systolic ≥140): distribution analysis
- Medication dose by agent with min/max/avg statistics
- Multi-visit patient tracking for longitudinal analysis

---

## Clinical & Technical Specifications

### Dataset Characteristics
- **20 unique patients** (PT001–PT020), age 48–71, mixed gender
- **4 antihypertensive medications:** Lisinopril, Enalapril, Ramipril, Amlodipine
- **Clinical endpoints:** Systolic/Diastolic BP, Heart Rate, Weight, Fasting Glucose, Total Cholesterol
- **Compliance tracking:** 80–100% patient adherence
- **Missing data pattern:** Realistic (1 BP missing, 47 adverse events not reported = no events)

### Quality Metrics
- **Data Completeness:** 91.02% (across all fields)
- **Completeness by Visit:** Baseline 88.89%, Week 4 93.61%, Week 8 90.56%
- **High-Severity Issues:** 2 identified and logged

---

## Skills & Standards Demonstrated

### Core Competencies
- ✅ **Clinical Data Management (CDM):** Multi-domain dataset assembly, edit checks, issue tracking
- ✅ **CDISC Standards:** CDASH→SDTM transformation, domain mapping, regulatory compliance
- ✅ **Python Data Validation:** Pandas, automated quality checks, issue logging
- ✅ **SQL Analytics:** Basic to intermediate (aggregation, window functions, CTEs)
- ✅ **Data Quality:** Logical consistency checks, range validation, missing value assessment

### Regulatory & Compliance
- ICH-GCP-aligned data governance framework
- 21 CFR Part 11-ready audit trail (Edit Clarification Log)
- Controlled Terminology ready (CDISC CT codes documented)
- Study safety tracking (SAE flags in AE domain mapping)


---

##  Points

1. **Data Quality Challenge Solved:**  
   "Identified and logged 2 critical Systolic BP missing values while correctly distinguishing them from legitimate missing Adverse Event data (78% of patients had no events). Demonstrated understanding of clinical context in data quality rules."

2. **CDISC Proficiency:**  
   "Mapped raw clinical data (CDASH) to standardized SDTM domains with regulatory precision. Implemented domain-specific logic: parameterized vital signs (separate rows per parameter), compliance-derived flags in drug exposure, and MedDRA-ready adverse event coding."

3. **End-to-End Workflow:**  
   "Built a complete CDM pipeline: raw data → validation → issue logging → SDTM transformation → SQL analytics. This mirrors real trial workflows at IQVIA, Fortrea, and ICON."

4. **SQL to Python Proficiency:**  
   "Demonstrated progression from basic aggregations to window functions to CTEs in SQL. Paired with Python automation for repeatable quality checks—showing ability to choose the right tool for the problem."

---

## Technology Stack

| Tool | Purpose | Skill Level |
|---|---|---|
| Python 3 (Pandas, NumPy) | Data quality validation, issue logging | Intermediate |
| SQL (DDL, DML, window functions, CTEs) | Clinical data analysis, reporting | Intermediate |
| Jupyter Notebook | Interactive data exploration & documentation | Intermediate |
| CDISC Standards (v1.7) | Regulatory-compliant data standards | Proficient |

---

## Regulatory & Compliance Notes

This project demonstrates understanding of:
- **ICH-GCP Guidelines:** Good Clinical Practice standards for data integrity
- **21 CFR Part 11:** Audit trails and data governance (simulated via Edit Clarification Log)
- **CDISC Standards:** Industry-standard data structures for regulatory submissions

---

## Author

**Sakshi** | Clinical Data Management & Analytics Portfolio  
B.Pharm (SGBAU, 2026) | 

**Contact & Links:**
- GitHub: [sakshihulke11-oss](https://github.com/sakshihulke11-oss)


This project is provided for portfolio and educational purposes. Synthetic data is not real patient information.

---

**Last Updated: August 12, 2026
