# Credit Risk Analytics — Give Me Some Credit

## Project Overview

This project analyzes **150,000 consumer credit records** to identify customer segments associated with future serious delinquency.

The project combines **Python** for data quality, EDA, and statistical testing; **PostgreSQL** for data cleaning, risk feature engineering, and analytical views; and **Power BI** for interactive portfolio risk monitoring.

## Key Findings

* Customers with **2+ prior 90-day delinquencies** had a **55.20%** observed default rate, or **8.26×** the portfolio baseline.
* Customers in the **100–200% credit utilization** segment had a **40.10%** default rate, approximately **6.00×** baseline risk.
* Within the normal debt-ratio range, the **50–100% DebtRatio** segment had a **9.83%** default rate.
* Customers showing **all three adverse signals** represented only **1.29%** of the portfolio, yet had a **52.95%** default rate, **7.92×** baseline risk, and contributed **10.20%** of observed defaults.
* Statistical testing showed significant associations between the key risk segments and future serious delinquency, with Cramér's V of **0.346** for prior 90+ DPD, **0.300** for utilization, and **0.319** for combined risk signals.

## Tools

**Python • PostgreSQL • SQL • Power BI • pandas • NumPy • SciPy**

## Dashboard Pages

1. **Portfolio Overview**
2. **Delinquency Risk**
3. **Credit Utilization & Debt Burden**
4. **Combined Risk Analysis**

## Statistical Methods

* Chi-square test of independence
* Cramér's V
* Risk ratio
* Population share
* Default share



