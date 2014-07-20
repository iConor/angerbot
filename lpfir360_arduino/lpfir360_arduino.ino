#include "legopowerfunctions.h"

const long BAUD_RATE = 9600;
const int IR_LED_PIN = 4;
const int red = 16;

int bluePWM;
int redPWM;

int previousBluePWM = 0;
int previousRedPWM = 0;

int timeOut = 0;

LEGOPowerFunctions irSend( IR_LED_PIN );

void setup() {
  Serial.begin( BAUD_RATE ); 
}

void loop() {

  if( bluePWM != previousBluePWM || redPWM != previousRedPWM || timeOut < millis() ) {

    irSend.ComboPWM( bluePWM, redPWM, CH1 );
    timeOut = 1100 + millis();

    previousBluePWM = bluePWM;
    previousRedPWM = redPWM;
  }

  if( Serial.available() > 0) {
    int received = Serial.read();
    Serial.write( received );
    if( received < red ) {
      bluePWM = received;
    }
    else {
      redPWM = received - red;
    }
  }  
}



