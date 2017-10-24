public class Button {
  float Width;
  float Height;
  float centerX;
  float centerY;
  String label;
  color backgroundColor;
  
  public Button(float x, float y, float w, float h, color c, String l) {
    Width = w;
    Height = h;
    centerX = x;
    centerY = y;
    label = l;
    backgroundColor = c;
  }
  
  public void setColor(color c) {
    this.backgroundColor = c;
  }
  public void setLabel(String l) {
    label = l;
  }
  
  public void setWidth(float w) {
    Width = w;
  }
  
  public void setHeight(float h) {
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
    rectMode(CORNER);
    rect(centerX, centerY, Width, Height);
    fill(0);
    textSize(14);
    textAlign(LEFT);
    //textAlign(CENTER,CENTER);
    text(label, centerX + 5, centerY + 15);
  }
}