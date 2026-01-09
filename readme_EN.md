# Operating Room Efficiency Analysis

## Optimization of Surgical Flow and Operating Room Utilization

---

## Project Description

This project analyzes **operating room (OR) efficiency in a hospital setting** using **PostgreSQL (SQL)** and **Power BI**, with the objective of identifying time losses, operational bottlenecks, and improvement opportunities **without increasing resources**.

The analysis focuses particularly on **surgical turnover** (idle time between surgeries), as well as start delays, duration overruns, and actual operating room utilization. The approach is **operational and business-oriented**, similar to what would be applied in a real hospital environment.

---

## Analytical Objectives

* Measure **actual operating room utilization**
* Identify **idle time between surgeries (turnover)**
* Analyze **start delays** and **overruns** (actual vs. planned duration)
* Compare efficiency by:

  * operating room
  * specialty
  * day of the week
* Simulate improvement scenarios using a **What-if model**

---

## Repository Structure

```
Operating-Room-Efficiency-Analysis/
│
├── data/
│   └── operating_room_efficiency_simulated.csv
│
├── sql/
│   ├── 01_create_table_surgeries.sql
│   ├── 02_first_metrics.sql
│   ├── 03_daily_or_utilization.sql
│   ├── 04_turnover_times.sql
│   ├── 05_kpi_turnover_avg_by_or.sql
│   ├── 06_kpi_turnover_avg_by_specialty.sql
│   ├── 07_kpi_turnover_by_weekday.sql
│   ├── 08_kpi_turnover_lost_time_by_month.sql
│   ├── 09_kpi_extra_surgeries_whatif.sql
│   └── 10_create_view_surgeries_enriched.sql
│
├── powerbi/
│   └── operating_room_efficiency.pbix
│
└── README.md
```

---

## Phase 1 — SQL (PostgreSQL)

### 1. Base Table Creation

**File:** `01_create_table_surgeries.sql`

Creation of the `surgeries` table from the CSV dataset, defining appropriate data types for dates, timestamps, and surgical durations.

---

### 2. Initial Metrics

**File:** `02_first_metrics.sql`

Calculation of surgery-level metrics:

* start delay
* end delay
* overrun (actual duration minus estimated duration)

These metrics highlight systematic deviations in surgical planning.

---

### 3. Daily Operating Room Utilization

**File:** `03_daily_or_utilization.sql`

Daily utilization is calculated by comparing:

* actual minutes used
* versus available operating room minutes

This analysis reveals underutilization and strong day-to-day variability.

---

### 4. Turnover Calculation

**File:** `04_turnover_times.sql`

Use of **window functions (`LAG`)** to calculate the time between the end of one surgery and the start of the next within the same operating room and day.

---

### 5. Operational KPIs in SQL

* Average turnover by operating room (`05_kpi_turnover_avg_by_or.sql`)
* Average turnover by specialty (`06_kpi_turnover_avg_by_specialty.sql`)
* Turnover by weekday (`07_kpi_turnover_by_weekday.sql`)
* Total lost turnover time by month (`08_kpi_turnover_lost_time_by_month.sql`)
* Estimated additional surgeries (What-if scenario) (`09_kpi_extra_surgeries_whatif.sql`)

These queries allow validation of results and exploratory analysis directly in SQL.

---

### 6. Enriched View for Power BI

**File:** `10_create_view_surgeries_enriched.sql`

Creation of the view:

```sql
v_surgeries_enriched
```

This view includes all original fields plus **turnover in minutes**. It acts as an **ETL / modeling layer**, keeping Power BI focused on analytics and visualization.

---

## Phase 2 — Power BI

### Data Model

* Direct connection to PostgreSQL
* Use of the `v_surgeries_enriched` view
* Dedicated **DAX measures table**
* **What-if parameter** to simulate turnover reduction scenarios

---

## Dashboards

### Page 1 — Executive Overview

**Purpose:** assess overall operating room performance.

**Key KPIs:**

* Average OR utilization: **54.35%**
* Average turnover: **79.6 minutes**
* Average start delay: **15.9 minutes**
* Average overrun: **10.4 minutes**

**Key insight:**

> Operating rooms are significantly underutilized, with turnover representing the main source of efficiency loss.

---

### Page 2 — Operational Efficiency

**Purpose:** identify where and when time is lost.

**Analysis dimensions:**

* specialty
* operating room
* weekday

**Key insights:**

* High turnover variability across specialties
* Significant differences between operating rooms
* Clear weekly efficiency patterns
* Relationship between start delays and higher overruns

---

### Page 3 — Optimization & What-if Analysis

**Purpose:** quantify the potential impact of operational improvements.

**Results:**

* **165.9 total hours** lost due to turnover
* Simulation of a **15% turnover reduction**
* Significant recovery of surgical time
* Ability to perform **additional surgeries without increasing resources**

**Key insight:**

> Moderate operational improvements can translate into a measurable increase in surgical capacity.

---

## Overall Conclusions

* The primary bottleneck is not surgery duration, but **time between surgeries**
* Turnover optimization provides the highest return with minimal cost
* The analysis supports data-driven operational prioritization
* The project is oriented toward **real-world decision making**, not purely descriptive analytics

---

## Technologies Used

* **PostgreSQL** — data modeling and transformation
* **SQL** — CTEs, window functions, views
* **Power BI** — data modeling, DAX, visualization
* **GitHub** — version control and documentation

---

## Author

Project developed as part of a **Data Analytics / Business Intelligence portfolio**, focused on operational analytics and healthcare efficiency.
