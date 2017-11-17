/** @author: Fumeng Yang (fyang@cs.tufts.edu)
 * since: Sep 2014
 * adpated for processing 3: Oct 2015 
 */

void settings(){
    size(int(displayHeight * 0.925), int(displayHeight * 0.925)); //, "processing.core.PGraphicsRetina2D");
}

void setup() {
    background(255, 255, 255);
    initSettings();
    surface.setResizable(true);
    surface.setTitle("SPLOM on - " + path);
}

void draw() {
    if (isResized()) {
        contrl.setPosition();
    }

    background(255, 255, 255);
    textSize(fontSize);
    textLeading(lineHeight);

    contrl.hover();

    contrl.drawViews();
    contrl.drawSelectedArea();
    contrl.handleSelectedArea();
}

void initSettings() {
    readData();
    marks = new boolean[data.getRowCount()];
    contrl = new SPLOMController();
    contrl.initViews();
}

boolean isResized() {
    if (pw != width || ph != height) {
        pw = width;
        ph = height;
        return true;
    }
    return false;
}

void mouseClicked(MouseEvent e) {
    contrl.cleanSelectedArea();
    pressPos = null;
}

void mouseDragged(MouseEvent e) {
    if (e.getButton() == RIGHT) {
        contrl.cleanSelectedArea();
        return;
    }
    if (pressPos != null) {
        contrl.setSelectedArea(pressPos.x, pressPos.y, mouseX, mouseY);
    }  
}

void mousePressed(MouseEvent e) {
    contrl.cleanSelectedArea();
    pressPos = new PVector(mouseX, mouseY);
    contrl.setSelectedArea(pressPos.x, pressPos.y, mouseX, mouseY);
}


void readData(){
   data = loadTable(path, "header");
   header = data.getColumnTitles();
}