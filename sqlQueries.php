<?php

  $sqlQueryGetOEEparams = "SELECT 
                            avg(quality), 
                            avg(availability), 
                            avg(effectiveness)
                          FROM 
                            daily_data"; //* zapydanie obliczające średnią wartość dla wszystkich wskaźników OEE

  $sqlGetQuality = "SELECT
                      ROUND(
                          (
                          SELECT
                            COUNT(*)
                          FROM
                            `produkty`
                          WHERE
                            status = 1 AND machineId LIKE ? AND timestamp BETWEEN ? AND ?
                          ) /(
                          SELECT
                            COUNT(*)
                          FROM
                            produkty
                          WHERE
                            status IN (1, 2, 3) AND machineId LIKE ? AND timestamp BETWEEN ? AND ?
                          ),2) AS quality;"; //* zapytanie zlicza dobre, złe i anulowane produkty

  $sqlGetAvailability = "SELECT
                          ROUND((SELECT (COUNT(*) * 20) / 3600 FROM machine_status
                          WHERE isOn = 1 
                            AND machineId LIKE ?
                            AND timestamp BETWEEN ? AND ?) 
                          /
                          (SELECT (COUNT(*) * 20) / 3600 FROM machine_status
                          WHERE machineId LIKE ?
                            AND timestamp BETWEEN ? AND ?),2) AS availability;";

  $sqlGetEffectiveness = "SELECT
                            ROUND(
                                AVG(COALESCE(scale, 0)) / 100,
                                2
                            ) AS effectiveness
                          FROM
                            produkty
                          WHERE
                            machineId LIKE ?
                            AND timestamp BETWEEN ? AND ?";

  $sqlGetProductStatus="SELECT
                          SUM(OK), SUM(NOK), SUM(ANULOWANY)
                        FROM(
                          SELECT
                            CASE WHEN status = 1 THEN 1 ELSE 0 END AS OK,
                            CASE WHEN status = 2 THEN 1 ELSE 0 END AS NOK,
                            CASE WHEN status = 3 THEN 1 ELSE 0 END AS ANULOWANY    
                          FROM 
                            produkty
                          WHERE
                            machineId LIKE ?
                            AND timestamp BETWEEN ? AND ?
                        ) a;";
  
  
  $sqlGetDataForLinearChart = "SELECT
                                date,
                                ROUND(AVG(quality) * 100,2) AS quality,
                                ROUND(quality * AVG(availability), 2) * 100 AS OEE
                               FROM
                                daily_data
                               GROUP BY
                                date;"; //* zapytanie oblicza wskaźnik OEE

  $sqlGetMachines = "SELECT 
                      machineId
                     FROM 
                      maszyny";
  
  $sqlGetAlerts = "SELECT
                    machineId,
                    message,
                    code,
                    timestamp
                   FROM
                    `alarmy`
                   WHERE
                    machineId LIKE ? AND timestamp BETWEEN ? AND ?";

$sqlGetEvents = "SELECT
                    machineId,
                    message,
                    code,
                    timestamp
                   FROM
                    `events`
                   WHERE
                    machineId LIKE ? AND timestamp BETWEEN ? AND ?";