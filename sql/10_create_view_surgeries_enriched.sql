-- ======================================================
-- VISTA ENRIQUECIDA DE CIRUGÍAS
-- Incluye cálculo de turnover (tiempo muerto)
-- ======================================================

CREATE OR REPLACE VIEW v_surgeries_enriched AS
WITH ordered AS (
    SELECT
        s.*,
        LAG(actual_end_time) OVER (
            PARTITION BY surgery_date, or_id
            ORDER BY actual_start_time
        ) AS prev_end_time
    FROM surgeries s
)
SELECT
    *,
    EXTRACT(EPOCH FROM (actual_start_time - prev_end_time)) / 60
        AS turnover_minutes
FROM ordered;
