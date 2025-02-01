<?php

  require 'dbconfig.php'; //* dane do połączenia z bazą
  require 'sqlQueries.php'; //* plik z zapytaniami sql
  
  include "debug.php";


  $get = $_GET;

  $machine = $get['machine'] ?? "%%";
  $dateFrom = $get['dateFrom'] ?? NULL;
  $dateTo = $get['dateTo'] ?? NULL;



  $conn = new mysqli($host,$user,$password,$database);

  if($conn->connect_error){
    echo "Błąd połączenia z bazą.";
  }else{
    

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