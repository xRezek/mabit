function createIndicator(id, value, title, color) {
  const data = [{
    type: "indicator",
    mode: "gauge+number",
    value: value,
    title: { text: title, font: { size: 16, } },
    gauge: {
      axis: { range: [0, 100] },
      bar: { color: color },
    },
    domain: { x: [0, 1], y: [0, 1] }
  }];

  const layout = {
    width: 290,
    height: 200,

    margin: { t: 30, r: 70, b: 20, l: 70 },
  };

  Plotly.newPlot(id, data, layout);
}

// Tworzenie wskaźników
createIndicator("oeeIndicator", 70, "OEE", "blue");
createIndicator("qualityIndicator", 85, "Quality", "green");
createIndicator("availabilityIndicator", 60, "Availability", "orange");
createIndicator("effectivenessIndicator", 90, "Effectiveness", "red");