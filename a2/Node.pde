public class Node {
  
  private float mass, x, y;
  private PVector velocity, acceleration, force;
  private boolean dragging;
  PVector coulombForce = new PVector();
  
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
    fill(0);
    otherNode.applyForce(r.copy().normalize().mult(force));
    this.applyForce(r.copy().normalize().rotate(PI).mult(force));
    this.coulombForce.add(r.copy().normalize().rotate(PI).mult(force));
    otherNode.coulombForce.add(r.copy().normalize().mult(force));
  }
  
  void render(float x, float y, float scale) {
    fill(0);
    float renderX = x + (scale * this.x);
    float renderY = y + (scale * this.y);
    fill(30, 99, 144);
    ellipse(renderX, renderY, (scale * this.mass * 10), (scale * this.mass * 10));
    fill(0);
    line(renderX, renderY, renderX + this.coulombForce.x, renderY + this.coulombForce.y);
    this.coulombForce = new PVector();
  }

  // t is the time step
  void updatePosition(float time, float dampingConstant) {
    PVector acceleration = this.force.div(this.mass);
    
    
    this.velocity.add(acceleration.mult(time));
    println("Velocity: ", this.velocity.mag());
    this.velocity.sub(this.velocity.copy().mult(dampingConstant));
    this.x += this.velocity.x * time;
    this.y += this.velocity.y * time;
    this.force.setMag(0);
  }
  
  void resetVelocity() {
    this.velocity = new PVector(); 
  }
  
  void setPosition(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  float kineticEnergy() {
    return 0.5 * this.mass * (this.velocity.magSq());
  }
  
}