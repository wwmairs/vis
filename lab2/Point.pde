public class Point {
  
  public Object x;
  public Object y;
  private float xCoord, yCoord, w, h;
 
  Point(Object xVal, Object yVal) {
    x = xVal;
    y = yVal;
  }
  
  public float x() {
    return xCoord + (w/2);
  }
  
  public float y() {
    return yCoord;
  }
  
  void drawBar() {
      if (this.hoverOver()) {
        fill(200);
        rect(xCoord, yCoord, w, h);
        toolTip();
      } else {
        fill(123, 48, 99);
        rect(xCoord, yCoord, w, h);
      }
    // all of this is just to make the text below the bars vertical
    pushMatrix();
    translate(xCoord, yCoord);
    rotate(-HALF_PI);
    translate(-xCoord, -yCoord);
    textAlign(RIGHT);
    textSize(10);
    fill(0);
    text(x.toString(), xCoord - h - 10, yCoord + w/2);
    popMatrix();
  }
  
  void drawPoint() {
    if (this.hoverOver()) {
        fill(200);
        ellipse(xCoord + w/2, yCoord, 10, 10);
        toolTip();
      } else {
        fill(123, 48, 99);;
        ellipse(xCoord + w/2, yCoord, 10, 10);
      }
    // all of this shiz is just to make the text below the bars vertical
    pushMatrix();
    translate(xCoord, yCoord);
    rotate(-HALF_PI);
    translate(-xCoord, -yCoord);
    textAlign(RIGHT);
    textSize(10);
    fill(0);
    text(x.toString(), xCoord - h - 10, yCoord + w/2);
    popMatrix();
  }
  
  void setDims(float X, float Y, float Width, float Height) {
    xCoord = X;
    yCoord = Y;
    w = Width;
    h = Height;
  }
  
  boolean hoverOver(){
    return ((mouseX > xCoord) && (mouseX < xCoord + w) && (mouseY > yCoord) && (mouseY < yCoord + h));
  }
  
  void toolTip() {
    fill(255);
    rect(mouseX - 90, mouseY - 17, 100, 25);
    fill(0);
    textAlign(RIGHT);
    text("( " + this.x + ", " + this.y + ")", mouseX, mouseY);
  }

}