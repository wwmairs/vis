import java.util.*; 

public class RectangleNode {
  private List<RectangleNode> children;
  private List<RectangleNode> genderBreakdown;
  private RectangleNode parent;
  private float area;
  private float women;
  float x, y, w, h;
  String id;
  
  RectangleNode() {
    this(0);
  }
  
  RectangleNode(float a) {
    this.setArea(a);
    this.parent = null;
    this.children = new ArrayList<RectangleNode>();
    this.genderBreakdown = new ArrayList<RectangleNode>();
  }
  
  void setArea(float a) {
    this.area = a; 
  }
  
  void setWomen(float w) {
    this.women = w;
  }
  
  RectangleNode(float a, float w, float h) {
    this.area = a;
    this.w = w;
    this.h = h;
  }
  
  public void updateGenderBreakdown() {
      genderBreakdown.add(0, new RectangleNode(this.area() - this.women));
      genderBreakdown.add(1, new RectangleNode(this.women));
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
    assert this.area > 0;
    return this.area;
  }
  
  public float women() {
    if (children.size() > 0) {
      float womenSum = 0;
      for (int i = 0; i < children.size(); i++) {
        womenSum += children.get(i).women();
      }
      this.women = womenSum;
    }
    assert this.women > 0;
    return this.women;
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
  
  public float getColor() {
    if (this.hoverOver()) {
      return 100;
    } else {
      return 200;
    }
  }
  public RectangleNode nodeHoveredOver() {
    for (int i = 0; i < this.children.size(); i++) {
      if (this.children.get(i).hoverOver()){
        return this.children.get(i).nodeHoveredOver();
      }
    }
    if (hoverOver()) {
      return this;
    }
    return null;
  }
  
  public boolean hoverOver()  {
    return ((mouseX < x + w) && (mouseX > x) && (mouseY < y + h) && (mouseY > y));
  }
  
  public void toolTip() {
    fill(255);
    stroke(0);
    rect(mouseX - 5, mouseY - 17, 140, 25);
    fill(0);
    text("Node: " + this.id + ", Value: " + nf(this.area(), 0, 0), mouseX, mouseY);
  }
  
}