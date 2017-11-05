static float POINT_RADIUS = 5;
static float CHART_MARGIN = 10;
static color HIGHLIGHT_COLOR = #f45c42;

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
  
  void render(float xCoord, float startY, float chartHeight) { //<>//
    ellipse(xCoord, yCoord(startY, chartHeight), POINT_RADIUS, POINT_RADIUS);
  }
  
  float yCoord(float startY, float chartHeight) {
    return (startY + (1 - this.y) * chartHeight);
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
  
  void render(float x, float y, float w, float h) {
    float xStep = w / (float) this.numPoints();
    for (int i = 0; i < this.numPoints(); i++) {
      fill((this.highlight) ? HIGHLIGHT_COLOR : 0);
      stroke((this.highlight) ? HIGHLIGHT_COLOR : 0);
      this.pointAt(i).render(x + (xStep * i) + (xStep / 2), y, h);
      if (i < this.numPoints() - 1) {
        line(x + (xStep * i) + (xStep / 2), this.pointAt(i).yCoord(y, h), x + (xStep * (i + 1)) + (xStep / 2), this.pointAt(i + 1).yCoord(y, h));
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
  
  DataPoint pointAt(int i) {
    return points.get(i);
  }
  
  int numPoints() {
    return points.size();
  }
}

class LineChart{
  Map<String, Line> lines;
  
  LineChart(Map<String, Line> _lines) {
    this.lines = _lines;
  }
  
  void renderCategory(float x, float y, float w, float h, String c) {
    // x axis
    line(x + CHART_MARGIN, y + h - CHART_MARGIN, x + w - CHART_MARGIN, y + h - CHART_MARGIN);
    // y axis
    line(x + CHART_MARGIN, y + h - CHART_MARGIN, x + CHART_MARGIN, y + CHART_MARGIN);
    
    Line aLine = lines.get(c);
    aLine.render(x + CHART_MARGIN, y + CHART_MARGIN, w - (2 * CHART_MARGIN), h - (2 * CHART_MARGIN));
  }
  
  void renderAll(float x, float y, float w, float h) {
    // x axis
    line(x + CHART_MARGIN, y + h - CHART_MARGIN, x + w - CHART_MARGIN, y + h - CHART_MARGIN);
    // y axis
    line(x + CHART_MARGIN, y + h - CHART_MARGIN, x + CHART_MARGIN, y + CHART_MARGIN);
    
    for (Map.Entry<String, Line> entry : lines.entrySet()) {
      String key = entry.getKey();
      println("rendering line", key);
      Line value = entry.getValue();
      value.render(x + CHART_MARGIN, y + CHART_MARGIN, w - (2 * CHART_MARGIN), h - (2 * CHART_MARGIN));
    }
  }
}