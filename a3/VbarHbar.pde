static float BAR_SHRINK = .17;
static float BAR_ROTATE = .19;
static float BAR_FALL = .3;

class VbarHbar {
  float x, y, fullHeight, fullWidth, fall;
  float currX, currY, currHeight, currWidth;
  //float globalCounter;
  //float scale;
  float barSquished;


  VbarHbar (float x, float y, float w, float h, float scale, float barSquished) {
    this.x = x;
    this.y = y;
    this.fullHeight = h;
    this.fullWidth = w;
    this.fall = (height - MARGIN) - y;
    this.currX = x;
    this.currY = y;
    this.currHeight = h;
    this.currWidth = w;
    //this.globalCounter = 0;
    //this.GLOBAL_SCALE = GLOBAL_SCALE;
    this.barSquished = barSquished;
  }

  // per is value between 0 and 1
  public void renderShrink() {
    float localPercent;
    //float yStep = (height - MARGIN - this.currY) / 100;
    if ((globalCounter >= 0) && (globalCounter < GLOBAL_SCALE * BAR_SHRINK)) {
      localPercent = rangeToPercent(0, BAR_SHRINK, globalCounter);
      rectMode(CORNER);
      ;
      if (this.currHeight > this.barSquished) {
        this.currHeight = (this.fullHeight * ((100 - localPercent)/100));
      }
      drawRect();
    } else if ((globalCounter >= GLOBAL_SCALE * BAR_SHRINK) && (globalCounter <= GLOBAL_SCALE * BAR_ROTATE)) {
      localPercent = rangeToPercent((BAR_SHRINK), (BAR_ROTATE), globalCounter);
      pushMatrix();
      // do something
      translate(x, y);
      rotate(-1 * radians(90) * (localPercent/100));
      // draw bar
      fill(255);
      rect(0, 0, this.currWidth, this.currHeight);
      popMatrix();
    } else if ((globalCounter > GLOBAL_SCALE * BAR_ROTATE) && (globalCounter <= GLOBAL_SCALE * BAR_FALL)) {
      if (globalCounter == int(GLOBAL_SCALE * BAR_ROTATE) + 1) {
        println("inside the conditional!");
        this.currY -= this.currWidth;
        float swap = this.currWidth;
        this.currWidth = this.currHeight;
        this.currHeight = swap;
      }
      // move y coordinate down! until at bottom of screen  
      localPercent = rangeToPercent(BAR_ROTATE, BAR_FALL, globalCounter);
      text(localPercent, 50, 50);
      this.currY += fall / 100;
      if (this.currY >= (height - MARGIN - currHeight)) {
        this.currY = height - MARGIN - currHeight;
      }
      drawRect();
    }
    else {
      drawRect();
    }
  }
  
  public void renderSquish(float prevX, float percent) {
    float tempX = currX;
    this.currX -= (currX - prevX) * (percent/100);
    drawRect();
    this.currX = tempX;
    
    if (percent > 80) {
      this.currX = prevX;
    }  
  }
  
  public float getCurrX() {
    return this.currX + this.currWidth;
  }
  
  public void drawRect() {
    fill(#ffffff);
    rect(this.currX, this.currY, this.currWidth, this.currHeight);
  }

  float rangeToPercent(float start, float end, float count) {
    //text((count - (GLOBAL_SCALE * start)) * (100 / (GLOBAL_SCALE * (end - start))), 50, 50);
    return (count - (GLOBAL_SCALE * start)) * (100 / (GLOBAL_SCALE * (end - start)));
  }
}