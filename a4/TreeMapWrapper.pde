class TreeMapWrapper {
  TreeMap currTreeMap;
  
  Map<String, TreeMap> treeMaps;
  
  TreeMapWrapper(Map<String, RectangleNode> roots) {
    String[] keys = roots.keySet().toArray(new String[roots.size()]);  
    
    treeMaps = new HashMap<String, TreeMap>();
    for (int i = 0; i < keys.length; i++) {
      treeMaps.put(keys[i], new TreeMap(roots.get(keys[i])));
      treeMaps.get(keys[i]).setCurrentNode(treeMaps.get(keys[i]).getRoot());
    }
  }
  
  void setCurrByYear(String year) {
    // maybe some error handling here would be nice.. if 
    // treeMaps doesn't contain 'year'
    currTreeMap = treeMaps.get(year);
  }

}