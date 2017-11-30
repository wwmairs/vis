const statistics = {"header": ["Program Description" , "Number"],
                    "values": [{"program": "College of Liberal Arts", "number": 22},
                               {"program": "Graduate Engineering", "number": 7},
                               {"program": "School of Engineering", "number": 8}]};


//ToDo (2): Learn how you access each value.
console.log(statistics);



//ToDo (3): Draw on a sheet of paper what your resulting DOM tree looks like.
let container = document.getElementById("container");

const svgns = "http://www.w3.org/2000/svg";

let svg = document.createElementNS(svgns, "svg");
svg.setAttribute("width", 500);
svg.setAttribute("height", 500);
container.appendChild(svg);

let chart = document.createElementNS(svgns, "g");
chart.setAttribute("id", "pie-chart");
svg.appendChild(chart);


//ToDo (4): Construct the pie chart.
//          If needed, introduce other data structures,
//          variables, etc. for your convenience.


//The below is an example which creates a pie chart consisting of 4 pie slices, but it does not use the given dataset.
let pathDescriptions = ["M250,250 L250,50 A200,200 0 0,1 450,250 z",
                        "M250,250 L450,250 A200,200 0 0,1 250,450 z",
                        "M250,250 L250,450 A200,200 0 0,1 50,250 z",
                        "M250,250 L50,250 A200,200 0 0,1 250,50 z"];
var sum = 0;
for (const value of statistics.values) {
  sum += value.number;
}
var startX = 250;
var startY = 50;
var endX = 0;
var endY = 0;
var startA = 0;
var cx = 250;
var cy = 250;
var r = 200
var largestFlag = 0;
for (var i = 1; i < statistics.values.length - 1; i++) {

  var value = statistics.values[i];
  let path = document.createElementNS(svgns, "path");
  // let's do some radians
  var a = ((value.number / sum) * 360) * Math.PI / 180;
  console.log(a); 
  console.log(r * Math.cos(startA + a));
  console.log(r * Math.sin(startA + a));
  endX = cx + r * Math.cos(startA + a);
  endY = cy - r * Math.sin(startA + a);
  startA += a;
  if (a > Math.PI) {
    largestFlag = 1;
  } else {
    largestFlag = 0;
  }
  // figure out path description
  var description = "M" + cx + "," + cy + " L" + startX + "," + startY + " A" + r + "," + r + " 0 " + largestFlag + ",1 " + endX + "," + endY + " z";
  console.log(description);
  path.setAttribute("d", description);
  path.setAttribute("stroke", "black");
  path.setAttribute("fill", "white");

  path.addEventListener("mouseover", function(event){
    console.log(value.number);
  });

  path.addEventListener("mouseleave", function(event){
    console.log("mouseleave");
  });

  chart.appendChild(path);
  startX = endX;
  startY = endY;
}

// for(const description of pathDescriptions){

//   let path = document.createElementNS(svgns, "path");
//   path.setAttribute("d", description);
//   path.setAttribute("stroke", "black");
//   path.setAttribute("fill", "white");

//   path.addEventListener("mouseover", function(event){
//     console.log("mouseover");
//   });

//   path.addEventListener("mouseleave", function(event){
//     console.log("mouseleave");
//   });

//   chart.appendChild(path);
// }


console.log(container);
