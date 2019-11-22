// IMA NYU Shanghai
// Interaction Lab
// For receiving multiple values from Arduino to Processing

/*
 * Based on the readStringUntil() example by Tom Igoe
 * https://processing.org/reference/libraries/serial/Serial_readStringUntil_.html
 */
PImage photo;
import processing.serial.*;

String myString = null;
Serial myPort;


int NUM_OF_VALUES = 2;   /** YOU MUST CHANGE THIS ACCORDING TO YOUR PROJECT **/
int[] sensorValues;      /** this array stores values from Arduino **/


void setup() {
  size(500, 500);
  background(0);
  setupSerial();
  photo = loadImage("panda.jpg");
  colorMode(HSB);
}


void draw() {
  updateSerial();
  printArray(sensorValues);

  // use the values like this!
  // sensorValues[0] 
  tint(sensorValues [0], 255, sensorValues [1], sensorValues [1]);
  image(photo,0,0);
  // add your code

  //
}



void setupSerial() {
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[ 4 ], 9600);
  // WARNING!
  // You will definitely get an error here.
  // Change the PORT_INDEX to 0 and try running it again.
  // And then, check the list of the ports,
  // find the port "/dev/cu.usbmodem----" or "/dev/tty.usbmodem----" 
  // and replace PORT_INDEX above with the index number of the port.

  myPort.clear();
  // Throw out the first reading,
  // in case we started reading in the middle of a string from the sender.
  myString = myPort.readStringUntil( 10 );  // 10 = '\n'  Linefeed in ASCII
  myString = null;

  sensorValues = new int[NUM_OF_VALUES];
}



void updateSerial() {
  while (myPort.available() > 0) {
    myString = myPort.readStringUntil( 10 ); // 10 = '\n'  Linefeed in ASCII
    if (myString != null) {
      String[] serialInArray = split(trim(myString), ",");
      if (serialInArray.length == NUM_OF_VALUES) {
        for (int i=0; i<serialInArray.length; i++) {
          sensorValues[i] = int(serialInArray[i]);
        }
      }
    }
  }
}
