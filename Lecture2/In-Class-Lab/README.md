# Hearing and Seeing Aliasing


| Sampling frequency | Nyquist frequency | Observed peak	Aliasing |
|---|---:|---|
| 24 kHz | 12 kHz | No |
| 16 kHz | 8 kHz | No |
| 12 kHz | 6 kHz | Yes |
| 8 kHz | 4 kHz | Yes |


# Questions

1) Which sampling frequencies represented the 7 kHz signal correctly?
-24 kHz, 16 kHz.
2) When did the 7 kHz signal appear as another frequency?
  WHen sampling frequency was 12 kHz and 8 kHz.
3) What happened when the Nyquist frequency became lower than 7 kHz?
  Aliasing.
4) Did the aliased signal sound different?
  Yes.
5) Why can MATLAB not recover the original 7 kHz signal after aliasing?
  When sampling frequency becomes lower than 2x the highrst frequency contained in the signal.


