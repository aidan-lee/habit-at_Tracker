#include <Servo.h>

int relayPin = 8;
int servoPin = 9;

Servo servo;

void setup() {
  // put your setup code here, to run once:

  Serial.begin(9600);
  servo.attach(servoPin);
  pinMode(8, OUTPUT);
}

void loop() {
  char state = Serial.read();
  waterFlower(state);
}

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
