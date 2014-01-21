import processing.serial.*;

import procontroll.*;
import net.java.games.input.*;

SerialThread serialThread;

void setup()
{
  serialThread = new SerialThread(this);
  
  initializeController();
  initializeDisplay();
  
  initializationDelay();
  serialThread.start();
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


