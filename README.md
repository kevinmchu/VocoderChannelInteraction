# VocoderChannelInteraction

## About
This repository contains code that implements a sine wave vocoder for simulating the sound quality of a cochlear implant (CI). The traditional sine wave vocoder models the limited spectral information available to a CI user by summing together sine waves at frequencies that correspond to the electrode channels of a CI. In CI users, the effective spectral resolution is limited by channel interactions, a psychophysical phenomenon where the electrical stimulation on one electrode channel influences the perception of a stimulus presented on an adjacent channel. 

This code simulates a CI with channel interaction. Channel interaction is simulated as a weighted sum of analysis band envelopes across different frequency bands. Note that the current code assumes the ACE CI processing strategy as implemented in the Nucleus MATLAB Toolbox.

## Functions
The main function to run is generateVocodedSpeechWithCurrentSpread.m. This function takes the following input arguments:
1) p: CI processing map
2) y: sine wave vocoded signal without channel interactions
3) filter_slope: controls the amount of channel interaction
