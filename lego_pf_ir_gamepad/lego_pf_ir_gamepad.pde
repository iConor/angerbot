CommThread commThread = new CommThread(this);

void setup()
{
  initializeController();
  initializeDisplay();
  
  initializationDelay();
  commThread.start();
}
void draw()
{
  updateController();
  updateDisplay();
}

/* MISCELLANEOUS */

void initializationDelay() // This startup pause prevents the first validation from failing.
{
  int waitUntil = 2000 + millis();
  while ( waitUntil > millis () );
}


