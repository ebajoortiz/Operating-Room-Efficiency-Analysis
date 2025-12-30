-- KPI 1: Turnover promedio por quirófano (minutos)

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
        or_id,
        EXTRACT(EPOCH FROM (actual_start_time - prev_end_time)) / 60 AS turnover_minutes
    FROM turnovers
    WHERE prev_end_time IS NOT NULL
)
SELECT
    or_id,
    ROUND(AVG(turnover_minutes)::numeric, 1) AS avg_turnover_min,
    COUNT(*) AS num_turnovers
FROM calc
WHERE turnover_minutes >= 0
GROUP BY or_id
ORDER BY avg_turnover_min DESC;
