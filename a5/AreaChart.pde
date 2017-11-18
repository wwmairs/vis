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
        // uncomment this to make the marked segment a different color
        //fill(this.data.get(i).isMarked() ? 100 : 150);
        
        // shade in the area beneath
        fill(150);
        noStroke();
        vertex(this.getX() + (xStep * i), this.getY() + yPos);
        vertex(this.getX() + (xStep * i), this.getY() + this.getHeight());
        vertex(this.getX() + (xStep * (i - 1)), this.getY() + this.getHeight());
        vertex(this.getX() + (xStep * (i - 1)), this.getY() + (this.getHeight() * (this.data.get(i - 1).getValue() / max)));
        endShape(CLOSE);
        // draw the line between points
        stroke(0);
        strokeWeight(1);
        line(this.getX() + (xStep * i), this.getY() + yPos, this.getX() + (xStep * (i - 1)), this.getY() + (this.getHeight() * (this.data.get(i - 1).getValue() / max)));
        if (this.data.get(i).isMarked()) {
          strokeWeight(3);
          stroke(0);
          line(this.getX() + (xStep * i), this.getY() + yPos, this.getX() + (xStep * i), this.getY() + this.getHeight());
          line(this.getX() + (xStep * (i - 1)), this.getY() + this.getHeight(), this.getX() + (xStep * (i - 1)), this.getY() + (this.getHeight() * (this.data.get(i - 1).getValue() / max)));
          strokeWeight(1);
          fill(0);
          ellipse(this.getX() + (xStep * i) - (xStep / 2), (this.getY() + (yPos + ((this.getHeight() * (this.data.get(i - 1).getValue() / max)) / 2) )), 10, 10);
        }
      }
      fill(0);
      ellipse(this.getX() + (xStep * i), this.getY() + yPos, 2, 2); 
    }
  }
}