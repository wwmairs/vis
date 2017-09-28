public class Button {
  int Width;
  int Height;
  int centerX;
  int centerY;
  String label;
  color backgroundColor;
  
  public Button(int w, int h, int x, int y, color c) {
    Width = w;
    Height = h;
    centerX = x;
    centerY = y;
    label = "Bars";
    backgroundColor = c;
  }
  
  public void changeLabel() {
    if (label == "Bars") {
      label = "Lines";
    } else {
      label = "Bars";
    }
  }
  
  public void setLabel(String l) {
    label = l;
  }
  
  public void setWidth(int w) {
    Width = w;
  }
  
  public void setHeight(int h) {
    Height = h;
  }
  
  boolean clickedOn(){
    if ((mouseX < (centerX + Width ) && (mouseX > centerX)) &&
        (mouseY < (centerY + Height) && (mouseY > centerY))) {
          return true;
        } else {
          return false;
        }
  }
  
  void render() {
    println("drawing button");
    fill(backgroundColor);
    rect(centerX, centerY, Width, Height);
    fill(0);
    textSize(14);
    textAlign(CENTER,CENTER);
    text(label, centerX, centerY);
  }
}