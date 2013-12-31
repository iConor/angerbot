#include<legopowerfunctions.h>

const long BAUD_RATE = 57600;
const int PACKET_SIZE = 5;
const int PACKET_START = '#';

int checkByte;

int bluePWM, redPWM;

LEGOPowerFunctions irTransmit( IR_TRANSMIT_PIN );

const int IR_TRANSMIT_PIN = 4;
const int LEFT_BLINKER_PIN = 8;
const int RIGHT_BLINKER_PIN = 9;
const int BRAKE_LIGHT_PIN = 7;
const int REVERSE_LIGHT_PIN = 10;

enum AmberLights { 
  OFF, LEFT, RIGHT, HAZARD };
AmberLights indicators = HAZARD;
AmberLights previousIndicators = HAZARD;

boolean leftIndicatorOn = false;
boolean rightIndicatorOn = false;

const unsigned long DUTY_CYCLE = 375;
unsigned long blinkerTimer = 0;

int throttle = 1;
int previousThrottle = 0;

void setup() {
  Serial.begin( BAUD_RATE );
  pinMode( LEFT_BLINKER_PIN, OUTPUT );
  pinMode( RIGHT_BLINKER_PIN, OUTPUT );
  pinMode( BRAKE_LIGHT_PIN, OUTPUT );
}

void loop() {
  if( Serial.available() >= PACKET_SIZE ) {
    if( Serial.read() == PACKET_START ) {
      checkByte = Serial.read();
      indicators = static_cast<AmberLights>(Serial.read());
      bluePWM = Serial.read();
      redPWM = Serial.read();
      irTransmit.ComboPWM( bluePWM, redPWM, CH1 );
      Serial.write( indicators );
      /*
       * Brake Lights
       */
      throttle = redPWM;
      if( throttle == 8 && throttle != previousThrottle ) {
        digitalWrite( BRAKE_LIGHT_PIN, HIGH );
      } 
      else if ( previousThrottle == 8 && throttle != previousThrottle ) {
        digitalWrite( BRAKE_LIGHT_PIN, LOW );
      }
      previousThrottle = throttle;
      /*
       * Amber Lights
       */
      if( indicators != previousIndicators ) {
        leftIndicatorOn = indicatorFlipFlop( true, LEFT_BLINKER_PIN );
        rightIndicatorOn = indicatorFlipFlop( true, RIGHT_BLINKER_PIN );
        blinkerTimer = 0;
      }
      previousIndicators = indicators;
    }
  }
  /*
   * Blinkers and Flashers
   */
  if( indicators != OFF && millis() >= blinkerTimer ) {
    if( indicators == LEFT ) {
      leftIndicatorOn = indicatorFlipFlop( leftIndicatorOn, LEFT_BLINKER_PIN );
    } 
    else if( indicators == RIGHT ) {
      rightIndicatorOn = indicatorFlipFlop( rightIndicatorOn, RIGHT_BLINKER_PIN );
    }
    else if( indicators == HAZARD ) {
      leftIndicatorOn = indicatorFlipFlop( leftIndicatorOn, LEFT_BLINKER_PIN );
      rightIndicatorOn = indicatorFlipFlop( rightIndicatorOn, RIGHT_BLINKER_PIN );
    }
    blinkerTimer = millis() + DUTY_CYCLE;
  }
}
/*
 * Swap indicator states:
 */
boolean indicatorFlipFlop( boolean indicatorOn, int indicatorPin ) {
  if( indicatorOn ){
    digitalWrite( indicatorPin, LOW );
    indicatorOn = false;
  }
  else {
    digitalWrite( indicatorPin, HIGH );
    indicatorOn = true;
  }
  return indicatorOn;
}
