import gamepadd.*;
import hypermedia.net.*;

Gamepadd gamepad;

int bluePWM;
int redPWM;

String reportedCode = "";
int timeout = 0;

UDP raspberrypi;
String botip = "192.168.1.74";

void setup() {

  frameRate( 10 );

  gamepad = new Gamepadd( this, 7, 0.1 );

  raspberrypi = new UDP( this, 9398 );
  raspberrypi.listen( true );
}

void draw() {

  bluePWM = slider2PWM( int( -gamepad.getRightHorizontal() ) );
  redPWM = slider2PWM( int( gamepad.getLeftVertical() ) );

  String desiredCode = hex(byte(4 << 4 | bluePWM)) + hex(byte(redPWM << 4 | 4^bluePWM^redPWM^0xF));
  if ( !reportedCode.equals(desiredCode) || timeout < millis() ) {
    raspberrypi.send( desiredCode, botip, raspberrypi.port());
    timeout = 1100 + millis();
  }
}

int slider2PWM( int sliderValue ) {
  int pwmValue;
  if ( sliderValue == 0 )
    pwmValue = 0;
  else if ( sliderValue > 0 )
    pwmValue =  sliderValue;
  else
    pwmValue = sliderValue + 16;
  return pwmValue;
}

void receive( byte[] data, String ip, int port ) {
  reportedCode = new String( data );
  println("Received: " + reportedCode + " from " + ip + ".");
}

