const oeeParams = document.querySelectorAll(".oeeParams");
const oeeValues = Array.from(oeeParams).map(element => element.value);

const qualityParams = document.querySelectorAll(".qualityParams");
const qualityValues = Array.from(qualityParams).map(element => parseInt(element.value));

const xAxisDate = JSON.parse(document.getElementById('columnData').dataset.json);
const yAxisOEE = JSON.parse(document.getElementById('columnOEE').dataset.json);
const yAxisQuality = JSON.parse(document.getElementById('columnQuality').dataset.json);


function createIndicator(id, value, title) {
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
    value: value,
    title: { text: title, font: { size: 16 } },
    gauge: {
      axis: { range: [0, 100] }, 
      bar: { color: barColor },
    },
    domain: { x: [0, 1], y: [0, 1] }
  }];

  const layout = {
    height: 200,
    margin: { t: 40, r: 40, b: 10, l: 40 }
  };

  const config = { responsive: true };
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
      title: 'Data',
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

  const config = { responsive: true }; 
  Plotly.newPlot(id, [oeeTrace, qualityTrace], layout, config); 
}

function createDonutChart(id, goodProducts, badProducts, canceledProducts) {
  // Dane do wykresu
  const data = [{
    type: 'pie',
    values: [goodProducts, badProducts, canceledProducts],
    labels: ['Dobre', 'Niedobre', 'Anulowane'],
    textinfo: 'label+percent', 
    marker: {
      colors: ['#28a745', '#dc3545', '#ffc107']
    }
  }];

  // Układ wykresu
  const layout = {
    title: 'Status wyrobów',
    height: 600,
    width: 600,
    margin: { t: 40, r: 70, b: 40, l: 70 }
  };

  const config = { responsive: true }; 
  Plotly.newPlot(id, data, layout, config);
}

function createHorizontalBarChart(id, labels, values, colors) {
  const data = [{
    type: 'bar',
    x: values, 
    y: labels,
    orientation: 'h',
    marker: { color: colors },
    text: values.map(String),
    textposition: 'auto'
  }];

  const layout = {
    title: 'Horyzontalny Bar Chart',
    xaxis: { title: 'Wartość' },
    yaxis: { title: 'Kategorie' },
    margin: { t: 40, r: 20, b: 40, l: 100 }, // Większy lewy margines dla długich etykiet
    height: 400,
    width: 600,
    paper_bgcolor: 'lightgray', // Tło całego wykresu
    plot_bgcolor: 'white' // Tło obszaru danych
  };

  const config = { responsive: true }; // Responsywność
  Plotly.newPlot(id, data, layout, config);
}




createIndicator("oeeIndicator", parseInt(oeeValues[0] * oeeValues[1] * oeeValues[2] * 100), "OEE", "blue");
createIndicator("qualityIndicator", parseInt(oeeValues[0] * 100), "Jakość", "green");
createIndicator("availabilityIndicator", parseInt(oeeValues[1] * 100), "Dostępność", "orange");
createIndicator("effectivenessIndicator", parseInt(oeeValues[2] * 100), "Wydajność", "red");





const xData = xAxisDate;
const yDataOEE = yAxisOEE;
const yQualityData = yAxisQuality;


createOeeLineChart('oeeLineChart', xData, yDataOEE, yQualityData);



const goodProducts = qualityValues[0]; 
const badProducts = qualityValues[1];  
const canceledProducts = qualityValues[2]; 


createDonutChart('productStatusChart', goodProducts, badProducts, canceledProducts);


const labels = ['Produkt A', 'Produkt B', 'Produkt C', 'Produkt D']; // Kategorie oś Y
const values = [120, 80, 150, 60]; // Wartości oś X
const colors = ['blue', 'green', 'red', 'orange']; // Kolory słupków


createHorizontalBarChart('productHorizontalBarChart', labels, values, colors);