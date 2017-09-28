public abstract class Chart {
  
  public Point[] data;
  private float maxXLabelWidth, maxYLabelWidth;
  private String xLabel, yLabel;
  private float xMin, xMax, yMin, yMax;
  
  Chart(Point[] dataInput, String xText, String yText) {

    // TODO: make sure that the "data" "y value" is a number
    data = dataInput;
    xLabel = xText;
    yLabel = yText;
    
    maxXLabelWidth = this.calculateXLabelWidth();
    maxYLabelWidth = this.calculateYLabelWidth();
    
    yMin = 0.0;
    yMax = 1.0;
    
    float tempYVal;
    
    for (int index = 0; index < data.length; index++) {
      tempYVal = Float.parseFloat((String)data[index].y);
      yMin = min(tempYVal, yMin);
      yMax = max(tempYVal, yMax);
    }
    
    /* float[] xLabelsLen = new float[data.length];
    for (int x = 0; x < data.length; x++) {
      xLabelsLen[x] = textWidth(data[x].x);
    }
    
    maxXLabelWidth = max(xLabelsLen);
        
    for (int x = 0; x < data.length; x++) {
      if (maxXLabelWidth != null) {
        
      } else {
        maxXLabelWidth = 
      }
    } */
  }
  
  protected abstract float calculateXLabelWidth();
  protected abstract float calculateYLabelWidth();
  protected abstract void drawData(float ratio, float chartX, float chartY, 
                                   float yZero, float elementWidth, float padding);
  
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
    //println(yMin, yMax, range, chartHeight, ratio, yZero);
    line(chartX, chartY+yZero, chartX + chartWidth, chartY + yZero);
    
    // Print the individual tick marks on the x axis    
    float elementToPaddingRatio = 3;
    float elementWidth = chartWidth / data.length;
    float padding = 0;
    do {
      padding = elementWidth / (elementToPaddingRatio + 1);
      elementWidth = (chartWidth - (padding * (data.length + 1))) / data.length; // add 1 in order to add spacing on each side of the bars
    } while (elementWidth/padding >= elementToPaddingRatio);  
    
    drawData(ratio, chartX, chartY, yZero, elementWidth, padding); //<>//
    
    pushMatrix();
    textSize(15);
    float xtw = textWidth(xLabel) + 1;
    float ytw = textWidth(yLabel) + 1;
    fill(0, 0, 0);
    textAlign(CENTER, CENTER);
    text(xLabel, w/2 - (xtw/2), y+h-20, xtw, 20);
    translate(x + 10, y + (h/2));
    rotate(PI/2.0);
    text(yLabel, -ytw/2, -10, ytw, 20);
    popMatrix();
    
  }
  
}