void initializeController() {
  // Start proCONTROLL.
  ctrlIO = ControllIO.getInstance( this );
  // Tell proCONTROLL which controller to use.
  gamePad = ctrlIO.getDevice( "Controller (Xbox 360 Wireless Receiver for Windows)" );
  // Tell proCONTROLL which sliders to use.
  steeringSlider = gamePad.getSlider( 3 );  // Right stick, horizontal axis.
  throttleSlider = gamePad.getSlider( 0 );  // Left stick, vertical axis.
  // Make each slider return a more convenient value for later conversion.
  steeringSlider.setMultiplier( -7 );
  throttleSlider.setMultiplier( -7 );
}

void updateController() {
  // Get slider values and set desired PWM states.
  bluePWM = slider2PWM( int( steeringSlider.getValue() ) );
  redPWM = slider2PWM( int( throttleSlider.getValue() ) );
}

// Convert slider values to LEGO Power Functions PWM step.
int slider2PWM( int sliderValue ) {
  if ( sliderValue == 0 ) // PWM step 0 is LEGO's "float" (neutral) position.
    return 0;
  else if ( sliderValue > 0 )  // PWM steps 1 through 7 are forward.
    return sliderValue;
  else // PWM steps 9 through 15 are reverse, so we shift our slider value into that range.
    return sliderValue + 16;
}

