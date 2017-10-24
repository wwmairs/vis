static float BARS = 0.3;
static float BAR_SQUISH = 0.65;
static float ARC_MOVE = 0.7;
static float ARC_WRAP = 1; 
static float START_RADIUS = 100000;

// sample array of bars

class BarToPie {
  float xOrigin, yOrigin;
  float xCoord, yCoord;
  VbarHbar [] VbarHbars;
  Line [] lines;
  Arc [] arcs;
  int dataSize;
  float [] data;
  int axisOpacity = 255;
 
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
    
    println("arcs =", arcs);
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
  
  void makeArcs() {
    float totalArcLength = 0;
    for (int i = 0; i < VbarHbars.length; i++) {
      totalArcLength += VbarHbars[i].currWidth;
    }
    arcs = new Arc[dataSize];
    for (int i = 0; i < VbarHbars.length; i++) {
      arcs[i] = new Arc(VbarHbars[i].currWidth, totalArcLength, START_RADIUS, VbarHbars[i].currHeight);
    }
  }
  
  void render(){
    
   if (globalCounter < (GLOBAL_SCALE * BARS)) {
     for (int i = 0; i < dataSize; i++) {
       VbarHbars[i].renderShrink();
     }
   } else if ((globalCounter >= (GLOBAL_SCALE * BARS)) && (globalCounter < (GLOBAL_SCALE * BAR_SQUISH))) {
     float localCount = globalCounter - (GLOBAL_SCALE * BARS);
     float countPerBar = ((GLOBAL_SCALE * ARC_WRAP) - (GLOBAL_SCALE * BAR_SQUISH)) / dataSize;
     int i = int(localCount) / int(countPerBar);
     if (ascend) {
       float prevX;
       for (int j = 0; j < dataSize; j++) {
         if (i != 0 && i == j){
           prevX = VbarHbars[i - 1].getCurrX();
           VbarHbars[i].renderSquish(prevX, (localCount % int(countPerBar)) * (100/int(countPerBar)));
         } else {
           VbarHbars[j].drawRect();
         }
       }   
     } else {
       // unsquish bars
     }
   } else if (globalCounter >= (GLOBAL_SCALE * BAR_SQUISH)) {
     if (this.arcs == null) {
       // make arcs
       makeArcs();
     }
     // draw arcs
     float startTheta = 0;
     for (int i = 0; i < arcs.length; i++) {
       arcs[i].renderAt(globalCounter, startTheta);
       startTheta += arcs[i].theta;
     }
   }
   
   if (globalCounter > (GLOBAL_SCALE / 2) && ascend) {
     this.axisOpacity -= 1;
   } else if (globalCounter > (GLOBAL_SCALE / 2)) {
     this.axisOpacity += 1;
   }
   stroke(0, 0, 0, axisOpacity);
   line(xOrigin, yOrigin, xOrigin, yCoord);
   line(xOrigin, yOrigin, xCoord, yOrigin);
  }
}