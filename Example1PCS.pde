import processing.serial.*;

String myString = null;
Serial myPort;

int NUM_OF_VALUES = 2; 
int[] sensorValues; 

void setup() {
size(500, 500);
background(0);
rectMode(CENTER);
setupSerial();
}

void draw() {
updateSerial();
printArray(sensorValues);

// use the values like this!
// sensorValues[0]

// add your code
fill(255,255,255);
ellipse(width/2,height/2,sensorValues [0], sensorValues [1]);
//
}
