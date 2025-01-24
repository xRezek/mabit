function createIndicator(id, value, title) {
  // Ustalenie koloru paska na podstawie wartości
  let barColor;
  if (value <= 20) {
    barColor = "red";
  } else if (value <= 40) {
    barColor = "orange";
  } else if (value <= 70) {
    barColor = "#FFE45E";
  } else if (value <= 90) {
    barColor = "green";
  } else {
    barColor = "blue";
  }

  const data = [{
    type: "indicator",
    mode: "gauge+number",
    value: value, // Wartość wskaźnika
    title: { text: title, font: { size: 16 } },
    gauge: {
      axis: { range: [0, 100] }, // Zakres wskaźnika
      bar: { color: barColor }, // Pasek zmieniający kolor
    },
    domain: { x: [0, 1], y: [0, 1] }
  }];

  const layout = {
    height: 200,
    margin: { t: 40, r: 40, b: 10, l: 40 }
  };

  const config = { responsive: true }; // Responsywność
  Plotly.newPlot(id, data, layout, config);
}


function createOeeLineChart(id, xData, oeeData, qualityData) {
  const oeeTrace = {
    x: xData,
    y: oeeData,
    name: 'OEE',
    mode: 'lines+markers',
    line: { color: 'blue', width: 2 },
    marker: { size: 8 }
  };

  // Ślad dla wskaźnika jakości
  const qualityTrace = {
    x: xData,
    y: qualityData,
    name: 'Jakość',
    mode: 'lines+markers',
    line: { color: 'green', width: 2 },
    marker: { size: 8 }
  };

  const layout = {
    title: 'Wskaźniki OEE i jakości w czasie',
    xaxis: {
      title: 'Czas',
      showgrid: true,
      zeroline: false
    },
    yaxis: {
      title: 'Wartość (%)',
      range: [0, 100],
      showline: true
    },
    margin: { t: 40, r: 20, b: 40, l: 50 },
    height: 600,
    width: 900
  };

  const config = { responsive: true }; // Responsywność
  Plotly.newPlot(id, [oeeTrace, qualityTrace], layout, config); // Dodanie obu serii danych
}

function createDonutChart(id, goodProducts, badProducts, canceledProducts) {
  // Dane do wykresu
  const data = [{
    type: 'pie',
    values: [goodProducts, badProducts, canceledProducts],
    labels: ['Dobre', 'Niedobre', 'Anulowane'],
    textinfo: 'label+percent', // Wyświetla etykiety i procenty
    marker: {
      colors: ['#28a745', '#dc3545', '#ffc107'] // Kolory dla sekcji
    }
  }];

  // Układ wykresu
  const layout = {
    title: 'Status wyrobów',
    height: 600,
    width: 600,
    margin: { t: 40, r: 70, b: 40, l: 70 }
  };

  const config = { responsive: true }; // Responsywność
  Plotly.newPlot(id, data, layout, config);
}


// Tworzenie wskaźników
createIndicator("oeeIndicator", 92, "OEE", "blue");
createIndicator("qualityIndicator", 85, "Jakość", "green");
createIndicator("availabilityIndicator", 10, "Dostępność", "orange");
createIndicator("effectivenessIndicator", 40, "Wydajność", "red");




// Tworzenie wykresu liniowego OEE
const xData = ['2025-01-01', '2025-01-02', '2025-01-03', '2025-01-04', '2025-01-05', '2025-01-06', '2025-01-07', '2025-01-08'];
const yData = [75, 80, 85, 78, 43, 57, 98, 75];
const qualityData = [82, 88, 90, 84, 67, 42, 83, 83]; 
createOeeLineChart('oeeLineChart', xData, yData, qualityData);


// Dane wejściowe
const goodProducts = 120; // Liczba wyrobów dobrych
const badProducts = 30;  // Liczba wyrobów niedobrych
const canceledProducts = 20; // Liczba wyrobów anulowanych

// Tworzenie wykresu donutowego
createDonutChart('productStatusChart', goodProducts, badProducts, canceledProducts);

