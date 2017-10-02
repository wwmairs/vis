public class Edge {
  
  Node nodeOne, nodeTwo;
  float defaultLength;
  
  Edge(Node nodeOne, Node nodeTwo, float defaultLength) {
    this.nodeOne = nodeOne;
    this.nodeTwo = nodeTwo;
    this.defaultLength = defaultLength;
  }
  
  void applyHookeForces() {
    
  }
  
  void render(float x, float y, float scale) {
    fill(0);
    line(scale * (x + nodeOne.x), scale * (y + nodeOne.y), scale * (x + nodeTwo.x), scale * (y + nodeTwo.y));
  }
}