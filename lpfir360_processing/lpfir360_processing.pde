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

PFont font;

void setup()
{
//  initializeSerialPort();
  initializeController();
  initializeDisplay();
}
void draw()
{
//  setRandomByte();
  updateControls();
//  transmitCommands();
  displayStatus();
//  receiveConfirmation();
}
void setRandomByte() // Generate random checkByte each cycle.
{
  checkByte = int( random( 128 ) );
}
void updateControls() // Get controller status and set motor control bytes.
{
  steeringPosition = int( steeringSlider.getValue() );
  throttlePosition = int( throttleSlider.getValue() );
  
  bluePWM = position2PWM( steeringPosition );
  redPWM = position2PWM( throttlePosition );
}
void transmitCommands() // Send sync, check and motor control bytes.
{
  comPort.write( syncByte );
  comPort.write( checkByte );
  comPort.write( bluePWM );
  comPort.write( redPWM );
}
void displayStatus() // Put the control status on the screen.
{  
//  println( " |  Throttle: " + throttlePosition + "  |  Steering: " + steeringPosition + "  | " ); // Print status.
  background( #ffffff );
  displayText();
  displayBoxes();
}
void receiveConfirmation() // Wait for a response and/or 'freeze' if there is an error.
{
  while( comPort.available() <= 0 );
  
  if( comPort.read() != checkByte )
    while( true );
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
void initializeSerialPort() // Change the 0 in brackets to the appropriate port.
{
  comPort = new Serial( this, Serial.list()[0], 9600 );
}
void initializeController() // Replace "Controller...Windows" with the name of the device.
{
  ctrlIO = ControllIO.getInstance( this );
  gamePad = ctrlIO.getDevice( "Controller (Xbox 360 Wireless Receiver for Windows)" );

  steeringSlider = gamePad.getSlider( 3 );
  steeringSlider.setMultiplier( -7 );
  throttleSlider = gamePad.getSlider( 0 );
  throttleSlider.setMultiplier( -7 );
}
void initializeDisplay()
{ 
  size( 420, 420 );
  font = loadFont("Consolas-16.vlw");
  textFont( font );
  fill( 0 );
  textAlign( CENTER, CENTER );
}
void displayText()
{ 
  text( "Throttle:", 60, 35 );
  text( "Steering:", 60, 75 );
  
  if( throttlePosition > 0 )
    text( "FWD " + throttlePosition, 70, 55 );
  if( throttlePosition < 0 )
    text( "REV " + abs( throttlePosition ), 70, 55 );
  if( steeringPosition > 0)
    text( "L " + steeringPosition, 70, 95 );
  if( steeringPosition < 0 )
    text( "R " + abs( steeringPosition ), 70, 95 );
}
void displayBoxes()
{
  if( steeringPosition >= 0 )
  {
    for( int i = 0; i <= steeringPosition; i++ )
    {
      rect( 250 - 20 * i, 50, 10, 22 + 4 * abs( i ), 10 );
    }
  }
  else
  {
    for( int i = 0; i >= steeringPosition; i-- )
    {
      rect( 250 - 20 * i, 50, 10, 22 + 4 * abs( i ), 10 );
    }
  }
  if( throttlePosition >= 0 )
  {
    for( int i = 0; i <= throttlePosition; i++ )
    {
      rect( 50, 250 - 20 * i, 22 + 4 * abs( i ), 10, 10 );
    }
  }
  else
  {
    for( int i = 0; i >= throttlePosition; i-- )
    {
      rect( 50, 250 - 20 * i, 22 + 4 * abs( i ), 10, 10 );
    }
  }
}


