-- ==========================================
-- TIEMPOS MUERTOS ENTRE CIRUGÍAS (TURNOVER)
-- ==========================================

WITH ordered AS (
    SELECT
        surgery_id,
        or_id,
        surgery_date,
        actual_start_time,
        actual_end_time,

        -- Cirugía anterior dentro del mismo quirófano y día
        LAG(actual_end_time) OVER (
            PARTITION BY surgery_date, or_id
            ORDER BY actual_start_time
        ) AS prev_end_time
    FROM surgeries
)

SELECT
    surgery_date,
    or_id,
    surgery_id,
    actual_start_time,
    prev_end_time,

    -- tiempo muerto = inicio actual – fin anterior
    EXTRACT(EPOCH FROM (actual_start_time - prev_end_time)) / 60
        AS turnover_minutes
FROM ordered
WHERE prev_end_time IS NOT NULL
ORDER BY surgery_date, or_id, actual_start_time
LIMIT 50;
