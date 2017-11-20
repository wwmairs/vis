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
    this.rangeStart = floor(minError);
    this.rangeEnd   = ceil(maxError);
    this.rangeSize  = rangeEnd - rangeStart;
    this.errorUnit  = w / rangeSize;
  }
  
  float getMinError() {
    float normalMin = min(normal.get("pie").minError(), normal.get("area").minError());
    float fillMin = min(normal.get("pie").minError(), normal.get("area").minError());
    return min(normalMin, fillMin);
  }
  
  float getMaxError() {
    float normalMax = max(normal.get("pie").maxError(), normal.get("area").maxError());
    float fillMax = max(normal.get("pie").maxError(), normal.get("area").maxError());
    return max(normalMax, fillMax);
  }
  
  void draw(){
    // lets just draw the normal one for now
    background(255); //<>//
    background(255);
    fill(0);
    //println(minError, maxError);
    for ( int i = 0; i < rangeSize; i++) {
      ellipse((errorUnit * i) + (errorUnit / 2), h, 10, 10);
      text(rangeStart + i, (errorUnit * i) + (errorUnit / 2), h - 15);
    }
    println("pie error", normal.get("pie").meanError());
    println("area error", normal.get("area").meanError());
    ellipse((errorUnit * normal.get("pie").meanError()) + (errorUnit / 2), h / 3, 20, 20);
    ellipse((errorUnit * normal.get("area").meanError()) + (errorUnit / 2), (2 * h) / 3, 20, 20);
  }
}