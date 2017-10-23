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
    
   if (counter < (GLOBAL_SCALE * BARS)) {
     for (int i = 0; i < dataSize; i++) {
       VbarHbars[i].renderShrink();
     }
   } else if ((counter >= (GLOBAL_SCALE * BARS)) && (counter < (GLOBAL_SCALE * BAR_SQUISH))) {
     float localCount = counter - (GLOBAL_SCALE * BARS);
     float countPerBar = ((GLOBAL_SCALE * ARC_WRAP) - (GLOBAL_SCALE * BAR_SQUISH)) / dataSize;
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
   } else if ((counter >= (GLOBAL_SCALE * BAR_SQUISH)) && (counter < (GLOBAL_SCALE * ARC_MOVE))) {
     if (this.arcs == null) {
       // make arcs
       makeArcs();
     }
     // move arcs to center of screen
     float targetX = ((width - MARGIN) / 2) + MARGIN;
     float targetY = ((height - MARGIN) / 2) - MARGIN;
     float xStep = (targetX - MARGIN) / ((GLOBAL_SCALE * ARC_MOVE) - (GLOBAL_SCALE * BAR_SQUISH));
     float yStep = (height - MARGIN - targetY) / ((GLOBAL_SCALE * ARC_MOVE) - (GLOBAL_SCALE * BAR_SQUISH));
     // draw arcs
     float startTheta = 0;
     for (int i = 0; i < arcs.length; i++) {
       arcs[i].render(startTheta);
       startTheta += arcs[i].theta;
       if (arcs[i].centerX < targetX) {
         arcs[i].centerX += xStep;
         arcs[i].centerY -= yStep;
       }
     }
   }
   else if ((counter >= (GLOBAL_SCALE * ARC_MOVE)) && (counter < (GLOBAL_SCALE * ARC_WRAP))){
     // wrap arcs
     // draw arcs
     //float radiusStep = (log(START_RADIUS) / log(2)) / ((GLOBAL_SCALE * ARC_WRAP) - (GLOBAL_SCALE * ARC_MOVE));
     float startTheta = 0;
     for (int i = 0; i < arcs.length; i++) {
       if (arcs[i].totalTheta < TWO_PI) {
         arcs[i].updateRadius(arcs[i].radius / 16);
       }
       arcs[i].render(startTheta);
       startTheta += arcs[i].theta;
     }
   } else {
     // draw arcs
     float startTheta = 0;
     for (int i = 0; i < arcs.length; i++) {
       arcs[i].render(startTheta);
       startTheta += arcs[i].theta;
     }
   }
   counter++;
   // some axes
   line(xOrigin, yOrigin, xOrigin, yCoord);
   line(xOrigin, yOrigin, xCoord, yOrigin);
  }
}