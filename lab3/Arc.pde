class Arc {
  private float xCor, yCor, radius, startTheta, endTheta;
  private String programName;
  private int people;
  private color c, hover; 
  private boolean donut = false;
  private float donutRadius = 50;
  Arc (float x, float y, float r, float startTheta, 
       float endTheta, String name, int people) {
    this.xCor = x;
    this.yCor = y;
    this.radius = r;
    this.programName = name;
    this.people = people;
    this.c = #54BDC9;
    this.hover = #CE800C;
    this.startTheta = startTheta;
    this.endTheta = endTheta;
    
  }
  public void render () {
    this.xCor = width/2;
    this.yCor = height/2;
    
    if (this.onHover()) {
      fill(this.hover);
      ellipseMode(RADIUS);
      arc(this.xCor, this.yCor, this.radius, this.radius, this.startTheta, this.endTheta, PIE);
      fill(#000000);
      textAlign(CENTER, BOTTOM);
      text("("+this.programName+", "+this.people+")", this.xCor, this.yCor - this.radius);
      
    } else {
      fill(this.c);
      ellipseMode(RADIUS);
      arc(this.xCor, this.yCor, this.radius, this.radius, this.startTheta, this.endTheta, PIE);
    }
    if (donut){
      fill(255);
      ellipse(this.xCor, this.yCor, this.donutRadius, this.donutRadius);
    }

  }

   public boolean onHover() {
     if (dist(mouseX, mouseY, this.xCor, this.yCor) < this.radius) {
       if (donut) {
         if(dist(mouseX, mouseY, this.xCor, this.yCor) < this.donutRadius) {
           return false;
         }
       }
       float xTheta = atan2(-1 *(mouseY - this.yCor), -1 *(mouseX - this.xCor)) + PI;
       println("x: ", mouseX - this.xCor, "y: ", mouseY - this.yCor);
       println("xTheta: ", xTheta);
       return((this.startTheta <= xTheta) && (xTheta <= this.endTheta)); 
     } else {
       return false;
     }
   }
   
   public void changeState() {
     donut = !donut;
   }
}