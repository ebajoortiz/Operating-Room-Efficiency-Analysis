-- KPI 3: Turnover por día de la semana
-- 0=domingo ... 6=sábado (Postgres)

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
    TO_CHAR(surgery_date, 'Dy') AS weekday_short,
    EXTRACT(DOW FROM surgery_date) AS weekday_num,
    ROUND(AVG(turnover_minutes)::numeric, 1) AS avg_turnover_min,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY turnover_minutes) AS median_turnover_min,
    COUNT(*) AS num_turnovers
FROM calc
WHERE turnover_minutes >= 0
GROUP BY weekday_short, weekday_num
ORDER BY weekday_num;
