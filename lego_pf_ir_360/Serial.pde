void initializeSerialPort() {
  // Print a numbered list of available serial ports.
  for (int i = 0; i < Serial.list().length; i++ ) {
    println(i + "   " + Serial.list()[i]);
  }
  // Change the 0 inside brackets to match the desired port number.
  myPort = new Serial( this, Serial.list()[0], BAUD_RATE );
}

void updateSerialPort() {
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
  }
}

