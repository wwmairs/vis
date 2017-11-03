class Parser {
  Map<String, RectangleNode> roots;
  List<String []> data;
  
  Parser(String filePath) {
    String[] lines = loadStrings(filePath);

    data = new ArrayList(lines.length - 2);
    int numYears = 0;
    int numCareers = 0;  
    
    for (int i = 0; i < lines.length ; i++) {
      String [] values = lines[i].split(",");
      if (i == 0) numYears = int(values[0]);
      else if (i == 1) numCareers = int(values[0]);
      else data.add(values);
    }
    
   makeRoots();
  }  
  
  void makeRoots() {
    roots = new HashMap<String, RectangleNode>();
    
    for (int i = 0; i < data.size(); i++) {
      String [] values = data.get(i);
      String year = values[2];
      
      if (roots.isEmpty() || !roots.containsKey(year)) {
        roots.put(year, initRoot(year));
      }
      
      RectangleNode newNode = new RectangleNode(float(values[3]));
      newNode.setWomen(float(values[4]));
      newNode.id = values[1];
      if (values[0].equals("pilot")) {
        // add to pilot child of correct root
        newNode.setParent(roots.get(year).childAtIndex(0));
      } else if (values[0].equals("non-pilot")) {
        // add to non-pilot child of correct root
        newNode.setParent(roots.get(year).childAtIndex(1));
      } else {
        // an unexpected value in the datafile
      }
    }
  }
  
  RectangleNode initRoot(String year){
    RectangleNode newRoot = new RectangleNode();
    newRoot.id = year;
    RectangleNode pilots = new RectangleNode();
    pilots.id = "pilot";
    RectangleNode nonPilots = new RectangleNode();
    nonPilots.id = "non-pilot";
    
    pilots.setParent(newRoot);
    nonPilots.setParent(newRoot);
    
    return newRoot;
  }
  
  Map<String, RectangleNode> getRoots() {
    return roots;
  }
  
  void printData() {
     for (int i = 0; i < data.size(); i++) {
       printArray(data.get(i));
     }
  }
  
}