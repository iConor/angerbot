import procontroll.*;

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

void initializeController() // Replace "Controller...Windows" with the name of the device.
{
  ctrlIO = ControllIO.getInstance( this );
//  gamePad = ctrlIO.getDevice( "Controller (Xbox 360 Wireless Receiver for Windows)" );
  gamePad = ctrlIO.getDevice( "Wireless 360 Controller" );

  steeringSlider = gamePad.getSlider( 3 );
  steeringSlider.setMultiplier( -7 );
  throttleSlider = gamePad.getSlider( 0 );
  throttleSlider.setMultiplier( -7 );
}
void updateController() // Get controller status and set motor control bytes.
{
  steeringPosition = int( steeringSlider.getValue() );
  throttlePosition = int( throttleSlider.getValue() );
  
  bluePWM = position2PWM( steeringPosition );
  redPWM = position2PWM( throttlePosition );
}
int position2PWM( int position ) // Convert thumbstick positions to LEGO PWM states.
{
  if ( position == 0 )
    return 8;
  else if ( position > 0 )
    return position;
  else
    return position + 16;
}
