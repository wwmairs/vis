static float BAR_SHRINK = .4;
static float BAR_ROTATE = .6;
static float BAR_FALL = 1;

class VbarHbar {
  float x, y, fullHeight, fullWidth, fall;
  float currX, currY, currHeight, currWidth;
  float counter;
  float scale;
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
    this.counter = 0;
    this.scale = scale;
    this.barSquished = barSquished;
  }

  // per is value between 0 and 1
  public void renderShrink() {
    float localPercent;
    //float yStep = (height - MARGIN - this.currY) / 100;
    if ((counter >= 0) && (counter < scale * BAR_SHRINK)) {
      localPercent = rangeToPercent(0, BAR_SHRINK, counter);
      rectMode(CORNER);
      ;
      if (this.currHeight > this.barSquished) {
        this.currHeight = (this.fullHeight * ((100 - localPercent)/100));
      }
      drawRect();
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
      }
      // move y coordinate down! until at bottom of screen  
      localPercent = rangeToPercent(BAR_ROTATE, BAR_FALL, counter);
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
    if (counter < scale + 1) {
      counter++;
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
    //text((count - (scale * start)) * (100 / (scale * (end - start))), 50, 50);
    return (count - (scale * start)) * (100 / (scale * (end - start)));
  }
}