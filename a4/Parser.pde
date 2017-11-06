class Parser {
  // for TreeMaps, keys are years, values are roots to trees
  Map<String, RectangleNode> roots;
  // for LineChart, keys are jobs, values are arrays of points
  // a point has a y value, a number (Q), and an x value, a year (O)
  Map<String, Line> lines;
  List<Source> scholarships;
  List<String> categories;
  List<String []> categoryData;
  List<String []> scholarshipData;
  
  Parser(String categoryFilePath, String scholarshipFilePath) {
    // load in the data for the category breakdowns
    String[] lines = loadStrings(categoryFilePath);

    categoryData = new ArrayList(lines.length - 2);
    int numYears = 0;
    int numCareers = 0;  
    
    for (int i = 0; i < lines.length ; i++) {
      String [] values = lines[i].split(",");
      if (i == 0) numYears = int(values[0]);
      else if (i == 1) numCareers = int(values[0]);
      else categoryData.add(values);
    }
    
    // load in the data for scholarship breakdowns
    lines = loadStrings(scholarshipFilePath);
    scholarshipData = new ArrayList(lines.length - 1);
    
    for (int i = 0; i < lines.length; i++) {
      String [] values = lines[i].split(",");
      scholarshipData.add(values);
    }
    
   makeRoots();
   makeLines();
   makeScholarships();
  }  
  
  void makeScholarships() {
    scholarships = new ArrayList<Source>();
    
    for (int i = 0; i < scholarshipData.size(); i++) {
      String [] values = scholarshipData.get(i);
      String name = values[0];
      float funds = parseFloat(values[1]);
      Source newSource = new Source(name, funds);
      // add targets to newSource
      for (int j = 2; j < values.length; j++) {
        String currValue = values[j];
        if (!currValue.equals("")) {
          newSource.addTarget(new Target(values[j]));
        }
      }
      scholarships.add(newSource);
    }
    
    
  }
  
  void makeLines() {
    lines = new HashMap<String, Line>();
    categories = new ArrayList<String>();
    
    for (int i = 0; i < categoryData.size(); i++) {
      String [] values = categoryData.get(i);
      String category = values[0];
      String job      = values[1];
      String year     = values[2];
      float numTotal  = parseFloat(values[3]);
      float numWomen  = parseFloat(values[4]);
      float percent   = numWomen / numTotal ;
      
      if (!lines.containsKey(job)) {
        categories.add(job);
        Line newLine = new Line(job, category);
        newLine.addPoint(year, percent, numWomen);
        lines.put(job, newLine);
      } else {
        lines.get(job).addPoint(year, percent, numWomen);
      }
    }
  }
  
  Map<String, Line> getLines() {
    return lines;
  }
  
  void makeRoots() {
    roots = new HashMap<String, RectangleNode>();
     //<>//
    for (int i = 0; i < categoryData.size(); i++) {
      String [] values = categoryData.get(i);
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
  } //<>//
  
  List<String> getCategories() {
    return categories;
  }
  
  
  Map<String, RectangleNode> getRoots() {
    return roots;
  }
  
  List<Source> getScholarships() {
    return this.scholarships;
  }
  
  void printData() {
     for (int i = 0; i < categoryData.size(); i++) {
       printArray(categoryData.get(i));
     }
  }
  
}