# Financial Performance Analysis — Capstone Project

End-to-end financial analytics project analyzing 10,400 transactions (Jan 2022 – Dec 2023) across 3 business units and 4 regions, using **Python, SQL, Power BI, and statistical hypothesis testing** to transform raw financial data into actionable business insights.

## Business Problem

Organizations generate thousands of financial transactions monthly, making it difficult to manually monitor revenue, expenses, profitability, budget utilization, and customer/vendor concentration. This project analyzes financial transaction data to compare actual vs. budgeted performance, identify high-value customers and vendors, evaluate performance across business units and regions, and validate findings statistically — consolidated into an interactive Power BI dashboard.

## Business Objectives

- Analyze revenue, expenses, and profitability
- Compare actual performance against budgeted values
- Evaluate business-unit and regional performance
- Identify high-value customers and vendors
- Analyze revenue trends over time
- Validate key findings using statistical hypothesis testing
- Build an interactive Power BI dashboard for decision-making
- Generate actionable business recommendations

## Dataset

| Table | Records | Description |
|---|---|---|
| `Financial_Transactions` | 10,400 | Core transaction table (5,514 revenue / 4,125 expense) |
| `Budget` | 72 | Planned revenue/expense by year, month, business unit |
| `Customers` | 400 | Customer master data |
| `Vendors` | 120 | Vendor master data |
| `Headcount` | 200 | Employee master data |

**Business Units:** Online, Retail, Enterprise | **Regions:** East, West, North, South
**Categories:** Product, Service, Subscription (revenue) · Payroll, Marketing, Utilities, Rent, Supplies, Other (expense)

## Pipeline

```
Raw Financial Data
        ↓
Python / Pandas — Data Cleaning & Validation, Feature Engineering
        ↓
                Clean Dataset
        ↓                ↓                    ↓
   SQL Analysis     Power BI Dashboard    Statistical Analysis
  (MySQL)                                (SciPy — Hypothesis Testing)
        ↓                ↓                    ↓
        └────────────────┴────────────────────┘
                         ↓
                Business Insights
                         ↓
                 Recommendations
```

## Key Findings

- **Revenue ₹864.61M | Expense ₹167.74M | Net Profit ₹696.87M | Profit Margin 80.6%**
- Revenue grew steadily through 2023; Retail was the highest revenue-generating business unit
- **Kruskal-Wallis test**: business unit has a statistically significant effect on revenue (p < 0.001); region does not (p = 0.985) — revenue is genuinely balanced across regions, not just visually similar
- **Pareto analysis**: ~72% of customers generate 80% of revenue — lower customer concentration risk than the classical 80/20 rule
- **Vendor analysis**: vendors carrying large Supplies/Utilities/Rent contracts drive disproportionately higher cost than smaller Marketing/Payroll-only vendors — a clear target for procurement negotiation
- Actual revenue exceeded budget across most periods; a small number of business-unit/month combinations showed budget overruns worth investigating

## Data Cleaning & Preparation

Python and Pandas were used to inspect dataset structure and data types, check missing values and duplicate records, validate `transaction_id` as primary key, create derived date features (Year, Month-Year), and export the cleaned dataset for SQL and Power BI.

**Results:** 10,400 records · 0 duplicate records · 0 duplicate transaction IDs. Missing `customer_id`/`vendor_id` values are structurally expected — not treated as data errors — since a transaction links to either a customer *or* a vendor, never both (revenue comes from customers, expenses go to vendors).

## SQL Analysis

MySQL was used to answer key business questions through aggregations, conditional logic, joins, CTEs, subqueries, and window functions.

**Analyses performed:**
1. Total Revenue, Total Expense & Net Profit
2. Revenue & Expense by Category
3. Region-wise Financial Performance
4. Business Unit Performance
5. Monthly Revenue & Expense Trends
6. Budget vs Actual Revenue (with Variance %)
7. Budget vs Actual Expense (with Variance %)
8. Customer Revenue Analysis
9. Customer Contribution Analysis
10. Pareto (80/20) Customer Analysis — using window functions for running/cumulative revenue
11. Top Vendor Payment Analysis

**Techniques used:** `SUM()`, `CASE WHEN`, `GROUP BY`, `ORDER BY`, `LIMIT`, `INNER JOIN`, CTEs, subqueries, window functions (`OVER()`), date functions, `ABS()` for expense sign conversion.

## Power BI Dashboard

A 4-page interactive dashboard: **Executive Overview**, **Budget vs Actual**, **Customer Analysis**, **Vendor Analysis** — connected through slicers for Date, Business Unit, and Region.

| KPI | Value |
|---|---|
| Total Revenue | ₹864.61M |
| Total Expense | ₹167.74M |
| Net Profit | ₹696.87M |
| Profit Margin | 80.60% |

## Statistical Analysis & Hypothesis Testing

| Test | Objective | Result | Conclusion |
|---|---|---|---|
| Shapiro-Wilk | Check if Revenue & Expense are normally distributed | p < 0.05 | Not normal → non-parametric tests used |
| Kruskal-Wallis (Business Unit) | Compare revenue across Online/Retail/Enterprise | p < 0.001 | Statistically significant difference |
| Kruskal-Wallis (Region) | Compare revenue across East/West/North/South | p ≈ 0.985 | No significant difference — revenue is genuinely balanced |

**Methodology note:** Shapiro-Wilk showed revenue and expense are not normally distributed, so non-parametric Kruskal-Wallis tests were used in place of ANOVA. Budget variance is calculated as Actual − Budget (standard finance convention) — positive revenue variance is favorable, positive expense variance is unfavorable.

## Key Business Insights

- **Revenue Performance** — steady upward trend through the analysis period
- **Budget Performance** — actual revenue exceeded planned budget
- **Business Unit Performance** — revenue differs significantly across units (statistically confirmed); Retail leads
- **Customer Analysis** — a relatively small group of high-value customers contributes a major share of revenue
- **Vendor Analysis** — spending is concentrated among vendors carrying large operational contracts, highlighting procurement/cost optimization opportunities
- **Regional Performance** — revenue is relatively consistent across regions, with no statistically significant difference

## Recommendations

**Revenue Growth** — Increase investment in high-performing business units; expand successful revenue-generating strategies.

**Customer Strategy** — Strengthen relationships with high-value customers; introduce retention and loyalty initiatives given revenue concentration.

**Cost Optimization** — Review high-value vendor expenditures; negotiate contracts with major operational vendors.

**Budget Management** — Monitor Actual vs. Budget performance monthly; investigate significant variances promptly.

**Data-Driven Decision Making** — Use the Power BI dashboard for continuous KPI monitoring; refresh underlying data regularly.

## Repository Structure

```
├── data/cleaned/          Cleaned CSV datasets (post-validation)
├── sql/                   Full MySQL analysis script (capstone_analysis.sql)
├── notebooks/             Python data validation & statistical analysis (HTML exports)
├── dashboard/             Power BI dashboard page screenshots
├── docs/                  SQL query documentation (queries + business interpretation)
└── presentation/          Final capstone presentation (PPTX)
```

## Tools & Technologies

Excel · Python (Pandas, NumPy, SciPy) · MySQL · Microsoft Power BI (DAX) · Jupyter Notebook · Statistics (Shapiro-Wilk, Kruskal-Wallis)

## Conclusion

This project demonstrates an end-to-end data analytics workflow: **Clean → Analyze → Visualize → Validate → Recommend.** Python cleaned and validated the data, SQL performed the business analysis, Power BI communicated the insights interactively, and statistical hypothesis testing validated the key findings — producing a data-driven view of financial performance that supports decisions around revenue growth, budgeting, customer management, vendor spending, and resource allocation.

## Author

**Aditya Dasarwar** — Data Analyst | Python | SQL | Power BI | Excel | Statistics

[GitHub](https://github.com/adidasarwar95) · [LinkedIn](https://www.linkedin.com/in/aditya-dasarwar-2a74113bb/)
