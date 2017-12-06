let container = document.getElementById("container");

const svgns = "http://www.w3.org/2000/svg";

let svg = document.createElementNS(svgns, "svg");
svg.setAttribute("width", window.innerWidth);
svg.setAttribute("height", 500);
container.appendChild(svg);

let chart = document.createElementNS(svgns, "g");
chart.setAttribute("id", "block-chart");
svg.appendChild(chart);




