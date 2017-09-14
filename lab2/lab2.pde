public class Point {
  public Object x;
  public Object y;
  
  public Point(Object xVal, Object yVal) {
    x = xVal;
    y = yVal;
  }
}

public class Chart {
  Point[] points;
  int Width;
  int Height;
  String xLabel;
  String yLabel;
  
  // chartWidth and chartHeight are percentage values from 0-100
  // add POINTS back in
  public Chart(int chartWidth, int chartHeight, int xCoord, int yCoord, String xAxis, String yAxis) {
    //points = data;
    Width = chartWidth;
    Height = chartHeight;
    xLabel = xAxis;
    yLabel = yAxis;
    centerX = xCoord;
    centerY = yCoord;
  }
    
  
  public renderBars() {
    rectMode(CENTER);
    rect(centerX, centerY, Width, Height);
    
  }
  
  public renderLines() {
  }
}


chart c;

void setup() {
  size(400,400);
  surface.setResizable(true);
  c = new Chart(width - 20, height - 20, width/2, height/2, "x", "y");
  
}

void draw() {
  c.renderBars();
}