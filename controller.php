<?php


  require 'dbconfig.php'; //* dane do połączenia z bazą
  include "debug.php";


  $conn = new mysqli($host,$user,$password,$database);

  if($conn->connect_error){
    echo "Błąd połączenia z bazą.";
  }else{
    $sqlQueryGetOEEparams = "SELECT avg(quality), avg(availability), avg(effectiveness) FROM daily_data"; //* zapydanie obliczające średnią wartość dla wszystkich wskaźników OEE
    $sqlGetQuality = "SELECT SUM(OK), SUM(NOK), SUM(ANULOWANY) FROM( SELECT CASE WHEN status = 1 THEN 1 ELSE 0 END AS OK, CASE WHEN status = 2 THEN 1 ELSE 0 END AS NOK, CASE WHEN status = 3 THEN 1 ELSE 0 END AS ANULOWANY FROM produkty) a"; //* zapytanie zlicza dobre, złe i anulowane produkty
    $sqlGetDataForLinearChart = "SELECT date, ROUND(quality * 100,2) AS quality , ROUND(quality * availability,2) * 100 as OEE FROM daily_data WHERE machine_id="."'1103_05_UA';"; //* zapytanie oblicza wskaźnik OEE
    $sqlGetMachines = "SELECT machineId FROM maszyny";

    $resultArray = $conn->query($sqlQueryGetOEEparams)->fetch_all();

    
    $resultQuality = $conn->query($sqlGetQuality)->fetch_all();

    $resultMachines = $conn->query($sqlGetMachines);

    $result = $conn->query($sqlGetDataForLinearChart);


    if($resultMachines){
      while($row = $resultMachines->fetch_assoc()){
        $columnMachine[] = $row["machineId"];
      }
    }
    
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $columnData[] = $row['date'];
            $columnOEE[] = $row['OEE'];
            $columnQuality[] = $row['quality'];
        }
      }
      
    

    $conn->close();
  }