


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
   Point start;
   Point end;
   
   public Line(float x1, float y1, float x2, float y2) {
     a = new Point(x1, y1);
     b = new Point(x2, y2);
     vector = new PVector(x2 - x1, y2 - y1);
     vector.normalize();
     start = calcStart();
     end = calcEnd();

   }
   
   public Point calcStart() {
     float x, y;
     y = height;
     x = a.x + ((height - a.y) / vector.y) * vector.x;
     if ((y > height) || (x < 0)) {
       x = 0;
       y = a.y - ((a.x / vector.x) * vector.y);
     }
     return new Point(x, y);
   }
   
   public Point calcEnd() {
     float x, y;
     
     y = 0;
     x = a.x - (a.y / vector.y) * vector.x;
     if ((y > height) || (x < 0)) {
       x = width;
       y = a.y + ((width - a.x / vector.x) * vector.y);
     }
     
     return new Point(x, y);
   }
   
   public void renderShootOut(float percent) {
   
   }

   public void renderComplete() {
     line(start.x, start.y, end.x, end.y);
   }
   
   public void renderRetract() {
     line(a.x, a.y, b.x, b.y);
   
   }
   
}