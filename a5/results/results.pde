static float MARGIN = 20;

Parser p;
ErrorBars errors;

void setup() {
  size(800, 600);
  p = new Parser("normal/", "fill/");
  errors = new ErrorBars(MARGIN, MARGIN, width - (2 * MARGIN), height - (2 * MARGIN), p.getNormal(), p.getFill());
}

void draw() {
  errors.draw();
}