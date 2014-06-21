import gamepadd.*;
import processing.serial.*;

/* Controller Stuff */

Gamepadd gamepad;

int steeringPosition;
int throttlePosition;

int bluePWM;
int redPWM;

int previousBluePWM;
int previousRedPWM;

/* Serial Stuff */

Serial myPort;

final int BAUD_RATE = 9600;
final int syncByte = '#';

int timeOut = 0;
int checkByte;

void setup() {

  // Setup a video game controller.
  gamepad = new Gamepadd( this, 7, 0.1 );

  // Print a numbered list of available serial ports.
  println("Serial Ports:");
  for (int i = 0; i < Serial.list().length; i++ ) {
    println("Port " + i + " - " + Serial.list()[i]);
  }
  
  // Change the 0 inside brackets to match the desired port number.
  myPort = new Serial( this, Serial.list()[5], BAUD_RATE );

  // Wait two seconds so the serial port doesn't lock up.
  int waitUntil = 2000 + millis();
  while ( waitUntil > millis () );
}

void draw() {

  // Get slider values and set desired PWM states.
  bluePWM = slider2PWM( int( -gamepad.getRightHorizontal() ) );
  redPWM = slider2PWM( int( gamepad.getLeftVertical() ) );

  // Only transmit when the controller changes or the LEGO timeout is almost up.
  if ( previousBluePWM != bluePWM || previousRedPWM != redPWM || timeOut < millis() ) {
    // This byte will be used to validate that the serial port is in sync.
    checkByte = int( random( 128 ) );
    // Write a packet of PWM states to the serial port.
    myPort.write( syncByte );
    myPort.write( checkByte );
    myPort.write( bluePWM );
    myPort.write( redPWM );
    // Wait for the checkByte to be sent back.
    while ( myPort.available () <= 0 );
    // Stop operation if something other than checkByte comes back.
    if ( myPort.read() != checkByte )
      while ( true );
    // Store which values were sent so we can check them next time through.
    previousBluePWM = bluePWM;
    previousRedPWM = redPWM;
    // Reset the timer.
    timeOut = 1100 + millis();
    // Print the values that were just sent.
    print("Output B (Blue):\t" + bluePWM + "\tOutput A (Red):\t" + redPWM);
    println( "\tElapsed Time (ms)\t" + millis() + "\t");
  }
}

// Convert slider values to LEGO Power Functions PWM steps.
int slider2PWM( int sliderValue ) {
  if ( sliderValue == 0 ) // PWM step 0 is LEGO's "float" (neutral) position.
    return 0;
  else if ( sliderValue > 0 )  // PWM steps 1 through 7 are forward.
    return sliderValue;
  else // PWM steps 9 through 15 are reverse, so we shift our negative values into that range.
  return sliderValue + 16;
}

