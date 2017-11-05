TreeMapWrapper ts;
LineChart lc;

static color PRIMARY1 = #e17775;
static color PRIMARY2 = #fb9d9b;
static color SECONDARY1 = #7379d4;
static color SECONDARY2 = #c3c5ec;

void setup() {
  size(600,600);
  
  Parser parser = new Parser("data.csv");
  ts = new TreeMapWrapper(parser.getRoots());
  ts.setCurrByYear("2011");
  lc = new LineChart(parser.getLines());

}

void draw() {
  background(255);
  ts.currTreeMap.drawTreeMap(0, 0, width, height/3);
  if ((keyPressed == true) && (key == ' ')) {
    ts.currTreeMap.getCurrentNode().nodeHoveredOver().toolTip();
  }
  lc.renderAll(0, height / 3, width, height / 3);
}

void mouseClicked() {
  if (inTreeMap()) {
    if (mouseButton == LEFT) {
      ts.currTreeMap.setTargetDepth(1);
    } else if (mouseButton == RIGHT) {
      ts.currTreeMap.setTargetDepth(-1);
    }
    
  } else if (inLineChart()) {
  
  } else if (inFlowChart()) {
  
  }
}

void mouseDragged() {
  if (inTreeMap()) {
    
  } else if (inLineChart()) {
  
  } else if (inFlowChart()) {
  
  }
}

boolean inTreeMap() {
  return mouseY < height / 3;
}

boolean inLineChart() {
  return mouseY < 2 * (height / 3);
}

boolean inFlowChart() {
  return mouseY < height;
}