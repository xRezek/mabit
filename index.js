const oeeParams = document.querySelectorAll(".oeeParams");
const oeeValues = Array.from(oeeParams).map(element => parseFloat(element.value));

const qualityParams = document.querySelectorAll(".qualityParams");
const qualityValues = Array.from(qualityParams).map(element => parseFloat(element.value));

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
    title: 'Wskaźniki OEE i jakości z wszystkich maszyn w czasie',
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
    margin: { t: 60, r: 60, b: 30, l: 40 },
    height: 390,
    width: 700
  };

  const config = { responsive: true }; 
  Plotly.newPlot(id, [oeeTrace, qualityTrace], layout, config); 
}

function createPieChart(id, goodProducts, badProducts, canceledProducts) {
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
    height: 450,
    width: 700,
    margin: { t: 40, r: 70, b: 40, l: 70 }
  };

  const config = { responsive: true }; 
  Plotly.newPlot(id, data, layout, config);
}



createIndicator("oeeIndicator", Math.round(oeeValues[0] * oeeValues[1] * oeeValues[2] * 100), "OEE");
createIndicator("qualityIndicator", parseInt(oeeValues[0] * 100), "Jakość");
createIndicator("availabilityIndicator", parseInt(oeeValues[1] * 100), "Dostępność");

if(oeeValues[2] === 1){
  createIndicator("effectivenessIndicator", null, "Wydajność");
}else{
  createIndicator("effectivenessIndicator", parseInt(oeeValues[2] * 100), "Wydajność");
}





const xData = xAxisDate;
const yDataOEE = yAxisOEE;
const yQualityData = yAxisQuality;


createOeeLineChart('oeeLineChart', xData, yDataOEE, yQualityData);


const goodProducts = qualityValues[0]; 
const badProducts = qualityValues[1];  
const canceledProducts = qualityValues[2]; 

createPieChart('productStatusChart', goodProducts, badProducts, canceledProducts);