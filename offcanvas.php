<div class="offcanvas offcanvas-end offcanvas-custom-width" data-bs-backdrop="static" tabindex="-1" id="staticBackdrop" aria-labelledby="staticBackdropLabel">
  <div class="offcanvas-header">
    <p class="offcanvas-title h5" id="staticBackdropLabel">Alerty i eventy</p>
    <hr class="text-secondary">
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
    <div class ="container-fluid">
      <div class="row">
        <div class="col">
          <p class="h6">Alerty</p>
          <table class="table table-border table-striped text-center">
            <thead >
              <tr>
                <th scope="col" class="custom-header">Maszyna</th>
                <th scope="col" class="custom-header">Treść komunikatu</th>
                <th scope="col" class="custom-header">Kod</th>
                <th scope="col" class="custom-header">Czas wystąpienia</th>
              </tr>
            </thead>
            <tbody>
              <?php
                while($row = $resultGetAlerts->fetch_row()){
                  echo "
                        <tr>
                          <td>$row[0]</td>
                          <td>$row[1]</td>
                          <td>$row[2]</td>
                          <td>$row[3]</td>
                        </tr>
                      ";
                }
              ?>
            </tbody>
          </table>
        </div>
        <div class="col">
        <p class="h6">Eventy</p>
          <table class="table table-border table-striped text-center">
            <thead>
              <tr>
                <th scope="col" class="custom-header">Maszyna</th>
                <th scope="col" class="custom-header">Treść komunikatu</th>
                <th scope="col" class="custom-header">Kod</th>
                <th scope="col" class="custom-header">Czas wystąpienia</th>
              </tr>
            </thead>
            <tbody>
              <?php
                while($row = $resultGetEvents->fetch_row()){
                  echo "
                        <tr>
                          <td>$row[0]</td>
                          <td>$row[1]</td>
                          <td>$row[2]</td>
                          <td>$row[3]</td>
                        </tr>
                      ";
                }
              ?>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>