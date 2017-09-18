public class BarChart extends Chart {
  
  BarChart (Point[] dataInput, String xText, String yText) {
    super(dataInput, xText, yText);
  }
  float calculateXLabelWidth() {
    return 80.0; 
  }
  
  float calculateYLabelWidth() {
    return 80.0;
  }
}