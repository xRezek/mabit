<?php
  include "controller.php";
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <link rel="stylesheet" href="style.css">
  <title>Mabit</title>
</head>
<body>
  <div id="columnData" data-json=<?= json_encode($columnData, JSON_HEX_APOS); ?> style="display:none"></div>
  <div id="columnOEE" data-json=<?= json_encode($columnOEE, JSON_HEX_APOS); ?> style="display:none"></div>
  <div id="columnQuality" data-json=<?= json_encode($columnQuality, JSON_HEX_APOS); ?> style="display:none"></div>
  <input type="hidden" class="oeeParams" value="<?= $resultArray[0][0]?>">
  <input type="hidden" class="oeeParams" value="<?= $resultArray[0][1]?>">
  <input type="hidden" class="oeeParams" value="<?= $resultArray[0][2]?>">
  <input type="hidden" class="qualityParams" value="<?= $resultQuality[0][0]?>">
  <input type="hidden" class="qualityParams" value="<?= $resultQuality[0][1]?>">
  <input type="hidden" class="qualityParams" value="<?= $resultQuality[0][2]?>">
  <nav class="navbar navbar-expand-lg nav-bg-color">
    <div class="container-fluid justify-content-center">
      <a class="navbar-brand" href="#">Mabit</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
        <form class="d-flex">
          <select class="form-select me-3" name="machine">
            <option value="---" selected>Wszystkie</option>
            <?php
              for($i = 0; $i<count($columnMachine); $i++)
                echo "<option value=$columnMachine[$i]>$columnMachine[$i]</option>";
            ?>
          </select>
          <label for="dateFrom" class="me-2 align-self-center">Od:</label>
          <input type="datetime-local" id="dateFrom" class="form-control me-2" name="dateFrom">            
          <label for="dateTo" class="me-2 align-self-center">Do:</label>
          <input type="datetime-local" id="dateTo" class="form-control" name="dateTo">
          <button class="btn btn-outline-dark ms-3" type="submit">Filtruj</button>
        </form>
      </div>
    </div>
  </nav>
  <div class="container-fluid">
    <div class="row mt-2 mx-4">
      <div class="col-md-6" >
        <div class="row">
          <div id="oeeIndicator"  class="col-md-3"></div>
          <div id="qualityIndicator"  class="col-md-3"></div>
          <div id="availabilityIndicator"  class="col-md-3"></div>
          <div id="effectivenessIndicator"  class="col-md-3"></div>
        </div>
        <div class="row">
          <div id="oeeLineChart" class="col"></div>
        </div>
      </div>
      <div class="col-1"></div>
      <div class="col-md-5">
        <div class="row">
          <div id="productStatusChart" class="col"></div>
        </div>
        <div class="row">
          <!-- <div id="productHorizontalBarChart"></div> -->
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="index.js"></script>
</body>
</html>