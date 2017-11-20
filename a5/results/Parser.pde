class Parser {
  HashMap<String, Data> fill;
  HashMap<String, Data> normal;
  
  Parser(String normalFilePath, String fillFilePath) {
    // load normal data    
    normal = mapFromPath(normalFilePath);
    
    // load fill data
    fill = mapFromPath(fillFilePath);
  }
  
  HashMap<String, Data> mapFromPath(String filePath) {
    String[] lines = loadStrings(filePath);
    ArrayList<DataPoint> piePoints  = new ArrayList<DataPoint>();
    ArrayList<DataPoint> areaPoints = new ArrayList<DataPoint>();
    HashMap<String, Data> map = new HashMap();
    for (int i = 0; i < lines.length; i++) {
      String[] values = lines[i].split(",");
      if (values[2].equals("PieChart")) {
        piePoints.add(new DataPoint(values[0], 
                                    Integer.parseInt(values[1]), 
                                    values[2], 
                                    Float.parseFloat(values[3]), 
                                    Float.parseFloat(values[4]), 
                                    Float.parseFloat(values[5])));
      } else if (values[2].equals("sample")) {
        areaPoints.add(new DataPoint(values[0], 
                                     Integer.parseInt(values[1]), 
                                     values[2], 
                                     Float.parseFloat(values[3]), 
                                     Float.parseFloat(values[4]), 
                                     Float.parseFloat(values[5])));
      }
    }
    map.put("pie", new Data(piePoints.toArray(new DataPoint[piePoints.size()])));
    map.put("area", new Data(areaPoints.toArray(new DataPoint[areaPoints.size()])));
    return map;
  }
  
  HashMap<String, Data> getFill() {
    return this.fill;
  }
  
  HashMap<String, Data> getNormal() {
    return this.normal;
  }
  
}