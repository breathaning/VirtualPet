import cc.arduino.*;
import org.firmata.*;

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

double jumpVelocity = 40;
double flapJumpThreshold = 100;
double gravity = 98;

double yVelocity = 0;
double yPosition = 0;

double lastHighestFlap = 0;
double lastFlapMagnitude = 0;

double previousTime = millis() / 1000.0;

void setup() {
  size(500, 500);
  arduino = new Arduino(this, Arduino.list()[0], 57600);
}

void draw() {
  double time = millis() / 1000.0;
  double deltaTime = time - previousTime;
  previousTime = time;
  float lightSensorRead = arduino.analogRead(5);
  float flapAngle = (lightSensorRead * PI / 180 / 4) - 0.4;
  
  yVelocity -= gravity * deltaTime;
  yPosition += yVelocity * deltaTime;
  if (yPosition < 0) {
    yPosition = 0;
    yVelocity = 0;
  }
  if (yPosition < -100) {
    yPosition = -100;
    yVelocity = -100;
  }
  
  background(173, 216, 230);
  translate(0, -(float)yPosition);
  strokeWeight(4);
  stroke(0, 0, 0);
  float legRotation = (float)yVelocity / 150;
  translate(250, 250);
  rotate(legRotation);
  line(0, 0, 25, 100);
  line(25, 100, 50, 105);
  line(25, 100, 40, 115);
  line(25, 100, 25, 120);
  rotate(-legRotation);
  translate(-250, -250);
  translate(150, 250);
  rotate(-legRotation);
  line(0, 0, -25, 100);
  line(-25, 100, 0, 105);
  line(-25, 100, -10, 115);
  line(-25, 100, -25, 120);
  rotate(legRotation);
  translate(-150, -250);
  fill(255, 255, 0);
  strokeWeight(4);
  stroke(0, 0, 0);
  float bodySizeOffset = -5 + ((float)yVelocity / 2);
  if (bodySizeOffset < 0) {
    bodySizeOffset = 0;
  }
  ellipse(200, 220, 200, 170 + bodySizeOffset);
  ellipse(300, 150, 125 + bodySizeOffset, 125);
  translate(250, 200);
  rotate(flapAngle);
  arc(-110, 0, 200, 125, -PI / 4, PI, CHORD);
  arc(-90, 25, 200, 50, PI / 2, PI, OPEN);
  arc(-90, 10, 150, 50, PI / 3, PI - (PI / 4), OPEN);
  rotate(-flapAngle);
  translate(-250, -200);
  fill(255, 255, 255);
  strokeWeight(4);
  float eyeSize = 35 + (float)yVelocity / 5;
  if (eyeSize < 35) {
    eyeSize = 35;
  }
  ellipse(275, 125, eyeSize, eyeSize);
  ellipse(325, 125, eyeSize, eyeSize);
  fill(0, 0, 0);
  strokeWeight(0);
  ellipse(275, 125, 25, 25);
  ellipse(325, 125, 25, 25);
  fill(255, 255, 255);
  rect(276, 116, 8, 8);
  rect(326, 116, 8, 8);
  fill(255, 128, 0);
  strokeWeight(2);
  float beakWidthOffset = (float)yVelocity / 15;
  if (beakWidthOffset < 0) {
    beakWidthOffset = 0;
  }
  triangle(300, 150 + beakWidthOffset, 315 + beakWidthOffset, 165, 285 - beakWidthOffset, 165);
  triangle(300, 180 - beakWidthOffset, 315 + beakWidthOffset, 165, 285 - beakWidthOffset, 165);
  strokeWeight(3);
  line(320 + beakWidthOffset, 165, 280 - beakWidthOffset, 165);
  noFill();
  strokeWeight(5);
  bezier(260, 100, 260, 105, 280, 110, 290, 105);
  bezier(310, 105, 320, 110, 340, 105, 340, 100);
  
  if (lightSensorRead > lastHighestFlap) { 
    lastHighestFlap = lightSensorRead;
  } else {
    lastFlapMagnitude = lastHighestFlap - lightSensorRead;
  }
  boolean doJump = (lastFlapMagnitude >= flapJumpThreshold);
  if (doJump) {
    yVelocity = jumpVelocity;
    lastHighestFlap = lightSensorRead;
  }
}
