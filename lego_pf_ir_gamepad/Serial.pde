import processing.serial.*;

Serial comPort;

final int BAUD_RATE = 57600;

final int syncByte = '#';

int checkByte;

int timeOut = 0;

void initializeSerialPort() // Change the 0 in brackets to the appropriate port.
{
  AutoSerial autoSerial = new AutoSerial();
  comPort = new Serial( this, autoSerial.name(), BAUD_RATE );
}
void updateSerialPort() // Send LEGO PWM states and validate the serial connection.
{
  if( previousBluePWM != bluePWM || previousRedPWM != redPWM || timeOut < millis() )
  {
  checkByte = int( random( 128 ) );
  
  comPort.write( syncByte );
  comPort.write( checkByte );
  comPort.write( bluePWM );
  comPort.write( redPWM );
  
  while( comPort.available() <= 0 );
  
  if( comPort.read() != checkByte )
    while( true );
  
  previousBluePWM = bluePWM;
  previousRedPWM = redPWM;
  timeOut = 1100 + millis();
  }
}

public class AutoSerial {

  //-------------------- Serial Port Names --------------------//

  // Known Serial Port Prefixes
  private final String WINDOWS= "COM";
  private final String MAC= "/dev/tty.usb";

  // List of Known Prefixes
  private final String[] KNOWN_PORTS = {
    WINDOWS, MAC
  };

  // Serial Port Name
  private String _name = "";
  // Serial Port Number
  private int _number = -1;

  //-------------------- Autodetection Routine --------------------//

  // Constructor
  public AutoSerial() {
    getSerialPortNameAndNumber();
  }

  // Get Serial Port Name and Number
  private void getSerialPortNameAndNumber() {

    String currentPortName = "";

    for ( int i=0; i < Serial.list().length; i++ ) {

      currentPortName = Serial.list()[i];

      for ( int j = 0; j < KNOWN_PORTS.length; j++ ) {

        if ( currentPortName.indexOf( KNOWN_PORTS[j] ) >= 0 ) {
          _name = currentPortName;
          _number = i;
        }
      }
    }
  }

  //-------------------- Name And Number Getters --------------------//

  public String name() {
    return _name;
  }
  public int number() {
    return _number;
  }
}
