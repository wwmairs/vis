TreeMapWrapper ts;
LineChart lc;


void setup() {
  size(600,700);
  
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
  lc.renderCategory(0, height / 3, width, height / 3, "flight attendant");
}

void mouseClicked() {
  if (mouseY < height / 3) {
    // the mouse is over the treemap
    if (mouseButton == LEFT) {
      ts.currTreeMap.setTargetDepth(1);
    } else if (mouseButton == RIGHT) {
      ts.currTreeMap.setTargetDepth(-1);
    }
  }
}