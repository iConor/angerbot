import processing.serial.*;

class CommThread extends Thread {

  PApplet parent;
  Serial comPort;

  int syncByte = '#';
  int checkByte;

  int timeOut = 0;

  boolean running;

  CommThread(PApplet caller) {
    parent = caller;
    running = false;
  }

  void start() {
    println("Starting communications thread.");
    running = true;
    comPort = new Serial( parent, Serial.list()[4], 9600 );
    super.start();
  }
  void run() {
    println("Running communications thread.");
    while (running) {
      if ( previousBluePWM != bluePWM || previousRedPWM != redPWM || timeOut < millis() )
      {
        checkByte = int( random( 128 ) );

        comPort.write( syncByte );
        comPort.write( checkByte );
        comPort.write( bluePWM );
        comPort.write( redPWM );

        while ( comPort.available () <= 0 );

        if ( comPort.read() != checkByte )
          while ( true );

        previousBluePWM = bluePWM;
        previousRedPWM = redPWM;
        timeOut = 1100 + millis();
      }
    }
  }
  void quit() {
    println("Quitting communications thread.");
    running = false;
    interrupt();
  }
}

