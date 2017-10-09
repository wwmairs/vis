FDDParser parser;
ForceDiagram diagram;
int lastFrame;
float x, y, w, h, scale;
float translateX, translateY;
float mx = 0;
float my = 0;

float springInitial = 30;
float dampingInitial = 0.1;
float coulombInitial = 100000;

boolean draggingNode = false;
boolean draggingDiagram = false;

Slider springSlider = new Slider(springInitial, 0, 200, "Spring");
Slider dampingSlider = new Slider(dampingInitial, 0.05, 0.4, "Damping");
Slider coulombSlider = new Slider(coulombInitial, 0, 200000, "Coulomb");

Button resetNodesButton = new Button(20, 420, 75, 40, color(240), "Reset Nodes");
Button resetConstantsButton = new Button(105, 420, 75, 40, color(240), "Reset Constants");

import processing.awt.PSurfaceAWT.SmoothCanvas;
import javax.swing.JFrame;
import java.awt.Dimension;

void setup() {
  size(800, 500);
  pixelDensity(displayDensity());
  SmoothCanvas sc = (SmoothCanvas) getSurface().getNative();
  JFrame jf = (JFrame) sc.getFrame();
  Dimension d = new Dimension(400, 305);
  jf.setMinimumSize(d);
  println(jf.getMinimumSize());
  surface.setResizable(true);
    
  parser = new FDDParser("data2.dd");
  diagram = new ForceDiagram(parser.getNodes(), parser.getEdges());
  
  layoutDiagram();
  
  diagram.setSpringConstant(springSlider.getValue());
  diagram.setCoulombConstant(coulombSlider.getValue());
  diagram.setDampingConstant(dampingSlider.getValue());
  
  lastFrame = frameCount;
}

void layoutDiagram() {
  // SET INITIAL X AND Y OF DRAWING
  x = 200;
  y = 0;
  scale = 1.0;
  
  translateX = 0;
  translateY = 0;
    
  // CALCULATE WIDTH AND HEIGHT
  w = width - x;
  h = height;
  
  diagram.performInitialLayout(0, 0, w, h);
}

void mouseClicked() {
  if (resetNodesButton.mouseOver()) {
    layoutDiagram();
  }
  
  if (resetConstantsButton.mouseOver()) {
    coulombSlider.setValue(coulombInitial);
    springSlider.setValue(springInitial);
    dampingSlider.setValue(dampingInitial);
    diagram.setSpringConstant(springSlider.getValue());
    diagram.setCoulombConstant(coulombSlider.getValue());
    diagram.setDampingConstant(dampingSlider.getValue());
  }
}

void mousePressed() {
  springSlider.startDrag();
  dampingSlider.startDrag();
  coulombSlider.startDrag();
  
  beginScaling();
  draggingNode = diagram.startDrag();
  endScaling();
  
  if (!draggingNode) {
    if (mouseX > x && mouseY > y) {
      draggingDiagram = true;
    }
  }
}

void beginScaling() {
  pushMatrix();

  translate(x + translateX, y + translateY);
  mx -= (x + translateX);
  my -= (y + translateY);
  scale(scale); 
}

void endScaling() {
  mx += (x + translateX);
  my += (y + translateY);
  popMatrix();
}

float getMouseX() {
  return (mouseX + mx) / scale; 
}

float getMouseY() {
  return (mouseY + my) / scale; 
}

void keyPressed() {
  if (key == 'r') {
    scale = 1;
    x = 200;
    y = 0;
  }
}

void mouseDragged() 
{
  if (springSlider.drag()) {
    diagram.setSpringConstant(springSlider.getValue());
  }
  if (dampingSlider.drag()) {
    diagram.setDampingConstant(dampingSlider.getValue()) ;
  }
  if (coulombSlider.drag()) {
    diagram.setCoulombConstant(coulombSlider.getValue());
  }
  

  
  if (draggingDiagram) {
    translateX += (mouseX - pmouseX);
    translateY += (mouseY - pmouseY);
  }
}


void mouseReleased() {

  springSlider.stopDrag();
  coulombSlider.stopDrag();
  dampingSlider.stopDrag();
  diagram.stopDrag();
  draggingNode = false;
  draggingDiagram = false;
}


void mouseWheel(MouseEvent e) {
  translateX -= (mouseX - x);
  translateY -= (mouseY - y);
  float delta = e.getCount() > 0 ? 1.05 : e.getCount() < 0 ? 1.0/1.05 : 1.0;
  scale *= delta;
  translateX *= delta;
  translateY *= delta;
  translateX += (mouseX - x);
  translateY += (mouseY - y);
}

void draw() {
  background(255);
    
  // Calculate the delta time using the frame difference between the last two draw periods and the frame rate
  int currFrame = frameCount;
  float time = (float)(currFrame - lastFrame) / (float)frameRate;
  lastFrame = currFrame;
  
  beginScaling();
  // Render the diagram!
  diagram.render(time);
  if (mousePressed) {
    draggingNode = diagram.drag(); 
  }
  
  endScaling();

  
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
  
  resetNodesButton.setPosition(20,height-80);
  resetNodesButton.render();
  
  resetConstantsButton.setPosition(105,height-80);
  resetConstantsButton.render();
  
  springSlider.render(20, 100, 180, 100);
  dampingSlider.render(20,150, 180, 150);
  coulombSlider.render(20, 200, 180, 200);
  println(height);
  fill(230);
  rect(0, height-20, x, 20);
  fill(70, 90, 200);
  textSize(10);
  textAlign(CENTER, CENTER);
  text("by William Mairs and Max Greenwald", 0, height-20, x, 20);

  
}