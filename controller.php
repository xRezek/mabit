<?php

  require 'dbconfig.php';
  include "debug.php";


  $conn = new mysqli($host,$user,$password,$database);

  if(!$conn){
    echo "Błąd połączenia z bazą.";
  }else{
    $sqlQueryGetOEEparams = "SELECT avg(quality), avg(availability), avg(effectiveness) FROM daily_data";
    

    $resultArray = $conn->query($sqlQueryGetOEEparams)->fetch_all();


    $conn->close();
  }