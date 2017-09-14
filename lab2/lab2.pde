import java.util.*; 
class CSVReader {
  // A generic CSV reader class
  
  public String[] headers;
  public List<Map<String, String>> rows;
  
  CSVReader(String filePath) {
    String[] lines = loadStrings("./data.csv");
    rows = new ArrayList<Map<String, String>>();
    
    // Get the headers from the first line
    headers = split(lines[0], ",");
    
    // Iterate through all the non-header rows
    for(int row = 1; row < lines.length; row++){
      
      // Split the row by comma
      String[] rowSplit = split(lines[row], ",");
      
      // Initialize a new map for this row, mapping strings to strings
      Map<String, String> rowData = new HashMap<String, String>();
      
      // For each row, get the data and put it into a Map at the associated row index
      for (int col = 0; col < rowSplit.length; col++) {
        rowData.put(headers[col], rowSplit[col]);
      }
      
      // Put the data into the "rows" map
      rows.add(rowData);
    }
  }
}

public class Point {
  public Object x;
  public Object y;
  
  public Point(Object xVal, Object yVal) {
    x = xVal;
    y = yVal;
  }
}

public class Chart {
  Point[] points;
  int Width;
  int Height;
  String xLabel;
  String yLabel;
  int x;
  int y;
  
  
  // chartWidth and chartHeight are percentage values from 0-100
  public Chart(String xAxis, String yAxis) {
    //points = data;
    xLabel = xAxis;
    yLabel = yAxis;
  }
    
  
  public void renderBars(int x, int y, int Width, int Height) {
    rectMode(CORNER);
    fill(50);
    rect(x, y, Width, Height);
    
  }
  
  public void renderLines() {
  }
}


Chart c;

void setup() {
  CSVReader data = new CSVReader("data.csv");
  Point[] points = new Point[data.rows.size()](); 
  for (int i=0; i < data.rows.size(); i++) {
    points[i] = new Point(data.rows.get(i).get("Name"), data.rows.get(i).get("Price));
  }
  size(400,400);
  surface.setResizable(true);
  c = new Chart("x", "y");
  
}

void draw() {
  background(255);
  c.renderBars(0, 0, width/2, height/2);
}