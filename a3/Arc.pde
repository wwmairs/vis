class Arc {
  float arcLength, totalArcLength, theta, totalTheta, radius, centerX, centerY, barHeight;
  
  Arc(float aLength, float tLength, float r, float h) {
    this.arcLength = aLength;
    this.totalArcLength = tLength;
    this.theta = aLength / (r / 2);
    this.totalTheta = tLength / (r / 2);
    this.radius = r;
    this.centerX = totalArcLength / 2 + MARGIN;
    this.centerY = height - MARGIN -  (r/2);
    this.barHeight = h;
  }
  
  void renderAt(float counter, float startTheta) {
    if ((counter >= (GLOBAL_SCALE * BAR_SQUISH)) && (counter < (GLOBAL_SCALE * ARC_MOVE))) {
       // move arcs to center of screen
       float targetX = ((width - MARGIN) / 2) + MARGIN;
       float targetY = ((height - MARGIN) / 2) - MARGIN;
       float xStep = (targetX - MARGIN) / ((GLOBAL_SCALE * ARC_MOVE) - (GLOBAL_SCALE * BAR_SQUISH));
       float yStep = (height - MARGIN - targetY) / ((GLOBAL_SCALE * ARC_MOVE) - (GLOBAL_SCALE * BAR_SQUISH));
       // draw arcs
       render(startTheta);
         if (centerX < targetX) {
           centerX += xStep;
           centerY -= yStep;
         }
    } else if ((counter >= (GLOBAL_SCALE * ARC_MOVE)) && (counter < (GLOBAL_SCALE * ARC_WRAP))){
       // wrap arcs
       // draw arcs
       //float radiusStep = (log(START_RADIUS) / log(2)) / ((GLOBAL_SCALE * ARC_WRAP) - (GLOBAL_SCALE * ARC_MOVE));
         if (totalTheta < TWO_PI) {
           updateRadius(radius / 16);
         }
       render(startTheta);
     }
     render(startTheta);

   }
  
  void render(float startTheta){
    pushMatrix();
    translate(centerX, centerY);
    rotate(angleToBottom());
    //ellipse(0, 0, radius, radius);
    fill(255);
    stroke(0);
    arc(0, 0, radius, radius, startTheta, startTheta + theta, PIE);
    noStroke();
    fill(BACKGROUND_COLOR);
    ellipse(0, 0, radius - (barHeight * 2), radius - (barHeight * 2));
    fill(255);
    stroke(0);
    popMatrix();
  }
  
  float angleToBottom() {
    return (PI/2) - (totalTheta / 2);
  }
  
  void updateRadius(float r) {
    this.radius -= r;
    this.centerY += r /2;
    this.theta = this.arcLength / (radius / 2);
    this.totalTheta = this.totalArcLength / (radius / 2);
  }
}