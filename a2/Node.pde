public class Node {
  
  private float mass, x, y;
  private PVector velocity, acceleration, force;
  private boolean dragging;
  
  Node(float mass) {
    this.mass = mass; 
    this.force = new PVector();
    this.velocity = new PVector();
  }
  
  void applyForce(PVector appliedForce) {
    this.force.add(appliedForce);
  }
  
  public void applyCoulombForce(Node otherNode, float coulombConstant) {
    PVector r = new PVector(otherNode.x - this.x, otherNode.y - this.y);
    float force = coulombConstant * ((this.mass * otherNode.mass) / r.magSq());
    otherNode.applyForce(r.copy().normalize().mult(force));
    this.applyForce(r.copy().normalize().rotate(PI).mult(force));
  }
  
  void render(float x, float y, float scale) {
    fill(0);
    float renderX = x + (scale * this.x);
    float renderY = y + (scale * this.y);
    fill(30, 99, 144);
    if (this.hover(x, y, scale)) {
      fill(255, 204, 0);
    }
    ellipse(renderX, renderY, (scale * this.mass * 10), (scale * this.mass * 10));
  }

  // t is the time step
  void updatePosition(float time, float dampingConstant) {
    PVector acceleration = this.force.div(this.mass);
    
    
    this.velocity.add(acceleration.mult(time));
    // I'm pretty sure this vector should NOT be normalized
    //this.velocity.sub(this.velocity.copy().normalize().mult(dampingConstant));
    this.velocity.sub(this.velocity.copy().mult(dampingConstant));
    this.x += this.velocity.x * time;
    this.y += this.velocity.y * time;
    this.force.setMag(0);
  }
  
  void setPosition(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  boolean hover(float x, float y, float scale){
    return (dist(mouseX + x, mouseY + y, this.x, this.y) <= (scale * this.mass * 10));
  } 
  
  float kineticEnergy() {
    return 0.5 * this.mass * (this.velocity.magSq());
  }
  
}