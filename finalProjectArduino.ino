// IMA NYU Shanghai
// Interaction Lab
// For sending multiple values from Arduino to Processing


void setup() {
  Serial.begin(9600);
}

void loop() {
  int sensor1 = analogRead(A0);
  int sensor2 = analogRead(A1);
  int sensor3 = analogRead(A2);
  int sensor4 = analogRead(A3);

  sensor1 = map(sensor1, 0, 1023, 0, 60);
  sensor2 = map(sensor2, 0, 1023, 0, 60);
  sensor3 = map(sensor3, 0, 1023, 0, 60);
  sensor4 = map(sensor4, 0, 1023, 0, 60);

  // keep this format
  Serial.print(sensor1);
  Serial.print(",");
  Serial.print(sensor2);
  Serial.print(",");
  Serial.print(sensor3);
  Serial.print(",");
  Serial.print(sensor4);
//  Serial.print(",");  // put comma between sensor values
//  Serial.print(sensor2);
  Serial.println(); // add linefeed after sending the last sensor value

  // too fast communication might cause some latency in Processing
  // this delay resolves the issue.
  delay(100);
}
