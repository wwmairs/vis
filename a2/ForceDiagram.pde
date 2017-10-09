public class ForceDiagram {
  
  private List<Node> nodes;
  private List<Edge> edges;
  private float springConstant = 15;
  private float dampingConstant = 0.1;
  private float coulombConstant = 6000;
  private float kineticEnergy = 0;
  
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
      
      // This was used to ensure nodes were not on top of each other by strictly setting left and right x positions
      // and then choosing a random Y. Later, we decided that this did not make sense.
      //leftX = x + (i * spacing) + padding;
      //rightX = leftX + spacing - (padding * 2);
       
      // Update the node's position to be random
      this.nodes.get(i).resetVelocity();
      this.nodes.get(i).setPosition(random(x, x+w), random(y, y + h));
    }
  }
  
  boolean startDrag() {
    for (int i = 0; i < nodes.size(); i++) {
      if (nodes.get(i).startDrag()) {
        return true;
      }
    }
    return false;
  }
  
  boolean drag(){
    for (int i = 0; i < nodes.size(); i++) {
      if (nodes.get(i).drag()) {
        return true;
      }
    }
    return false;
  }
  
  void stopDrag() {
    for (int i = 0; i < nodes.size(); i++) {
      nodes.get(i).stopDrag();
    }
  }
  
  float kineticEnergy() {
    return this.kineticEnergy;
  }
  
  
  void render(float time) {
    //println(getMouseX(), getMouseY());
    
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
    this.kineticEnergy = ke;


    for (int i = 0; i < nodes.size(); i++) {
      this.nodes.get(i).render();
    }
    for (int i = 0; i < edges.size(); i++) {
      this.edges.get(i).render();
    }
    
  }
    
}