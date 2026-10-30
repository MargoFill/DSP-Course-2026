What was filtered:
I identified a steady low-frequency electrical hum (mains hum) in the recording, primarily centered around 50 Hz.

Filter used:
I applied an IIR notch filter (a narrow band-stop filter) using MATLAB's iirnotch and filtfilt functions. The filter was configured with a target frequency of 50 Hz to target the electrical interference specifically.

What changed:
The spectrogram and waveform show a significant reduction of energy at the 50 Hz mark, effectively removing the constant drone in the background. The overall listening experience is improved. Because a narrow band-stop filter was used, the useful audio (such as voice or music) remains largely preserved, though any useful low-frequency components exactly at 50 Hz were inevitably attenuated as well.
