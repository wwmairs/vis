Chart b;
Chart l;

boolean bar = false;

void setup() {
  size(800, 600);
  pixelDensity(2);
  surface.setResizable(true);
  CSVReader data = new CSVReader("data.csv");
  int dataSize = data.rows.size();
  
  Point[] chartPoints = new Point[dataSize];
  for (int i = 0; i < dataSize; i++) {
    chartPoints[i] = new Point(data.rows.get(i).get("Name"), data.rows.get(i).get("Price"));
  }
  
  b = new BarChart(chartPoints, "Name", "Price");
  l = new LineChart(chartPoints, "Name", "Price");
}

void draw() {
  background(255);
  if (bar) {
    b.render(10, 10, width-20, height-20);
  } else {
    l.render(10, 10, width-20, height-20);
  }
}