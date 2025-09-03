void setup() {
 size(500, 500);
}

void draw() {
    background(255, 255, 255);
    strokeWeight(4);
    stroke(0, 0, 0);
    line(250, 250, 275, 350);
    line(275, 350, 300, 355);
    line(275, 350, 290, 365);
    line(275, 350, 275, 370);
    line(150, 250, 125, 350);
    line(125, 350, 150, 355);
    line(125, 350, 140, 365);
    line(125, 350, 125, 370);
    fill(255, 255, 0);
    strokeWeight(4);
    stroke(0, 0, 0);
    ellipse(200, 220, 200, 170);
    ellipse(300, 150, 125, 125);
    arc(140, 200, 200, 125, -PI / 4, PI, CHORD);
    arc(160, 225, 200, 50, PI / 2, PI, OPEN);
    arc(160, 210, 150, 50, PI / 3, PI - (PI / 4), OPEN);
    fill(255, 255, 255);
    strokeWeight(4);
    ellipse(275, 125, 35, 35);
    ellipse(325, 125, 35, 35);
    fill(0, 0, 0);
    strokeWeight(0);
    ellipse(275, 125, 25, 25);
    ellipse(325, 125, 25, 25);
    fill(255, 255, 255);
    rect(276, 116, 8, 8);
    rect(326, 116, 8, 8);
    fill(255, 128, 0);
    strokeWeight(2);
    triangle(300, 150, 315, 165, 285, 165);
    triangle(300, 180, 315, 165, 285, 165);
    strokeWeight(3);
    line(320, 165, 280, 165);
    noFill();
    strokeWeight(5);
    bezier(260, 100, 260, 105, 280, 110, 290, 105);
    bezier(310, 105, 320, 110, 340, 105, 340, 100);
}
