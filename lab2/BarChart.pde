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
  
  void drawData(float ratio, float chartX, float chartY, float yZero, float elementWidth, float padding) {
    fill(180);
    for (int index = 0; index < data.length; index++) {
      float elementHeight = Float.parseFloat((String)data[index].y) * ratio;
      float startX = chartX + (padding * (index + 1)) + (elementWidth * index);
      data[index].setDims(startX, chartY + yZero - elementHeight, elementWidth, elementHeight);
      data[index].drawBar();
      //rect(startX, chartY + yZero - elementHeight, elementWidth, elementHeight);
      // this line is the little tick mark beneath each bar
      line(startX + (elementWidth/2), chartY + yZero + abs(max(-5, (-1 *abs(elementHeight)))), startX + (elementWidth/2), chartY + yZero - min(5, abs(elementHeight)));
    }
  }
}