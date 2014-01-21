class SerialThread extends Thread {

  private final int BAUD_RATE = 57600;
  private final int syncByte = '#';

  private boolean running;
  private int checkByte;
  private int timeOut;
  private Serial serial;

  SerialThread(PApplet pApplet) {
    print("Creating communications thread.");
    running = false;
    SerialPort serialPort = new SerialPort();
    serial = new Serial( pApplet, serialPort.name(), BAUD_RATE );
    println("   Done.");
  }

  public void start() {
    print("Starting communications thread.");
    running = true;
    super.start();
    timeOut = 0;
    println("   Done.");
  }

  public void run() {
    println("Running communications thread.");
    while (running) {
      if ( previousBluePWM != bluePWM || previousRedPWM != redPWM || timeOut < millis() )
      {
        // println("Cycling communications.");
        
        checkByte = int( random( 128 ) );

        serial.write( syncByte );
        serial.write( checkByte );
        serial.write( bluePWM );
        serial.write( redPWM );

        while ( serial.available () <= 0 );

        if ( serial.read() != checkByte )
          while ( true );

        timeOut = 1100 + millis();
      }
    }
  }

  public void quit() {
    print("Quitting communications thread.");
    running = false;
    serial.stop();
    println("   Done.");
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

