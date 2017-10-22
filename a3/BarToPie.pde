static float BARS = 0.5;
static float BAR_SQUISH = 0.8;
static float SOMETHING_ELSE = 1; 


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
      
      VbarHbars[i] = new VbarHbar(start, (yOrigin + barHeight), bar, -barHeight, GLOBAL_SCALE * BARS, barSquished);
      start += barSpace;
    }
  }
  
  
  void render(){
    // some axes
    line(xOrigin, yOrigin, xOrigin, yCoord);
    line(xOrigin, yOrigin, xCoord, yOrigin);
    
   if (counter < (GLOBAL_SCALE * BARS)) {
     for (int i = 0; i < dataSize; i++) {
       VbarHbars[i].renderShrink();
     }
   } else if ((counter >= (GLOBAL_SCALE * BARS)) && (counter < (GLOBAL_SCALE * BAR_SQUISH))) {
     float localCount = counter - (GLOBAL_SCALE * BARS);
     float countPerBar = ((GLOBAL_SCALE * SOMETHING_ELSE) - (GLOBAL_SCALE * BAR_SQUISH)) / dataSize;
     int i = int(localCount) / int(countPerBar);
     float prevX;
     for (int j = 0; j < dataSize; j++) {
       if (i != 0 && i == j){
         prevX = VbarHbars[i - 1].getCurrX();
         VbarHbars[i].renderSquish(prevX, (localCount % int(countPerBar)) * (100/int(countPerBar)));
       } else {
         VbarHbars[j].drawRect();
       }
     }   
   }
   counter++;
  }
}