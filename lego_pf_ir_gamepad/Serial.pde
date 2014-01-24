class SerialThread extends Thread {

  private final int BAUD_RATE = 57600;
  private final int syncByte = '#';

  private boolean running;
  private int checkByte = 0;
  private int timeOut;
  private Serial serial;

  SerialThread(PApplet pApplet) {
    print("Creating communications thread.");
    running = false;
    AutoSerial autoSerial = new AutoSerial();
    serial = new Serial( pApplet, autoSerial.name(), BAUD_RATE );
    println("   Done.");
  }

  public void start() {
    print("Starting communications thread.");
    running = true;
    super.start();
    timeOut = 0;
    println("   Done.");

    // Start serial handshaking.
    serial.write( syncByte );
    serial.write( checkByte );
    serial.write( bluePWM );
    serial.write( redPWM );
  }

  public void run() {
    println("Running communications thread.");
    while (running) {
    }
  }

  public void quit() {
    print("Quitting communications thread.");
    running = false;
    serial.stop();
    println("   Done.");
  }

  public void event() {

    if ( serial.read() != checkByte )
      while ( true );

    checkByte = int( random( 128 ) );

    serial.write( syncByte );
    serial.write( checkByte );
    serial.write( bluePWM );
    serial.write( redPWM );
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

void serialEvent(Serial p) { 
  serialThread.event();
}

