static float MARGIN = 20;
static float SPACE = 0.15;
static float GLOBAL_SCALE = 1000;

BarToLine barToLine;
VbarHbar testVbar;
BarToPie barToPie;

float temp_width = 25;
float temp_height = 100;
float temp_x = 300;
float temp_y = 400;

void setup() {
  size(800, 600);
  surface.setResizable(true);
  
  barToLine = new BarToLine(parseData("data1.csv"));
  barToPie = new BarToPie(parseData("data1.csv"));
  testVbar = new VbarHbar(temp_x, temp_y, temp_width, temp_height, 400, 0.1);
}

void draw() {
  background(#C5FFEB);
  //barToLine.render();
  barToPie.render();
  //testVbar.render();
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