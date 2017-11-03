float CHART_RATIO = 0.9;
float SPACE = 0.15;
color LIGHT = #ffdae0;
color DARK = #ffa7b6;
String x_label = "";
String y_label = "";
static float PADDING = 5;

class LineChart {
  float x_origin, y_origin; 
  float x_coord, y_coord;
  int rows;
  float bar_width;
  String[] names;
  int[] values;
  
  public LineChart(String[] lines,float y, float w, float h) {
    x_origin = PADDING;
    y_origin= y + h - PADDING;
    x_coord = w - PADDING;
    y_coord = y + PADDING;
    //rows = lines.length - 1;
    
    names = new String[rows];
    values = new int[rows];
    
    //for (int i = 0; i < rows; i++) {
      //String[] data = split(lines[i + 1], ",");
      //names[i] = data[0];
      //values[i] = int(data[1]);
    //}
  }
  
  public void display() {
    int x_spacing = (int) (0.05 * width);
    int y_spacing = (int) (0.07 * height);
    float mid_x = x_origin + ((x_coord - x_origin) / 2);
    float mid_y = y_origin - ((y_origin - y_coord) / 2);
    
    fill(#000000);
    line(x_origin, y_origin, x_origin, y_coord); // y axis
    line(x_origin, y_origin, x_coord, y_origin); // x axis
    text(x_label, mid_x, (y_origin + x_spacing));
    text(y_label, (x_origin - y_spacing), mid_y);
  }
  
  public void resize() {
    y_origin = (int) (height * CHART_RATIO);
    x_origin = (int) (width * (1 - CHART_RATIO));
    x_coord = (int) (width * CHART_RATIO);
    y_coord = (int) (height * (1 - CHART_RATIO));
  }
}