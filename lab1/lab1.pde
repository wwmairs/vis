public class Button {
  int Width;
  int Height;
  int centerX;
  int centerY;
  int state;
  String label;
  color backgroundColor;
  
  public Button(int w, int h, int x, int y, color c) {
    Width = w;
    Height = h;
    centerX = x;
    centerY = y;
    label = t1;
    backgroundColor = c;
    state = 0;
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
    if ((mouseX < (centerX + (Width / 2)) && (mouseX > (centerX - (Width / 2)))) &&
        (mouseY < (centerY + (Height / 2)) && (mouseY > (centerY - (Height / 2))))) {
          return true;
        } else {
          return false;
        }
  }
  
  void transition() {
    state = (state + 1) % 3;
    if (state == 0) {
      label = t1;
      backgroundColor = c1;
      Width = width / 2;
      Height = height / 2;
    } else if (state == 1) {
      label = t2;
      backgroundColor = c2;
      Width = width / 3;
      Height = height / 3;
    } else if (state == 2) {
      label = t3;
      backgroundColor = c3;
      Width = width / 4;
      Height = height / 4;
    };
  }
  void render() {
    rectMode(CENTER);
    fill(backgroundColor);
    rect(centerX, centerY, Width, Height);
    fill(0);
    textSize(14);
    textAlign(CENTER,CENTER);
    text(label, centerX, centerY);
  }
}

Button b1;
String t1 = "Hello, this is my button";
String t2 = "Why'd you click?";
String t3 = "Jeez, stop it";
color c1 = color(0, 255, 153);
color c2 = color(255, 255, 153);
color c3 = color(255, 80, 80);

void setup () {
  size(400, 300);
  rectMode(CENTER);
  b1 = new Button(width/2, height/2, width/2, height/2, c1);
}

void draw () {
  background(50);
  b1.render();
}

void mouseClicked () {
  if (b1.clickedOn()){
    clear();
    b1.transition();
  }
}