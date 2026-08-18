--Create an analytical view 
create or replace view vw_credit_risk_features as 
with risk_signals AS(
select *, 
case when "NumberOfTimes90DaysLate" > 0 then 1 else 0 end as high_90dpd,
case when "RevolvingUtilizationOfUnsecuredLines">0.7 then 1 else 0 end as high_utiliztion,
case when "DebtRatio" >0.5 then 1 else 0 end as high_debt_ratio
from vw_credit_risk_clean)
select *, 
high_90dpd+high_utiliztion+high_debt_ratio AS risk_factor_count, 
case when high_90dpd = 1 and high_utiliztion = 1 and high_debt_ratio = 1 then 'All 3 signals' 
when high_90dpd = 1 and high_utiliztion = 1 then '90DPD + High Utilization' 
when high_90dpd = 1 and high_debt_ratio = 1 then '90DPD + High DebtRatio'
when high_utiliztion = 1 and high_debt_ratio = 1 then 'High Utilization + High DebtRatio' 
when high_90dpd = 1  then '90DPD only' 
when high_utiliztion = 1 then 'High Utilization only' 
when high_debt_ratio = 1 then 'High DebtRatio only' 
else 'No signals' 
end as risk_combination
from risk_signals


select risk_factor_count, 
count(*) as customers 
from vw_credit_risk_features
GROUP BY risk_factor_count
ORDER BY risk_factor_count;

select risk_combination, 
COUNT(*) as total_customers 
from vw_credit_risk_features
group by risk_combination
order by total_customers;

SELECT
    high_90dpd,
    high_utiliztion,
    high_debt_ratio,
    COUNT(*) AS customers
FROM vw_credit_risk_features
GROUP BY
    high_90dpd,
    high_utiliztion,
    high_debt_ratio
ORDER BY
    high_90dpd DESC,
    high_utiliztion DESC,
    high_debt_ratio DESC;

SELECT
    COUNT(*) AS customers,
    COUNT(*) FILTER (WHERE high_90dpd = 1) AS has_90dpd,
    COUNT(*) FILTER (WHERE high_debt_ratio = 1) AS has_high_debt_ratio,
    COUNT(*) FILTER (
        WHERE high_90dpd = 1
        AND high_debt_ratio = 1
    ) AS has_both
FROM vw_credit_risk_features
WHERE CAST("RevolvingUtilizationOfUnsecuredLines" AS NUMERIC) > 10;

SELECT
    COUNT(*) FILTER (WHERE high_90dpd = 1) AS sql_90dpd,
    COUNT(*) FILTER (WHERE high_utiliztion = 1) AS sql_high_utilization,
    COUNT(*) FILTER (WHERE high_debt_ratio = 1) AS sql_high_debt_ratio
FROM vw_credit_risk_features;

SELECT
    COUNT(*) FILTER (WHERE "NumberOfTimes90DaysLate" IN (96, 98)) AS invalid_90dpd
FROM vw_credit_risk_clean;


select risk_combination, count(*) as total_customers, SUM("SeriousDlqin2yrs") as defaults,
ROUND(100.0*AVG("SeriousDlqin2yrs"),2) as default_rate, 
round(100.0*COUNT(*)/SUM(COUNT(*)) OVER(),2) as population_share, 
round(100.0*SUM("SeriousDlqin2yrs")/SUM(SUM("SeriousDlqin2yrs")) OVER(),2) as default_share, 
ROUND(AVG("SeriousDlqin2yrs")/AVG(AVG("SeriousDlqin2yrs")) over(),2) as risk_ratio
FROM vw_credit_risk_features
GROUP BY risk_combination
ORDER BY default_rate DESC;


WITH risk_summary AS (
    SELECT
        risk_combination,
        COUNT(*) AS customers,
        SUM("SeriousDlqin2yrs") AS defaults,
        AVG("SeriousDlqin2yrs") AS default_rate
    FROM vw_credit_risk_features
    GROUP BY risk_combination
)
SELECT
    risk_combination,
    customers,
    defaults,
    ROUND(100 * default_rate,2) AS default_rate,
    ROUND(100.0 * customers / SUM(customers) OVER (),2) AS population_share,
    ROUND(100.0 * defaults / SUM(defaults) OVER (),2) AS default_share,
    ROUND(default_rate/ (SUM(defaults) OVER () / SUM(customers) OVER ()),2) AS risk_ratio
FROM risk_summary
ORDER BY default_rate DESC;
