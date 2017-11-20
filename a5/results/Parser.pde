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
    String[] lines = loadStrings(filePath + "all.csv");
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
    String[] errors = loadStrings(filePath + "error.csv");
    float pieError = Float.parseFloat(errors[1].split(",")[0]);
    float areaError = Float.parseFloat(errors[1].split(",")[1]);
    Data pieData  = new Data(piePoints.toArray(new DataPoint[piePoints.size()]));
    Data areaData = new Data(areaPoints.toArray(new DataPoint[areaPoints.size()]));
    pieData.setError(pieError);
    areaData.setError(areaError);
    map.put("pie", pieData);
    map.put("area", areaData);
    return map;
  }
  
  HashMap<String, Data> getFill() {
    return this.fill;
  }
  
  HashMap<String, Data> getNormal() {
    return this.normal;
  }
  
}