import procontroll.*;
import processing.serial.*;

/* Serial Stuff */

Serial myPort;

final int BAUD_RATE = 9600;
final int syncByte = '#';

int timeOut = 0;
int checkByte;

/* Controller Stuff */

ControllIO ctrlIO;

ControllDevice gamePad;
ControllSlider steeringSlider;
ControllSlider throttleSlider;

int steeringPosition;
int throttlePosition;

int bluePWM;
int redPWM;

int previousBluePWM;
int previousRedPWM;

/* Self-Explanatory? */

void setup() {
  initializeController();
  initializeSerialPort();
  // Wait two seconds.
  initializationDelay();
}

void draw() {
  updateController();
  updateSerialPort();
}

// Without this, the first serial port validation will fail.
void initializationDelay() {
  int waitUntil = 2000 + millis();
  while ( waitUntil > millis () );
}


