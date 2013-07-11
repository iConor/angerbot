#include<legopowerfunctions.h>

LEGOPowerFunctions irSend( 2 );

int syncByte = '#';
int checkByte;

int bluePWM;
int redPWM;

void setup()
{ 
  Serial.begin( 9600 ); 
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


