static float MARGIN = 20;
static float SPACE = 0.15;


// sample array of bars

class BarToLine {
  float xOrigin, yOrigin;
  float xCoord, yCoord;
  BarPoint [] barPoints;
  int dataSize;
  HashMap<String, String []> data;
 
 //HashMap<String, String []> data this is an argument
  public BarToLine(int numBars){
    //this.data = data;
    //this.barPoints = new BarPoint[this.data.get('x').length];
    barPoints = new BarPoint[numBars];
    dataSize = numBars;
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
    float greatestValue = 100; // should actually be the first element in the hashmap
    // for (all the things in the hash table)
    // set greatestValue to the max oen
    float ratio = (yCoord - yOrigin) / greatestValue;
    
    // make bars
    float start = xOrigin + space;
    float barHeight = 30; // dont actually do this
    for (int i = 0; i < dataSize; i++) {
      barPoints[i] = new BarPoint(start, (yOrigin + barHeight * ratio), bar, -barHeight * ratio);
      start += barSpace;
      barHeight += 10;
    }
  
  }
  
  void render(){
    // some axes
    line(xOrigin, yOrigin, xOrigin, yCoord);
    line(xOrigin, yOrigin, xCoord, yOrigin);
    println(width - MARGIN);
    
   for (int i = 0; i < dataSize; i++) {
     barPoints[i].render();
   }
  }
}