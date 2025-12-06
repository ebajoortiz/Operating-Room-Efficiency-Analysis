-- ===============================
-- MÉTRICAS BÁSICAS DE EFICIENCIA QUIRÚRGICA
-- Retrasos y diferencia de duración
-- ===============================

SELECT
    surgery_id,
    or_id,
    surgery_date,

    -- Retraso de inicio (minutos). Negativo = empieza antes.
    EXTRACT(EPOCH FROM (actual_start_time - scheduled_start_time)) / 60
        AS delay_start_min,

    -- Retraso de fin (minutos). Negativo = acaba antes.
    EXTRACT(EPOCH FROM (actual_end_time - scheduled_end_time)) / 60
        AS delay_end_min,

    -- Diferencia duración real - estimada. Positivo = se alargó.
    actual_duration_min - estimated_duration_min
        AS overrun_min

FROM surgeries
ORDER BY surgery_date, or_id, surgery_id
LIMIT 50;

