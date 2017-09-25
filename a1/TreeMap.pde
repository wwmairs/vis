public class TreeMap {
  
  private RectangleNode root;
  private RectangleNode currNode;
  
  TreeMap(RectangleNode treeRoot) {
    this.root = treeRoot;
    this.currNode = this.root;
  }
  
  public void drawTreeMap(float x, float y, float w, float h) {
    float ratio = currNode.area() / (w * h);
    println("Ratio: ", ratio, "Area:", currNode.area());
    
    drawNode(root, x, y, w, h, ratio);
  }
  
  // x and y are the top-left corner's coordinates of the node being drawn
  // w and h are of the node being drawn
  public void drawNode(RectangleNode node, float x, float y, float w, float h, float ratio) {
    float shortSide = min(w, h);
    
    // Find if we are drawing horizontally or verticallyy
    boolean horizontal = false;
    if (shortSide == h) {
      horizontal = true;
    }
    
    float c1Ratio =0, c2Ratio = 0;
    
    float currX = x, currY = y, currWidth = w, currHeight = h;
    
    float currRowWidth = 0;
    
    int rowStart = 0;
    
    for (int currChild = 0; currChild < node.children.size(); currChild++) {
      println("SIZE", node.children.subList(rowStart, currChild+1).size());
      currRowWidth = updateRow(node.children.subList(rowStart, currChild+1), shortSide, horizontal, ratio);
      println("curr width", currRowWidth);
      c2Ratio = node.children.get(currChild).aspect();
      
      if (currChild == rowStart) {
        c1Ratio = c2Ratio;
        print("CONTINUE ON FIRST");
        continue;
      }
      
      // If the currChild is the last element and is a row of it's own, draw it!
      if (currChild == rowStart && currChild == node.children.size()-1) {
        currRowWidth = updateRow(node.children.subList(rowStart, currChild+1), shortSide, horizontal, ratio);
        drawRow(node.children.subList(rowStart, currChild+1), currX, currY, currWidth, currHeight, horizontal);
      }
      
      // DO THE CHECK
      if (!betterRatio(c2Ratio, c1Ratio)) {
         currRowWidth = updateRow(node.children.subList(rowStart, currChild), shortSide, horizontal, ratio);
         drawRow(node.children.subList(rowStart, currChild), currX, currY, currWidth, currHeight, horizontal);
         
         // Next row starts at currChild
         rowStart = currChild;
         
         currChild--;
         
         // Change subsection (currX, currY, ...) dimensions
         if (horizontal) {
           currX = currX + currRowWidth;
           currWidth = currWidth - currRowWidth;
         } else {
           currY = currY + currRowWidth;
           currHeight = currHeight - currRowWidth;
         }
         
         // Recalculate ShortSide and horizontal
         shortSide = min(currWidth, currHeight);
         if (shortSide == currHeight) {
            horizontal = true;
         }
         
      } else {
      
        c1Ratio = c2Ratio;
      
      }
      
    }
    
  }
  
  // returns true if the first arg is a better (more square, i.e. closer to 1) aspect that the second arg
  private boolean betterRatio(float r1, float r2) {
    if (Math.abs(r1 - 1) < Math.abs(r2 - 1)) {
      return true;
    } else {
      return false;
    }
  }
  
  // updates the w and h values of each node in a row, so that all that shit fits
  private float updateRow(List<RectangleNode> row, float shortSide, boolean horizontal, float ratio) {
    float rowWidth = sumArea(row) / shortSide;
    println("ROW SIZE: ", row.size(), "ROW AREA", sumArea(row));
    for (int i = 0; i < row.size(); i++) {
      RectangleNode rect = row.get(i);
      if (horizontal) {
        rect.w = rowWidth;
        rect.h = (rect.area() * ratio) / rowWidth;
        print("row_width", rect.w, " rect height", rect.h);
      } else {
        rect.h = rowWidth;
        rect.w = (rect.area() * ratio) / rowWidth;
      }
    }
    
    return rowWidth;
  }
  
  private float sumArea(List<RectangleNode> row) {
    float sum = 0;
    for (int i = 0; i < row.size(); i++) {
      sum += row.get(i).area();
    }
    return sum;
  }
  private void drawRow(List<RectangleNode> row, float x, float y, float canvasw, float canvash, boolean horizontal) {
    if (horizontal) {
      float startX = x;
      float startY = y + canvash;
      for (int i = 0; i < row.size(); i++) {
        RectangleNode r = row.get(i);
        startY = startY - r.h;
        print("drawing rect: ", startX, ",", startY, ",", r.w, ",", r.h);
        fill(88);
        rect(startX, startY, r.w, r.h);
      }
    } else {
      float startX = x;
      float startY = y + canvash - row.get(0).h;
      for (int i = 0; i < row.size(); i++) {
        RectangleNode r = row.get(i);
        print("drawing rect: ", startX, ",", startY, ",", r.w, ",", r.h);
        rect(startX, startY, r.w, r.h);
        startX = startX + r.w;
      }
    }
  }
   
  public void setCurrentNode(RectangleNode newCurr) {
    this.currNode = newCurr;
  }
      
  public RectangleNode getRoot(){
    return this.root;
  }
}