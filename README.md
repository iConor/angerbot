# LEGO Power Functions IR 360

### Motivation

***Enable enhanced LEGO Power Functions operation - by replacing the standard Power Functions IR Remote Control - with an Xbox 360 Controller (using Processing and an Arduino to generate the infrared transmissions).***

### Hardware

* LEGO 9398 4X4 Crawler (includeds controller, IR-TX) - [LEGO.com](http://www.lego.com/en-us/technic/products/speed/9398-4x4-crawler "Official site.") | [Brickipedia](http://lego.wikia.com/wiki/9398_4x4_Crawler "More info.")
* LEGO 8885 Power Functions IR Remote Control (IR-TX) - [LEGO.com](http://powerfunctions.lego.com/en-us/products/default.aspx#8885 "Official site.") | [Brickipedia](http://lego.wikia.com/wiki/8885_Power_Functions_IR_Remote_Control "More info.")
* Xbox 360 Wireless Controller (Or, any controller that appears to Processing as one.)
* A pair of Xbee radios (optional). This allows the Arduino to be mounted on the crawler.

##### Out-of-the-box Operation:

*Power Functions IR Remote Control -> Power Functions IR Receiver*

* Left Stick: Drive - Forward (1 Speed) / Neutral / Reverse (1 Speed).
* Right Stick: Steering - Right (1 Angle) / Straight / Left (1 Angle).

##### Enhanced Operation:

*Xbox 360 Wireless Controller -> Processing -> Xbees -> Arduino -> IR LED -> Power Functions IR Receiver*

* Left Stick: Drive - Forward (7 Speeds) / Neutral / Reverse (7 Speeds).
* Right Stick: Steering - Right (7 Angles) / Straight / Left (7 Angles).

### Software:

##### Dependencies:

*These libraries do all of the hard work:*

* proCONTROLL Library for Processing - [Source](http://creativecomputing.cc/p5libs/procontroll/ "proCONTROLL") | [Download](http://creativecomputing.cc/p5libs/procontroll/procontroll.zip "proCONTROLL")
* LEGOPowerFunctions Library for Arduino - [Source](http://www.eurobricks.com/forum/index.php?showtopic=31640 "Eurobricks")  | [Download](http://rjwiersma.nl/img/LEGOPowerFunctions.rar "LEGOPowerFunctions")

##### Releases:

1.0 - An Xbox 360 Controller replaces the included LEGO 8885 IR-TX.

### References:

* Lego PF IR Protocol Documentation - [Source](http://philohome.com/pf/pf.htm "Philo's Home Page") | [PDF](http://philohome.com/pf/LEGO_Power_Functions_RC_v120.pdf "LEGO Power Functions RC v1.20")
* XBee Series 2 Point to Point Communication - [Tutorial](http://tutorial.cytron.com.my/2012/03/08/xbee-series-2-point-to-point-communication/ "")
