create database post_liver_transplantation;

/* UNDERSTAND THE DATA */
describe table liver_transplant;

/* RETRIEVE THE DATA */
select * from liver_transplant;

/* checking data type*/
SELECT DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'liver_transplant' AND COLUMN_NAME = 'R_Blood_Transfusion';

/* shape of the data*/
select count(*) as numberofcolumns 
from information_schema.columns where table_name = 'liver_transplant';

select count(*) as numberofrows from liver_transplant;


/* changing the column name */
ALTER TABLE liver_transplant
CHANGE COLUMN `D_Cause of Death` `D_Cause_of_Death` text;

ALTER TABLE liver_transplant
CHANGE COLUMN `R Na` `R_Na` double;

/* HANDLE MISSING VALUES */
/*  missing values for all features */
SELECT 
    COUNT(*) AS missing_count_Column1,
    COUNT(*) AS missing_count_D_Age,
    COUNT(*) AS missing_count_D_Gender,
    COUNT(*) AS missing_count_D_BMI,
    COUNT(*) AS missing_count_D_Cause_of_Death,
    COUNT(*) AS missing_count_D_Diabetes,
    COUNT(*) AS missing_count_D_Hypertension,
    COUNT(*) AS missing_count_D_Alcohol_Abuse,
    COUNT(*) AS missing_count_D_Smoking,
    COUNT(*) AS missing_count_D_Lympochyte,
    COUNT(*) AS missing_count_D_HepatitisB,
    COUNT(*) AS missing_count_D_HepatitisC,
    COUNT(*) AS missing_count_R_Etiology,
    COUNT(*) AS missing_count_R_MELD_Score,
    COUNT(*) AS missing_count_R_Age,
    COUNT(*) AS missing_count_R_Gender,
    COUNT(*) AS missing_count_R_BMI,
    COUNT(*) AS missing_count_R_Diabetes,
    COUNT(*) AS missing_count_R_Hypertension,
    COUNT(*) AS missing_count_R_Alcohol_Abuse,
    COUNT(*) AS missing_count_R_Smoking,
    COUNT(*) AS missing_count_R_Lympochyte,
    COUNT(*) AS missing_count_R_HepatitisB,
    COUNT(*) AS missing_count_R_HepatitisC,
    COUNT(*) AS missing_count_R_Albumin_level,
    COUNT(*) AS missing_count_R_Alcoholic_cirrhosis,
    COUNT(*) AS missing_count_R_Primary_biliary_cirrhosis,
    COUNT(*) AS missing_count_R_Na,
    COUNT(*) AS missing_count_R_Mg,
    COUNT(*) AS missing_count_R_WBC,
    COUNT(*) AS missing_count_R_Platelets,
    COUNT(*) AS missing_count_R_Cold_Ischemia_Time,
    COUNT(*) AS missing_count_R_Warm_Ischemia_Time,
    COUNT(*) AS missing_count_R_Blood_Transfusion,
    COUNT(*) AS missing_count_R_Immunosuppressant_Medication,
    COUNT(*) AS missing_count_R_Rejection_Episodes,
    COUNT(*) AS missing_count_Complications
FROM liver_transplant;


/* CLEAN AND PREPROCESS THE DATA */
/* removal of duplicates */
DELETE FROM liver_transplant
WHERE Column1 IN (
    SELECT Column1
    FROM (
        SELECT Column1, D_Age, D_Gender, D_BMI, D_Cause_of_Death, D_Diabetes, D_Hypertension, D_Alcohol_Abuse, D_Smoking, D_Lympochyte, D_HepatitisB, D_HepatitisC, R_Etiology, R_MELD_Score, R_Age, R_Gender, R_BMI, R_Diabetes, R_Hypertension, R_Alcohol_Abuse, R_Smoking, R_Lympochyte, R_HepatitisB, R_HepatitisC, R_Albumin_level, R_Alcoholic_cirrhosis, R_Primary_biliary_cirrhosis, R_Na, R_Mg, R_WBC, R_Platelets, R_Cold_Ischemia_Time, R_Warm_Ischemia_Time, R_Blood_Transfusion, R_Immunosuppressant_Medication, R_Rejection_Episodes, Complications
        FROM liver_transplant
        GROUP BY Column1, D_Age, D_Gender, D_BMI, D_Cause_of_Death, D_Diabetes, D_Hypertension, D_Alcohol_Abuse, D_Smoking, D_Lympochyte, D_HepatitisB, D_HepatitisC, R_Etiology, R_MELD_Score, R_Age, R_Gender, R_BMI, R_Diabetes, R_Hypertension, R_Alcohol_Abuse, R_Smoking, R_Lympochyte, R_HepatitisB, R_HepatitisC, R_Albumin_level, R_Alcoholic_cirrhosis, R_Primary_biliary_cirrhosis, R_Na, R_Mg, R_WBC, R_Platelets, R_Cold_Ischemia_Time, R_Warm_Ischemia_Time, R_Blood_Transfusion, R_Immunosuppressant_Medication, R_Rejection_Episodes, Complications
        HAVING COUNT(*) > 1
    ) AS duplicates
);

select * from liver_transplant;

/* another method to remove duplicates*/
SELECT DISTINCT Column1 ,
D_Age,
D_Gender,
D_BMI,
D_Cause_of_Death,
D_Diabetes,
D_Hypertension,
D_Alcohol_Abuse,
D_Smoking,
D_Lympochyte,
D_HepatitisB,
D_HepatitisC,
R_Etiology,
R_MELD_Score,
R_Age,
R_Gender,
R_BMI,
R_Diabetes,
R_Hypertension,
R_Alcohol_Abuse ,
R_Smoking ,
R_Lympochyte,
R_HepatitisB,
R_HepatitisC,
R_Albumin_level,
R_Alcoholic_cirrhosis ,
R_Primary_biliary_cirrhosis,
R_Na, 
R_Mg,
R_WBC,
R_Platelets,
R_Cold_Ischemia_Time,
R_Warm_Ischemia_Time,
R_Blood_Transfusion ,
R_Immunosuppressant_Medication,
R_Rejection_Episodes,
Complications
FROM liver_transplant;


/* Handle outliers */
/* to know the lower and upper bound or threshold*/
/* for D_Age */
SELECT
  'D_Age' AS column_name,
  AVG(D_Age) - 1.5 * STDDEV(D_Age) AS lower_bound,
  AVG(D_Age) + 1.5 * STDDEV(D_Age) AS upper_bound
FROM liver_transplant;

SELECT D_Age
FROM liver_transplant
WHERE D_Age > 21.574819004513827 AND D_Age < 66.80470529745101;

/* for D_BMI */
SELECT
  'D_BMI' AS column_name,
  AVG(D_BMI) - 1.5 * STDDEV(D_BMI) AS lower_bound,
  AVG(D_BMI) + 1.5 * STDDEV(D_BMI) AS upper_bound
FROM liver_transplant;

SELECT D_BMI
FROM liver_transplant
WHERE D_BMI > 19.544422212026472 AND D_BMI< 38.58194800514002;

/* for R_MELD_Score*/
SELECT
  'R_MELD_Score' AS column_name,
  AVG(R_MELD_Score) - 1.5 * STDDEV(R_MELD_Score) AS lower_bound,
  AVG(R_MELD_Score) + 1.5 * STDDEV(R_MELD_Score) AS upper_bound
FROM liver_transplant;

SELECT R_MELD_Score
FROM liver_transplant
WHERE R_MELD_Score > 12.4783731724214 AND R_MELD_Score< 28.86909321847829;


/* R_Age */
SELECT
  'R_Age' AS column_name,
  AVG(R_Age) - 1.5 * STDDEV(R_Age) AS lower_bound,
  AVG(R_Age) + 1.5 * STDDEV(R_Age) AS upper_bound
FROM liver_transplant;

SELECT R_MELD_Score
FROM liver_transplant
WHERE D_BMI > 22.29645568737867 AND D_BMI< 67.38813583278679;

/* R_BMI */
SELECT
  'R_BMI' AS column_name,
  AVG(R_BMI) - 1.5 * STDDEV(R_BMI) AS lower_bound,
  AVG(R_BMI) + 1.5 * STDDEV(R_BMI) AS upper_bound
FROM liver_transplant;

SELECT R_BMI
FROM liver_transplant
WHERE D_BMI > 17.697406726140883 AND D_BMI< 32.105490325074925;

/* R_Albumin_level */
SELECT
  'R_Albumin_level' AS column_name,
  AVG(R_Albumin_level) - 1.5 * STDDEV(R_Albumin_level) AS lower_bound,
  AVG(R_Albumin_level) + 1.5 * STDDEV(R_Albumin_level) AS upper_bound
FROM liver_transplant;

SELECT R_Albumin_level
FROM liver_transplant
WHERE R_Albumin_level > 31.138788003947155 AND R_Albumin_level< 49.414469493467536;

/* R_Na */
SELECT
  'R_Na' AS column_name,
  AVG(R_Na) - 1.5 * STDDEV(R_Na) AS lower_bound,
  AVG(R_Na) + 1.5 * STDDEV(R_Na) AS upper_bound
FROM liver_transplant;

SELECT R_NA
FROM liver_transplant
WHERE R_NA > -4.3545757614197615 AND R_NA< 24.208143496683512;

/* R_Mg */
SELECT
  'R_Mg' AS column_name,
  AVG(R_Mg) - 1.5 * STDDEV(R_Mg) AS lower_bound,
  AVG(R_Mg) + 1.5 * STDDEV(R_Mg) AS upper_bound
FROM liver_transplant;

SELECT R_Mg
FROM liver_transplant
WHERE R_Mg > -0.3743405827051516 AND R_Mg< 2.3520034575758846;

/* R_WBC */
SELECT
  'R_WBC' AS column_name,
  AVG(R_WBC ) - 1.5 * STDDEV(R_WBC ) AS lower_bound,
  AVG(R_WBC ) + 1.5 * STDDEV(R_WBC ) AS upper_bound
FROM liver_transplant;

SELECT R_WBC
FROM liver_transplant
WHERE R_WBC > 4484.422670450713 AND R_WBC< 23607.732448473795;

/* R_Platelets */
SELECT
  'R_Platelets' AS column_name,
  AVG(R_Platelets) - 1.5 * STDDEV(R_Platelets) AS lower_bound,
  AVG(R_Platelets) + 1.5 * STDDEV(R_Platelets) AS upper_bound
FROM liver_transplant;

SELECT R_Platelets
FROM liver_transplant
WHERE R_Platelets > 172662.96956789118 AND R_Platelets< 431214.9663162867;

/* R_Cold_Ischemia_Time */
SELECT
  'R_Cold_Ischemia_Time' AS column_name,
  AVG(R_Cold_Ischemia_Time) - 1.5 * STDDEV(R_Cold_Ischemia_Time) AS lower_bound,
  AVG(R_Cold_Ischemia_Time) + 1.5 * STDDEV(R_Cold_Ischemia_Time) AS upper_bound
FROM liver_transplant;

SELECT R_Cold_Ischemia_Time
FROM liver_transplant
WHERE R_Cold_Ischemia_Time > 2.667057711834339 AND R_Cold_Ischemia_Time < 11.175444873481057;

/* R_Warm_Ischemia_Time */
SELECT
  'R_Warm_Ischemia_Time' AS column_name,
  AVG(R_Warm_Ischemia_Time) - 1.5 * STDDEV(R_Warm_Ischemia_Time) AS lower_bound,
  AVG(R_Warm_Ischemia_Time) + 1.5 * STDDEV(R_Warm_Ischemia_Time) AS upper_bound
FROM liver_transplant;

SELECT R_Warm_Ischemia_Time
FROM liver_transplant
WHERE R_Warm_Ischemia_Time > 1.2405175736452696 AND R_Cold_Ischemia_Time < 4.73197467040851;

/* Normalize or transform variables */
/* find the minimum and maximum values */
/* finding min and max for single numeric column */
SELECT MIN(D_Age) AS min_value, MAX(D_Age) AS max_value
FROM liver_transplant;

/* finding min and max for single alphabetic or text column */
SELECT MIN(D_Cause_of_Death) AS min_value, MAX(D_Cause_of_Death) AS max_value
FROM liver_transplant;

/* finding min and max values for numeric columns of all features */
SELECT
    MIN(Column1) AS Min_Column1,
    MAX(Column1) AS Max_Column1,
    MIN(D_Age) AS Min_D_Age,
    MAX(D_Age) AS Max_D_Age,
    MIN(D_BMI) AS Min_D_BMI,
    MAX(D_BMI) AS Max_D_BMI,
    MIN(D_Diabetes) AS Min_D_Diabetes,
    MAX(D_Diabetes) AS Max_D_Diabetes,
    MIN(D_Hypertension) AS Min_D_Hypertension,
    MAX(D_Hypertension) AS Max_D_Hypertension,
    MIN(D_Alcohol_Abuse) AS Min_D_Alcohol_Abuse,
    MAX(D_Alcohol_Abuse) AS Max_D_Alcohol_Abuse,
    MIN(D_Smoking) AS Min_D_Smoking,
    MAX(D_Smoking) AS Max_D_Smoking,
    MIN(D_Lympochyte) AS Min_D_Lympochyte,
    MAX(D_Lympochyte) AS Max_D_Lympochyte,
    MIN(D_HepatitisB) AS Min_D_HepatitisB,
    MAX(D_HepatitisB) AS Max_D_HepatitisB,
    MIN(D_HepatitisC) AS Min_D_HepatitisC,
    MAX(D_HepatitisC) AS Max_D_HepatitisC,
    MIN(R_MELD_Score) AS Min_R_MELD_Score,
    MAX(R_MELD_Score) AS Max_R_MELD_Score,
    MIN(R_Age) AS Min_R_Age,
    MAX(R_Age) AS Max_R_Age,
    MIN(R_BMI) AS Min_R_BMI,
    MAX(R_BMI) AS Max_R_BMI,
    MIN(R_Diabetes) AS Min_R_Diabetes,
    MAX(R_Diabetes) AS Max_R_Diabetes,
    MIN(R_Hypertension) AS Min_R_Hypertension,
    MAX(R_Hypertension) AS Max_R_Hypertension,
    MIN(R_Alcohol_Abuse) AS Min_R_Alcohol_Abuse,
    MAX(R_Alcohol_Abuse) AS Max_R_Alcohol_Abuse,
    MIN(R_Smoking) AS Min_R_Smoking,
    MAX(R_Smoking) AS Max_R_Smoking,
    MIN(R_Lympochyte) AS Min_R_Lympochyte,
    MAX(R_Lympochyte) AS Max_R_Lympochyte,
    MIN(R_HepatitisB) AS Min_R_HepatitisB,
    MAX(R_HepatitisB) AS Max_R_HepatitisB,
    MIN(R_HepatitisC) AS Min_R_HepatitisC,
    MAX(R_HepatitisC) AS Max_R_HepatitisC,
    MIN(R_Albumin_level) AS Min_R_Albumin_level,
    MAX(R_Albumin_level) AS Max_R_Albumin_level,
    MIN(R_Alcoholic_cirrhosis) AS Min_R_Alcoholic_cirrhosis,
    MAX(R_Alcoholic_cirrhosis) AS Max_R_Alcoholic_cirrhosis,
    MIN(R_Primary_biliary_cirrhosis) AS Min_R_Primary_biliary_cirrhosis,
    MAX(R_Primary_biliary_cirrhosis) AS Max_R_Primary_biliary_cirrhosis,
    MIN(R_Na) AS Min_R_Na,
    MAX(R_Na) AS Max_R_Na,
    MIN(R_Mg) AS Min_R_Mg,
    MAX(R_Mg) AS Max_R_Mg,
    MIN(R_WBC) AS Min_R_WBC,
    MAX(R_WBC) AS Max_R_WBC,
    MIN(R_Platelets) AS Min_R_Platelets,
    MAX(R_Platelets) AS Max_R_Platelets,
    MIN(R_Cold_Ischemia_Time) AS Min_R_Cold_Ischemia_Time,
    MAX(R_Cold_Ischemia_Time) AS Max_R_Cold_Ischemia_Time,
    MIN(R_Warm_Ischemia_Time) AS Min_R_Warm_Ischemia_Time,
    MAX(R_Warm_Ischemia_Time) AS Max_R_Warm_Ischemia_Time,
    MIN(R_Blood_Transfusion) AS Min_R_Blood_Transfusion,
    MAX(R_Blood_Transfusion) AS Max_R_Blood_Transfusion,
    MIN(R_Rejection_Episodes) AS Min_R_Rejection_Episodes,
    MAX(R_Rejection_Episodes) AS Max_R_Rejection_Episodes
    FROM liver_transplant;

/* finding min and max values for text columns of all features */
SELECT
    MIN(D_Gender) AS Min_D_Gender,
    MAX(D_Gender) AS Max_D_Gender,
    MIN(D_Cause_of_Death) AS Min_D_Cause_of_Death,
    MAX(D_Cause_of_Death) AS Max_D_Cause_of_Death,
    MIN(R_Etiology) AS Min_R_Etiology,
    MAX(R_Etiology) AS Max_R_Etiology,
    MIN(R_Gender) AS Min_R_Gender,
    MAX(R_Gender) AS Max_R_Gender,
    MIN(R_Immunosuppressant_Medication) AS Min_R_Immunosuppressant_Medication,
    MAX(R_Immunosuppressant_Medication) AS Max_R_Immunosuppressant_Medication,
    MIN(Complications) AS Min_Complications,
    MAX(Complications) AS Max_Complications
FROM liver_transplant;

/* add min and max values in the normalization formula(known as min-max normalization or feature scaling)
SELECT (column1 - min_value) / (max_value - min_value) AS normalized_column
FROM your_table; */
SELECT (Column1- 0) / (1937 - 0) AS normalized_column
FROM liver_transplant;

SELECT (D_Age - 18) / (70 - 18) AS normalized_column
FROM liver_transplant;

SELECT (D_BMI - 18) / (40 - 18) AS normalized_column
FROM liver_transplant;

SELECT (D_Diabetes - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (D_Hypertension - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (D_Alcohol_Abuse - 0) / (1- 0) AS normalized_column
FROM liver_transplant;

SELECT (D_Smoking - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (D_Lympochyte - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (D_HepatitisB - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (D_HepatitisC - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (R_MELD_Score - 12) / (30 - 12) AS normalized_column
FROM liver_transplant;

SELECT (R_Age - 18) / (70 - 18) AS normalized_column
FROM liver_transplant;

SELECT (R_BMI - 15) / (35- 15) AS normalized_column
FROM liver_transplant;

SELECT (R_Diabetes - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (R_Hypertension - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (R_Alcohol_Abuse - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (R_Smoking - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (R_Lympochyte - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (R_HepatitisB - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (R_HepatitisC - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (R_Albumin_level - 30) / (50 - 30) AS normalized_column
FROM liver_transplant;

SELECT (R_Alcoholic_cirrhosis - 0)/(100 - 0) AS normalized_column
FROM liver_transplant;

SELECT (R_Primary_biliary_cirrhosis - 0.1)/(25 - 0.1)AS normalized_column
FROM liver_transplant;

SELECT (R_Na - 0.1)/(50 - 0.1) AS normalized_column
FROM liver_transplant;

SELECT (R_Mg - 0) / (3.5 - 0) AS normalized_column
FROM liver_transplant;

SELECT (R_WBC - 3005) / (24983 - 3005) AS normalized_column
FROM liver_transplant;

SELECT (R_Platelets - 150189) / (449992 - 150189) AS normalized_column
FROM liver_transplant;

SELECT (R_Cold_Ischemia_Time - 2) / (12 - 2) AS normalized_column
FROM liver_transplant;

SELECT (R_Warm_Ischemia_Time - 1) / (5 - 1) AS normalized_column
FROM liver_transplant;

SELECT (R_Blood_Transfusion - 0) / (1 - 0) AS normalized_column
FROM liver_transplant;

SELECT (R_Rejection_Episodes - 0) / (5 - 0) AS normalized_column
FROM liver_transplant;

/* PERFORM DESCRIPTIVE STATISTICS */
/* using SQL aggregate functions */
/* D_Age */
SELECT COUNT(*) AS total_rows,
       SUM(D_Age) AS sum_D_Age,
       AVG(D_Age) AS average_D_Age,
       MIN(D_Age) AS minimum_D_Age,
       MAX(D_Age) AS maximum_D_Age
FROM liver_transplant;

----- OR -----

SELECT COUNT(*) AS total_rows FROM liver_transplant;
SELECT SUM(D_Age) AS total_sum FROM liver_transplant;
SELECT AVG(D_Age) AS average_value FROM liver_transplant;
SELECT MIN(D_Age) AS min_value FROM liver_transplant;
SELECT MAX(D_Age) AS max_value FROM liver_transplant;

/* finding 1st,2nd,3rd and 4th moment business decision
mean, standard deviation, skewness, kurtosis */
SELECT 'D_Age' AS column_name,
    AVG(D_Age) AS mean,
    STDDEV(D_Age) AS standard_deviation,
    (
        SUM(POWER(D_Age - (SELECT AVG(D_Age) FROM liver_transplant), 3)) / COUNT(D_Age)
    ) / POWER(STDDEV(D_Age), 3) AS skewness,
    (
        SUM(POWER(D_Age - (SELECT AVG(D_Age) FROM liver_transplant), 4)) / COUNT(D_Age)
    ) / POWER(STDDEV(D_Age), 4) - 3 AS kurtosis
FROM liver_transplant;

/* D_BMI */
SELECT COUNT(*) AS total_rows,
       SUM(D_BMI) AS sum_D_BMI,
       AVG(D_BMI) AS average_D_BMI,
       MIN(D_BMI) AS minimum_D_BMI,
       MAX(D_BMI) AS maximum_D_BMI
FROM liver_transplant;

SELECT 'D_BMI' AS column_name,
    AVG(D_BMI) AS mean,
    STDDEV(D_BMI) AS standard_deviation,
    (
        SUM(POWER(D_BMI - (SELECT AVG(D_BMI) FROM liver_transplant), 3)) / COUNT(D_BMI)
    ) / POWER(STDDEV(D_BMI), 3) AS skewness,
    (
        SUM(POWER(D_BMI - (SELECT AVG(D_BMI) FROM liver_transplant), 4)) / COUNT(D_BMI)
    ) / POWER(STDDEV(D_BMI), 4) - 3 AS kurtosis
FROM liver_transplant;

/* R_MELD_Score */
SELECT COUNT(*) AS total_rows,
       SUM(R_MELD_Score) AS sum_R_MELD_Score,
       AVG(R_MELD_Score) AS average_R_MELD_Score,
       MIN(R_MELD_Score) AS minimum_R_MELD_Score,
       MAX(R_MELD_Score) AS maximum_R_MELD_Score
FROM liver_transplant;

SELECT 'R_MELD_Score' AS column_name,
    AVG(R_MELD_Score) AS mean,
    STDDEV(R_MELD_Score) AS standard_deviation,
    (
        SUM(POWER(R_MELD_Score - (SELECT AVG(R_MELD_Score) FROM liver_transplant), 3)) / COUNT(R_MELD_Score)
    ) / POWER(STDDEV(R_MELD_Score), 3) AS skewness,
    (
        SUM(POWER(R_MELD_Score - (SELECT AVG(R_MELD_Score) FROM liver_transplant), 4)) / COUNT(R_MELD_Score)
    ) / POWER(STDDEV(R_MELD_Score), 4) - 3 AS kurtosis
FROM liver_transplant;

/* R_Age */
SELECT COUNT(*) AS total_rows,
       SUM(R_Age) AS sum_R_Age,
       AVG(R_Age) AS average_R_Age,
       MIN(R_Age) AS minimum_R_Age,
       MAX(R_Age) AS maximum_R_Age
FROM liver_transplant;

SELECT 'R_Age' AS column_name,
    AVG(R_Age) AS mean,
    STDDEV(R_Age) AS standard_deviation,
    (
        SUM(POWER(R_Age - (SELECT AVG(R_Age) FROM liver_transplant), 3)) / COUNT(R_Age)
    ) / POWER(STDDEV(R_Age), 3) AS skewness,
    (
        SUM(POWER(R_Age - (SELECT AVG(R_Age) FROM liver_transplant), 4)) / COUNT(R_Age)
    ) / POWER(STDDEV(R_Age), 4) - 3 AS kurtosis
FROM liver_transplant;

/* R_BMI */
SELECT COUNT(*) AS total_rows,
       SUM(R_BMI) AS sum_R_BMI,
       AVG(R_BMI) AS average_R_BMI,
       MIN(R_BMI) AS minimum_R_BMI,
       MAX(R_BMI) AS maximum_R_BMI
FROM liver_transplant;

SELECT 'R_BMI' AS column_name,
    AVG(R_BMI) AS mean,
    STDDEV(R_BMI) AS standard_deviation,
    (
        SUM(POWER(R_BMI - (SELECT AVG(R_BMI) FROM liver_transplant), 3)) / COUNT(R_BMI)
    ) / POWER(STDDEV(R_BMI), 3) AS skewness,
    (
        SUM(POWER(R_BMI - (SELECT AVG(R_BMI) FROM liver_transplant), 4)) / COUNT(R_BMI)
    ) / POWER(STDDEV(R_BMI), 4) - 3 AS kurtosis
FROM liver_transplant;

/* R_Rejection_Episodes */
SELECT COUNT(*) AS total_rows,
       SUM(R_Rejection_Episodes) AS sum_R_Rejection_Episodes,
       AVG(R_Rejection_Episodes) AS average_R_Rejection_Episodes,
       MIN(R_Rejection_Episodes) AS minimum_R_Rejection_Episodes,
       MAX(R_Rejection_Episodes) AS maximum_R_Rejection_Episodes
FROM liver_transplant;

SELECT 'R_Rejection_Episodes' AS column_name,
    AVG(R_Rejection_Episodes) AS mean,
    STDDEV(R_Rejection_Episodes) AS standard_deviation,
    (
        SUM(POWER(R_Rejection_Episodes - (SELECT AVG(R_Rejection_Episodes) FROM liver_transplant), 3)) / COUNT(R_Rejection_Episodes)
    ) / POWER(STDDEV(R_Rejection_Episodes), 3) AS skewness,
    (
        SUM(POWER(R_Rejection_Episodes - (SELECT AVG(R_Rejection_Episodes) FROM liver_transplant), 4)) / COUNT(R_Rejection_Episodes)
    ) / POWER(STDDEV(R_Rejection_Episodes), 4) - 3 AS kurtosis
FROM liver_transplant;






