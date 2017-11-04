static int MAX_TARGET_DEPTH = 2;
static color BOI = PRIMARY2;
static color WOMAN = PRIMARY1;
static color BACKGROUND = SECONDARY1;
static color FOREGROUND = SECONDARY2;

public class TreeMap {
  
  // Private Class Variables
  private RectangleNode rootNode;
  private RectangleNode currNode;
  private float padding = 10;
  private int maxDepth = 0, currDepth = 0;
  private color rootColor = BACKGROUND;
  private color leafColor = FOREGROUND;
  private int targetDepth = 0;
  
  // TreeMap Constructor
  //   - Set the root node, current node, and update the max tree depth
  TreeMap(RectangleNode treeRoot) {
    this.rootNode = treeRoot;
    this.rootNode.women();
    this.maxDepth = this.getMaxDepth(this.rootNode);
    this.targetDepth = 1;
    this.setCurrentNode(this.rootNode, 0);
  }
  
  // drawTreeMap
  //   - Draw the current tree map in the given frame
  //   - Set the padding based on the width and height
  public void drawTreeMap(float x, float y, float w, float h) {
    fill(255);
    this.padding = min(max(w, h) / 150.0, 6);
    this.currNode.x = x;
    this.currNode.y = y;
    this.currNode.w = w;
    this.currNode.h = h;
    
    // Draw the current root node
    drawNode(this.currNode, this.currDepth);
  }
  
  public void newDrawNode(RectangleNode node, int depth) {
    if (depth == targetDepth) {
      // draw gender breakdown
    } else {
      // draw children
    }
    float currX = node.x, currY = node.y, currWidth = node.w, currHeight = node.h;
  }
  // drawNode
  //   - draw the given node and layout all of its children
  //   - use "depth" to find the color of the node
  public void drawNode(RectangleNode node, int depth) {    

    // Set local variables to keep track of the remaining x, y, width, and height
    float currX = node.x, currY = node.y, currWidth = node.w, currHeight = node.h;
    
    // For all nodes being drawn (except the outermost node), pad it by this.padding on each side
    if (node != this.currNode) {
      node.x = node.x + this.padding; node.y = node.y + this.padding; node.w = node.w - (2 * this.padding); node.h = node.h - (2 * this.padding);
    }
    
    // Pad single children around the outside for extra visibility
    /*if (node.children.size() == 1) {
      if ((node.w > (6)) && (node.h > (6))) {
        currX = node.x + (this.padding/4);
        currY = node.y + (this.padding/4);
        currWidth = node.w - (this.padding/2);
        currHeight = node.h - (this.padding/2);
        
      // In case the view gets to small, limit the actual padding
      } else {
        currX = node.x - (this.padding/2);
        currY = node.y - (this.padding/2);
        currWidth = node.w + (this.padding);
        currHeight = node.h + (this.padding);
      }
    } */
    
    // Find if should layout horizontal or vertical row
    boolean horizontal = (currHeight < currWidth);

    // Set initial vars for child iteration
    int rowStart = 0;
    float currRowWidth = 0;
    
    // Get ratio for current node of its pixel area to its area
    float ratio = (currWidth * currHeight) / node.area();

    // Iterate through the children and layout all the rows
    for (int currChild = 0; currChild < node.children.size(); currChild++) {
      
      // Get the current row (from rowStart to currChild) and its potential width
      List<RectangleNode> currRow = node.children.subList(rowStart, currChild+1);

      // If the current row does not contain the smallest child, try to layout the next row and compare their aspect ratios
      if (currChild < node.children.size() - 1) {
        
        // Get the "next" row (one longer than the current row)
        List<RectangleNode> nextRow = node.children.subList(rowStart, currChild+2);
         //<>//
 //<>// //<>//
        
        // Do nextRatio calculation first in order to use the currRatio calculation in this iteration if necessary
        this.updateRowBounds(nextRow, currX, currY, currWidth, currHeight, ratio);
        
        // Calculate the shortest side of the current canvas
        float shortSide = min(currWidth, currHeight);
        
        // Find the "worst" aspect ratio of the next row
        float nextRatio = this.worst(nextRow, shortSide);
        
        // Get the row width of the current row (which may be helpful later) and find its "worst" aspect ratio
        currRowWidth = this.updateRowBounds(currRow, currX, currY, currWidth, currHeight, ratio);
        float currRatio = this.worst(currRow, shortSide);

        // If the next ratio is better than the current ratio, we need to continue iteration to check the next row
        if (currRatio > nextRatio) {
          continue;
        }
        
        
      // If this is the last child, update the row bounds!
      } else {
        currRowWidth = this.updateRowBounds(currRow, currX, currY, currWidth, currHeight, ratio);
      }
      
      // If we get here, we are going to start a new row      
      
      // If we are drawing a horizontal row, update the current x points. If not, update the y points.
      if (horizontal) { //<>//
        currX = currX + currRowWidth; //<>// //<>//
        currWidth = currWidth - currRowWidth ; //<>//
      } else {
        currY = currY + currRowWidth;
        currHeight = currHeight - currRowWidth;
      }
      
      // Find the new horizontal
      horizontal = (currHeight < currWidth);
      
      // Increment rowStart to the new row starting child
      rowStart = currChild + 1;
     
    }
    
    // After we have layed out the children, draw the current node
    
    // If the node is currently being hovered over, fill it in gray
    
    if (node == currNode.nodeHoveredOver()) {
      if (node.id == currNode.nodeHoveredOver().id)
        fill(#d5ffed);
    // Fill in the node to be on a spectrum between rootColor and leafColor, depending on its depth
    } else {
      fill(lerpColor(this.rootColor, this.leafColor, (this.maxDepth > 0) ? (float) depth / (float) this.maxDepth : 0));
    }
    
    if (node.hoverOver() && targetDepth == depth) {
      fill(#ffe2b9);
    }
    
    // Set the stroke weight depending on the depth, with a maximum of 2.5
    //strokeWeight(min(this.maxDepth - depth + 1, 1.5));
    
    // Draw the node!
    stroke(0);
    rect(node.x, node.y, node.w, node.h, 3);

    // Recursively draw all children, adding 1 to the depth
    if (this.targetDepth > depth) {
      for (int i = 0; i < node.children.size(); i++) {
        this.drawNode(node.children.get(i), depth + 1); 
      }
    } else {
      node.updateGenderBreakdown();
        this.drawGenderBreakdown(node, depth + 1);
    }
    
    // Draw the 'id' text label for each leaf node in black in the center of the node
    fill(0);
    if (node.children.size() == 0) {
      text(node.id, node.x + (node.w/2) - 8, node.y + (node.h / 2) + 3);
    } //<>//
  }
  
  // worst
  //   - finds the worst aspect ratio in the row //<>//
  private float worst(List<RectangleNode> row, float rowWidth) { //<>//
    
    // Calculate rowWidth^2, rowArea^2, and the sum pixelRowArea for the row
    float wSquared = rowWidth * rowWidth;
    float rowArea = sumPixelArea(row);
    float rowAreaSquared = rowArea * rowArea;
    
    // Complete the "worst" caluculation to find the worst aspect ratio of all nodes in the row
    return max(((wSquared * row.get(0).pixelArea()) / rowAreaSquared), (rowAreaSquared / (wSquared * row.get(row.size() - 1).pixelArea())));
  }
   //<>//
  // rowWidth
  //   - Get the width of a row, using the ratio of nodeArea (w*h) / rectArea (node.area())
  private float rowWidth(float rowArea, float ratio, float w, float h) {
    boolean horizontal = (h < w); //<>//
    return ratio * (rowArea / (horizontal ? h : w)); //<>//
  }
  
  // updateRowBounds
  //   - Update the w and h values of each node in a row using the rowWidth
  private float updateRowBounds(List<RectangleNode> row, float x, float y, float w, float h, float ratio) {
    
    boolean horizontal = (h < w);
    
    // Get the row sumArea and rowWidth
    float rowArea = sumArea(row);
    float rowWidth = rowWidth(rowArea, ratio, w, h);
    
    // Iterate over each child in the row
    for (int i = 0; i < row.size(); i++) {
      
      // Get the rect area to row area ratio, and update the node bounds if horizontal or not, accoringly
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
  
  // sumArea
  //   - Get the sum of all the areas in a row list
  private float sumArea(List<RectangleNode> row) {
    float sum = 0;
    for (int i = 0; i < row.size(); i++) {
      sum += row.get(i).area();
    }
    return sum;
  }
  
  // sumPixelArea
  //   - Get the sum of all the actual w*h pixels in a row
  private float sumPixelArea(List<RectangleNode> row) {
    float sum = 0;
    for (int i = 0; i < row.size(); i++) {
      sum += row.get(i).pixelArea();
    }
    return sum;
  }  
   
  // setCurrentNode
  //   - Set the current node and update the currDepth
  public void setCurrentNode(RectangleNode newCurr, int depth) {
    this.currNode = newCurr;
    this.currDepth = this.getDepth(this.currNode);
    this.targetDepth += depth;
  }
  
  public void setTargetDepth(int depth) {
    this.targetDepth += depth;
    if (targetDepth > 2) {
      targetDepth = 2;
    }
    if (targetDepth < 0) {
      targetDepth = 0;
    }
    println(targetDepth);
  }
      
  // getCurrentNode
  //   - Get the current root node
  public RectangleNode getCurrentNode() {
    return this.currNode;
  }
  
  // getRoot
  //   - get the root node
  public RectangleNode getRoot(){
    return this.rootNode;
  }
  
  // getMaxDepth
  //   - Recursively find the max depth of the tree
  private int getMaxDepth(RectangleNode node) {
    int maxDepth = 0;
    if (node.children.size() == 0) {
      return 0; 
    }
    for (int i = 0; i < node.children.size(); i++) {
      maxDepth = max(maxDepth, 1 + this.getMaxDepth(node.children.get(i)));
    }
    return maxDepth;
  }
  
  // getDepth
  //   - get the current depth of a node
  private int getDepth(RectangleNode node) {
    if (node.parent == null) {
      return 0; 
    }
    return 1 + this.getDepth(node.parent);
  }
  public void drawGenderBreakdown(RectangleNode node, int depth) {    
 //<>//
    // Set local variables to keep track of the remaining x, y, width, and height
    float currX = node.x, currY = node.y, currWidth = node.w, currHeight = node.h;
    
    // For all nodes being drawn (except the outermost node), pad it by this.padding on each side //<>//
    if (node != this.currNode) { //<>//
      node.x = node.x + this.padding; 
      node.y = node.y + this.padding; 
      node.w = node.w - (2 * this.padding); 
      node.h = node.h - (2 * this.padding);
    }
    
    // Find if should layout horizontal or vertical row
    boolean horizontal = (currHeight < currWidth);

    // Set initial vars for child iteration
    int rowStart = 0;
    float currRowWidth = 0;
    
    // Get ratio for current node of its pixel area to its area
    float ratio = (currWidth * currHeight) / node.area();

    // Iterate through the children and layout all the rows
    for (int currChild = 0; currChild < node.genderBreakdown.size(); currChild++) {
      
      // Get the current row (from rowStart to currChild) and its potential width
      List<RectangleNode> currRow = node.genderBreakdown.subList(rowStart, currChild+1);

      // If the current row does not contain the smallest child, try to layout the next row and compare their aspect ratios
      if (currChild < node.genderBreakdown.size() - 1) {
        
        // Get the "next" row (one longer than the current row)
        List<RectangleNode> nextRow = node.genderBreakdown.subList(rowStart, currChild+2);
         //<>//
 //<>//
        
        // Do nextRatio calculation first in order to use the currRatio calculation in this iteration if necessary
        this.updateRowBounds(nextRow, currX, currY, currWidth, currHeight, ratio);
        
        // Calculate the shortest side of the current canvas
        float shortSide = min(currWidth, currHeight);
        
        // Find the "worst" aspect ratio of the next row
        float nextRatio = this.worst(nextRow, shortSide);
        
        // Get the row width of the current row (which may be helpful later) and find its "worst" aspect ratio
        currRowWidth = this.updateRowBounds(currRow, currX, currY, currWidth, currHeight, ratio);
        float currRatio = this.worst(currRow, shortSide);

        // If the next ratio is better than the current ratio, we need to continue iteration to check the next row
        if (currRatio > nextRatio) {
          continue;
        }
        
        
      // If this is the last child, update the row bounds!
      } else {
        currRowWidth = this.updateRowBounds(currRow, currX, currY, currWidth, currHeight, ratio);
      }
       //<>//
      // If we get here, we are going to start a new row       //<>//
      
      // If we are drawing a horizontal row, update the current x points. If not, update the y points.
      if (horizontal) { //<>//
        currX = currX + currRowWidth; //<>// //<>//
        currWidth = currWidth - currRowWidth ; //<>//
      } else {
        currY = currY + currRowWidth;
        currHeight = currHeight - currRowWidth;
      }
      
      // Find the new horizontal
      horizontal = (currHeight < currWidth);
      
      // Increment rowStart to the new row starting child
      rowStart = currChild + 1;
     
    }
    
    // After we have layed out the children, draw the current node
    
    // If the node is currently being hovered over, fill it in gray
    /*if (node.id == currNode.nodeHoveredOver().id) {
      fill(100);
    // Fill in the node to be on a spectrum between rootColor and leafColor, depending on its depth
    } else {
      fill(lerpColor(this.rootColor, this.leafColor, (this.maxDepth > 0) ? (float) depth / (float) this.maxDepth : 0));
    } */
    
    // Set the stroke weight depending on the depth, with a maximum of 2.5
    //strokeWeight(min(this.maxDepth - depth + 1, 2.5));
    
    // Draw the node! //<>//
    //rect(node.x, node.y, node.w, node.h, 3);

    // Recursively draw all children, adding 1 to the depth //<>//
      for (int i = 0; i < 2 ; i++) { //node.genderBreakdown.size() //<>//
        RectangleNode drawMe = node.genderBreakdown.get(i);
        if (i == 0) fill(BOI);
        else fill(WOMAN);
        stroke(0);
        drawMe.x = drawMe.x + this.padding; 
        drawMe.y = drawMe.y + this.padding; 
        drawMe.w = drawMe.w - (2 * this.padding); 
        drawMe.h = drawMe.h - (2 * this.padding);
        rect(drawMe.x, drawMe.y, drawMe.w, drawMe.h, 3);
        fill(255);
      }
    
    // Draw the 'id' text label for each leaf node in black in the center of the node
    fill(0);
    textAlign(CENTER);
    text(node.id, node.x + (node.w/2) - 8, node.y + (node.h / 2) + 3);
    
  }
}