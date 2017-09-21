import java.util.*; 

public class RectangleNode {
  private List<RectangleNode> children;
  private RectangleNode parent;
  private float x, y, w, h, area;
  
  RectangleNode() {
    this(0);
  }
  
  RectangleNode(float a) {
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
          areaSum += children.get(index).calculateArea();
       }
       // Set the current rectangle node's area to the sum of its children's areas
       this.area = areaSum;
    }
    
    assert(this.area) > 0;
    return this.area;
  }
  
  public RectangleNode getParent() {
    return this.parent;
  }
 
  public void setParent(RectangleNode newParent) {
    this.parent = newParent;
  }
  
  public void addChild(RectangleNode child) {
    this.children.add(child);
  }
  
  public RectangleNode childAtIndex(int index) {
    return this.children.get(index);
  } 
  
  public int numberOfChildren() {
    return this.children.size(); 
  }
  
  public float aspect() {
    if (this.w && this.h) {
      return (h/w);
    }
  }
  
  // and important function for squarify
  public float width() {
    if (this.aspect() < 1) {
      return this.h;
    }
    else {
      return this.w;
    }
  }

  
}