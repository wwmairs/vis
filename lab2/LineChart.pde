public class LineChart extends Chart {
  
  LineChart (Point[] dataInput, String xText, String yText) {
    super(dataInput, xText, yText);
  }
  float calculateXLabelWidth() {
    return 80.0; 
  }
  
  float calculateYLabelWidth() {
    return 80.0;
  }
  
  void drawData(float ratio, float chartX, float chartY, float yZero, float elementWidth, float padding) {
    for (int index = 0; index < data.length; index++) {
      if ((index > 0) && (index < (data.length - 1))) {
        Point p1 = data[index - 1];
        Point p3 = data[index + 1];
        Point p2 = data[index];
        line(p1.x(), p1.y(), p2.x(), p2.y());
        line(p2.x(), p2.y(), p3.x(), p3.y());
        println("doing a line");
      }
      float elementHeight = Float.parseFloat((String)data[index].y) * ratio;
      float startX = chartX + (padding * (index + 1)) + (elementWidth * index);
      data[index].setDims(startX, chartY + yZero - elementHeight, elementWidth, elementHeight);
      data[index].drawPoint();
      //rect(startX, chartY + yZero - elementHeight, elementWidth, elementHeight);
      // this line is the little tick mark beneath each bar
      line(startX + (elementWidth/2), chartY + yZero + abs(max(-5, (-1 *abs(elementHeight)))), startX + (elementWidth/2), chartY + yZero - min(5, abs(elementHeight)));
    }
  }
}