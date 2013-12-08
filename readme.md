## LEGO Power Functions Infrared Gamepad

**Enable enhanced Power Functions operation - by replacing the standard Power Functions IR Remote Control - with a gamepad (using Processing and an Arduino).**

### Standard Operation:

*Power Functions IR Remote Control -> Power Functions IR Receiver*

* Left Stick: Drive - Forward (1 Speed) / Neutral / Reverse (1 Speed).
* Right Stick: Steering - Right (1 Angle) / Straight / Left (1 Angle).

### Enhanced Operation:

*Gamepad -> Processing -> Xbees -> Arduino -> IR LED -> Power Functions IR Receiver*

* Left Stick: Drive - Forward (7 Speeds) / Neutral / Reverse (7 Speeds).
* Right Stick: Steering - Right (7 Angles) / Straight / Left (7 Angles).

### Resources:

*The information and libraries needed to implement this configuration.*

* proCONTROLL Library for Processing - [Site](http://creativecomputing.cc/p5libs/procontroll/ "proCONTROLL") | [Download](http://creativecomputing.cc/p5libs/procontroll/procontroll.zip "proCONTROLL")
* LEGOPowerFunctions Library for Arduino - [Site](http://www.eurobricks.com/forum/index.php?showtopic=31640 "Eurobricks")  | [Download](http://rjwiersma.nl/img/LEGOPowerFunctions.rar "LEGOPowerFunctions")
* Lego PF IR Protocol Documentation [Site](http://philohome.com/pf/pf.htm "Philo's Home Page") | [PDF](http://philohome.com/pf/LEGO_Power_Functions_RC_v120.pdf "LEGO Power Functions RC v1.20")