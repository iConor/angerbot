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
  initializeController();
  initializeDisplay();
  initializeSerialPort();
  
  initializationDelay();
}
void draw()
{
  updateController();
  updateDisplay();
  updateSerialPort();
}

/* CONTROLLER */

void initializeController() // Replace "Controller...Windows" with the name of the device.
{
  ctrlIO = ControllIO.getInstance( this );
  gamePad = ctrlIO.getDevice( "Controller (Xbox 360 Wireless Receiver for Windows)" );

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

/* DISPLAY */

void initializeDisplay() // Print controller and serial port info to the console.
{
  ctrlIO.printDevices();
  gamePad.printButtons();
  gamePad.printSliders();
  println( Serial.list() );
}
void updateDisplay() // Put the control status on the screen.
{  
  println( " |  Throttle: " + throttlePosition + "  |  Steering: " + steeringPosition + "  | " );
}

/* SERIAL PORT */

void initializeSerialPort() // Change the "0" in brackets to the appropriate port.
{
  comPort = new Serial( this, Serial.list()[0], 9600 );
}
void updateSerialPort() // Send LEGO PWM states and validate the serial connection.
{
  checkByte = int( random( 128 ) );
  
  comPort.write( syncByte );
  comPort.write( checkByte );
  comPort.write( bluePWM );
  comPort.write( redPWM );
  
  while( comPort.available() <= 0 );
  
  if( comPort.read() != checkByte )
    while( true );
}

/* MISCELLANEOUS */

void initializationDelay() // This startup pause prevents the first validation from failing.
{
  int waitUntil = 2000 + millis();
  while ( waitUntil > millis () );
}


