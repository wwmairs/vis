TreeMapWrapper ts;
LineChart lc;
FlowChart fc;

//List<String> categories;
//String currYear;
Manager manager;

static color PRIMARY1 = #23AA84;
static color PRIMARY2 = #a7ddcd;
static color SECONDARY1 = #7e7e7e;
static color SECONDARY2 = #d3d3d3;

// TreeMap margins
static float SIDE_MARGIN = 10;
static float TOP_MARGIN = 10;

void setup() {
  size(600,650);
  //currYear = "2011";
  
  Parser parser = new Parser("data.csv", "scholarship_data.csv");
  manager = new Manager("2016", "student", 2, parser.getCategories(), "");
  //categories = parser.getCategories();
  ts = new TreeMapWrapper(parser.getRoots());
  lc = new LineChart(parser.getLines());
  fc = new FlowChart(parser.getScholarships());
}

void draw() {
  background(255);
  update();
  ts.currTreeMap.drawTreeMap(SIDE_MARGIN, TOP_MARGIN, width - (2* SIDE_MARGIN), height/3 - TOP_MARGIN);
  if ((keyPressed == true) && (key == ' ')) {
    ts.currTreeMap.getCurrentNode().nodeHoveredOver().toolTip();
  }
  //categories.remove("flight attendant");
  lc.renderAll(0, height / 3, width, height / 3);
  fc.render(0, (height / 3) * 2, width, height / 3);
}

void update() {
  ts.setCurrByYear();
  lc.updateLines();
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