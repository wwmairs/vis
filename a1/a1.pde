TreeMap t;
void setup() {
  SHFParser parser = new SHFParser("./hierarchy1.shf");
  println(parser.getRootNode().children);
  t = new TreeMap(parser.getRootNode()); 
  t.setCurrentNode(t.getRoot());
  size(800,500);
  noLoop();
}

void draw() {
  t.drawTreeMap();
}