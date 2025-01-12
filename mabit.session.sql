--*Zapytania SQL do obliczenia wskaźnika OEE

SELECT 
  (round(count(CASE WHEN status = 1 THEN 1 END)/COUNT(*),2)) AS Jakość
FROM 
  produkty;


-- SELECT timestamp
-- FROM machine_status
-- WHERE isOn = 1

SELECT 
    t1.machineId,
    t1.timestamp AS current_timestamp,
    t1.isOn,
    (
        SELECT MIN(t2.timestamp)
        FROM machine_status t2
        WHERE t2.machineId = t1.machineId AND t2.timestamp > t1.timestamp
    ) AS next_timestamp
FROM 
    machine_status t1
WHERE 
    t1.machineId = '1103_05_UA';

--!fixit: Zapytanie nie działa poprawnie

--todo: Napisz zapytanie, które zwróci wskaznik wydajności dla maszyny 1103_05_UA


