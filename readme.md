# 🧠 SQL Data Warehouse Analytics Project 

This project is an extension of my [SQL Data Warehouse Project](https://github.com/meshivamk/SQL_DataWarehouse), which built the foundational Medallion architecture (Bronze → Silver → Gold).
, this project leverages the **Gold Layer views** created in the Medallion architecture (Bronze → Silver → Gold).  
The goal is to perform **advanced analytical exploration** on business-ready data to generate actionable insights — forming an “Owner Avatar” that represents the business’s most valuable customer and product segments.

---

## 🔗 Relation to Main Project

This analytics layer builds directly upon:
- The **Gold Layer** fact and dimension views from the main [SQL Data Warehouse Project](https://github.com/meshivamk/SQL_DataWarehouse).  
- Uses cleaned, validated, and modeled data (customers, products, and sales) to generate **analytical insights**.  
- Focuses entirely on **analysis and storytelling using SQL**, not ETL or data transformations.

---

## 🎯 Project Objective

Transform Gold Layer data models into **actionable business insights** through analytical SQL — uncovering:
- Customer behavior and engagement trends  
- Product performance patterns  
- Sales performance evolution over time  
- Market segmentation and ranking dynamics  

This forms the analytical foundation for decision-making and business intelligence reporting.

---

## 📊 Key Analytical Themes

### 1. **Customer Profiling**
- Identify customer segments based on recency, frequency, and monetary behavior.  
- Analyze loyalty and churn risk by profiling spend and interaction trends.

### 2. **Product Profiling**
- Measure product performance through sales contribution, volume, and margin.  
- Highlight key SKUs driving revenue or requiring optimization.

### 3. **Performance & Trend Analysis**
- Track sales growth using **change-over-time** and **cumulative measures**.  
- Evaluate business KPIs such as average order value, growth rate, and retention.

### 4. **Segmentation & Ranking**
- Segment customers or products by revenue contribution and magnitude.  
- Use ranking analysis to spotlight top performers and underperforming areas.  

---

## ⚙️ Technical Overview

- **Source:** Gold Layer fact and dimension views from SQL Data Warehouse Project
- **Technology:** T-SQL (SQL Server)  
- **Focus:** Analytical SQL (Window functions, CTEs, aggregation, ranking, and ratio analysis)  
- **Scope:** Data storytelling and analytical queries — no data ingestion or schema creation  

```bash
SQL_DataWarehouse_Analytics_Project/
│
├── customer_profile.sql            # Customer demographics, segments, and engagement patterns
├── product_profile.sql             # Product-level KPIs, pricing & performance metrics
├── performance_analysis.sql        # Overall sales performance analysis
├── change_over_time_analysis.sql   # Trend & time-series exploration
├── cumulative_analysis.sql         # Rolling and cumulative measures
├── data_segmentation.sql           # Customer or product segmentation logic
├── magnitude_analysis.sql          # Contribution and magnitude-based comparisons
├── measures_exploration.sql        # KPI breakdowns and derived measures
├── part_to_whole_analysis.sql      # Ratio and share-based calculations
├── ranking_analysis.sql            # Rank-based insights (top customers, products, etc.)
│
└── Readme.txt                      # Documentation for the analytics layer

```
---

## 🧩 Skills Demonstrated

- **Advanced SQL for analytics** (CTEs, ranking, ratio, cumulative calculations)  
- **Data storytelling** using business-ready datasets  
- **Analytical design patterns** like segmentation, part-to-whole, and time-trend analysis  
- **Model reusability** — extending the Gold Layer for business intelligence  
- **Version control and documentation** for analytical workflows  

---

## 🧠 Insights Snapshot

| Analysis Type | Example Insight |
|----------------|----------------|
| **Customer Profile** | Top 15% of customers contribute nearly 70% of total sales. |
| **Product Profile** | Mid-tier products show higher repeat purchase rates. |
| **Performance Analysis** | 2024 Q2 sales rose by 23% after process optimization. |
| **Segmentation** | Customers segmented into 4 groups based on purchase frequency and value. |

---

## 🧾 How to Use

1. Clone or download this repository.  
2. Connect it to the **same SQL Server instance** used in the Data Warehouse project.  
3. Run the `.sql` scripts sequentially on the **Gold Layer database**.  
4. Export or visualize query outputs in **Power BI** or **Excel** for reporting.

---

## 👨‍💻 Author

**Shivam Kumar**  
Data Analyst | Writer 
Building data systems that talk — not just store.  

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat&logo=linkedin)](https://www.linkedin.com/in/meshivamk/)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github)](https://github.com/meshivamk)
