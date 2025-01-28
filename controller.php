<?php

  require 'dbconfig.php';
  include "debug.php";


  $conn = new mysqli($host,$user,$password,$database);

  if($conn->connect_error){
    echo "Błąd połączenia z bazą.";
  }else{
    $sqlQueryGetOEEparams = "SELECT avg(quality), avg(availability), avg(effectiveness) FROM daily_data";
    $sqlGetQuality = "SELECT SUM(OK), SUM(NOK), SUM(ANULOWANY) FROM( SELECT CASE WHEN status = 1 THEN 1 ELSE 0 END AS OK, CASE WHEN status = 2 THEN 1 ELSE 0 END AS NOK, CASE WHEN status = 3 THEN 1 ELSE 0 END AS ANULOWANY FROM produkty) a";
    $getDataForLinearChart = "SELECT date, quality, ROUND(quality * availability,2) * 100 as OEE FROM daily_data";

    $resultArray = $conn->query($sqlQueryGetOEEparams)->fetch_all();

    
    $resultQuality = $conn->query($sqlGetQuality)->fetch_all();

    $result = $conn->query($getDataForLinearChart);
    
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $columnData[] = $row['date'];
            $columnOEE[] = $row['OEE'];
            $columnQuality[] = $row['quality'];
        }
      }
        

    $conn->close();
  }