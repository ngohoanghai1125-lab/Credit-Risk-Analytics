# Credit Risk Analytics

## Project Overview

This project analyzes **150,000 consumer credit records** to identify customer segments associated with future serious delinquency.

The project combines **Python** for data quality, exploratory data analysis, and statistical testing; **PostgreSQL** for data cleaning, risk feature engineering, and analytical views; and **Power BI** for interactive portfolio risk monitoring.

## Project Workflow

**Python → PostgreSQL → Power BI**

* **Python:** Data quality checks, EDA, feature analysis, and statistical testing
* **PostgreSQL:** Data cleaning, risk signal engineering, analytical views, and aggregation
* **Power BI:** Interactive dashboard for portfolio-level risk monitoring

## Key Findings

* Customers with **2+ prior 90-day delinquencies** had a **55.20% observed default rate**, or **8.26× the portfolio baseline**.
* Customers in the **100–200% credit utilization** segment had a **40.10% default rate**, approximately **6.00× baseline risk**.
* Within the normal debt-ratio range, the **50–100% DebtRatio** segment had a **9.83% default rate**.
* Customers showing **all three risk signals** represented only **1.29% of the portfolio**, yet had a **52.95% default rate**, **7.92× baseline risk**, and contributed **10.20% of observed defaults**.
* Statistical testing showed significant associations between the key risk segments and future serious delinquency, with **Cramer's V of 0.346** for prior 90+ DPD, **0.300** for credit utilization, and **0.319** for combined risk signals.

## Tools

**Python • PostgreSQL • SQL • Power BI • pandas • NumPy • SciPy**

## Dashboard Pages

### 1. Portfolio Overview

* Overall portfolio size and default performance
* Risk combination comparison
* Interactive utilization and 90+ DPD filters

### 2. Delinquency Risk

* Default rate by previous 90+ DPD history
* Default share and population share
* Risk ratio analysis

### 3. Credit Utilization & Debt Burden

* Default rate by credit utilization
* Default rate by DebtRatio
* DebtRatio > 1 analysis by income availability

### 4. Combined Risk Analysis

* Risk combination analysis
* Risk factor count
* Default rate and default share across combined risk signals

## Analytical Metrics

* **Default rate**
* **Risk ratio**
* **Population share**
* **Default share**

## Statistical Methods

* Chi-square test of independence
* Cramer's V

## Business Recommendations

Based on the observed risk patterns in the portfolio, the following actions could support credit risk monitoring and early-warning processes:

### 1. Prioritize Customers with Repeated Delinquency History

Customers with **2+ prior 90-day delinquencies** showed a **55.20% observed default rate** and **8.26× the portfolio baseline**. These customers should receive enhanced monitoring and early-warning treatment.

### 2. Flag Customers with High Credit Utilization

The **100–200% utilization** segment showed a **40.10% observed default rate** and approximately **6.00× baseline risk**. High-utilization customers could be prioritized for exposure review and targeted risk interventions.

### 3. Use Combined Risk Signals for Risk-Based Prioritization

Customers exhibiting **all three risk signals** represented only **1.29% of the portfolio** but accounted for **10.20% of observed defaults**. Combining multiple signals can help risk teams focus resources on a relatively small group of high-risk customers.

### 4. Investigate Customers with High DebtRatio and Available Income Information

Among customers with **DebtRatio > 1**, those with reported income had a **10.13% observed default rate**, compared with **5.58%** among customers with missing income. Income availability may therefore provide additional context when assessing high-debt customers.




