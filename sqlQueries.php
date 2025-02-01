<?php

  $sqlQueryGetOEEparams = "SELECT avg(quality), avg(availability), avg(effectiveness) FROM daily_data"; //* zapydanie obliczające średnią wartość dla wszystkich wskaźników OEE

  $sqlGetQuality = "SELECT SUM(OK), SUM(NOK), SUM(ANULOWANY) FROM( SELECT CASE WHEN status = 1 THEN 1 ELSE 0 END AS OK, CASE WHEN status = 2 THEN 1 ELSE 0 END AS NOK, CASE WHEN status = 3 THEN 1 ELSE 0 END AS ANULOWANY FROM produkty) a"; //* zapytanie zlicza dobre, złe i anulowane produkty

  $sqlGetDataForLinearChart = "SELECT date, ROUND(AVG(quality) * 100,2) AS quality , ROUND(quality * AVG(availability),2) * 100 AS OEE FROM daily_data GROUP BY date;"; //* zapytanie oblicza wskaźnik OEE

  $sqlGetMachines = "SELECT machineId FROM maszyny";