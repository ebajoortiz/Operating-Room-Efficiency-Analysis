-- KPI 2: Turnover promedio por especialidad (minutos)
-- Nota: asignamos el turnover a la especialidad de la cirugía que empieza (la "actual").

WITH turnovers AS (
    SELECT
        surgery_date,
        or_id,
        specialty,
        actual_start_time,
        LAG(actual_end_time) OVER (
            PARTITION BY surgery_date, or_id
            ORDER BY actual_start_time
        ) AS prev_end_time
    FROM surgeries
),
calc AS (
    SELECT
        specialty,
        EXTRACT(EPOCH FROM (actual_start_time - prev_end_time)) / 60 AS turnover_minutes
    FROM turnovers
    WHERE prev_end_time IS NOT NULL
)
SELECT
    specialty,
    ROUND(AVG(turnover_minutes)::numeric, 1) AS avg_turnover_min,
    COUNT(*) AS num_turnovers
FROM calc
WHERE turnover_minutes >= 0
GROUP BY specialty
ORDER BY avg_turnover_min DESC;
