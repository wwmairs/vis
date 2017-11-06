static float FLOW_DOT_MARGIN = 50;

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
  
  void render(float _x, float _y, float _w, float _h) {
    float controlX = _w / 3;
    // will draw source circle and curves to targets
    // at this point, POSITION WILL HAVE BEEN UPDATED BY FLOWCHART CLASS
    ellipse(this.x, this.y, this.r, this.r);
    
    // let's try with one target first
    for (int i = 0; i < this.targets.size(); i++ ) {
      Target t = this.targets.get(i);
      println("drawing line to target:", t.category);
      println("t.x and t.y are", t.x, t.y);
      noFill();
      bezier(this.x, this.y, this.x + controlX, this.y, t.x - controlX, t.y, t.x, t.y); //<>//
      // restore fill (?) maybe everything should just take care of its own stroke and fill
      fill(0);
    }
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
    ellipse(this.x, this.y, this.r, this.r);
  }
}

class FlowChart{
  List<Source> sources;
  List<Target> targets;
  float maxFunds;
  
  FlowChart(List<Source> _sources) {
    this.maxFunds = 0;
    this.sources = _sources;
    this.targets = new ArrayList<Target>();
    for (int i = 0; i < this.sources.size(); i++) {
      Source oneSource = this.sources.get(i);
      for (int j = 0; j < oneSource.targets.size(); j++) {
        // this doesn't work! cause objects
        //if (!this.targets.contains(oneSource.targets.get(j))) {
        //  this.targets.add(oneSource.targets.get(j));
        //}
          boolean contains = false;
          for (int k = 0; k < this.targets.size(); k++) {
            if (this.targets.get(k).category.equals(oneSource.targets.get(j).category)) {
              contains = true;
            }
          }
          if (!contains) {
            this.targets.add(oneSource.targets.get(j));
          }
      }
    }
    this.sortSources();
  }
  
  void render(float x, float y, float w, float h) {
    updateDimensions(x, y, w, h);
    //this.sources.get(3).render(x, y, w, h);
    for (int i = 0; i < this.sources.size(); i++) {
      this.sources.get(i).render(x, y, w, h);
    }
    for (int i = 0; i < this.targets.size(); i++) {
      this.targets.get(i).render();
    }
  }
  
  void updateDimensions(float x, float y, float w, float h) {
    float sourceStep = h / sources.size();
    float targetStep = h / targets.size();
    float sourceX = x + FLOW_DOT_MARGIN;
    float targetX = x + w - FLOW_DOT_MARGIN;
    for (int i = 0; i < this.sources.size(); i++) {
      this.sources.get(i).x = sourceX;
      this.sources.get(i).y = y + (sourceStep * i);
      this.sources.get(i).r = sourceStep * (this.sources.get(i).funds / this.maxFunds);
    }
    for (int i = 0; i < this.targets.size(); i++) {
      this.targets.get(i).x = targetX;
      this.targets.get(i).y = y + (targetStep * i);
      this.targets.get(i).r = targetStep;
    }
  }
  
  void sortSources() {
    Collections.sort(this.sources, new Comparator<Source>() {
      public int compare(Source s1, Source s2) {
        if (s1.funds > s2.funds) return -1;
        if (s1.funds < s2.funds) return 1;
        return 0;
      }
    });
    this.maxFunds = this.sources.get(0).funds;
  }
}