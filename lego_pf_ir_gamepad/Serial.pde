import processing.serial.*;

Serial comPort;

final int BAUD_RATE = 57600;

final int syncByte = '#';

int checkByte;

int timeOut = 0;

void initializeSerialPort() // Change the 0 in brackets to the appropriate port.
{
  SerialPort serialPort = new SerialPort();
  comPort = new Serial( this, serialPort.name(), BAUD_RATE );
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

public class SerialPort {

  public final String WINDOWS= "COM";
  public final String LINUX_MAC= "/dev/tty.usb";

  private final String[] KNOWN_PORTS = {
    WINDOWS, LINUX_MAC
  };
  
  private String _name = "";
  
  SerialPort() {
    String currentPortName = "";
    
    for (int i=0;i<Serial.list().length;i++) {

      currentPortName = Serial.list()[i];

      for (int j=0;j<KNOWN_PORTS.length;j++) {

        if (currentPortName.indexOf(KNOWN_PORTS[j])>=0) {
          _name = currentPortName;
        }
      }
    }
  }
  
  public String name() {
    return _name;
  }
}
