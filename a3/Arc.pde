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