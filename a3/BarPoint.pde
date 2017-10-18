static float BAR_SHRINK_UP = .6;
static float BAR_SHRINK_IN = .9;
static float POINT_RISE = 1;

static float SCALE = 400;

class BarPoint {
  float x, y, fullHeight, fullWidth;
  float currX, currY, currHeight, currWidth;
  float pointWidth;
  float pointHeight;
  float counter;
  
  BarPoint (float x, float y, float w, float h) {
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
    this.counter = 0;
  }
  
  // per is value between 0 and 1
  public void render() {
    float localPercent;
    if ((counter >= 0) && (counter < SCALE * BAR_SHRINK_UP)) {
      localPercent = rangeToPercent(0, BAR_SHRINK_UP, counter);
      rectMode(CORNER);;
      if (this.currHeight > this.pointHeight) {
        this.currHeight = (this.fullHeight * ((100 - localPercent)/100));
      }
    } else if ((counter >= SCALE * BAR_SHRINK_UP) && (counter < SCALE * BAR_SHRINK_IN)){
      localPercent = rangeToPercent((BAR_SHRINK_UP), (BAR_SHRINK_IN), counter);
      rectMode(CENTER);
      this.currX = this.x + (this.fullWidth / 2);
      this.currY = this.y + (this.currHeight / 2);
      if (this.currWidth > this.pointWidth) {
        this.currWidth = (this.fullWidth * ((100 - localPercent)/100));
      } 
    } else if ((counter >= SCALE * BAR_SHRINK_IN) && (counter < SCALE * POINT_RISE)) {
      // move y coordinate up gradually by pointHeight / 2
      localPercent = rangeToPercent(BAR_SHRINK_IN, POINT_RISE, counter);
      this.currY -= (this.pointHeight/2)/100;
    }
    if (counter < SCALE) {
      counter++;
    }
    fill(#ffffff);
    rect(this.currX, this.currY, this.currWidth, this.currHeight);
    fill(#000000);
  }
}

float rangeToPercent(float start, float end, float count) {
  text((count - (SCALE * start)) * (100 / (SCALE * (end - start))), 50, 50);
  return (count - (SCALE * start)) * (100 / (SCALE * (end - start)));
}