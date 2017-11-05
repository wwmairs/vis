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
  
  FlowChart(List<Source> _sources, List<Target> _targets) {
    this.sources = _sources;
    this.targets = _targets;
  }
  
  void render(float x, float y, float w, float h) {
  }
  
  void updateDimensions(float x, float y, float w, float h) {
  }
}