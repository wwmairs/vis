public class TreeMap {
  
  private RectangleNode root;
  private RectangleNode currNode;
  
  TreeMap(RectangleNode treeRoot) {
    this.root = treeRoot;
    this.currNode = this.root;
  }
  
  public void drawTreeMap(float x, float y, float Width, float Height) {
  }
  
  public void drawNode(float x, float y, float Width, float Height) {
  }
  
  private void squarify(List<RectangleNode> children, List<RectangleNode> row, RectangleNode subRectangle) {
    float w = subRectangle.width();
    
    
    
  }
  
  private void layoutRow() {
  }
  
  private float worst(List<RectangleNode> row, float w) {
    return max( ((w*w) * maxArea(row))/(sumArea(row) * sumArea(row)),(sumArea(row) * sumArea(row))/((w*w) * minArea(row)));
  }
  
  private float maxArea(List<RectangleNode> row){
    float currMax = row.get(0).area();
    for (int i = 0; i < row.size(); i++) {
      if (row.get(i).area() > currMax) {
        currMax = row.get(i).area();
      }
    }
    return currMax;
  }
  private float minArea(List<RectangleNode> row){
    float currMin = row.get(0).area();
    for (int i = 0; i < row.size(); i++) {
      if (row.get(i).area() < currMin) {
        currMin = row.get(i).area();
      }
    }
    return currMin;
  }
  private float sumArea(List<RectangleNode> row){
    float sum = 0;
    for (int i = 0; i < row.size(); i++) {
      sum += row.get(i).area();
    }
    return sum;
  }
  
  public void setCurrentNode(RectangleNode newCurr) {
    this.currNode = newCurr;
  }
      
}