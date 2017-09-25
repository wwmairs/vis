public class TreeMap {
  
  private RectangleNode root;
  private RectangleNode currNode;
  private int padding;
  
  TreeMap(RectangleNode treeRoot) {
    this.root = treeRoot;
    this.currNode = this.root;
  }
  
  public void drawTreeMap(float x, float y, float w, float h) {
    fill(255);
    line(0, 0, 6, 6);
    this.padding = 6;
    this.currNode.x = x;
    this.currNode.y = y;
    this.currNode.w = w;
    this.currNode.h = h;
    drawNode(this.currNode);
  }
  
  // x and y are the top-left corner's coordinates of the nde being drawn
  // w and h are of the node being drawn
  public void drawNode(RectangleNode node) {    
    // Find if we are drawing horizontally or vertically
    
    //float currX = node.x, currY = node.y, currWidth = node.w, currHeight = node.h;
    
    float currX = node.x + this.padding, currY = node.y + this.padding, currWidth = node.w - (2 * this.padding), currHeight = node.h - (2 * this.padding);
    //node.x = currX; node.y = currY; node.w = currWidth; node.h = currHeight;
    
    boolean horizontal = (currHeight < currWidth);

    int rowStart = 0;
    float currRowWidth = 0;
    float ratio = (currWidth * currHeight) / node.area();
    println(ratio);
    
    for (int currChild = 0; currChild < node.children.size(); currChild++) {
      List<RectangleNode> currRow = node.children.subList(rowStart, currChild+1);
      currRowWidth = rowWidth(sumArea(currRow), ratio, currWidth, currHeight);

      if (currChild < node.children.size() - 1) {
        List<RectangleNode> nextRow = node.children.subList(rowStart, currChild+2);
        
        float nextRowWidth = rowWidth(sumArea(nextRow), ratio, currWidth, currHeight);
        
        float shortSide = min(currWidth, currHeight);
        
        // Do nextRatio calculation first in order to use the currRatio calculation in this iteration if possible
        // without recalculating
        this.updateRowBounds(nextRow, currX, currY, currWidth, currHeight, ratio);
        float nextRatio = this.worst(nextRow, shortSide);
        
        
        this.updateRowBounds(currRow, currX, currY, currWidth, currHeight, ratio);
        float currRatio = this.worst(currRow, shortSide);

        if (currRatio > nextRatio) {
          continue;
        }
        
      } else {
        this.updateRowBounds(currRow, currX, currY, currWidth, currHeight, ratio);
      }
      
      if (horizontal) {
        currX = currX + currRowWidth; //<>//
        currWidth = currWidth - currRowWidth ;
      } else {
        currY = currY + currRowWidth;
        currHeight = currHeight - currRowWidth;
      }
      
      horizontal = (currHeight < currWidth);
      
      rowStart = currChild + 1;
     
    }
    
    // Draw the current node
    if (node.parent != this.currNode) {
      fill(200);
    } else {
      fill(100);
    }
    
    if (node.children.size() == 0 && node.parent != this.currNode) {
      strokeWeight(1); //<>//
    } else {
      strokeWeight(1);
    }
    
    if (node != this.currNode) {
      //rect(node.x, node.y, node.w, node.h);
      rect(node.x + this.padding, node.y + this.padding, node.w - (this.padding * 2), node.h - (this.padding * 2));
    }
    for (int i = 0; i < node.children.size(); i++) {
      RectangleNode child = node.children.get(i);
      this.drawNode(child); 
    }
    fill(0);
    text(node.id, node.x + (node.w/2) - 10, node.y + (node.h / 2));
    
    
    
  }
  
  private boolean horizontal(float w, float h) {
    return (w < h);
  }
  
  // returns true if the first arg is a better (more square, i.e. closer to 1) aspect that the second arg
  private float worst(List<RectangleNode> row, float rowWidth) {
    float wSquared = rowWidth * rowWidth;
    float rowArea = sumPixelArea(row);
    float rowAreaSquared = rowArea * rowArea;
    return max(((wSquared * row.get(0).pixelArea()) / rowAreaSquared), (rowAreaSquared / (wSquared * row.get(row.size() - 1).pixelArea())));
  }
  
  private float rowWidth(float rowArea, float ratio, float w, float h) {
    boolean horizontal = (h < w);
    return ratio * (rowArea / (horizontal ? h : w)); //<>//
  }
  
  // updates the w and h values of each node in a row
  private float updateRowBounds(List<RectangleNode> row, float x, float y, float w, float h, float ratio) {
    boolean horizontal = (h < w);
    float rowArea = sumArea(row);
    float rowWidth = rowWidth(rowArea, ratio, w, h);
    for (int i = 0; i < row.size(); i++) {
      RectangleNode rect = row.get(i);
      float rectToRowRatio = rect.area() / rowArea;
      
      if (horizontal) {
        rect.x = x;
        rect.y = (i < 1) ? y : (row.get(i-1).y + row.get(i-1).h);
        rect.w = rowWidth;
        rect.h = rectToRowRatio * h;
      } else {
        rect.x = (i < 1) ? x : (row.get(i-1).x + row.get(i-1).w);;
        rect.y = y;
        rect.w = rectToRowRatio * w;
        rect.h = rowWidth;
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
  
  private float sumPixelArea(List<RectangleNode> row) {
    float sum = 0;
    for (int i = 0; i < row.size(); i++) {
      sum += row.get(i).pixelArea();
    }
    return sum;
  }  
   
  public void setCurrentNode(RectangleNode newCurr) {
    this.currNode = newCurr;
  }
      
  public RectangleNode getRoot(){
    return this.root;
  }
}