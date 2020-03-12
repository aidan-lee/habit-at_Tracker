#include <Servo.h>

// Declaring pins 
int relayPin = 8;
int servoPin = 9;

Servo servo;

void setup() {
  // Initializing the serial port connection
  Serial.begin(9600);

  // Setting up the Arduino pins to interact with the servo and relay
  servo.attach(servoPin);
  pinMode(8, OUTPUT);
}

void loop() {
  // Continually check for messages on the serial port
  char state = Serial.read();
  waterFlower(state);
}

// Based on the state, moves the servo to a specified angle and starts the water pump
void waterFlower(int state)
{
  if (state == 0)
  {
    servo.write(0);
    delay(1000);
    digitalWrite(relayPin, HIGH);
    delay(750);
    digitalWrite(relayPin, LOW);
  }
  else if (state == 1)
  {
    servo.write(90);
    delay(1000);
    digitalWrite(relayPin, HIGH);
    delay(750);
    digitalWrite(relayPin, LOW);
  }
  if (state == 2)
  {
    servo.write(180);
    delay(1000);
    digitalWrite(relayPin, HIGH);
    delay(750);
    digitalWrite(relayPin, LOW);
  }
}
