# Marketing-Analytics-Pipeline-Dashboard-Using-DBT-Power-BI

# 📊 Marketing Analytics Pipeline
### End-to-end analytics engineering project using dbt · BigQuery · Power BI

---

## 🗂️ Project Overview

This project builds a complete **Marketing Analytics data pipeline** from raw CSV data through to an interactive Power BI dashboard. It follows modern analytics engineering best practices using **dbt** for transformation, **BigQuery** as the data warehouse, and **Power BI** for visualization.

The pipeline answers key business questions around:
- Customer lifetime value & journey analysis
- Campaign ROI & performance by channel
- Channel spend distribution & revenue trends

---

## 🏗️ Architecture

```
Raw CSVs
   ↓
BigQuery (Raw Layer)
   ↓
dbt Staging Models       → stg_customers, stg_sessions, stg_campaigns, stg_orders
   ↓
dbt Intermediate Models  → int_customer_sessions, int_customers_orders
   ↓
dbt Mart Models          → mart_customer_journey, mart_campaign_performance, mart_channel_monthly
   ↓
Power BI Dashboard       → 3-page interactive report
```

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| **dbt Core** | Data transformation & modelling |
| **Google BigQuery** | Cloud data warehouse |
| **Power BI** | Dashboard & visualization |
| **SQL** | Transformation logic |
| **YAML** | dbt tests & documentation |

---

## 📁 Project Structure

```
marketing_analytics/
│
├── models/
│   ├── staging/
│   │   ├── stg_customers.sql
│   │   ├── stg_sessions.sql
│   │   ├── stg_campaigns.sql
│   │   └── stg_orders.sql
│   │
│   ├── intermediate/
│   │   ├── int_customer_sessions.sql
│   │   └── int_customers_orders.sql
│   │
│   └── marts/
│       ├── mart_customer_journey.sql
│       ├── mart_campaign_performance.sql
│       └── mart_channel_monthly.sql
│
├── tests/
│   └── generic & singular tests
│
├── macros/
│
├── dbt_project.yml
├── profiles.yml
└── README.md
```

---

## 📐 Data Models

### Staging Layer
Cleans and standardises raw source data. One staging model per source table.

| Model | Description |
|-------|-------------|
| `stg_customers` | Customer demographic & segment data |
| `stg_sessions` | Web session data with acquisition channel |
| `stg_campaigns` | Campaign metadata — type, channel, spend |
| `stg_orders` | Order transactions with revenue |

### Intermediate Layer
Joins and enriches staging models. Handles business logic like session-to-order attribution.

| Model | Description |
|-------|-------------|
| `int_customer_sessions` | Joins customers with their sessions |
| `int_customers_orders` | Joins customers with their orders for CLV calculation |

### Mart Layer
Final wide tables ready for reporting. Optimised for Power BI consumption.

| Model | Grain | Description |
|-------|-------|-------------|
| `mart_customer_journey` | One row per customer | CLV, days to first purchase, RFM scores, conversion rate |
| `mart_campaign_performance` | One row per campaign | Spend, revenue, ROAS, ROI%, CTR by campaign |
| `mart_channel_monthly` | One row per channel per month | Monthly spend & revenue trends by channel |

---

## 📊 Power BI Dashboard

The report has **3 pages**:

### Page 1 — Customer Insights & Journey
- Total Customers, Avg CLV, Avg Days to First Purchase, Session → Order Rate
- Customers by Country (map)
- Avg CLV by Segment (bar chart)
- RFM Scatter — Recency vs Frequency sized by Monetary value

### Page 2 — Campaign ROI & Performance Analysis
- EURO Spend, ROAS, Revenue KPI cards
- ROI% by Channel (stacked bar)
- CTR by Channel (bar chart)
- Spend vs Revenue by Campaign (scatter)
- Campaign Performance Details (table)

### Page 3 — Channel Mix & Spend Analysis
- Revenue by Month (line chart)
- ROAS by Month (line chart)
- Revenue Share by Channel (donut chart)
- Total Spend by Channel & Month (matrix table)

---

## ⚙️ How to Run

### Prerequisites
- Python 3.8+
- dbt Core installed (`pip install dbt-bigquery`)
- Google Cloud account with BigQuery access
- Service account key with BigQuery permissions

### Setup

```bash
# Clone the repo
git clone https://github.com/yourusername/marketing-analytics-dbt.git
cd marketing-analytics-dbt

# Install dbt dependencies
pip install dbt-bigquery

# Configure your profiles.yml with your BigQuery project details
# profiles.yml location: ~/.dbt/profiles.yml
```

### profiles.yml example

```yaml
marketing_analytics:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: service-account
      project: your-gcp-project-id
      dataset: marketing_dev
      keyfile: /path/to/your/keyfile.json
      threads: 4
```

### Run the pipeline

```bash
# Test your connection
dbt debug

# Install packages
dbt deps

# Run all models
dbt run

# Run tests
dbt test

# Generate & serve documentation
dbt docs generate
dbt docs serve
```

---

## ✅ dbt Tests Implemented

- `not_null` on all primary keys
- `unique` on all primary keys
- `accepted_values` on segment, channel, campaign_type
- `relationships` between staging models

---

## 🔑 Key Concepts Demonstrated

- **Staging → Intermediate → Mart** layered architecture
- **Grain definition** — every model has a clearly defined grain
- **`{{ source() }}`** and **`{{ ref() }}`** for dependency management
- **`safe_divide()`** for ROAS & ROI calculations avoiding division by zero
- **RFM scoring** — Recency, Frequency, Monetary customer segmentation
- **`persist_docs`** — column descriptions pushed to BigQuery from dbt YAML
- **DAX measures** in Power BI for dynamic ROAS calculation

---

## 📸 Dashboard Preview

> *Screenshots of all 3 dashboard pages*
![Customer Journey](https://raw.githubusercontent.com/ShrutiPatil2223/Marketing-Analytics-Pipeline-Dashboard-Using-DBT-Power-BI/main/marketing_analytics/Screenshots/customer%20insights.png)
![Campaign ROI](https://raw.githubusercontent.com/ShrutiPatil2223/Marketing-Analytics-Pipeline-Dashboard-Using-DBT-Power-BI/main/marketing_analytics/Screenshots/campaign%20analysis.png)
![Channel Mix](https://raw.githubusercontent.com/ShrutiPatil2223/Marketing-Analytics-Pipeline-Dashboard-Using-DBT-Power-BI/main/marketing_analytics/Screenshots/channel%20mix%20%26%20spend%20analysis.png)
---

## 👩‍💻 Author

**Shruti**
MSc Data Science · BHT Berlin
Analytics Engineering · dbt · BigQuery · Power BI

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://www.linkedin.com/in/shrutigpatil/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black)](https://github.com/yourusername)

---

## 📌 Notes

- BigQuery project: `marketing-analytics-dbt-497908`
- Dataset: `marketing_dev`
- Dashboard built in Power BI Desktop (Import mode)
- Data is synthetic/sample marketing data for portfolio purposes
