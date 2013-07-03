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

int sliderSegmentDimensionLong = 50;
int sliderSegmentDimensionShort = 12;
int sliderSegmentPositionScaling = 20;

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
  displayText();
  displayBackground();
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
  size( 800, 450 );
  font = loadFont("Consolas-10.vlw");
  textFont( font );
  textAlign( CENTER, CENTER );
  rectMode( CENTER );
  background( #ffffff );
}
void displayBackground()
{
  stroke( #000000 );
  fill( #ffffff );
  rect( width / 2, height / 2, 750, 400, 10, 0, 10, 0 );
  rect( width / 2, height / 2, 600, 400 );
  rect( width / 2, height / 2, 750, 250 );
  rect( width / 2, height / 2, 250, 250 );
  rect( width / 2, height / 3, 400, 200, 10, 0, 10, 0 );
  rect( width / 2, height - 100, 350, 100, 10, 0, 10, 0 );
  rect( width - 700, height / 2, 100, 350, 10, 0, 10, 0 );
  rect( width - 100, height / 2, 100, 350, 10, 0, 10, 0 );
}
void displayText()
{ 
  stroke( #000000 );
  fill( #000000 );
  
  text( "Throttle", width - 700, height - 387.5 );
  text( "Steering", width / 2, height - 137.5 );    
  text( "Status", width - 100, height - 387.5 );
  text( "Video", width / 2, height - 300 );
}
void displayBoxes()
{
  stroke( #000000 );
  fill( #000000 );
  
  rect( width / 2, height - 100, sliderSegmentDimensionShort * 2, sliderSegmentDimensionLong, 10, 0, 10, 0 );
  rect( width - 700, height / 2, sliderSegmentDimensionLong, sliderSegmentDimensionShort * 2, 10, 0, 10, 0 );
  
  for( int i = -7; i < 0; i++ )
  {
    if( throttlePosition > 0 && abs( i ) <= throttlePosition )
      fill( #000000 );
    else
      fill( #ffffff );
    rect( width - 700, height  / 2 - sliderSegmentDimensionShort / 2 - sliderSegmentPositionScaling * abs( i ), sliderSegmentDimensionLong, sliderSegmentDimensionShort, 10, 0, 10, 0 ); // FWD
    if( throttlePosition < 0 && i >= throttlePosition )
      fill( #000000 );
    else
      fill( #ffffff );
    rect( width - 700, height  / 2 + sliderSegmentDimensionShort / 2 - sliderSegmentPositionScaling * i, sliderSegmentDimensionLong, sliderSegmentDimensionShort, 10, 0, 10, 0 ); // REV
    if( steeringPosition > 0 && abs( i ) <= steeringPosition )
      fill( #000000 );
    else
      fill( #ffffff );
    rect( width / 2 - sliderSegmentDimensionShort / 2 - sliderSegmentPositionScaling * abs( i ), height - 100, sliderSegmentDimensionShort, sliderSegmentDimensionLong, 10, 0, 10, 0 ); // Left
    if( steeringPosition < 0 && i >= steeringPosition )
      fill( #000000 );
    else
      fill( #ffffff );
    rect( width / 2 + sliderSegmentDimensionShort / 2 - sliderSegmentPositionScaling * i, height - 100, sliderSegmentDimensionShort, sliderSegmentDimensionLong, 10, 0, 10, 0 ); // Right
  }
}


