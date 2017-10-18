


class Point {
  float x, y;
  
  public Point(float x, float y) {
    this. x = x;
    this.y = y;
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y;
  }
}

class Line {
   Point a;
   Point b;
   PVector vector;
   
   public Line(float x1, float y1, float x2, float y2, float range) {
     a = new Point(x1, y1);
     b = new Point(x2, y2);
     vector = new PVector(x2 - x1, y2 - y1);

   }
   
   public void renderShootOut(float percent) {
   
   }

   public void renderComplete() {
     PVector maxDiagonal = new Pvector(
   
   }
   
   public void renderRetract(float percent) {
   
   }
   
}