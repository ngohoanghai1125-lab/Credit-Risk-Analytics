--DASHBOARD 
drop view if exists vw_credit_risk_dashboard;

create or replace view vw_credit_risk_dashboard as 
select customer_id, "SeriousDlqin2yrs", age,
    monthly_income,
    "DebtRatio",
    "RevolvingUtilizationOfUnsecuredLines",
    "NumberOfTime30-59DaysPastDueNotWorse",
    "NumberOfTime60-89DaysPastDueNotWorse",
    "NumberOfTimes90DaysLate",
    "NumberOfOpenCreditLinesAndLoans",
    "NumberRealEstateLoansOrLines",
    number_of_dependents,
    high_90dpd,
    high_utiliztion,
    high_debt_ratio,
    risk_factor_count,
    risk_combination,
case when "NumberOfTimes90DaysLate" is null then 'Missing' 
when "NumberOfTimes90DaysLate" = 0 then '0'
when "NumberOfTimes90DaysLate" = 1 then '1'
else '2+'
end as late_90_band, 
case when "RevolvingUtilizationOfUnsecuredLines" = 0 then '0'
when "RevolvingUtilizationOfUnsecuredLines" <= 0.3 then '0-30%'
when "RevolvingUtilizationOfUnsecuredLines" <= 0.7 then '30-70%'
when "RevolvingUtilizationOfUnsecuredLines" <= 1 then '70-100%'
when "RevolvingUtilizationOfUnsecuredLines" <=2 then '100-200%'
else '200%+'
end as utilization_band,
case when "DebtRatio" <= 0.3 then '0-30%'
when "DebtRatio" <= 0.5 then '30-50%'
when "DebtRatio" <= 1 then '50-100%'
else '>100%'
end as debt_ratio_band,
case when monthly_income is null then 'missing'
else 'income_available'
end as income_status, 
case when CAST("RevolvingUtilizationOfUnsecuredLines" AS NUMERIC) > 10 then 1 
else 0 
end as extreme_utilization_flag
FROM vw_credit_risk_features;

select count(*) from vw_credit_risk_dashboard;
select * from vw_credit_risk_dashboard
limit 10;