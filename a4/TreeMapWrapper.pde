class TreeMapWrapper {
  TreeMap currTreeMap;
  
  Map<String, TreeMap> treeMaps;
  
  TreeMapWrapper(Map<String, RectangleNode> roots) {
    String[] keys = roots.keySet().toArray(new String[roots.size()]);  
    
    treeMaps = new HashMap<String, TreeMap>();
    for (int i = 0; i < keys.length; i++) {
      treeMaps.put(keys[i], new TreeMap(roots.get(keys[i])));
      treeMaps.get(keys[i]).setCurrentNode(treeMaps.get(keys[i]).getRoot(), 0);
    }
  }
  
  void setCurrByYear() {
    // maybe some error handling here would be nice.. if 
    // treeMaps doesn't contain 'year'
    currTreeMap = treeMaps.get(manager.year);
  }
  
  void toggleCareer() {
    if (manager.career != "pilot" && (manager.career != "non-pilot")) {
     if (manager.careers.contains(manager.career)) {
      manager.careers.remove(manager.career);
      } else {
        manager.careers.add(manager.career);
      }
    }
  }
}