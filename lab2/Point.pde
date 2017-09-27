public class Point {
  
  public Object x;
  public Object y;
  private float xCoord, yCoord, w, h;
 
  Point(Object xVal, Object yVal) {
    x = xVal;
    y = yVal;
  }
  
  void drawBar() {
    rect(xCoord, yCoord, w, h);
    pushMatrix();
    translate(xCoord, yCoord);
    rotate(-HALF_PI);
    translate(-xCoord, -yCoord);
    textAlign(RIGHT);
    textSize(10);
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
}