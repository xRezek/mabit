SELECT 
  (round(count(CASE WHEN status = 1 THEN 1 END)/COUNT(CASE WHEN status != 4 AND status != 0 THEN 1 END),2)) AS Jakość,
  CONCAT(EXTRACT(DAY FROM timestamp),'-',EXTRACT(MONTH FROM timestamp)) AS work_date
FROM 
  produkty
WHERE machineId = '1103_05_UA'
GROUP BY EXTRACT(DAY FROM timestamp);


-- SELECT 
--     DATE(t1.timestamp) AS work_date,
--     SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, t1.timestamp, t2.timestamp))) AS total_work_time
-- FROM 
--     machine_status t1
-- JOIN 
--     machine_status t2 
--     ON t1.machineId = t2.machineId 
--     AND t1.timestamp < t2.timestamp
--     AND t2.isOn = 1
-- WHERE 
--   t1.isOn = 1
-- GROUP BY 
--     t1.machineId
-- ORDER BY 
--     work_date;

-- SELECT SUM(TIMESTAMPDIFF(SECOND, t1.timestamp, t2.timestamp)) AS total_work_time


-- SELECT 
--     t1.timestamp AS start_time,
--     t2.timestamp AS end_time,
--     TIMESTAMPDIFF(SECOND, t1.timestamp, t2.timestamp) AS work_time_in_seconds
-- FROM 
--     machine_status t1
-- JOIN 
--     machine_status t2 
--     ON t1.machineId = t2.machineId 
--     AND t1.timestamp < t2.timestamp
--     AND t2.isOn = 0
-- WHERE 
--     t1.machineId = '1103_05_UA'
--     AND t1.isOn = 1
-- ORDER BY 
--     t1.timestamp;
