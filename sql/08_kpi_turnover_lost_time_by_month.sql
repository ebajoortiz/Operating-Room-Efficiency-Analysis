-- KPI 4: Tiempo total perdido por turnover por mes (horas)

WITH turnovers AS (
    SELECT
        surgery_date,
        or_id,
        actual_start_time,
        LAG(actual_end_time) OVER (
            PARTITION BY surgery_date, or_id
            ORDER BY actual_start_time
        ) AS prev_end_time
    FROM surgeries
),
calc AS (
    SELECT
        surgery_date,
        EXTRACT(EPOCH FROM (actual_start_time - prev_end_time)) / 60 AS turnover_minutes
    FROM turnovers
    WHERE prev_end_time IS NOT NULL
)
SELECT
    DATE_TRUNC('month', surgery_date)::date AS month,
    ROUND(SUM(turnover_minutes)::numeric, 1) AS total_turnover_min,
    ROUND((SUM(turnover_minutes) / 60.0)::numeric, 1) AS total_turnover_hours,
    COUNT(*) AS num_turnovers
FROM calc
WHERE turnover_minutes >= 0
GROUP BY month
ORDER BY month;
