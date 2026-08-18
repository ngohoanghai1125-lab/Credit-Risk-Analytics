--Checking for rows containing the text "NA" that are being misinterpreted as actual values.
select "MonthlyIncome", count(*) as total_customers 
from cs_training
group by "MonthlyIncome"
order by total_customers desc 
limit 10;

--Checking column name and data type
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'cs_training'
AND column_name = 'MonthlyIncome';

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'cs_training'
ORDER BY ordinal_position;


--Create a cleaned view 
CREATE OR REPLACE VIEW vw_credit_risk_clean AS 
SELECT 
    "Column1" AS customer_id,
    "SeriousDlqin2yrs",
    "RevolvingUtilizationOfUnsecuredLines",
    "age",
    case when "NumberOfTime30-59DaysPastDueNotWorse" in (96,98)
    then null
    else "NumberOfTime30-59DaysPastDueNotWorse"
    end as "NumberOfTime30-59DaysPastDueNotWorse",
    "DebtRatio",
    CASE WHEN "MonthlyIncome" = 'NA' THEN NULL
         ELSE CAST("MonthlyIncome" AS NUMERIC)
    END AS monthly_income,
    "NumberOfOpenCreditLinesAndLoans",
    case when "NumberOfTimes90DaysLate" in (96,98)
    then null
    else "NumberOfTimes90DaysLate"
    end as "NumberOfTimes90DaysLate",
    "NumberRealEstateLoansOrLines",
    case when "NumberOfTime60-89DaysPastDueNotWorse" in (96,98)
    then null 
    else "NumberOfTime60-89DaysPastDueNotWorse"
    end as "NumberOfTime60-89DaysPastDueNotWorse",
    CASE WHEN "NumberOfDependents" = 'NA' THEN NULL
         ELSE CAST("NumberOfDependents" AS NUMERIC)
    END AS number_of_dependents
FROM public.cs_training;

select * from vw_credit_risk_clean
limit 10;

SELECT
    COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE monthly_income IS NULL) AS monthly_income_missing,
COUNT(*) FILTER (WHERE number_of_dependents IS NULL) AS dependents_missing
FROM vw_credit_risk_clean;

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'vw_credit_risk_clean'
ORDER BY ordinal_position;

SELECT
    '30-59' AS delinquency_type, COUNT(*) FILTER (WHERE "NumberOfTime30-59DaysPastDueNotWorse" IN (96, 98)) AS invalid_values
FROM cs_training
union all 
select '60-89' AS delinquency_type, COUNT(*) FILTER (WHERE "NumberOfTime60-89DaysPastDueNotWorse" IN (96, 98)) AS invalid_values
FROM cs_training
union all 
select '90+' AS delinquency_type, COUNT(*) FILTER (WHERE "NumberOfTimes90DaysLate" IN (96, 98)) AS invalid_values
FROM cs_training;

--Audit Utilization
SELECT
    count(*) AS total_customers,
    count(*) FILTER (WHERE CAST("RevolvingUtilizationOfUnsecuredLines" as numeric) > 1) AS util_over_1,
    count(*) FILTER (WHERE CAST("RevolvingUtilizationOfUnsecuredLines" as numeric) > 10) AS util_over_10,
    MAX(CAST("RevolvingUtilizationOfUnsecuredLines" as numeric)) AS max_utilization
FROM vw_credit_risk_clean;

--Audit DebtRatio 
SELECT
    count(*) AS total_customers,
    count(*) FILTER (WHERE "DebtRatio" > 1) AS debt_ratio_over_1,
    count(*) FILTER (WHERE "DebtRatio" > 2) AS debt_ratio_over_2,
    count(*) FILTER (WHERE "DebtRatio" > 5) AS debt_ratio_over_5,
    count(*) FILTER (WHERE "DebtRatio" > 10) AS debt_ratio_over_10,
    MAX("DebtRatio") AS max_debt_ratio
FROM vw_credit_risk_clean;
