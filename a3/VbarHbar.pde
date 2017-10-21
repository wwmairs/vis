static float BAR_SHRINK = .4;
static float BAR_ROTATE = .6;
static float BAR_FALL = 1;
static float BAR_SQUISH = 1;

class VbarHbar {
  float x, y, fullHeight, fullWidth;
  float currX, currY, currHeight, currWidth;
  float pointWidth;
  float pointHeight;
  float counter;
  float scale;
  float barSquished;


  VbarHbar (float x, float y, float w, float h, float scale, float barSquished) {
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
    this.scale = scale;
    this.barSquished = barSquished;
  }

  // per is value between 0 and 1
  public void render() {
    float localPercent;
    float fall = (height - MARGIN) - this.currHeight - this.currWidth;
    //float yStep = (height - MARGIN - this.currY) / 100;
    if ((counter >= 0) && (counter < scale * BAR_SHRINK)) {
      localPercent = rangeToPercent(0, BAR_SHRINK, counter);
      rectMode(CORNER);
      ;
      if (this.currHeight > this.barSquished) {
        this.currHeight = (this.fullHeight * ((100 - localPercent)/100));
      }
      rect(this.currX, this.currY, this.currWidth, this.currHeight);
    } else if ((counter >= scale * BAR_SHRINK) && (counter <= scale * BAR_ROTATE)) {
      localPercent = rangeToPercent((BAR_SHRINK), (BAR_ROTATE), counter);
      pushMatrix();
      // do something
      translate(x, y);
      rotate(-1 * radians(90) * (localPercent/100));
      // draw bar
      rect(0, 0, this.currWidth, this.currHeight);
      popMatrix();
    } else if ((counter > scale * BAR_ROTATE) && (counter <= scale * BAR_FALL)) {
      if (counter == int(scale * BAR_ROTATE) + 1) {
        println("inside the conditional!");
        this.currY -= this.currWidth;
        float swap = this.currWidth;
        this.currWidth = this.currHeight;
        this.currHeight = swap;
        //fall = (height - MARGIN) - this.currY;
      }
      // move y coordinate down! until at bottom of screen  
      localPercent = rangeToPercent(BAR_ROTATE, BAR_FALL, counter);
      this.currY += fall / localPercent;
      rect(this.currX, this.currY, this.currWidth, this.currHeight);
    }
    else {
      rect(this.currX, this.currY, this.currWidth, this.currHeight);
    }
    if (counter < scale) {
      counter++;
    } 
  }

  float rangeToPercent(float start, float end, float count) {
    text((count - (scale * start)) * (100 / (scale * (end - start))), 50, 50);
    return (count - (scale * start)) * (100 / (scale * (end - start)));
  }
}