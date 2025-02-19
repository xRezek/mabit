<?php
  require_once "controller.php";
  include_once "offcanvas.php";
?>
<!DOCTYPE html>
<html lang="pl-PL">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <link rel="stylesheet" href="style.css">
  <title>Mabit</title>
</head>
<body>
  <div id="columnData" data-json="<?= isset($columnDate) ? htmlspecialchars(json_encode($columnDate, JSON_HEX_APOS), ENT_QUOTES, 'UTF-8') : ''; ?>" style="display:none"></div>
  <div id="columnOEE" data-json="<?= isset($columnOEE) ? htmlspecialchars(json_encode($columnOEE, JSON_HEX_APOS), ENT_QUOTES, 'UTF-8') : ''; ?>" style="display:none"></div>
  <div id="columnQuality" data-json="<?= isset($columnQuality) ? htmlspecialchars(json_encode($columnQuality, JSON_HEX_APOS), ENT_QUOTES, 'UTF-8') : ''; ?>" style="display:none"></div>
  <input type="hidden" class="oeeParams" value="<?= isset($resultGetQuality[0]) ? htmlspecialchars($resultGetQuality[0], ENT_QUOTES, 'UTF-8') : '' ?>">
  <input type="hidden" class="oeeParams" value="<?= isset($resultGetAvailability[0]) ? htmlspecialchars($resultGetAvailability[0], ENT_QUOTES, 'UTF-8') : '' ?>">
  <input type="hidden" class="oeeParams" value="<?= isset($resultGetEffectiveness[0]) ? htmlspecialchars($resultGetEffectiveness[0], ENT_QUOTES, 'UTF-8') : '' ?>">
  <input type="hidden" class="qualityParams" value="<?= isset($resultGetProductStatus[0]) ? htmlspecialchars($resultGetProductStatus[0], ENT_QUOTES, 'UTF-8') : '' ?>">
  <input type="hidden" class="qualityParams" value="<?= isset($resultGetProductStatus[1]) ? htmlspecialchars($resultGetProductStatus[1], ENT_QUOTES, 'UTF-8') : '' ?>">
  <input type="hidden" class="qualityParams" value="<?= isset($resultGetProductStatus[2]) ? htmlspecialchars($resultGetProductStatus[2], ENT_QUOTES, 'UTF-8') : '' ?>">
  <nav class="navbar navbar-expand-lg nav-bg-color">
    <div class="container-fluid justify-content-center">
      <a class="navbar-brand" href="#">Mabit</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
        <form class="d-flex">
          <select class="form-select me-3" name="machine">
            <option value="%%" selected>Wszystkie</option>
            <?php
              $columnMachineCount = count($columnMachine);
              $option = $machine;
              foreach ($columnMachine as $option) {
                $option = htmlspecialchars($option, ENT_QUOTES, 'UTF-8');
                $selected = isset($get) && isset($get['machine']) && $get['machine'] === $option ? 'selected' : '';
                echo "<option value='$option' $selected>$option</option>";
              }
            ?>
          </select>
          <label for="dateFrom" class="me-2 align-self-center">Od:</label>
          <input type="datetime-local" id="dateFrom" class="form-control me-2" name="dateFrom" value="<?php if(isset($get['dateFrom'])){
            echo  htmlspecialchars($get['dateFrom'],ENT_QUOTES,'UTF-8');
          }else{
            echo  htmlspecialchars(date("Y-m-d\TH:i", strtotime('-24 hours')),ENT_QUOTES,'UTF-8');
          }?>">            
          <label for="dateTo" class="me-2 align-self-center">Do:</label>
          <input type="datetime-local" id="dateTo" class="form-control" name="dateTo" value="<?php if(isset($get['dateTo'])){
            echo  htmlspecialchars($get['dateTo'],ENT_QUOTES,'UTF-8');
          }else{
            echo  htmlspecialchars(date("Y-m-d\TH:i"),ENT_QUOTES,'UTF-8');
          }?>">
          <label class="text-nowrap mx-2 align-self-center custom-checkbox" for="skipEffectiveness">Pomiń wydajność</label>
            <input class="custom-checkbox" type="checkbox" name="skipEffectiveness" id="skipEffectiveness" <?php
             if(isset($skipEffectiveness) && $skipEffectiveness === "on")
              echo "checked";            
            ?>>
          
          <button class="btn btn-outline-dark ms-3" type="submit">Filtruj</button>
        </form>
        <div class="vr ms-3"></div>
        <button class="btn btn-outline-dark ms-3" type="button" data-bs-toggle="offcanvas" data-bs-target="#staticBackdrop">
          Alerty i eventy
        </button>
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
          <div class="col mt-5 ms-3">
            <p class="h3">Historia</p>
            <table class="table table-border table-striped text-center">
              <thead>
                <tr>
                  <th scope="col" class="custom-header">Maszyna</th>
                  <th scope="col" class="custom-header">Status</th>
                  <th scope="col" class="custom-header">Program</th>
                  <th scope="col" class="custom-header">Czas cyklu</th>
                  <th scope="col" class="custom-header">Skala</th>
                  <th scope="col" class="custom-header">Znacznik czasowy</th>
                </tr>
              </thead>
              <tbody>
                <?php
                  if($machine === "%%"){
                    echo "<tr><td colspan='6'>Wybierz konkretną maszynę aby zobaczyć historię</td></tr>";
                  }
                  elseif($resultGetHistory->num_rows === 0){
                    echo "<tr><td colspan='6'>Brak danych</td></tr>";
                  }
                  else{
                    while($row = $resultGetHistory->fetch_row()){
                      echo "
                            <tr>
                              <td>$row[0]</td>
                              <td>$row[1]</td>
                              <td>$row[2]</td>
                              <td>$row[3]s</td>
                              <td>$row[4]</td>
                              <td>$row[5]</td>
                            </tr>
                          ";
                    }
                  }
                ?>
              </tbody>
            </table>
            <?php if($totalPages > 1 and $machine !== "%%"):?>
            <nav class =" mt-4">
              <ul class="pagination justify-content-center">
                <?php
                  for($i = 1; $i <= $totalPages; $i++){
                    $active = $i == $page ? 'active' : '';
                    $skipEffectivenessPagination = isset($get['skipEffectiveness']) ? "&skipEffectiveness=on" : "";
                    echo "<li class='page-item'><a class='page-link pagination-item $active' href='?machine=$machine&dateFrom=$dateFrom&dateTo=$dateTo" . "$skipEffectivenessPagination&page=$i'>$i</a></li>";
                  }
                ?>
              </ul>
            </nav> 
            <?php endif;?>
          </div>
        </div>
      </div>
      <div class="col-1"></div>
      <div class="col-md-5">
        <div class="row">
          <div id="productStatusChart" class="col"></div>
        </div>
        <div class="row">
          <div id="oeeLineChart" class="col"></div>
        </div>
      </div>
    </div>
  </div>


  <script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8" defer></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="index.js" defer></script>
</body>
</html>