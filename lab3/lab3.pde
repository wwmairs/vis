Button toggleButton;
String [] lines;
String [] programs;
int [] numbers;

Arc a;
Arc [] segments;

void setup() {
  lines = loadStrings("./data.csv");
  programs = new String[lines.length - 1];
  numbers = new int[lines.length - 1];
  segments = new Arc[programs.length];

  for(int i = 1; i < lines.length; i++){
    String[] data = split(lines[i], ",");
    programs[i - 1] = data[0];
    numbers[i - 1] = int(data[1]);
  }
  printArray(programs);
  printArray(numbers);
  
  a = new Arc(width/2, height/2, 100, 0, PI, "Liberal arts", 22);
  int totalPeople = 0; 
  for (int i = 0; i < programs.length; i++) {
    totalPeople += numbers[i];
  }
  println("totalPeople", totalPeople);
  float previousStart = 0;
  for (int i = 0; i < programs.length; i++) {
    println("number[i]: ", numbers[i]);
    float ratio = (float) numbers[i] / (float) totalPeople;
    float arcLength = lerp(0, TWO_PI, ratio);
    println("ratio: ", ratio);
    println("arcLength: ", arcLength);
    segments[i] = new Arc((float) width/2, (float) height/2, (float) 150, 
                          previousStart, previousStart + arcLength, programs[i], numbers[i]);
    previousStart += arcLength;
  }
  size(800,600);
  surface.setResizable(true);
  
  toggleButton = new Button(20, 20, 60, 20, 255);

}

void draw() {
  background(255);
  toggleButton.render();
  for (int i = 0; i < segments.length; i++) {
    segments[i].render();
  }
}

void mouseClicked(){
  if (toggleButton.clickedOn()) {
    toggleButton.changeLabel();
    for (int i = 0; i < segments.length; i++) {
      segments[i].changeState();
    }
  }
}