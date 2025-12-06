-- Tabla principal de cirugías de quirófano
CREATE TABLE IF NOT EXISTS surgeries (
    surgery_id             INTEGER PRIMARY KEY,      -- identificador único de la cirugía
    or_id                  INTEGER NOT NULL,         -- quirófano (1, 2, 3...)
    surgery_date           DATE NOT NULL,            -- fecha de la cirugía

    scheduled_start_time   TIMESTAMP NOT NULL,       -- inicio programado
    actual_start_time      TIMESTAMP NOT NULL,       -- inicio real
    scheduled_end_time     TIMESTAMP NOT NULL,       -- fin programado
    actual_end_time        TIMESTAMP NOT NULL,       -- fin real

    estimated_duration_min INTEGER NOT NULL,         -- duración estimada (minutos)
    actual_duration_min    INTEGER NOT NULL,         -- duración real (minutos)

    procedure_type         TEXT NOT NULL,            -- tipo de procedimiento (ej. Appendectomy)
    specialty              TEXT NOT NULL,            -- especialidad (ej. General Surgery)
    surgeon                TEXT NOT NULL,            -- cirujano
    anesthesiologist       TEXT NOT NULL             -- anestesista
);
