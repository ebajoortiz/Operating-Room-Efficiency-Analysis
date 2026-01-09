# 🏥 Operating Room Efficiency Analysis

## Optimización del flujo quirúrgico y utilización de quirófanos

---

## 📌 Descripción del proyecto

Este proyecto analiza la **eficiencia operativa de los quirófanos hospitalarios** utilizando **PostgreSQL (SQL)** y **Power BI**, con el objetivo de identificar pérdidas de tiempo, cuellos de botella y oportunidades de mejora **sin necesidad de ampliar recursos**.

El análisis se centra especialmente en el **turnover quirúrgico** (tiempo muerto entre cirugías), además de retrasos, sobreduración y utilización real del quirófano. El enfoque es **operativo y orientado a negocio**, similar al que se usaría en un entorno hospitalario real.

---

## 🎯 Objetivos analíticos

* Medir la **utilización real** de los quirófanos
* Identificar **tiempos muertos** entre cirugías (turnover)
* Analizar **retrasos de inicio** y **overrun** (duración real vs planificada)
* Comparar eficiencia por:

  * quirófano
  * especialidad
  * día de la semana
* Simular escenarios de mejora mediante un **modelo What-if**

---

## 🗂️ Estructura del repositorio

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

## 🛠️ Fase 1 — SQL (PostgreSQL)

### 1️⃣ Creación de la tabla base

**Archivo:** `01_create_table_surgeries.sql`

Carga del dataset CSV y creación de la tabla `surgeries`, definiendo tipos de datos adecuados para fechas, horas y duraciones quirúrgicas.

---

### 2️⃣ Métricas iniciales

**Archivo:** `02_first_metrics.sql`

Cálculo de métricas clave a nivel de cirugía:

* retraso en el inicio
* retraso en el final
* overrun (duración real – duración estimada)

Estas métricas permiten detectar desviaciones sistemáticas en la planificación quirúrgica.

---

### 3️⃣ Utilización diaria del quirófano

**Archivo:** `03_daily_or_utilization.sql`

Cálculo de la utilización diaria del quirófano comparando:

* minutos reales utilizados
* frente a minutos disponibles

Permite identificar infrautilización y alta variabilidad entre días.

---

### 4️⃣ Cálculo del turnover

**Archivo:** `04_turnover_times.sql`

Uso de **window functions (`LAG`)** para calcular el tiempo entre el final de una cirugía y el inicio de la siguiente dentro del mismo quirófano y día.

---

### 5️⃣ KPIs operativos en SQL

* **Turnover medio por quirófano** (`05_kpi_turnover_avg_by_or.sql`)
* **Turnover medio por especialidad** (`06_kpi_turnover_avg_by_specialty.sql`)
* **Turnover por día de la semana** (`07_kpi_turnover_by_weekday.sql`)
* **Tiempo total perdido por mes** (`08_kpi_turnover_lost_time_by_month.sql`)
* **Estimación de cirugías adicionales (what-if)** (`09_kpi_extra_surgeries_whatif.sql`)

Estas queries permiten validar resultados y realizar análisis exploratorio directamente en SQL.

---

### 6️⃣ Vista enriquecida para Power BI

**Archivo:** `10_create_view_surgeries_enriched.sql`

Creación de la vista:

```sql
v_surgeries_enriched
```

Incluye todas las columnas originales más el **turnover en minutos**. Esta vista actúa como capa de **modelado / ETL**, dejando Power BI enfocado exclusivamente en análisis y visualización.

---

## 📊 Fase 2 — Power BI

### 🔹 Modelo de datos

* Conexión directa a PostgreSQL
* Uso de la vista `v_surgeries_enriched`
* Tabla independiente de **medidas DAX**
* Parámetro **What-if** para simulación de mejoras en turnover

---

## 📄 Dashboards creados

### 🟦 Página 1 — Visión Ejecutiva

**Objetivo:** evaluar el rendimiento global del bloque quirúrgico.

**KPIs principales:**

* Utilización media del quirófano: **54,35%**
* Turnover medio: **79,6 min**
* Retraso medio de inicio: **15,9 min**
* Overrun medio: **10,4 min**

**Insight clave:**

> Existe una infrautilización relevante de los quirófanos, siendo el turnover el principal factor de pérdida de eficiencia.

---

### 🟩 Página 2 — Eficiencia Operativa

**Objetivo:** identificar dónde y cuándo se pierde el tiempo.

**Análisis por:**

* especialidad
* quirófano
* día de la semana

**Insights clave:**

* Alta variabilidad de turnover entre especialidades
* Diferencias significativas entre quirófanos
* Patrones semanales de eficiencia
* Relación entre retrasos iniciales y mayor overrun

---

### 🟨 Página 3 — Optimización & What-if

**Objetivo:** cuantificar el impacto potencial de mejoras operativas.

**Resultados:**

* **165,9 horas** totales perdidas por turnover
* Simulación de reducción del turnover del **15%**
* Recuperación significativa de tiempo quirúrgico
* Posibilidad de realizar **cirugías adicionales** sin aumentar recursos

**Insight clave:**

> Pequeñas mejoras operativas pueden traducirse en un aumento real de la capacidad asistencial.

---

## 💡 Conclusiones generales

* El principal cuello de botella no es la duración de las cirugías, sino el **tiempo entre ellas**
* Optimizar el turnover ofrece el mayor retorno con el menor coste
* El análisis permite priorizar acciones basadas en impacto real
* Proyecto orientado a **toma de decisiones operativas**, no solo a análisis descriptivo

---

## 🧪 Tecnologías utilizadas

* **PostgreSQL** — modelado y transformación de datos
* **SQL** — CTEs, window functions, vistas
* **Power BI** — modelado, DAX, visualización
* **GitHub** — versionado y documentación

---


