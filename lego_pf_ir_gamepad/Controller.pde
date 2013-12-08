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

void initializeController()
{
  ctrlIO = ControllIO.getInstance( this );
  Gamepad gamepad = new Gamepad( ctrllIO );
  gamePad = ctrlIO.getDevice( gamepad.activeGamepad );

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

public static class Gamepad {

  private static final String[] gamepadName = {"PLAYSTATION(R)3 Controller", "Controller (Xbox 360 Wireless Receiver for Windows)", "Wireless 360 Controller", "AIRFLO             "};

  public static String activeGamepad = "";

  public Gamepad(ControllIO controllIO) {
    
    ControllDevice controllDevice;
    String currentDeviceName = "";
    
    for (int i=0;i<controllIO.getNumberOfDevices();i++) {
      
      controllDevice = controllIO.getDevice(i);
      currentDeviceName = controllDevice.getName();
      
      for(int j=0;j<gamepadName.length;j++){
        
        if(currentDeviceName.equals(gamepadName[j])){
          activeGamepad = gamepadName[j];
        }
        
      }
    }
  }
}
