-- What-if: cirugías extra si reducimos turnover un 10% y 15%
-- Idea: minutos recuperados / duración promedio real (min) ≈ cirugías adicionales
-- Aquí hacemos un “what-if” simple:
----calculamos el tiempo total de turnover en un periodo (p.ej. mes)
----si reduces un % (10% o 15%), recuperas minutos
----y estimamos cuántas cirugías extra caben usando una duración promedio real.

WITH base AS (
    SELECT
        DATE_TRUNC('month', surgery_date)::date AS month,
        actual_duration_min
    FROM surgeries
),
avg_case AS (
    SELECT
        month,
        AVG(actual_duration_min)::numeric AS avg_case_min
    FROM base
    GROUP BY month
),
turnovers AS (
    SELECT
        DATE_TRUNC('month', surgery_date)::date AS month,
        EXTRACT(EPOCH FROM (actual_start_time - LAG(actual_end_time) OVER (
            PARTITION BY surgery_date, or_id
            ORDER BY actual_start_time
        ))) / 60 AS turnover_minutes
    FROM surgeries
),
turnover_month AS (
    SELECT
        month,
        SUM(turnover_minutes)::numeric AS total_turnover_min
    FROM turnovers
    WHERE turnover_minutes IS NOT NULL AND turnover_minutes >= 0
    GROUP BY month
)
SELECT
    t.month,
    ROUND(t.total_turnover_min, 1) AS total_turnover_min,
    ROUND(a.avg_case_min, 1) AS avg_case_min,

    -- minutos recuperados
    ROUND(t.total_turnover_min * 0.10, 1) AS recovered_min_10pct,
    ROUND(t.total_turnover_min * 0.15, 1) AS recovered_min_15pct,

    -- cirugías extra aproximadas
    FLOOR((t.total_turnover_min * 0.10) / a.avg_case_min) AS extra_surgeries_10pct,
    FLOOR((t.total_turnover_min * 0.15) / a.avg_case_min) AS extra_surgeries_15pct
FROM turnover_month t
JOIN avg_case a USING (month)
ORDER BY t.month;
