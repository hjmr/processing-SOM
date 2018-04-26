SOM som = null;

void setup() {
    size(600, 600);
    frameRate(20);
    background(0);

    som = new SOM(10, 10, 5);
}

void draw() {
    fadeToBlack();
    if( som != null ) {
        som.draw();
    }
}

void fadeToBlack() {
    noStroke();
    fill(0, 50);
    rectMode(CORNER);
    rect(0, 0, width, height);
}

void mouseMoved() {
    if( som != null ) {
        som.checkMouseOver();
    }
}