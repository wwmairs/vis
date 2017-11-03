static float POINT_RADIUS = 5;
static float CHART_MARGIN = 10;

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
  
  void render(float xCoord, float startY, float chartHeight) {
    println("trying to render a point from year", this.x);
    println("this point's percent value is", this.y);
    println("x, y, radius are", xCoord, startY + (1 - this.y) * chartHeight, POINT_RADIUS); //<>//
    ellipse(xCoord, yCoord(startY, chartHeight), POINT_RADIUS, POINT_RADIUS);
  }
  
  float yCoord(float startY, float chartHeight) {
    return (startY + (1 - this.y) * chartHeight);
  }
}

class Line {
  String category;
  List<DataPoint> points;
  
  Line(String _c) {
    this.category = _c;
    this.points = new ArrayList<DataPoint>(0);
  }
  
  void render(float x, float y, float w, float h) {
    float xStep = w / (float) this.numPoints();
    for (int i = 0; i < this.numPoints(); i++) {
      this.pointAt(i).render(x + (xStep * i), y, h);
      if (i < this.numPoints() - 1) {
        line(x + (xStep * i), this.pointAt(i).yCoord(y, h), x + (xStep * (i + 1)), this.pointAt(i + 1).yCoord(y, h));
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
  
  void render(float x, float y, float w, float h) {
    // x axis
    line(x + CHART_MARGIN, y + h - CHART_MARGIN, x + w - CHART_MARGIN, y + h - CHART_MARGIN);
    // y axis
    line(x + CHART_MARGIN, y + h - CHART_MARGIN, x + CHART_MARGIN, y + CHART_MARGIN);
    
    for (Map.Entry<String, Line> entry : lines.entrySet()) {
      String key = entry.getKey();
      Line value = entry.getValue();
      value.render(x + CHART_MARGIN, y + CHART_MARGIN, w - (2 * CHART_MARGIN), h - (2 * CHART_MARGIN));
    }
  }
}