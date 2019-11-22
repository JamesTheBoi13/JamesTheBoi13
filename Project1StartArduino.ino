void setup() {
Serial.begin(9600);
}

void loop() {
int sensor1 = analogRead(A0);
int sensor2 = analogRead(A1);

sensor1 = map(sensor1, 0 ,1023, 0, 500);
sensor2 = map(sensor2, 0, 1023, 0, 500);

// keep this format
Serial.print(sensor1);
Serial.print(","); // put comma between sensor values
Serial.print(sensor2);
Serial.println();
// add linefeed after sending the last sensor value

// too fast communication might cause some latency in Processing
// this delay resolves the issue.
delay(100);
}
