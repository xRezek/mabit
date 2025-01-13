SELECT 
  (round(count(CASE WHEN status = 1 THEN 1 END)/COUNT(CASE WHEN status != 4 AND status != 0 THEN 1 END),2)) AS Jakość,
  CONCAT(EXTRACT(DAY FROM timestamp),'-',EXTRACT(MONTH FROM timestamp)) AS work_date
FROM 
  produkty
WHERE machineId = '1103_05_UA'
GROUP BY EXTRACT(DAY FROM timestamp);


SELECT EXTRACT(DAY FROM TIMESTAMP) AS work_day,
 SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, TIMESTAMP, next_timestamp))) AS total_work_time
FROM (
  SELECT TIMESTAMP,
            LEAD(TIMESTAMP) OVER (PARTITION BY EXTRACT(DAY FROM TIMESTAMP) ORDER BY TIMESTAMP) AS next_timestamp
        FROM machine_status WHERE isOn = 1 AND machineId = "1103_05_UA"
     ) AS derived_table
WHERE next_timestamp IS NOT NULL
GROUP BY work_day
ORDER BY work_day DESC;