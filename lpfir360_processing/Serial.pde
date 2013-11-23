import processing.serial.*;

Serial comPort;

int syncByte = '#';
int checkByte;

int timeOut = 0;

void initializeSerialPort() // Change the 0 in brackets to the appropriate port.
{
  comPort = new Serial( this, Serial.list()[4], 9600 );
}
void updateSerialPort() // Send LEGO PWM states and validate the serial connection.
{
  if( previousBluePWM != bluePWM || previousRedPWM != redPWM || timeOut < millis() )
  {
  checkByte = int( random( 128 ) );
  
  comPort.write( syncByte );
  comPort.write( checkByte );
  comPort.write( bluePWM );
  comPort.write( redPWM );
  
  while( comPort.available() <= 0 );
  
  if( comPort.read() != checkByte )
    while( true );
  
  previousBluePWM = bluePWM;
  previousRedPWM = redPWM;
  timeOut = 1100 + millis();
  }
}
