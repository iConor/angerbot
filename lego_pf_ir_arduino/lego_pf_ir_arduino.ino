#include<legopowerfunctions.h>

long BAUD_RATE = 57600;
int IR_LED_PIN = 4;

int syncByte = '#';
int checkByte;

int bluePWM, redPWM;

LEGOPowerFunctions irSend( IR_LED_PIN );

void setup()
{ 
  Serial.begin( BAUD_RATE ); 
}
void loop()
{
  if( Serial.available() >= 4 )
  {
    if( Serial.read() == syncByte )
    {
      checkByte = Serial.read();
      bluePWM = Serial.read();
      redPWM = Serial.read();
      irSend.ComboPWM( bluePWM, redPWM, CH1 );
      Serial.write( checkByte );
    }
  }
}
