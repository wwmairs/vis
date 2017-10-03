FDDParser parser;
ForceDiagram diagram;
int lastFrame;
float x, y, w, h;
Slider scaleSlider = new Slider(0.25);
Slider horizontalSlider = new Slider(0.5);
Slider verticalSlider = new Slider(0.5);

Button upButton = new Button(65, 40, 70, 40, color(240), "Up");
Button downButton = new Button(65, 140, 70, 40, color(240), "Down");
Button leftButton = new Button(25, 90, 70, 40, color(240), "Left");
Button rightButton = new Button(105, 90, 70, 40, color(240), "Right");

void setup() {
  size(800, 500);
  pixelDensity(displayDensity());
  surface.setResizable(true);
  
  // SET INITIAL X AND Y OF DRAWING
  x = 200;
  y = 0;
  
  // CALCULATE WIDTH AND HEIGHT
  w = width - x;
  h = height;
    
  parser = new FDDParser("data2.fdd");
  diagram = new ForceDiagram(parser.getNodes(), parser.getEdges());
  diagram.performInitialLayout(0, 0, w, h);
  lastFrame = frameCount;
}

void mouseClicked() {
  if (upButton.mouseOver()) {
    diagram.incementOffset(0, 20); 
  }
  if (downButton.mouseOver()) {
    diagram.incementOffset(0, -20); 
  }
  if (leftButton.mouseOver()) {
    diagram.incementOffset(20, 0); 
  }
  if (rightButton.mouseOver()) {
    diagram.incementOffset(-20, 0); 
  }
}

void mousePressed() {
  scaleSlider.startDrag();
  horizontalSlider.startDrag();
  verticalSlider.startDrag();
}

void mouseDragged() 
{
  if (scaleSlider.drag()) {
    diagram.setScale(scaleSlider.getPercentage() * 4.0);
  }
  if (horizontalSlider.drag()) {
    diagram.setScale(scaleSlider.getPercentage() * 4.0);
  }
  if (verticalSlider.drag()) {
    diagram.setScale(scaleSlider.getPercentage() * 4.0);
  }
}


void mouseReleased() {
  if (scaleSlider.stopDrag()) {
    
  }
  horizontalSlider.stopDrag();
  verticalSlider.stopDrag();
}


void draw() {
  background(255);
  
  
  // Calculate the delta time using the frame difference between the last two draw periods and the frame rate
  int currFrame = frameCount;
  float time = (float)(currFrame - lastFrame) / (float)frameRate;
  lastFrame = currFrame;
  
  // Render the diagram!
  diagram.render(x, y, w, h, time);
  
  // Render the sidebar
  fill(240);
  rect(0, 0, 200, height);
  scaleSlider.render(20, 20, 180, 20);
  upButton.render();
  downButton.render();
  leftButton.render();
  rightButton.render();
  //horizontalSlider.render(20, 50, 180, 50);
  //verticalSlider.render(20, 80, 180, 80);

  
}