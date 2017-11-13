public class BarChart extends Chart{
  public Point[] pData;
  private float maxXLabelWidth, maxYLabelWidth;
  private String xLabel, yLabel;
  private float xMin, xMax, yMin, yMax;

  public BarChart(Data data, int chartX, int chartY, int chartWidth, int chartHeight){
    super(data, chartX, chartY, chartWidth, chartHeight);
    this.name = "BarChart";
    this.data = data;
    this.pData = new Point [data.size()];
    for (int i = 0; i < data.size(); i++) {
      this.pData[i] = new Point(data.get(i).isMarked(), data.get(i).getValue());
    }
    
    yMin = 0.0;
    yMax = 1.0;
    
    float tempYVal;
    
    for (int index = 0; index < data.size(); index++) {
      tempYVal = (float) pData[index].y;
      yMin = min(tempYVal, yMin);
      yMax = max(tempYVal, yMax);
    }
  }
  void drawData(float ratio, float chartX, float chartY, float yZero, float elementWidth, float padding) {
    for (int index = 0; index < pData.length; index++) {
      float elementHeight = (float )pData[index].y * ratio;
      float startX = chartX + (padding * (index + 1)) + (elementWidth * index);
      pData[index].setDims(startX, chartY + yZero - elementHeight, elementWidth, elementHeight);
      pData[index].drawBar();
    }
  }
  public void render(int x, int y, int w, int h) {
    float xLabelWidth = min(h/4, maxXLabelWidth);
    float yLabelWidth = min(w/4, maxYLabelWidth);
    float chartX = x + yLabelWidth;
    float chartY = y;
    float chartWidth = w - yLabelWidth;
    float chartHeight = h - xLabelWidth;
    fill(255);
    rect(x, y, w, h);
    // Print the rect for the chart outline
    rect(chartX, chartY, chartWidth, chartHeight);
        
    float range = yMax-yMin;
    float ratio = chartHeight/range;
    float yZero = yMax * ratio;
    line(chartX, chartY+yZero, chartX + chartWidth, chartY + yZero);
    
    // Print the individual tick marks on the x axis    
    float elementToPaddingRatio = 3;
    float elementWidth = chartWidth / pData.length;
    float padding = 0;
    do {
      padding = elementWidth / (elementToPaddingRatio + 1);
      elementWidth = (chartWidth - (padding * (pData.length + 1))) / pData.length; // add 1 in order to add spacing on each side of the bars
    } while (elementWidth/padding >= elementToPaddingRatio);  
    
    drawData(ratio, chartX, chartY, yZero, elementWidth, padding);
  }

  @Override
  public void draw(){
    this.render(this.viewX, this.viewY, this.viewWidth, this.viewHeight);
  }

}


public class Point {
  
  public Object x;
  public Object y;
  private float xCoord, yCoord, w, h;
 
  Point(Object xVal, Object yVal) {
    x = xVal;
    y = yVal;
  }
  
  public float x() {
    return xCoord + (w/2);
  }
  
  public float y() {
    return yCoord;
  }
  
  void drawBar() {
      fill(255);
      stroke(0);
      rect(xCoord, yCoord, w, h);
      if ((boolean) this.x) {
        fill(0);
        ellipse(xCoord + (w/2), yCoord + (h / 2), 10, 10);
      }
  }
  
  void drawPoint() {
      fill(123, 48, 99);;
      ellipse(xCoord + w/2, yCoord, 10, 10);
  }
  
  void setDims(float X, float Y, float Width, float Height) {
    xCoord = X;
    yCoord = Y;
    w = Width;
    h = Height;
  }
  
  boolean hoverOver(){
    return ((mouseX > xCoord) && (mouseX < xCoord + w) && (mouseY > yCoord) && (mouseY < yCoord + h));
  }

}