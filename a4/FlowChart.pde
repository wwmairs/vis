class Source{
  String name;
  float funds;
  List<Target> targets;
  float x;
  float y;
  float r;
  
  Source(String _name, float _funds) {
    this.name  = _name;
    this.funds = _funds;
    this.targets = new ArrayList<Target>();
  }
  
  void addTarget(Target _target) {
    this.targets.add(_target);
  }
  
  void render() {
    // will draw source circle and curves to targets
    // at this point, POSITION WILL HAVE BEEN UPDATED BY FLOWCHART CLASS
  }
  
}

class Target{
  String category;
  float x;
  float y;
  float r;
  
  Target(String _category) {
    this.category = _category; 
  }
  
  void render() {
    // will draw target circle
    // at this point, POSITION WILL HAVE BEEN UPDATED BY FLOWCHART CLASS
  }
}

class FlowChart{
  List<Source> sources;
  List<Target> targets;
  
  FlowChart(List<Source> _sources) {
    this.sources = _sources;
    this.targets = new ArrayList<Target>();
    for (int i = 0; i < this.sources.size(); i++) {
      Source oneSource = this.sources.get(i);
      for (int j = 0; j < oneSource.targets.size(); j++) {
        if (!this.targets.contains(oneSource.targets.get(j))) {
          this.targets.add(oneSource.targets.get(j));
        }
      }
    }
    this.sortSources();
  }
  
  void render(float x, float y, float w, float h) {
    updateDimensions(x, y, w, h);
  }
  
  void updateDimensions(float x, float y, float w, float h) {
    float sourceStep = h / sources.size();
    float targetStep = h / targets.size();
  }
  
  void sortSources() {
    Collections.sort(this.sources, new Comparator<Source>() {
      public int compare(Source s1, Source s2) {
        if (s1.funds > s2.funds) return 1;
        if (s1.funds < s2.funds) return -1;
        return 0;
      }
    });
  }
}