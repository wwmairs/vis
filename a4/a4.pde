TreeMap t;
TreeMapWrapper ts;

void setup() {
  size(500,800);
  
  Parser parser = new Parser("data.csv");
  //t = new TreeMap(parser.getRoots().get("2016")); 
  //t.setCurrentNode(t.getRoot());
  ts = new TreeMapWrapper(parser.getRoots());
  ts.setCurrByYear("2011");
}

void draw() {
  ts.currTreeMap.drawTreeMap(0, 0, width, height/3);
  if ((keyPressed == true) && (key == ' ')) {
    ts.currTreeMap.getCurrentNode().nodeHoveredOver().toolTip();
  } 
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    ts.currTreeMap.setCurrentNode(ts.currTreeMap.getCurrentNode().nodeHoveredOver());
  } else if (mouseButton == RIGHT) {
    ts.currTreeMap.setCurrentNode(ts.currTreeMap.getCurrentNode().getParent());
  }
}