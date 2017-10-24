static float MARGIN = 50;
static float SPACE = 0.15;
static float GLOBAL_SCALE = 1000;
static color BACKGROUND_COLOR = #C5FFEB;

BarToLine barToLine;
VbarHbar testVbar;
BarToPie barToPie;

Button barButton  = new Button(200, 570, 50, 20, 255, "BAR");
Button lineButton = new Button(400, 570, 50, 20, 255, "LINE");
Button pieButton  = new Button(600, 570, 50, 20, 255, "PIE");

float temp_width = 25;
float temp_height = 100;
float temp_x = 300;
float temp_y = 400;

String currChart = "TOLINE";

float counter = 0;
float target  = 0;

void setup() {
  size(800, 600);
  surface.setResizable(true);
  
  barToLine = new BarToLine(parseData("data1.csv"));
  barToPie = new BarToPie(parseData("data1.csv"));
  testVbar = new VbarHbar(temp_x, temp_y, temp_width, temp_height, 400, 0.1);
}

void draw() {
  background(BACKGROUND_COLOR);
  if (target != counter) {
    if (target == 1000) {
      counter++;
    } else {
      counter--;
    }
  }
  if (currChart == "TOLINE") {
    barToLine.renderAt(counter);
    if (target == 1000) {
      pieButton.setColor(100);
    } else {
      pieButton.setColor(255);
    }
  } else if (currChart == "TOPIE") {
    barToPie.render();
    if (target == 1000) {
      lineButton.setColor(100);
    } else {
      lineButton.setColor(255);
    }
  } 
  
  barButton.render();
  lineButton.render();
  pieButton.render();
}

void mouseClicked(){
  if (barButton.clickedOn()) {
    target = 0;
  } else if (lineButton.clickedOn()) {
    if (currChart == "TOLINE") {
      target = 1000;
    } else if (currChart == "TOPIE" && target == 0) {
      currChart = "TOLINE";
      target = 1000;
    }
  } else if (pieButton.clickedOn()) {
    if (currChart == "TOPIE") {
      target = 1000;
    } else if (currChart == "TOLINE" && target == 0) {
      currChart = "TOPIE";
      target = 1000;
    }
  }
}

float [] parseData(String filename) {
  String [] unparsedData = loadStrings(filename);
  int numRows = unparsedData.length;
  float [] keys = new float [numRows - 1];
  float [] values = new float [numRows - 1];
  
  for (int i = 1; i < numRows; i++) {
    String [] line = unparsedData[i].split(",");
    keys[i - 1] = float(line[0]);
    values[i - 1] = float(line[1]);
  }
  return values;
}