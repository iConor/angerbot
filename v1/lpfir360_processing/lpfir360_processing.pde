import gamepadd.*;
import processing.serial.*;

final int red = 16;

Gamepadd gamepad;

int steeringPosition;
int throttlePosition;

int desiredBluePWM = 0;
int desiredRedPWM = 16;

int reportedBluePWM = 0;
int reportedRedPWM = 16;

Serial myPort;
final int BAUD_RATE = 9600;

void setup() {

  gamepad = new Gamepadd( this, 7, 0.25 );

  println("Serial Ports:");
  for (int i = 0; i < Serial.list ().length; i++ ) {
    println("Port " + i + " - " + Serial.list()[i]);
  }

  myPort = new Serial( this, Serial.list()[0], BAUD_RATE );

  int waitUntil = 2000 + millis();
  while ( waitUntil > millis () );
}

void draw() {

  desiredBluePWM = slider2PWM( int( -gamepad.getRightHorizontal() ) );
  desiredRedPWM = red + slider2PWM( int( gamepad.getLeftVertical() ) );

  if ( transmission( reportedBluePWM, desiredBluePWM ) ) {
    println("TX - Blue - " + desiredBluePWM);
  }
  if ( transmission( reportedRedPWM, desiredRedPWM ) ) {
    println("TX - Red - " + (desiredRedPWM - red));
  }

  if ( myPort.available() > 0 ) {
    int received = myPort.read();
    if ( received < red ) {
      reportedBluePWM = received;
      println("RX - Blue - " + reportedBluePWM);
    } else {
      reportedRedPWM = received - red;
      println("RX - Red - " + reportedRedPWM);
    }
  }
}

int slider2PWM( int sliderValue ) {
  if ( sliderValue == 0 )
    return 0;
  else if ( sliderValue > 0 )
    return sliderValue;
  else
    return sliderValue + 16;
}

boolean transmission ( int reported, int desired ) {
  boolean transmit = desired != reported;
  if ( transmit ) {
    myPort.write( desired );
  }
  return transmit;
}

