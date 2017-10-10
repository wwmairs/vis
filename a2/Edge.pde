public class Edge {
  
  Node nodeOne, nodeTwo;
  float defaultLength;
  
  Edge(Node nodeOne, Node nodeTwo, float defaultLength) {
    this.nodeOne = nodeOne;
    this.nodeTwo = nodeTwo;
    this.defaultLength = defaultLength;
  }
  
  void applyHookeForces(float springConstant) {
    PVector spring = new PVector(this.nodeTwo.x - this.nodeOne.x, this.nodeTwo.y - this.nodeOne.y);
    float force = springConstant * (spring.mag() - this.defaultLength);
    PVector nodeOneForce = spring.normalize().mult(force);
    PVector nodeTwoForce = nodeOneForce.copy().rotate(PI);
    
    this.nodeOne.applyForce(nodeOneForce);
    this.nodeTwo.applyForce(nodeTwoForce);
  }
  
  void render() {
    fill(0);
    line(this.nodeOne.x, this.nodeOne.y, this.nodeTwo.x, this.nodeTwo.y);
  }
}