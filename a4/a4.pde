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
static color HIGHLIGHT1 = #ffe2b9;

static float GLOBAL_MARGIN_TOP = 20;

// TreeMap margins
static float SIDE_MARGIN = 10;
static float TOP_MARGIN = 10;


// dear Katya, I can't come up with a good title
static String TITLE = "Careers in Aviation and How to (not) Get Them";

void setup() {
  size(600,650);
  pixelDensity(displayDensity());
  surface.setResizable(true);
  
  Parser parser = new Parser("data.csv", "scholarship_data.csv");
  manager = new Manager("2016", "", 2, parser.getCategories(), "");
  //categories = parser.getCategories();
  ts = new TreeMapWrapper(parser.getRoots());
  lc = new LineChart(parser.getLines());
  fc = new FlowChart(parser.getScholarships());
}

void draw() {
  float W = width;
  float H = height - GLOBAL_MARGIN_TOP;
  background(255);
  update();
  
  textSize(20);
  textAlign(CENTER);
  text(TITLE, W / 2, GLOBAL_MARGIN_TOP);
  
  ts.currTreeMap.drawTreeMap(SIDE_MARGIN, TOP_MARGIN + GLOBAL_MARGIN_TOP, W - (2* SIDE_MARGIN), H/3 - TOP_MARGIN);
  if ((keyPressed == true) && (key == ' ')) {
    ts.currTreeMap.getCurrentNode().nodeHoveredOver().toolTip();
  }
  //categories.remove("flight attendant");
  lc.renderAll(0, (H / 3) + GLOBAL_MARGIN_TOP, W, H / 3);
  fc.render(0, ((H / 3) * 2) + GLOBAL_MARGIN_TOP, W, H / 3);
}

void update() {
  ts.setCurrByYear();
  lc.updateLines();
}

void mouseClicked() {
  if (inTreeMap()) {
    if (mouseButton == LEFT) {
      ts.currTreeMap.setTargetDepth(1);
      if (manager.depth == 2) {
        ts.toggleCareer();
      }
    } else if (mouseButton == RIGHT) {
      ts.currTreeMap.setTargetDepth(-1);
    }
    
  } else if (inLineChart()) {
    lc.toggleCareer();
  
  } else if (inFlowChart()) {
    fc.toggleCareer();
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