void setup()
{
  initializeController();
  initializeDisplay();
  initializeSerialPort();
  
  initializationDelay();
}
void draw()
{
  updateController();
  updateDisplay();
  updateSerialPort();
}

/* MISCELLANEOUS */

void initializationDelay() // This startup pause prevents the first validation from failing.
{
  int waitUntil = 2000 + millis();
  while ( waitUntil > millis () );
}


