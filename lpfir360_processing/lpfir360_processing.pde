import processing.serial.*;
import procontroll.*;

Serial comPort;

ControllIO ctrlIO;

ControllDevice gamePad;
ControllSlider steeringSlider;
ControllSlider throttleSlider;

int steeringPosition;
int throttlePosition;

int syncByte = '#';
int checkByte;

int bluePWM;
int redPWM;

void setup()
{
  comPort = new Serial( this, Serial.list()[0], 9600 );
  
  ctrlIO = ControllIO.getInstance( this );
  gamePad = ctrlIO.getDevice( "Controller (Xbox 360 Wireless Receiver for Windows)" );

  steeringSlider = gamePad.getSlider( 3 );
  steeringSlider.setMultiplier( -7 );
  throttleSlider = gamePad.getSlider( 0 );
  throttleSlider.setMultiplier( -7 );
  
  int startupTimer = 2000 + millis();
  while ( startupTimer > millis () );
}
void draw()
{
  checkByte = int( random( 128 ) );
  
  steeringPosition = int( steeringSlider.getValue() );
  throttlePosition = int( throttleSlider.getValue() );
  
  bluePWM = position2PWM( steeringPosition );
  redPWM = position2PWM( throttlePosition );
  
  comPort.write( syncByte );
  comPort.write( checkByte );
  comPort.write( bluePWM );
  comPort.write( redPWM );
  
  println( " |  Throttle: " + throttlePosition + "  |  Steering: " + steeringPosition + "  | " ); // Print status.
  
  while( comPort.available() <= 0 );
  
  if( comPort.read() != checkByte )
  {
    while( true );
  }
}
int position2PWM( int position )
{
  if ( position == 0 )
  {
    return 8;
  }
  else if ( position > 0 )
  {
    return position;
  }
  else
  {
    return position + 16;
  }
}
