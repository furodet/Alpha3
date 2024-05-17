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

### Tuning and pitch shifting

OSC1 and OSC2 main pitch controlled for each oscillator:

  * octave, -2, -1 and +1
  * fine pitch: adss up to 252 *xtones* per octave, meaning `252/12=21` *xtones* per semi-tone

### Oscillator mix

OSC1/OSC2 mix controlled by:

  * The amount of OSC1 versus OSC2
  * Phase shifting of OSC2 versus OSC1

OSC1/OSC2/NOISE mix controlled by the amount of noise versus carrier.

## Digitally controlled filter (DCF)

TODO

## Envelopes

Two envelopes:

  * ENV: main envelope
    * Attack/Decay/Sustain/Release (ADSR) envelope
    * Connected to the DCA to control amplification of the signal
    * Freely usable for modulation
  * ENV1: alternative envelope freely usable for modulation
    * delay/Attack/Decay/Sustain/Release (dADSR) envelope

## Low Frequency Oscillators (LFO)

Two LFOs:

  * LFO: main LFO
    * Connected to the DCA to modulate amplification of the signal
    * Freely usable for modulation
  * LFO1: alternative LFO freely usable for modulation

The two LFOs are MSO, which can be modulated by ENV and ENV1.

## Digitally Controlled Amplifier (DCA)

TODO

## Modulation

TODO

