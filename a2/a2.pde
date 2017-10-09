FDDParser parser;
ForceDiagram diagram;
int lastFrame;
float x, y, w, h;
Slider scaleSlider = new Slider(1, 0, 4, "Scale");
Slider springSlider = new Slider(15, 0, 100, "Spring");
Slider dampingSlider = new Slider(0.1, 0.1, 0.9, "Damping");
Slider coulombSlider = new Slider(6000, 0, 10000, "Coulomb");

Button upButton = new Button(65, 120, 70, 40, color(240), "Up");
Button downButton = new Button(65, 220, 70, 40, color(240), "Down");
Button leftButton = new Button(25, 170, 70, 40, color(240), "Left");
Button rightButton = new Button(105, 170, 70, 40, color(240), "Right");
Button resetButton = new Button(40, 430, 120, 40, color(240), "Reset");

boolean mouseDown = false;
int movementSpeed = 5;

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
    
  parser = new FDDParser("data0.fdd");
  diagram = new ForceDiagram(parser.getNodes(), parser.getEdges());
  diagram.performInitialLayout(0, 0, w, h);
  
  diagram.setSpringConstant(springSlider.getValue());
  diagram.setCoulombConstant(coulombSlider.getValue());
  diagram.setDampingConstant(dampingSlider.getValue());
  springSlider.setValue(diagram.getSpringConstant());
  dampingSlider.setValue(diagram.getDampingConstant());
  coulombSlider.setValue(diagram.getCoulombConstant());
  
  lastFrame = frameCount;
}

void mouseClicked() {
  if (resetButton.mouseOver()) {
    diagram.resetOffset();
    scaleSlider.setValue(1);
    diagram.setScale(1);
    diagram.performInitialLayout(0, 0, w, h); 
  }
}

void mousePressed() {
  mouseDown = true;
  
  scaleSlider.startDrag();
  springSlider.startDrag();
  dampingSlider.startDrag();
  coulombSlider.startDrag();
}

void mouseDragged() 
{
  if (scaleSlider.drag()) {
    diagram.setScale(scaleSlider.getValue());
  }
  if (springSlider.drag()) {
    diagram.setSpringConstant(springSlider.getValue());
  }
  if (dampingSlider.drag()) {
    diagram.setDampingConstant(dampingSlider.getValue()) ;
  }
  if (coulombSlider.drag()) {
    diagram.setCoulombConstant(coulombSlider.getValue());
  }
  diagram.dragNode(x, y);
  
}


void mouseReleased() {
  mouseDown = false;
  if (scaleSlider.stopDrag()) {
    
  }
  springSlider.stopDrag();
  coulombSlider.stopDrag();
  dampingSlider.stopDrag();
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
  rect(0, 0, x, height);
  
  fill(230);
  rect(0,0, x, 60);
  
  fill(0);
  textSize(18);
  textAlign(CENTER, BOTTOM);
  text("Force-Directed", 0, 0, x, 30);
  textAlign(CENTER, TOP);
  text("Node-Link Diagram", 0, 30, x, 30);
  
  scaleSlider.render(20, 100, 180, 100);
  upButton.render();
  downButton.render();
  leftButton.render();
  rightButton.render();
  resetButton.render();
  springSlider.render(20, 300, 180, 300);
  dampingSlider.render(20,350, 180, 350);
  coulombSlider.render(20, 400, 180, 400);
  
  if (mouseDown) {
    if (upButton.mouseOver()) {
      diagram.incementOffset(0, movementSpeed); 
    }
    if (downButton.mouseOver()) {
      diagram.incementOffset(0, -1 * movementSpeed); 
    }
    if (leftButton.mouseOver()) {
      diagram.incementOffset(movementSpeed, 0); 
    }
    if (rightButton.mouseOver()) {
      diagram.incementOffset(-1 * movementSpeed, 0); 
    }
  }

  
}