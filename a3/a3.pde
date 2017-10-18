import java.util.List;
import java.util.HashMap;

BarToLine barToLine;
BarPoint barpoint;
float temp_width = 50;
float temp_height = 200;
float temp_x = 400;
float temp_y = 500;

void setup() {
  size(1000, 800);
  surface.setResizable(true);
  
  barpoint = new BarPoint(temp_width, temp_height, temp_x, temp_y);
  barToLine = new BarToLine(8);
}

void draw() {
  background(255);
  //barpoint.render();
  barToLine.render();
}