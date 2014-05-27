void initializeSerialPort() {
  // Print a numbered list of available serial ports.
  for (int i = 0; i < Serial.list().length; i++ ) {
    println(i + "   " + Serial.list()[i]);
  }
  // Change the 0 inside brackets to match the desired port number.
  myPort = new Serial( this, Serial.list()[0], BAUD_RATE );
}

void updateSerialPort() {
  // Write a packet of PWM states to the serial port.
  myPort.write( syncByte );
  myPort.write( checkByte );
  myPort.write( bluePWM );
  myPort.write( redPWM );
}

void serialEvent( Serial myPort ) {
  // Stop operation if something other than checkByte comes back.
  if ( myPort.read() != checkByte )
    while ( true );
  // This byte will be used to validate that the serial port is in sync.
  checkByte = int( random( 128 ) );
  // It's safe to write another packet at this point.
  updateSerialPort();
}

