static float POINT_RADIUS = 5;
static color HIGHLIGHT_COLOR = #f45c42;
static float CHART_MARGIN_LEFT = 25;
static float CHART_MARGIN_RIGHT = 10;

class DataPoint {
  // the year
  String x;
  // the percent of women who have that job
  float y;
  // the number of women who have that job
  float id;
 
  DataPoint(String _x, float _y, float _id) {
    this.x  = _x;
    this.y  = _y;
    this.id = _id;
  }
   //<>//
  void render(float xCoord, float startY, float chartHeight, float scale) { //<>//
    ellipse(xCoord, yCoord(startY, chartHeight, scale), POINT_RADIUS, POINT_RADIUS);
  }
  
  float yCoord(float startY, float chartHeight, float scale) { //<>//
    return (startY + (1 - (this.y / scale)) * chartHeight); //<>//
  }
}

class Line {
  String category;
  List<DataPoint> points;
  boolean highlight;
  
  Line(String _c) {
    this.category = _c;
    this.points = new ArrayList<DataPoint>(0);
    this.highlight = false;
  }
  
  void highlight() {
    this.highlight = true;
  }
  
  void unHighlight() {
    this.highlight = false;
  }
  
  void render(float x, float y, float w, float h, float scale) {
    float xStep = w / (float) this.numPoints();
    for (int i = 0; i < this.numPoints(); i++) {
      fill((this.highlight) ? HIGHLIGHT_COLOR : 0);
      stroke((this.highlight) ? HIGHLIGHT_COLOR : 0);
      this.pointAt(i).render(x + (xStep * i) + (xStep / 2), y, h, scale);
      if (i < this.numPoints() - 1) {
        line(x + (xStep * i) + (xStep / 2), this.pointAt(i).yCoord(y, h, scale), x + (xStep * (i + 1)) + (xStep / 2), this.pointAt(i + 1).yCoord(y, h, scale));
      }
    }
  }
  
  void addPoint(String year, float percent, float num) {
    this.points.add(new DataPoint(year, percent, num));
    // maintains that good chronological order
    this.sortPoints();
  }
  
  void sortPoints() {
    Collections.sort(this.points, new Comparator<DataPoint>() {
      public int compare(DataPoint p1, DataPoint p2) {
        if (parseFloat(p1.x) > parseFloat(p2.x)) return 1;
        if (parseFloat(p1.x) < parseFloat(p2.x)) return -1;
        return 0;
      }
    });
  }
  
  float greatestY() {
    float greatestY = points.get(0).y; 
    for (int i = 1; i < points.size(); i++) {
      float temp = points.get(i).y;
      if (temp > greatestY) greatestY = temp;
    }
    return greatestY;
  }
  
  DataPoint pointAt(int i) {
    return points.get(i);
  }
  
  int numPoints() {
    return points.size();
  }
}

class LineChart{
  Map<String, Line> lines;
  Map<String, Line> currLines;
  float scale;
  
  LineChart(Map<String, Line> _lines) {
    this.lines = _lines;
    this.currLines = new HashMap<String, Line>();
  }
  
  void calcScale() {
    float greatestY = 0;
    for (Map.Entry<String, Line> entry : currLines.entrySet()) {
      String key = entry.getKey();
      Line value = entry.getValue();
      
      float temp = value.greatestY();
      if (temp > greatestY) greatestY = temp;
    }
    scale = greatestY * 1.2;
    if (scale > .75) scale = 1; //<>//
  }
  
  void updateLines(List<String> categories) {
    this.currLines.clear();
    for (int i = 0; i < categories.size(); i++) {
      String currCat = categories.get(i);
      Line currLine = lines.get(currCat);
      currLines.put(currCat,currLine);
    }
    calcScale();
  }
  
  void renderCategory(float x, float y, float w, float h, String c) {
    // x axis
    line(x + CHART_MARGIN_LEFT, y + h - CHART_MARGIN_RIGHT, x + w - CHART_MARGIN_LEFT, y + h - CHART_MARGIN_RIGHT);
    // y axis
    line(x + CHART_MARGIN_LEFT, y + h - CHART_MARGIN_RIGHT, x + CHART_MARGIN_LEFT, y + CHART_MARGIN_RIGHT);
    
    Line aLine = lines.get(c);
    //aLine.render(x + CHART_MARGIN, y + CHART_MARGIN, w - (2 * CHART_MARGIN), h - (2 * CHART_MARGIN));
  }
  
  void renderAll(float x, float y, float w, float h) {
    stroke(0);
    strokeWeight(.5);
    // x axis
    textAlign(CENTER);
    text(str(int(scale * 100)) + "%", x + (CHART_MARGIN_LEFT/2), y + CHART_MARGIN_LEFT);
    line(x + CHART_MARGIN_LEFT, y + h - CHART_MARGIN_RIGHT, x + w - CHART_MARGIN_LEFT, y + h - CHART_MARGIN_RIGHT);
    // y axis
    text("0%", x + (CHART_MARGIN_LEFT/2), y + h - CHART_MARGIN_RIGHT);
    line(x + CHART_MARGIN_LEFT, y + h - CHART_MARGIN_RIGHT, x + CHART_MARGIN_LEFT, y + CHART_MARGIN_RIGHT);
    
    for (Map.Entry<String, Line> entry : currLines.entrySet()) {
      String key = entry.getKey();
      println("rendering line", key);
      Line value = entry.getValue();
      value.render(x + CHART_MARGIN_LEFT, y + CHART_MARGIN_RIGHT, w - (2 * CHART_MARGIN_LEFT), h - (2 * CHART_MARGIN_RIGHT), scale);
    }
  }
}