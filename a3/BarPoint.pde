static float BAR_SHRINK_UP = .6;
static float BAR_SHRINK_IN = .9;
static float POINT_RISE = 1;

class BarPoint {
  float x, y, fullHeight, fullWidth;
  float currX, currY, currHeight, currWidth;
  float pointWidth;
  float pointHeight;
  //float GLOBAL_SCALE;
  
  BarPoint (float x, float y, float w, float h, float scale) {
    this.x = x;
    this.y = y;
    this.fullHeight = h;
    this.fullWidth = w;
    this.currX = x;
    this.currY = y;
    this.currHeight = h;
    this.currWidth = w;
    this.pointWidth = 10;
    this.pointHeight = 10;
    //this.GLOBAL_SCALE = GLOBAL_SCALE;
  }
  
  // per is value between 0 and 1
  public void render(float counter) {
    float localPercent;
    if ((counter >= 0) && (counter < GLOBAL_SCALE * BAR_SHRINK_UP)) {
      localPercent = rangeToPercent(0, BAR_SHRINK_UP, counter);
      rectMode(CORNER);;
      if (this.currHeight > this.pointHeight) {
        this.currHeight = (this.fullHeight * ((100 - localPercent)/100));
      }
    } else if ((counter >= GLOBAL_SCALE * BAR_SHRINK_UP) && (counter < GLOBAL_SCALE * BAR_SHRINK_IN)){
      localPercent = rangeToPercent((BAR_SHRINK_UP), (BAR_SHRINK_IN), counter);
      rectMode(CENTER);
      this.currX = this.x + (this.fullWidth / 2);
      this.currY = this.y + (this.currHeight / 2);
      if (this.currWidth > this.pointWidth) {
        this.currWidth = (this.fullWidth * ((100 - localPercent)/100));
      } 
    } else if ((counter >= GLOBAL_SCALE * BAR_SHRINK_IN) && (counter < GLOBAL_SCALE * POINT_RISE)) {
      // move y coordinate up gradually by pointHeight / 2
      localPercent = rangeToPercent(BAR_SHRINK_IN, POINT_RISE, counter);
      this.currY -= (this.pointHeight/2)/100;
    }
    if (counter < GLOBAL_SCALE) {
      counter++;
    }
    fill(#ffffff);
    rect(this.currX, this.currY, this.currWidth, this.currHeight);
    fill(#000000);
  }
  
  void renderAt(float count) {
    float counter = 0;
    //println("trying to renderAt: " + count);
    while (counter <= count) {
      float localPercent;
      if ((counter >= 0) && (counter < GLOBAL_SCALE * BAR_SHRINK_UP)) {
        this.currHeight = this.fullHeight;
        this.currWidth = this.fullWidth;
        this.currX = this.x;
        this.currY = this.y;
        localPercent = rangeToPercent(0, BAR_SHRINK_UP, counter);
        rectMode(CORNER);
        this.currHeight = max((this.fullHeight * ((100 - localPercent)/100)), this.pointHeight);
      } else if ((counter >= GLOBAL_SCALE * BAR_SHRINK_UP) && (counter < GLOBAL_SCALE * BAR_SHRINK_IN)){
        this.currHeight = this.pointHeight;
        this.currWidth = this.fullWidth;
        this.currX = this.x;
        this.currY = this.y;
        localPercent = rangeToPercent((BAR_SHRINK_UP), (BAR_SHRINK_IN), counter);
        rectMode(CENTER);
        this.currX = this.x + (this.fullWidth / 2);
        this.currY = this.y + (this.currHeight / 2);
        this.currWidth = max((this.fullWidth * ((100 - localPercent)/100)), this.pointWidth);
      } else if ((counter >= GLOBAL_SCALE * BAR_SHRINK_IN) && (counter < GLOBAL_SCALE * POINT_RISE)) {
        this.currWidth = this.pointWidth;
        this.currHeight = this.pointHeight;
        // move y coordinate up gradually by pointHeight / 2
        localPercent = rangeToPercent(BAR_SHRINK_IN, POINT_RISE, counter);
        this.currY -= (this.pointHeight/2)/100;
      }
      counter++;
    }
    fill(#ffffff);
    rect(this.currX, this.currY, this.currWidth, this.currHeight);
    fill(#000000);
  
  }
  
  float rangeToPercent(float start, float end, float count) {
    //text((count - (GLOBAL_SCALE * start)) * (100 / (GLOBAL_SCALE * (end - start))), 50, 50);
    return (count - (GLOBAL_SCALE * start)) * (100 / (GLOBAL_SCALE * (end - start)));
}

}