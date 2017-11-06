class Manager {
  String year;
  // the thing you're hovering over
  String career;
  String scholarship;
  int depth;
  // the list of careers that are toggled
  List<String> careers;
  
  Manager(String yr, String car, int dep, List<String> cars, String sch) {
    year = yr;
    career = car;
    depth = dep;
    careers = cars;
    scholarship = sch;
  }
}