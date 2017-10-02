public class ForceDiagram {
  
  private List<Node> nodes;
  private List<Edge> edges;
  private float springConstant = 10.0;
  private float dampingConstant = 10.0;
  private float coulombConstant = 10.0;
  private float xOffset = 0.0, yOffset = 0.0, scale = 1.0;
  private float currWidth, currHeight;
  
  ForceDiagram(List<Node> nodes, List<Edge> edges) {
    // Set local nodes and edges
    this.nodes = nodes;
    this.edges = edges;
  }
  
  void setScale(float newScale) {
    println(this.xOffset, this.yOffset);
    this.xOffset -= ((this.currWidth * newScale) - (this.currWidth * this.scale)) / 2;
    this.yOffset -= ((this.currHeight * newScale) - (this.currHeight * this.scale)) / 2;
    this.scale = newScale; 
  }
  
  void performInitialLayout(float x, float y, float w, float h) {
    float spacing = w/nodes.size();
    float padding = spacing / 10; // The *10* here is very arbitrary - could be changed.

    float leftX, rightX;
    
    // Iterate through the nodes and update their positions to random values
    for (int i = 0; i < nodes.size(); i++) {
      // Calculate the domain of this node's placement
      leftX = x + (i * spacing) + padding;
      rightX = leftX + spacing - (padding * 2);
       
      // Update the node's position to be random
      nodes.get(i).setPosition(random(leftX, rightX), random(y, y + h));
    }
  }
  
  void render(float x, float y, float w, float h, float time) {
    this.currWidth = w;
    this.currHeight = h;
    for (int i = 0; i < edges.size(); i++) {
      edges.get(i).render(x + this.xOffset, y + this.yOffset, this.scale);
    }
    for (int i = 0; i < nodes.size(); i++) {
      nodes.get(i).render(x + this.xOffset, y + this.yOffset, this.scale);
    }
    
  }
  
}