import gamepadd.*;
import hypermedia.net.*;

Gamepadd gamepad;

int bluePWM;
int redPWM;

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
  
  String code = hex(byte(4 << 4 | bluePWM)) + hex(byte(redPWM << 4 | 4^bluePWM^redPWM^0xF));
  raspberrypi.send( code, botip, raspberrypi.port());
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
  println("Received: " + new String( data ) + " from " + ip + ".");
}
