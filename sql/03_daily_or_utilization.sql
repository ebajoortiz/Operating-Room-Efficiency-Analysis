-- ==========================================
-- UTILIZACIÓN DIARIA DEL QUIRÓFANO
-- Por fecha (surgery_date) y quirófano (or_id)
-- ==========================================

-- Paso 1: agregamos por día y quirófano
WITH daily AS (
    SELECT
        surgery_date,
        or_id,
        COUNT(*) AS num_surgeries,               -- número de cirugías ese día en ese quirófano
        SUM(actual_duration_min) AS total_actual_min  -- minutos totales usados
    FROM surgeries
    GROUP BY surgery_date, or_id
)

-- Paso 2: calculamos minutos disponibles y porcentaje de ocupación
SELECT
    surgery_date,
    or_id,
    num_surgeries,
    total_actual_min,
    
    -- Suponemos jornada de 9 horas por quirófano (08:00–17:00)
    9 * 60 AS available_minutes,
    
    ROUND(
        (total_actual_min::numeric / (9 * 60)) * 100,
        1
    ) AS utilization_pct
FROM daily
ORDER BY surgery_date, or_id
LIMIT 50;
