INSERT INTO daily_data (date, quality, availability, effectiveness)
SELECT
  CURRENT_DATE() as date,
  (SELECT 
    ROUND(
      SUM(CASE WHEN status = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 
      2
    ) 
  FROM `produkty`
  WHERE status IN (1, 2, 3) AND DATE(timestamp) = CURRENT_DATE()) AS quality,
  (SELECT
    ROUND((SELECT (COUNT(*) * 20) / 3600 FROM machine_status
  WHERE isOn = 1 AND DATE(timestamp) = CURRENT_DATE()) 
  /
  (SELECT (COUNT(*) * 20) / 3600 FROM machine_status
  WHERE DATE(timestamp) = CURRENT_DATE()),2)) AS availability,
  (SELECT
    ROUND(AVG(COALESCE(scale, 0)) / 100,2) AS effectiveness
  FROM
    `produkty`
  WHERE DATE(timestamp) = CURRENT_DATE()) AS effectiveness
  
