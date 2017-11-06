static float FLOW_DOT_MARGIN = 50;
// these are bad colors, but they were easy to find
color SOURCE_START_COLOR = PRIMARY1;
color SOURCE_END_COLOR = SECONDARY1;

class Source{
  String name;
  float funds;
  List<Target> targets;
  float x;
  float y;
  float r;
  color c;
  
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
    stroke(c);
    fill(c);
    ellipse(this.x, this.y, this.r, this.r);
    
    // let's try with one target first
    for (int i = 0; i < this.targets.size(); i++ ) {
      Target t = this.targets.get(i);
      println("drawing line to target:", t.category);
      println("t.x and t.y are", t.x, t.y);
      noFill();
      stroke(c);
      strokeWeight(3);
      if (manager.careers.contains(t.category)){ 
        bezier(this.x, this.y, this.x + controlX, this.y, t.x - controlX, t.y, t.x, t.y); //<>//
        // restore fill (?) maybe everything should just take care of its own stroke and fill
        strokeWeight(1);
        fill(0);
      }
    }
  }
  
  boolean hover(){
    return (dist(mouseX, mouseY, this.x, this.y) <= this.r / 2);
  }
  
  void displayTooltip() {
    rectMode(CENTER);
    textSize(12);
    fill(255);
    textAlign(LEFT, CENTER);
    rect(mouseX + (6 * this.name.length())/2, mouseY, 6.5 * this.name.length(), 15);
    fill(0);
    text(this.name, mouseX, mouseY);
    rectMode(CORNER);
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
    if (this.hover()) {
      this.displayTooltip();
    }
  }
  
  boolean hover(){
    return (dist(mouseX, mouseY, this.x, this.y) <= this.r / 2);
  }
  
  void displayTooltip() {
    rectMode(CENTER);
    textSize(12);
    fill(255);
    textAlign(CENTER, CENTER);
    rect(mouseX, mouseY, 8 * this.category.length(), 15);
    fill(0);
    text(this.category, mouseX, mouseY);
    rectMode(CORNER);
  }
}

class FlowChart{
  List<Source> sources;
  List<Target> targets;
  List<Source> currentSources;
  List<Target> currentTargets;
  float maxFunds;
  
  FlowChart(List<Source> _sources) {
    this.maxFunds = 0;
    this.sources = _sources;
    this.targets = new ArrayList<Target>();
    for (int i = 0; i < this.sources.size(); i++) {
      Source oneSource = this.sources.get(i);
      for (int j = 0; j < oneSource.targets.size(); j++) {
          boolean contains = false;
          for (int k = 0; k < this.targets.size(); k++) {
            if (this.targets.get(k).category.equals(oneSource.targets.get(j).category)) {
              contains = true;
              oneSource.targets.set(j, this.targets.get(k));
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
    println("num curr sources", this.currentSources.size());
    for (int i = 0; i < this.currentSources.size(); i++) {
      this.currentSources.get(i).render(x, y, w, h);
    }
    for (int i = 0; i < this.currentTargets.size(); i++) {
      this.currentTargets.get(i).render();
    }
    for (int i = 0; i < this.currentSources.size(); i++) {
      if (this.currentSources.get(i).hover()) {
        this.currentSources.get(i).displayTooltip();
      }
    }
  }
  
  void updateDimensions(float x, float y, float w, float h) {
    List<Target> currTargets = new ArrayList<Target>();
    List<Source> currSources = new ArrayList<Source>();
    for (int i = 0; i < this.targets.size(); i++) {
      if (manager.careers.contains(this.targets.get(i).category)) {
        // add target[i] to currTargets
        currTargets.add(this.targets.get(i));
      }
    }
    for (int i = 0; i < this.sources.size(); i++) {
      for (int j = 0; j < this.sources.get(i).targets.size(); j++) {
        if (manager.careers.contains(this.sources.get(i).targets.get(j).category)) {
          currSources.add(this.sources.get(i));
        }
      }
    }
    float sourceStep = h / currSources.size();
    float targetStep = h / currTargets.size();
    float sourceX = x + FLOW_DOT_MARGIN;
    float targetX = x + w - FLOW_DOT_MARGIN;
    for (int i = 0; i < currSources.size(); i++) {
      currSources.get(i).x = sourceX;
      currSources.get(i).y = y + (sourceStep * i) + (sourceStep / 2);
      currSources.get(i).r = (sourceStep / 2) + (currSources.get(i).funds / this.maxFunds) * (sourceStep / 2);
      currSources.get(i).c = lerpColor(SOURCE_START_COLOR, SOURCE_END_COLOR, (float)i / (float) currSources.size());
    }
    for (int i = 0; i < currTargets.size(); i++) {
      currTargets.get(i).x = targetX;
      currTargets.get(i).y = y + (targetStep * i) + (targetStep / 2);
      currTargets.get(i).r = targetStep / 2;
    }
    this.currentSources = currSources;
    this.currentTargets = currTargets;
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