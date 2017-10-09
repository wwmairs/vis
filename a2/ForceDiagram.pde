public class ForceDiagram {
  
  private List<Node> nodes;
  private List<Edge> edges;
  private float springConstant = 15;
  private float dampingConstant = 0.1;
  private float coulombConstant = 6000;
  private float xOffset = 0.0, yOffset = 0.0, scale = 1.0;
  private float currWidth, currHeight;
  private float x, y, w, h;
  
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
  
  public void resetOffset() {
    this.xOffset = 0;
    this.yOffset = 0;
  }
  
  public void incementOffset(float x, float y) {
    this.xOffset += x;
    this.yOffset += y; 
  }
  
  void setSpringConstant(float springConstant) {
    this.springConstant = springConstant; 
    println("Spring: ", this.springConstant);
  }
  
  float getSpringConstant() {
    return this.springConstant;
  }
  
  void setDampingConstant(float dampingConstant) {
    this.dampingConstant = dampingConstant; 
    println("Damping: ", this.dampingConstant);
  }
  
  float getDampingConstant() {
    return this.dampingConstant;
  }
  
  void setCoulombConstant(float coulombConstant) {
    this.coulombConstant = coulombConstant; 
    println("Coulomb: ", this.coulombConstant);
  }
  
  float getCoulombConstant() {
    return this.coulombConstant;
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
      this.nodes.get(i).resetVelocity();
      this.nodes.get(i).setPosition(random(leftX, rightX), random(y, y + h));
    }
  }
  
  void startDrag() {
    for (int i = 0; i < nodes.size(); i++) {
      nodes.get(i).startDrag(this.x + this.xOffset, this.y + this.yOffset, this.scale);
    }
  }
  
  void drag(){
    for (int i = 0; i < nodes.size(); i++) {
      nodes.get(i).drag(this.x + this.xOffset, this.y + this.yOffset, this.scale);
    }
    
  }
  
  void stopDrag() {
    for (int i = 0; i < nodes.size(); i++) {
      nodes.get(i).stopDrag();
    }
  }
  
  void render(float x, float y, float w, float h, float time) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
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
    }
    //println(ke);


    for (int i = 0; i < nodes.size(); i++) {
      this.nodes.get(i).render(x + this.xOffset, y + this.yOffset, this.scale);
    }
    for (int i = 0; i < edges.size(); i++) {
      this.edges.get(i).render(x + this.xOffset, y + this.yOffset, this.scale);
    }
    
    
    
    
  }
    
}