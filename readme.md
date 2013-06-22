## LEGO Power Functions Infrared 360

**Enable enhanced Power Functions operation - by replacing the standard Power Functions IR Remote Control - with an Xbox 360 Controller.**

### The Story

I unlocked some hidden capabilities of my LEGO 9398 4X4 Crawler when I switched from the included remote control to a video game controller. The Power Function IR Remote Control is limited to simple forward/reverse and right/left commands. The crawler has only one speed in either direction and the wheels only allow for a single turning radius in either direction. I learned from the PDF linked below that the IR protocol passes PWM steps which actually allow for 7 steps in any direction. Using the Xbox 360 Controller allows easy access to 7 forward speeds, another 7 in reverse and 7 wheel angles for a variety of turning radii in either direction.

### What do?

I have an Xbee and IR LED connected via breadboard to an Arduino which is mounted on the LEGO set. The Host PC has a second Xbee connected to it as well as the Xbox 360 Controller. The .ino file for the Arduino receives commands from the Host PC, transmits motor controls to the LEGO set and echoes a check byte back to the Host PC. The .pde file for Processing on the Host PC handles controller input and generates commands for the Arduino. Each command includes two motor states and a randomly generated check byte. The data is transferred via serial port and Xbees are used to wirelessly extend the port. After the Host PC sends each command it waits until it receives the check byte back before sending another command. This allows timing on the Arduino to control data flow and aborts data flow in the event of some hiccup to prevent spastic or unsynchronized operation. 

### Standard Operation:

*Power Functions IR Remote Control -> Power Functions IR Receiver*

* Left Stick: Drive - Forward (1 Speed) / Neutral / Reverse (1 Speed).
* Right Stick: Steering - Right (1 Angle) / Straight / Left (1 Angle).

### Enhanced Operation:

*Xbox 360 Controller -> Host PC -> Xbee -> Arduino -> Power Functions IR Receiver*

* Left Stick: Drive - Forward (7 Speeds) / Neutral / Reverse (7 Speeds).
* Right Stick: Steering - Right (7 Angles) / Straight / Left (7 Angles).

### Resources:

*The information and files I have gathered in order to make this work.*

* Library for Processing - [Site](http://creativecomputing.cc/p5libs/procontroll/ "proCONTROLL") | [Download](http://creativecomputing.cc/p5libs/procontroll/procontroll.zip "proCONTROLL")
* Library for Arduino - [Site](http://www.eurobricks.com/forum/index.php?showtopic=31640 "Eurobricks")  | [Download](http://rjwiersma.nl/img/LEGOPowerFunctions.rar "LEGOPowerFunctions")
* Lego PF IR Protocol Documentation [Site](http://philohome.com/pf/pf.htm "Philo's Home Page") | [PDF](http://philohome.com/pf/LEGO_Power_Functions_RC_v120.pdf "LEGO Power Functions RC v1.20")



