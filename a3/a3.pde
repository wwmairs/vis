static float MARGIN = 50;
static float SPACE = 0.15;
static float GLOBAL_SCALE = 1000;
static color BACKGROUND_COLOR = #C5FFEB;

BarToLine barToLine;
BarToPie barToPie;

Button barButton  = new Button(200, 570, 50, 20, 255, "BAR");
Button lineButton = new Button(400, 570, 50, 20, 255, "LINE");
Button pieButton  = new Button(600, 570, 50, 20, 255, "PIE");

float globalCounter;
boolean active;
boolean ascend;

String currChart = "TOLINE";

void setup() {
  size(800, 600);
  surface.setResizable(true);
  
  barToLine = new BarToLine(parseData("data1.csv"));
  barToPie = new BarToPie(parseData("data1.csv"));
  ascend = true;
  active = false;
}

void draw() {
  background(BACKGROUND_COLOR);
  
  if (currChart == "TOLINE" || currChart == "LINETOBAR") {
    barToLine.renderAt(globalCounter);
    if (active) {
      pieButton.setColor(100);
    } else {
      pieButton.setColor(255);
    }
  } else if (currChart == "TOPIE" || currChart == "PIETOBAR") {
    barToPie.render();
    if (active) {
      lineButton.setColor(100);
    } else {
      lineButton.setColor(255);
    }
  } 
  
  if (ascend && globalCounter == GLOBAL_SCALE) {
    ascend = false;
    active = false;
  } else if (!ascend && globalCounter == 0) {
    ascend = true;
    active = false;
  }
  if (ascend && active) {
    globalCounter++;
  } else if (active) {
    globalCounter--;
  }
  
  println(globalCounter);
  
  barButton.render();
  lineButton.render();
  pieButton.render();
}

void mouseClicked(){
  if (barButton.clickedOn() && !active && !ascend) {
    if (currChart == "TOPIE") {
      currChart = "PIETOBAR";
    } else currChart = "LINETOBAR";
    active = true;
  } else if (lineButton.clickedOn() && !active && ascend) {
    currChart = "TOLINE";
    active = true;
  } else if (pieButton.clickedOn() && !active && ascend) {
    barToPie = new BarToPie(parseData("data1.csv"));
    currChart = "TOPIE";
    active = true;
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