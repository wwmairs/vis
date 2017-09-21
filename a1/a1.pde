void setup() {
  SHFParser parser = new SHFParser("./hierarchy2.shf");
  println(parser.getRootNode().children);
}

void draw() {
  
}