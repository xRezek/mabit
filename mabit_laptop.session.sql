SELECT 
  machineId,
  (ROUND(COUNT(CASE WHEN status = 1 THEN 1 END)/COUNT(CASE WHEN status != 4 AND status != 0 THEN 1 END),2)) AS Quality,
  CONCAT(EXTRACT(DAY FROM timestamp),'-',EXTRACT(MONTH FROM timestamp)) AS work_date
FROM 
  produkty
GROUP BY EXTRACT(DAY FROM timestamp), machineId;


SELECT DATE(timestamp) AS work_day,
 machineId,
 SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, TIMESTAMP, next_timestamp))) AS total_work_time
FROM (
  SELECT machineId, TIMESTAMP,
            LEAD(TIMESTAMP) OVER (PARTITION BY EXTRACT(DAY FROM TIMESTAMP) ORDER BY TIMESTAMP) AS next_timestamp
        FROM machine_status WHERE isOn = 1
     ) AS derived_table
WHERE next_timestamp IS NOT NULL
GROUP BY work_day, machineId
ORDER BY work_day;




-- SELECT 
-- 	t1.machineId,
--     t1.timestamp AS timestamp,
--     MIN(t2.timestamp) AS next_timestamp
-- FROM 
--     machine_status t1
-- LEFT JOIN 
--     machine_status t2
-- ON 
--     t2.timestamp > t1.timestamp
-- WHERE t1.isOn = 1
-- GROUP BY 
--     t1.timestamp
-- ORDER BY 
--     t1.timestamp

