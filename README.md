# Alpha3 virtual analog synthesizer

Alpha3 is a VA synth developed with Simulink.

# Architecture

## Digitally Controlled Oscillator (DCO)

The carrier is a mix of 3 oscillators:

  * OSC1: a square oscillator with pulse width (PW)
  * OSC2: a *multi-shape* oscillator
  * NOISE: blue-noise generator

### Multi-shape oscillator (MSO)

Basically a triangle shape with two parameters:

  * Pulse Width (PW): position of the "inflection point" of the triangle (i.e. the summit)
      * `PW=0`: inverted sawtooth
      * `PW=255`: sawtooth
      * `PW=127`: triangle
  * Saturation (SAT): saturates the signal
      * With maximum saturation, the oscillator generates a good approximation of a square signal

## Digitally controlled filter (DCF)

TODO

## Envelopes

TODO

## Low Frequency Oscillators (LFO)

TODO

## Digitally Controlled Amplifier (DCA)

TODO

## Modulation

TODO

