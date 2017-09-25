TreeMap t;
void setup() {
  SHFParser parser = new SHFParser("./hierarchy2.shf");
  println(parser.getRootNode().children);
  t = new TreeMap(parser.getRootNode()); 
  t.setCurrentNode(t.getRoot());
  size(800,500);
  pixelDensity(2);
  surface.setResizable(true);
}

void draw() {
  t.drawTreeMap(0, 0, width, height);
}

void mouseMoved() {
  t.getCurrentNode().highlightHover();
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    t.setCurrentNode(t.getCurrentNode().nodeHoveredOver());
  } else if (mouseButton == RIGHT) {
    t.setCurrentNode(t.getCurrentNode().getParent());
  }
}