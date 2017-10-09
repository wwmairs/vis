  String[] lines, headers, names;
  int[] values;
  float maxHeight;
  BarChart chart;
void setup() {
  lines = loadStrings("./data.csv");
  headers = split(lines[0], ",");
  names = new String[lines.length - 1];
  values = new int[lines.length - 1];
  surface.setSize(500, 700);
  surface.setResizable(true);

  for(int i = 1; i < lines.length; i++){
    String[] data = split(lines[i], ",");
    names[i - 1] = data[0];
    values[i - 1] = int(data[1]);
  }
    maxHeight = 0;
    for(int i = 0; i < values.length; i++){
    if (values[i] > maxHeight) {
      maxHeight = values[i];
    }
  }
  printArray(headers);
  chart = new BarChart(headers, names, values);
  printArray(headers);
}
 void draw() {
  background(255);
  chart.render();
}