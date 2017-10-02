FDDParser parser;
ForceDiagram diagram;
int lastFrame;
float x, y, w, h;
Slider scaleSlider = new Slider(0.5);

void setup() {
  size(800, 500);
  pixelDensity(2);
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
  lastFrame = frameCount;
}

void mousePressed() {
  scaleSlider.startDrag();
}

void mouseDragged() 
{
  if (scaleSlider.drag()) {
    diagram.setScale(scaleSlider.getPercentage() * 2.0);
  }
}


void mouseReleased() {
  if (scaleSlider.stopDrag()) {
    
  }
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

  
}