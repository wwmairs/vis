import java.util.*; 

public class RectangleNode {
  private List<RectangleNode> children;
  private RectangleNode parent;
  private float area;
  float x, y, w, h, c;
  String id;
  
  RectangleNode() {
    this(0);
  }
  
  RectangleNode(float a) {
    this.setArea(a);
    this.parent = null;
    this.children = new ArrayList<RectangleNode>();
    this.c = 200;
  }
  
  void setArea(float a) {
    this.area = a; 
  }
  
  RectangleNode(float a, float w, float h) {
    this.area = a;
    this.w = w;
    this.h = h;
  }
  
  
  public float area() {
    if (children.size() > 0) {
      
       //calculate area 
       float areaSum = 0;
       
       // Iterate through the children and calculate their total area
       for (int index = 0; index < children.size(); index++) {
          areaSum = areaSum + children.get(index).area();
       }
       // Set the current rectangle node's area to the sum of its children's areas
       this.area = areaSum;
    }
    assert(this.area) > 0;
    return this.area;
  }
  
  public RectangleNode getParent() {
    if (this.parent != null) {
      return this.parent;
    } else {
      return this;
    }
  }
 
  public void setParent(RectangleNode newParent) {
    if (this.parent != null) {
      this.parent.children.remove(this);
    }
    this.parent = newParent;
    this.parent.addChild(this);
  }
  
  private void addChild(RectangleNode child) {
    this.children.add(child);
  }
  
  public RectangleNode childAtIndex(int index) {
    return this.children.get(index);
  } 
  
  public int numberOfChildren() {
    return this.children.size(); 
  }
  

  public float aspect() {
    return h / w;
  }
  
  public float pixelArea() {
    return w * h;
  }
  
  public void sortChildren() {
    Collections.sort(this.children, new Comparator<RectangleNode>() {
      public int compare(RectangleNode node1, RectangleNode node2) {
        if (node1.area() > node2.area()) return -1;
        if (node1.area() < node2.area()) return 1;
        return 0;
      }
    }); 
    
    for (int i = 0; i < this.children.size(); i++) {
      this.children.get(i).sortChildren();
    }
    
  }
  
  public void highlightHover() {
    for (int i = 0; i < this.children.size(); i++) {
      this.children.get(i).highlightHover();
    }
    if (this.hoverOver()) {
      this.c = 100;
    }
    else {
      this.c = 200;
    }
  }
  public RectangleNode nodeHoveredOver() {
    for (int i = 0; i < this.children.size(); i++) {
      if (this.children.get(i).hoverOver()){
        return this.children.get(i).nodeHoveredOver();
      }
    }
    return this;
  }
  
  public boolean hoverOver()  {
    return ((mouseX < x + w) && (mouseX > x) && (mouseY < y + h) && (mouseY > y));
  }
  
}