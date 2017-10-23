public class Button {
  int Width;
  int Height;
  int centerX;
  int centerY;
  String label;
  color backgroundColor;
  
  public Button(int x, int y, int w, int h, color c, String l) {
    Width = w;
    Height = h;
    centerX = x;
    centerY = y;
    label = l;
    backgroundColor = c;
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
    println("mouse at: ", mouseX, mouseY);
    println("about to draw rect: ", centerX, centerY, Width, Height);
    rect(centerX, centerY, Width, Height);
    fill(0);
    textSize(14);
    textAlign(LEFT);
    //textAlign(CENTER,CENTER);
    text(label, centerX + 5, centerY + 15);
  }
}