public class ForceDiagram {
  
  private List<Node> nodes;
  private List<Edge> edges;
  private float springConstant = 15;
  private float dampingConstant = 0.1;
  private float coulombConstant = 6000;
  private Node latest;
  private int drawingNewNode = 2;
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
  

  void updateNewNodeState() {
    drawingNewNode = (drawingNewNode + 1) % 3;
  }
  
  boolean makeNode(){
    boolean anyNodeHovered = false;
    for (int i = 0; i < this.nodes.size(); i++) {
      anyNodeHovered = anyNodeHovered || this.nodes.get(i).hover();
    }
    println(anyNodeHovered);
    if (!anyNodeHovered) {
      diagram.updateNewNodeState();
      Node newNode = new Node(2);
      latest = newNode;
      newNode.setPosition(getMouseX(),getMouseY());
      this.nodes.add(newNode);
    }
    return !anyNodeHovered;
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
  

  void makeEdge(Node node1) {
    Node node2 = null;
    for (int i = 0; i < this.nodes.size(); i++) {
      if (this.nodes.get(i).hover()){
        node2 = this.nodes.get(i);
        Edge newEdge = new Edge(node1, node2, dist(node1.x, node1.y, node2.x, node2.y));
        println(newEdge);
        edges.add(newEdge);
      }
    } 
  }
  
  void makeNewEdge() {
    println("about to make new edge");
    updateNewNodeState();
    for (int i = 0; i < this.nodes.size(); i++) {
      if (this.nodes.get(i).hover()){
        this.latest = this.nodes.get(i);
      }
    }
  }

  float kineticEnergy() {
    return this.kineticEnergy;
  }
  
  
  void render(float time) {
    
    float ke = 0;

     switch (drawingNewNode) {
      // determining size of new node
      case 0 :
        if (latest != null) {
          latest.incrementMass();
        }
        if (!mousePressed){
          updateNewNodeState();
        }
        break;
      // determining which node this one is connected to
      case 1 :
        // make edge
        line(latest.x, latest.y, getMouseX(), getMouseY());
        if (mousePressed && (mouseButton == LEFT)){
          makeEdge(latest);
          updateNewNodeState();
        }
        break;
      // normal behavior
      case 2 :
        for (int i = 0; i < edges.size(); i++) {
          this.edges.get(i).applyHookeForces(this.springConstant);
        }
        for (int i = 0; i < nodes.size(); i++) {
          for (int j = i + 1; j < nodes.size(); j++) {
            this.nodes.get(i).applyCoulombForce(nodes.get(j), this.coulombConstant);
          }
        }
    
        
        for (int i = 0; i < nodes.size(); i++) {
          nodes.get(i).updatePosition(time, this.dampingConstant);
          ke += this.nodes.get(i).kineticEnergy();
        }
        break;
      case 3:
        // make edge
        line(latest.x, latest.y, getMouseX(), getMouseY());
        if (!mousePressed){
          makeEdge(latest);
          drawingNewNode = 0;
        }
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