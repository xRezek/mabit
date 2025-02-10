<?php

  require_once 'dbconfig.php'; //* dane do połączenia z bazą
  require_once 'sqlQueries.php'; //* plik z zapytaniami sql
  
  include 'debug.php';


  $get = $_GET;

  $machine = $get['machine'] ?? "%%";
  $dateFrom = $get['dateFrom'] ?? date("Y-m-d\TH:i", strtotime('-24 hours'));
  $dateTo = $get['dateTo'] ?? date("Y-m-d\TH:i");
  $skipEffectiveness = $get['skipEffectiveness'] ?? null;

  if($dateFrom > $dateTo){
    $temp = $dateFrom;
    $dateFrom = $dateTo;
    $dateTo = $temp;
  }


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
    

    if($skipEffectiveness === "on"){
      $resultGetEffectiveness[0] = 1;
    }else{
      $stmtGetEffectiveness = $conn->prepare($sqlGetEffectiveness);
      $stmtGetEffectiveness->bind_param("sss", $machine, $dateFrom, $dateTo);
      $stmtGetEffectiveness->execute();
      $resultGetEffectiveness = $stmtGetEffectiveness->get_result()->fetch_row();
      $stmtGetEffectiveness->close();
    }


    $stmtGetProductStatus = $conn->prepare($sqlGetProductStatus);
    $stmtGetProductStatus->bind_param("sss", $machine, $dateFrom, $dateTo);
    $stmtGetProductStatus->execute();
    $resultGetProductStatus = $stmtGetProductStatus->get_result()->fetch_row();
    $stmtGetProductStatus->close();

    $stmtGetAlerts = $conn->prepare($sqlGetAlerts);
    $stmtGetAlerts->bind_param("sss", $machine, $dateFrom, $dateTo);
    $stmtGetAlerts->execute();
    $resultGetAlerts = $stmtGetAlerts->get_result();
    $stmtGetAlerts->close();

    $stmtGetEvents = $conn->prepare($sqlGetEvents);
    $stmtGetEvents->bind_param("sss", $machine, $dateFrom, $dateTo);
    $stmtGetEvents->execute();
    $resultGetEvents = $stmtGetEvents->get_result();
    $stmtGetEvents->close();

    $stmtGetHistory = $conn->prepare($sqlGetHistory);
    $stmtGetHistory->bind_param("sss", $machine, $dateFrom, $dateTo);
    $stmtGetHistory->execute();
    $resultGetHistory = $stmtGetHistory->get_result();
    $stmtGetHistory->close();

    

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