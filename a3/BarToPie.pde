//static float BAR_TO_POINT = 0.5;
//static float FULL_LINES = 0.7;
//static float COMPLETE_LINES = 1; 


// sample array of bars

class BarToPie {
  float xOrigin, yOrigin;
  float xCoord, yCoord;
  VbarHbar [] VbarHbars;
  Line [] lines;
  int dataSize;
  float [] data;
  float counter;
 
 //HashMap<String, String []> data this is an argument
  public BarToPie(float [] data){
    this.data = data;
    dataSize = data.length;
    VbarHbars = new VbarHbar[dataSize];
    lines = new Line[dataSize];
    this.xOrigin = MARGIN;
    this.yOrigin = height - MARGIN;
    this.xCoord = width - MARGIN;
    this.yCoord = MARGIN;
    this.counter = 0;
    
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
    float vbarRatio = bar / (greatestValue);
    
    // make bars
    float start = xOrigin + space;
    // start at one because we don't care about the label
    for (int i = 0; i < dataSize; i++) {
      float barHeight = data[i]  * ratio;
      float barSquished = data[i] * vbarRatio;
      
      VbarHbars[i] = new VbarHbar(start, (yOrigin + barHeight), bar, -barHeight, GLOBAL_SCALE * BAR_TO_POINT, barSquished);
      start += barSpace;
    }
  }
  
  
  void render(){
    // some axes
    line(xOrigin, yOrigin, xOrigin, yCoord);
    line(xOrigin, yOrigin, xCoord, yOrigin);
    println(width - MARGIN);
    
    for (int i = 0; i < dataSize; i++) {
      VbarHbars[i].render();
   }
   counter++;
  }
}