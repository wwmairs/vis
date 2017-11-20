class ErrorBars{
  // designed only to support two datasets i.e. two hypotheses and chart comparisons
  HashMap<String, Data> normal;
  HashMap<String, Data> fill;
  float x;
  float y;
  float w;
  float h;
  float minError;
  float maxError;
  int rangeStart;
  int rangeEnd;
  int rangeSize;
  // number of pixels that corresponds to an error difference of 1
  float errorUnit;
  
  ErrorBars(float _x, float _y, float _w, float _h, HashMap<String, Data> _n, HashMap<String, Data> _f) {
    this.x = _x;
    this.y = _y;
    this.w = _w;
    this.h = _h;
    this.normal = _n;
    this.fill   = _f;
    this.minError   = getMinError();
    this.maxError   = getMaxError();
    this.rangeStart = floor(minError) - 1;
    this.rangeEnd   = ceil(maxError) + 1;
    this.rangeSize  = rangeEnd - rangeStart;
    this.errorUnit  = w / rangeSize;
  }
  
  float getMinError() {
    float normalMin = min(normal.get("pie").meanError(), normal.get("area").meanError());
    float fillMin = min(fill.get("pie").meanError(), fill.get("area").meanError());
    return min(normalMin, fillMin);
  }
  
  float getMaxError() {
    float normalMax = max(normal.get("pie").meanError(), normal.get("area").meanError());
    float fillMax = max(fill.get("pie").meanError(), fill.get("area").meanError());
    return max(normalMax, fillMax);
  }
  
  void draw(){
    // lets just draw the normal one for now
    background(255); //<>//
    background(255);
    fill(0);
    //println(minError, maxError);
    for ( int i = 0; i < rangeSize; i++) {
      rectMode(CENTER);
      rect((errorUnit * i) + (errorUnit / 2), h, 0, 10);
      textAlign(CENTER);
      text(rangeStart + i, (errorUnit * i) + (errorUnit / 2), h + 20);
    }
    line((errorUnit / 2), h, (errorUnit * (rangeSize - 1)) + (errorUnit / 2), h);
    //println("pie error", normal.get("pie").getError());
    //println("area error", normal.get("area").getError());
    errorBar(normal.get("pie").meanError(), normal.get("pie").getError(), 1, "Monochromatic Pie");
    errorBar(normal.get("area").meanError(), normal.get("area").getError(), 2, "Monochromatic Area");
    errorBar(fill.get("pie").meanError(), fill.get("pie").getError(), 3, "Highlighted Pie");
    errorBar(fill.get("area").meanError(), fill.get("area").getError(), 4, "Highlighted Area");
  }
  
  
  void errorBar(float mean, float error, int c, String label) {
    float meanX = (errorUnit * mean) + (errorUnit / 2);
    ellipse(meanX, (h * c) / 5, 10, 10);
    stroke(0);
    strokeWeight(2);
    line(meanX, (h * c) / 5, meanX - (errorUnit * error), (h * c) / 5);
    line(meanX, (h * c) / 5, meanX + (errorUnit * error), (h * c) / 5);
    fill(0);
    textAlign(LEFT);
    text(label, this.x, (h * c) / 5);
  }
}