public class Node {
  
  private float mass, x, y;
  private PVector velocity, acceleration, force;
  
  Node(float mass) {
    this.mass = mass; 
  }
  
  void updatePosition() {
    
  }
  
  void render(float x, float y, float scale) {
    fill(0);
    //println(y, this.y);
    float renderX = scale * (x + this.x);
    float renderY = scale * (y + this.y);
    //println(renderX, renderY);
    fill(255);
    ellipse(renderX, renderY, (scale * 10), (scale * 10));
  }
  
  void setPosition(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
}