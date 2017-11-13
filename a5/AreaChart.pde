public class AreaChart extends Chart {
   public AreaChart(Data data, int chartX, int chartY, int chartWidth, int chartHeight){
    super(data, chartX, chartY, chartWidth, chartHeight);
    this.name = "sample";
  }

  @Override
  public void draw(){
    fill(255);
    rect(getX(), getY(), getWidth(), getHeight());
    float xStep = this.getWidth() / this.data.size();
    float max = 0;
    for (int i = 0; i < this.data.size(); i++) {
      if (this.data.get(i).getValue() > max) {
        max = this.data.get(i).getValue();
      }
    }
    for (int i = 0; i < this.data.size(); i++) {
      float yPos = this.getHeight() * (this.data.get(i).getValue() / max);
      if (i > 0) {
        beginShape();
        fill(150);
        vertex(this.getX() + (xStep * i), this.getY() + yPos);
        vertex(this.getX() + (xStep * i), this.getY() + this.getHeight());
        vertex(this.getX() + (xStep * (i - 1)), this.getY() + this.getHeight());
        vertex(this.getX() + (xStep * (i - 1)), this.getY() + (this.getHeight() * (this.data.get(i - 1).getValue() / max)));
        endShape(CLOSE);
      }
      fill(0);
      ellipse(this.getX() + (xStep * i), this.getY() + yPos, 5, 5); 
    }
  }
}