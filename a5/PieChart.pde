public class PieChart extends Chart {

  PieChart(Data data, int x, int y, int w, int h) {
    super(data, x, y, w, h);
    this.name = "PieChart";
  }  
  
  public int getRadius() {
    return min(super.getWidth(), super.getHeight()) / 2 - 10;
  }
  
  public void draw() {
    fill(255);
    rect(getX(), getY(), getWidth(), getHeight());
    float dataSum = this.data.getSum();
    float offset = 0;
    for (int i = 0; i < this.data.size(); i++) {
      float a2 = TWO_PI * this.data.get(i).getValue() / dataSum;
      
      if (this.data.get(i).isMarked()) {
        stroke(0);
        fill(255);
        arc(getCenterX(), getCenterY(), getWidth() - 10, getHeight() - 10, offset, offset + a2, PIE);
        float mx = getCenterX() + cos(offset + a2/2) * getRadius() / 2;
        float my = getCenterY() + sin(offset + a2/2) * getRadius() / 2;
        fill(0);
        ellipse(mx, my, 10, 10);
      } else {
        stroke(0);
        fill(255);
        arc(getCenterX(), getCenterY(), getWidth() - 10, getHeight() - 10, offset, offset + a2, OPEN);
      }
      offset += a2;
    }
  }
}