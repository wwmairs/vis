public class TreeMap {
  
  private RectangleNode root;
  private RectangleNode currNode;
  
  TreeMap(RectangleNode treeRoot) {
    this.root = treeRoot;
    this.currNode = this.root;
  }
  
  public void drawTreeMap() {
    float canvas_area = width * height;
    float total_value = currNode.area();
    float VA_ratio = total_value / canvas_area;
    drawNode(root, 0, 0, width, height, VA_ratio);
  }
  
  // x and y are the top-left corner's coordinates of the node being drawn
  // Width and Height are of the node being drawn
  public void drawNode(RectangleNode node, float x, float y, float Width, float Height, float ratio) {
    float short_side = min(Width, Height);
    boolean horizontal = false;
    if (short_side == Height) {
      horizontal = true;
    }
    int currChild = 0;
    List<RectangleNode> row;
    RectangleNode c1 = node.children.get(currChild);
    row.add(c1);
    updateRow(row, short_side, horizontal, ratio);
    do {
      currChild++;
      RectangleNode c2 = node.children.get(currChild);
      row.add(c2);
      updateRow(row, short_side, horizontal, ratio);
      float c1_ratio = c1.aspect();
      float c2_ratio = c2.aspect();
      c1 = c2;
    } while (betterRatio?(c2_ratio, c1_ratio) );    
  }
  
  // returns true if the first arg is a better (more square, i.e. closer to 1) aspect that the second arg
  private boolean betterRatio?(float r1, float r2) {
    if (Math.abs(r1 - 1) < Math.abs(r2 - 1)) {
      return true;
    } else {
      return false;
    }
  }
  
  // updates the w and h values of each node in a row, so that all that shit fits
  private void updateRow(List<RectangleNode> row, float short_side, boolean horizontal, float ratio) {
    float row_width = sumArea(row) / short_side;
    for (int i = 0; i < row.size(); i++) {
      RectangleNode rect = row.get(i);
      if (horizontal) {
        rect.w = row_width;
        rect.h = (rect.area() / ratio) / row_width;
      } else {
        rect.h = row_width;
        rect.w = (rect.area() / ratio) / row_width;
      }
    }
  }
  
  private float sumArea(List<RectangleNode> row) {
    float sum = 0;
    for (int i = 0; i < row.size(); i++) {
      sum += row.get(i).area();
    }
    return sum;
  }
  private void drawRow(List<RectangleNode> row, float x, float y, boolean horizontal) {
  }
   
  public void setCurrentNode(RectangleNode newCurr) {
    this.currNode = newCurr;
  }
      
}