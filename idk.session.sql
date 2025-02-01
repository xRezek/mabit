-- INSERT INTO daily_data (date, machine_id, quality, availability, effectiveness)
-- SELECT 
--     result.work_date,
--     result.machineId,
--     result.quality,
--     result.availability,
--     result.effectiveness
-- FROM (
-- SELECT 
--     result.work_date,
--     result.machineId,
--     result.quality,
--     result.availability,
--     result.effectiveness
-- FROM (
--     SELECT 
--         q.work_date,
--         q.machineId,
--         q.quality,
--         ROUND(ms.working_time_seconds / 3600 / 7, 2) AS availability,
--         ROUND(
--                 (SELECT ROUND(AVG(cycleTime)/3600, 2) FROM produkty WHERE status = 1)
--                 * (SELECT COUNT(*) FROM produkty WHERE status IN (1, 2, 3))
            
--             / (ms.working_time_seconds / 60),
--             2
--         ) AS effectiveness
--     FROM (
--         SELECT *
--         FROM (
--             SELECT 
--                 machineId,
--                 ROUND(COUNT(CASE WHEN status = 1 THEN 1 END) / 
--                       COUNT(CASE WHEN status != 4 AND status != 0 THEN 1 END), 2) AS quality,
--                 DATE(timestamp) AS work_date
--             FROM 
--                 produkty
--             GROUP BY 
--                 work_date, machineId
--         ) AS quality_indicator
--         WHERE quality IS NOT NULL AND quality != 0
--     ) AS q
--     JOIN (
--         SELECT 
--             DATE(timestamp) AS work_date,
--             machineId,
--             COUNT(*) * 20 AS working_time_seconds
--         FROM 
--             machine_status
--         WHERE 
--             isOn = 1
--         GROUP BY 
--             work_date, machineId
--     ) AS ms
--     ON 
--         q.work_date = ms.work_date 
--         AND q.machineId = ms.machineId
-- ) AS result
-- ORDER BY 
--     result.work_date, result.machineId
-- ) AS result;

-- ?Czy współczynnik OEE jest obliczany poprawnie?


-- SELECT *
-- FROM(
--   SELECT 
--     machineId,
--     (round(count(CASE WHEN status = 1 THEN 1 END)/COUNT(CASE WHEN status != 4 AND status != 0 THEN 1 END),2)) AS quality,
--     DATE(timestamp) AS work_date
--   FROM 
--     produkty
--   GROUP BY work_date, machineId
-- ) AS quality_indicator
-- WHERE quality IS NOT NULL AND quality != 0


-- SELECT 
--     DATE(timestamp) AS work_date,
--     machineId,
--     COUNT(*) * 20 AS working_time_seconds,
--     SEC_TO_TIME(COUNT(*) * 20) AS working_time_hms
-- FROM 
--     machine_status
-- WHERE 
--     isOn = 1
-- GROUP BY 
--     work_date, machineId
-- ORDER BY 
--     work_date, machineId;



-- SELECT machineId (SELECT AVG(cycleTime) FROM produkty WHERE status = 1 AS avg_cycle_time) * (SELECT *
-- FROM(
--   SELECT 
--     (round(COUNT(CASE WHEN status != 4 AND status != 0 THEN 1 END),2)) AS quality,
--     DATE(timestamp) AS work_date
--   FROM 
--     produkty
--   GROUP BY work_date, machineId
-- ) AS quality_indicator
-- WHERE quality IS NOT NULL AND quality != 0)

-- * zapytanie oblicza parametry do obliczenia wskaźnika OEE
-- SELECT 
--     result.work_date,
--     result.machineId,
--     result.quality,
--     result.availability,
--     result.effectiveness
-- FROM (
--     SELECT 
--         q.work_date,
--         q.machineId,
--         q.quality,
--         ROUND(ms.working_time_seconds / 3600 / 7, 2) AS availability,
--         ROUND(
--                 (SELECT ROUND(AVG(cycleTime)/3600, 2) FROM produkty WHERE status = 1)
--                 * (SELECT COUNT(*) FROM produkty WHERE status IN (1, 2, 3))           
--             / (ms.working_time_seconds / 3600),
--             2
--         ) AS effectiveness
--     FROM (
--         SELECT *
--         FROM (
--             SELECT 
--                 machineId,
--                 ROUND(COUNT(CASE WHEN status = 1 THEN 1 END) / 
--                       COUNT(CASE WHEN status != 4 AND status != 0 THEN 1 END), 2) AS quality,
--                 DATE(timestamp) AS work_date
--             FROM 
--               produkty
--             GROUP BY 
--               work_date, machineId
--         ) AS quality_indicator
--         WHERE quality IS NOT NULL AND quality != 0
--     ) AS q
--     JOIN (
--         SELECT 
--             DATE(timestamp) AS work_date,
--             machineId,
--             COUNT(*) * 20 AS working_time_seconds
--         FROM 
--             machine_status
--         WHERE 
--             isOn = 1
--         GROUP BY 
--             work_date, machineId
--     ) AS ms
--     ON 
--         q.work_date = ms.work_date 
--         AND q.machineId = ms.machineId
-- ) AS result
-- ORDER BY 
--     result.work_date, result.machineId



-- * zapytanie zlicza produkty do wykresu kołowego 

-- SELECT
--   SUM(OK), SUM(NOK), SUM(ANULOWANY)
-- FROM(
--   SELECT
--     CASE WHEN status = 1 THEN 1 ELSE 0 END AS OK,
--     CASE WHEN status = 2 THEN 1 ELSE 0 END AS NOK,
--     CASE WHEN status = 3 THEN 1 ELSE 0 END AS ANULOWANY    
--   FROM produkty
-- ) a;


-- SELECT
--   ROUND(COUNT(CASE WHEN status = 1 THEN 1 END)/COUNT(CASE WHEN status != 4 AND status != 0 THEN 1 END),2) AS quality
-- FROM 
--   produkty
-- WHERE machineId LIKE "%%"


-- * zapytanie bez parametru
-- SELECT
-- 	ROUND((SELECT COUNT(*) FROM `produkty` WHERE status = 1 AND machineId LIKE "%%") 
--   /(SELECT COUNT(*) FROM produkty WHERE status NOT IN (0,4)),2) as quality


-- SELECT
-- 	ROUND((SELECT COUNT(*) FROM `produkty` WHERE status = 1 AND machineId LIKE "%%" AND timestamp BETWEEN "2025-01-29T08:00" AND "2025-01-29 16:00")
--   /(SELECT COUNT(*) FROM produkty WHERE status NOT IN (0,4) AND timestamp BETWEEN "2025-01-29T08:00" AND ''  ),2) as quality