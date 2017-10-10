public class Button {
  float x, y, w, h;
  String text;
  color background;
  
  public Button(String text, color c) {
    this.text = text;
    this.background = c;
  }
  
  public void setLabel(String l) {
    text = l;
  }

  boolean mouseOver(){
    if (mouseX > this.x && mouseX < (this.x + this.w) && mouseY > this.y && mouseY < (this.y + this.h)) {
          return true;
        } else {
          return false;
        }
  }
  
  void render(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    if (this.mouseOver()) {
      fill(150);
    } else {
      fill(this.background);
    }
    
    rect(x, y, w, h);
    fill(0);
    textSize(14);
    textLeading(12);
    textAlign(CENTER, CENTER);
    text(text, x, y, w, h-5);
  }
}