static float BAR_TO_POINT = 0.5;
static float FULL_LINES = 0.7;
static float COMPLETE_LINES = 1; 


// sample array of bars

class BarToLine {
  float xOrigin, yOrigin;
  float xCoord, yCoord;
  BarPoint [] barPoints;
  Line [] lines;
  int dataSize;
  float [] data;
 
 //HashMap<String, String []> data this is an argument
  public BarToLine(float [] data){
    this.data = data;
    dataSize = data.length;
    barPoints = new BarPoint[dataSize];
    lines = new Line[dataSize];
    this.xOrigin = MARGIN;
    this.yOrigin = height - MARGIN;
    this.xCoord = width - MARGIN;
    this.yCoord = MARGIN;
    
    makeBars();
  }
  
  void makeBars() {
    // determine bar width
    float barSpace = (xCoord - xOrigin)/dataSize;
    float space = barSpace * SPACE;
    float bar = barSpace - space;
    
    // determine bar height
    float greatestValue = 0;
    for (int i = 0; i < dataSize; i ++) {
      if (data[i] > greatestValue) {
        greatestValue= data[i];
      }
    }
    float ratio = (yCoord - yOrigin) / greatestValue;
    
    // make bars
    float start = xOrigin + space;
    // start at one because we don't care about the label
    for (int i = 0; i < dataSize; i++) {
      float barHeight = data[i]  * ratio;
      barPoints[i] = new BarPoint(start, (yOrigin + barHeight), bar, -barHeight, GLOBAL_SCALE * BAR_TO_POINT);
      start += barSpace;
    }
  }
  
  void makeLines() {
    for (int i = 0; i < dataSize; i++) {
      if (i == 0) {
       lines[i] = new Line(MARGIN, height - MARGIN, barPoints[i].currX, barPoints[i].currY);
      } else {
        lines[i] = new Line(barPoints[i - 1].currX, barPoints[i - 1].currY, barPoints[i].currX, barPoints[i].currY);
      }  
    }
  }
  

  void renderAt(float counter){
    // some axes
    line(xOrigin, yOrigin, xOrigin, yCoord);
    line(xOrigin, yOrigin, xCoord, yOrigin);
    
    for (int i = 0; i < dataSize; i++) {
      barPoints[i].renderAt(counter);
    }
   
   
   makeLines();
   //if (counter >= (GLOBAL_SCALE * BAR_TO_POINT)) {
   //  for (int i = 0; i < dataSize - 1; i++) {
   //    lines[i].renderComplete();
   //  }
   //}
   
   if (counter >= (GLOBAL_SCALE * FULL_LINES)) {
     for (int i = 0; i < dataSize; i++) {
       lines[i].renderRetract();
     }
   }
  }
}