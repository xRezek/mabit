<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <title>Mabit</title>
</head>
<body>
  <div class="container-fluid">
    <div class="row mt-2 mx-4">
      <div class="col-md-6" >
        <div class="row">
          <div id="oeeIndicator"  class="col-md-3"></div>
          <div id="qualityIndicator"  class="col-md-3"></div>
          <div id="effectivenessIndicator"  class="col-md-3"></div>
          <div id="availabilityIndicator"  class="col-md-3"></div>
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
          
        </div>
      </div>
    </div>
  </div>


















  <script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="index.js"></script>
</body>
</html>