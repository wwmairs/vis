public class ForceDiagram {
  
  private List<Node> nodes;
  private List<Edge> edges;
  private float springConstant = 1.0;
  private float dampingConstant = 0.4;
  private float coulombConstant = 1000.0;
  private float xOffset = 0.0, yOffset = 0.0, scale = 1.0;
  private float currWidth, currHeight;
  
  ForceDiagram(List<Node> nodes, List<Edge> edges) {
    // Set local nodes and edges
    this.nodes = nodes;
    this.edges = edges;
    
    Collections.sort(this.nodes, new Comparator<Node>() {
      public int compare(Node nodeOne, Node nodeTwo) {
        if (nodeOne.mass > nodeTwo.mass) return -1;
        if (nodeOne.mass < nodeTwo.mass) return 1;
        return 0;
      }});
  }
  
  void setScale(float newScale) {
    this.xOffset += ((this.currWidth * this.scale) - (this.currWidth * newScale)) / 2;
    this.yOffset += ((this.currHeight * this.scale) - (this.currHeight * newScale)) / 2;
    this.scale = newScale; 
  }
  
  void incementOffset(float x, float y) {
    this.xOffset += x;
    this.yOffset += y; 
  }
  
  void performInitialLayout(float x, float y, float w, float h) {
    float spacing = w/nodes.size();
    float padding = spacing / 10; // The *10* here is very arbitrary - could be changed.

    float leftX, rightX;
    
    // Iterate through the nodes and update their positions to random values
    for (int i = 0; i < this.nodes.size(); i++) {
      // Calculate the domain of this node's placement
      leftX = x + (i * spacing) + padding;
      rightX = leftX + spacing - (padding * 2);
       
      // Update the node's position to be random
      this.nodes.get(i).setPosition(random(leftX, rightX), random(y, y + h));
    }
  }
  
  void render(float x, float y, float w, float h, float time) {
    this.currWidth = w;
    this.currHeight = h;
    
    for (int i = 0; i < edges.size(); i++) {
      this.edges.get(i).applyHookeForces(this.springConstant);
    }
    for (int i = 0; i < nodes.size(); i++) {
      for (int j = i + 1; j < nodes.size(); j++) {
        this.nodes.get(i).applyCoulombForce(nodes.get(j), this.coulombConstant);
      }
    }
    
    float ke = 0;
    for (int i = 0; i < nodes.size(); i++) {
      nodes.get(i).updatePosition(time, this.dampingConstant);
      ke += this.nodes.get(i).kineticEnergy();
      if (mousePressed && nodes.get(i).hover(this.scale)) {
        nodes.get(i).setPosition(mouseX, mouseY);
      }
    }
    println(ke);


    for (int i = 0; i < nodes.size(); i++) {
      this.nodes.get(i).render(x + this.xOffset, y + this.yOffset, this.scale);
    }
    for (int i = 0; i < edges.size(); i++) {
      this.edges.get(i).render(x + this.xOffset, y + this.yOffset, this.scale);
    }
    
    
    
    
  }
    
}