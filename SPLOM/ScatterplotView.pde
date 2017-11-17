class ScatterplotView extends AbstractView {
    float[] xArray = null;
    float[] yArray = null;
    String xTitle = null;
    String yTitle = null;

    float xMax = -1;
    float yMax = -1;
    float xMin = -1;
    float yMin = -1;

    int xIndex = -1;
    int yIndex = -1;

    // get the radius of points for drawing
    public float getRadius() {
        return w / 70.0;
    }

    public void hover() {
        // get the condtions (the range of data to be highlighted)
        // here is an approximation
        println("mouseX + getRadius()", mouseX + getRadius());
        println("inverseToXReal of that", inverseToXReal(mouseX + getRadius()));
        Condition cond1 = new Condition(xTitle, "<=", inverseToXReal(mouseX + getRadius()));
        Condition cond2 = new Condition(xTitle, ">=", inverseToXReal(mouseX - getRadius()));
        Condition cond3 = new Condition(yTitle, "<=", inverseToYReal(mouseY - getRadius()));
        Condition cond4 = new Condition(yTitle, ">=", inverseToYReal(mouseY + getRadius()));
        Condition[] conds = new Condition[4];
        conds[0] = cond1;
        conds[1] = cond2;
        conds[2] = cond3;
        conds[3] = cond4;
         
        // Finish this:
        // send a message to the controller to tell the current conditions for highlighting
        // 1. create a new message instance (Message.pde)
        // 2. set the source of this message (Message.pde)
        // 3. set the conditions of this message (Message.pde)
        // 4. send the message (AbstractView.pde)
    }

    public void handleThisArea(Rectangle rect) {
        Rectangle rectSub = getIntersectRegion(rect);

        if (rectSub != null) {
            Condition[] conds = new Condition[4];

            // Finish this:
            // Write the conditions here.(Condition.pde, Rectangle.pde)
            // The rect is the whole selected area.(Rectangle.pde)
            // The getIntersectRegion() gets you the smaller rectangle which is within the current view. (AbstractView.pde)
            
            // send out the message
            Message msg = new Message();
            msg.setSource(name)
               .setConditions(conds);
            sendMsg(msg);
        }
    }

    public void display() {
        pushStyle();
        stroke(0);
        strokeWeight(1);
        fill(255);
        rectMode(CORNER);

        rect(leftX, leftY, w, h);

        ellipseMode(CENTER);
        for (int i = 0; i < xArray.length; i++) {
            if (marks[i]) {
                fill(pointHighLight);
            } else {
                fill(pointColor);
            }
            noStroke();
            // draw points
            ellipse(xScale(xArray[i]), yScale(yArray[i]), getRadius() * 2, getRadius() * 2);
        }

        textAlign(CENTER);
        fill(0);
        
        // draw labels
        if(yIndex == 0){
            text(xTitle, leftX + w / 2.0, leftY - fontSize / 2.0);
        }

        if(xIndex == 0){
            pushMatrix();
            translate(leftX - fontSize / 2.0, leftY + w / 2.0);
            rotate(radians(-90));
            text(yTitle, 0, 0);
            popMatrix();
        }
        popStyle();
    }

    public ScatterplotView setXYIndice(int x, int y) {
        this.xIndex = x;
        this.yIndex = y;
        return this;
    }

    // set the indice of columns that this view can see
    public ScatterplotView setData(float[] xArray, float[] yArray) {
        this.xArray = xArray;
        this.yArray = yArray;
        return this;
    }

    public ScatterplotView setTitles(String xStr, String yStr) {
        this.xTitle = xStr;
        this.yTitle = yStr;
        return this;
    }

    public ScatterplotView initXYRange() {
        xMin = 0;//min(xArray);
        xMax = max(xArray) * 1.2;
        yMin = 0;//min(yArray);
        yMax = max(yArray) * 1.2;

        return this;
    }

    float xScale(float x) {
        return leftX + (x - xMin) / (xMax - xMin) * w;
    }

    float yScale(float y) {
        return leftY + h - ((y - yMin) / (yMax - yMin) * h);
    }

    float inverseToXReal(float px) {
        return (px - leftX) / w * (xMax - xMin) + xMin;
    }

    float inverseToYReal(float py) {
        return (h - (py - leftY)) / h * (yMax - yMin) + yMin;
    }


}