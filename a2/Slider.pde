public class Slider {
  private int buttonDiameter = 23;
  private float percentage, x1, y1, x2, y2, buttonX, buttonY;
  private boolean dragging;
  
  Slider() {
   this(0); 
  }
  
  Slider(float percentage) {
    this.dragging = false;
    this.percentage = percentage;
    this.x1 = 0;
    this.x2 = 0;
    this.y1 = 0;
    this.y2 = 0;
    this.calculateButtonPosition();
  }
  
  public float getPercentage() {
    return this.percentage; 
  }
  
  public void setPercentage(float percentage) {
    this.percentage = percentage;
  }
  
  public float getInverse() {
    return 1-this.percentage;
  }
  
  public boolean startDrag() {
    if(this.mouseOver()) {
      this.dragging = true;
    }
    return this.dragging;
  }
  
  public boolean drag() {
    if(this.dragging) {
       this.percentage = (mouseX - this.x1) / (this.x2 - this.x1);
       if (this.percentage > 1) {
         this.percentage = 1;
       }
       if (this.percentage < 0) {
         this.percentage = 0; 
       }
       
       this.calculateButtonPosition();
    }
    
    return this.dragging;
  }
  
  public boolean stopDrag() {
    if (this.dragging) {
      this.dragging = false; 
      return true;
    }
    
    return false;
  }
  
  boolean mouseOver(){
    float radius = sqrt(pow((mouseX - this.buttonX), 2) + pow((mouseY - this.buttonY), 2));
    return radius <= (this.buttonDiameter/2);
  }
  
  private void calculateButtonPosition() {
    this.buttonX = x1 + ((x2-x1) * percentage);
    this.buttonY = y1 + ((y2-y1) * percentage);
  }
  
  public void render(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.calculateButtonPosition();
    
    fill(0);
    strokeWeight(3);
    line(x1, y1, x2, y2);
    
    fill(200);
    ellipse(this.buttonX, this.buttonY, this.buttonDiameter, this.buttonDiameter);
    strokeWeight(1);

    /*
    fill(0);
    textSize(9);
    text(nf(round(this.percentage*100), 0, 0) + "%", buttonX, buttonY); 
    
    strokeWeight(1);
    */

  }
  
}