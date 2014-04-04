#include "legopowerfunctions.h"

const long BAUD_RATE = 9600;
const int IR_LED_PIN = 4;
const int syncByte = '#';

int checkByte;
int bluePWM; // Output B
int redPWM; // Output A

// Tell the LEGO Power Functions library which pin to use.
LEGOPowerFunctions irSend( IR_LED_PIN );

void setup() {
  // Start the serial port.
  Serial.begin( BAUD_RATE ); 
}

void loop() {
  // Wait for Processing to send a whole packet.
  if( Serial.available() >= 4 ) {
    // Read the packet starting at the syncByte.
    if( Serial.read() == syncByte ) {
      // Read the packet's contents into memory.
      checkByte = Serial.read();
      bluePWM = Serial.read();
      redPWM = Serial.read();
      // Transmit the PWM steps to the LEGO Power Functions receiver.
      irSend.ComboPWM( bluePWM, redPWM, CH1 );
      // Send the checkByte back to Processing for validation.
      Serial.write( checkByte );
    }
  }
}
