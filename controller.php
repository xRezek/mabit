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
    
    $stmtGetQuality = $conn->prepare($sqlGetQuality);
    $stmtGetQuality->bind_param("ssssss", $machine, $dateFrom, $dateTo, $machine, $dateFrom, $dateTo);
    $stmtGetQuality->execute();
    $resultGetQuality = $stmtGetQuality->get_result()->fetch_row();

    $stmtGetAvailability = $conn->prepare($sqlGetAvailability);
    $stmtGetAvailability->bind_param("ssssss", $machine, $dateFrom, $dateTo, $machine, $dateFrom, $dateTo);
    $stmtGetAvailability->execute();
    $resultGetAvailability = $stmtGetAvailability->get_result()->fetch_row(); 

    $stmtGetEffectiveness = $conn->prepare($sqlGetEffectiveness);
    $stmtGetEffectiveness->bind_param("sss", $machine, $dateFrom, $dateTo);
    $stmtGetEffectiveness->execute();
    $resultGetEffectiveness = $stmtGetEffectiveness->get_result()->fetch_row();


    $stmtGetProductStatus = $conn->prepare($sqlGetProductStatus);
    $stmtGetProductStatus->bind_param("sss", $machine, $dateFrom, $dateTo);
    $stmtGetProductStatus->execute();
    $resultGetProductStatus = $stmtGetProductStatus->get_result()->fetch_row();


    

    $resultMachines = $conn->query($sqlGetMachines);

    $result = $conn->query($sqlGetDataForLinearChart);


    if($resultMachines){
      while($row = $resultMachines->fetch_assoc()){
        $columnMachine[] = $row["machineId"];
      }
    }
    
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $columnDate[] = $row['date'];
            $columnOEE[] = $row['OEE'];
            $columnQuality[] = $row['quality'];
        }
      }
      
    

    $conn->close();
  }

  //todo zebrać dane i przetestować działanie wskaźników