# TASK 1 Build a Square Wave from Harmonics
## Predictions
As more odd harmonics are added to the partial sum, the generated signal will progressively approximate an ideal square wave. The transition edges between high and low states will become steeper, and the flat tops and bottoms of the waveform will become smoother and flatter.
## Results and Observations
- Effect of Increasing $H$: As the maximum harmonic index $H$ increases from 1 to 25, the number of ripple oscillations per period increases, but their amplitude decreases along the flat top and bottom. The slope of the signal during state transitions becomes significantly steeper, making the shape much closer to a ideal square wave.
- Sharp Transitions & Gibbs Phenomenon: Near the sharp discontinuities (step changes), noticeble overshoots and high-frequency oscillations appear. This behavior is known as the Gibbs phenomenon. Regardless of how high $H$ is increased, the peak overshoot near the transition remains at approximately 9% of the step height, though the overshoot region becomes narrower and concentrates closer to the edge.
# TASK 2  Find Two Frequencies with the FFT
## Frequencies and Amplitudes
`f1=15Hz, A1=0.8`

`f2=40Hz, A2=0.4`
## Predictions
Since $f_1 = 15\text{ Hz}$ and $f_2 = 40\text{ Hz}$ are integer values that fit an exact number of complete cycles within the $1\text{-second}$ window, both frequencies lie precisely on the DFT frequency grid. The single-sided amplitude spectrum will show two clean, sharp peaks at $15\text{ Hz}$ and $40\text{ Hz}$ with exact amplitudes of $0.8$ and $0.4$, with no spectral leakage into neighboring bins.

## Frequency-Bin Spacing Calculation
- Sampling frequency: $f_s = 200\text{ Hz}$
- Record length: $T = 1\text{ s} \implies N = f_s \cdot T = 200\text{ samples}$
- Bin Spacing:$$\Delta f = \frac{f_s}{N} = \frac{200}{200} = 1\text{ Hz}$$
## Results
- Measured Peak 1: $f = 15\text{ Hz}$, Amplitude $= 0.8$
- Measured Peak 2: $f = 40\text{ Hz}$, Amplitude $= 0.4$
- Comparison: Measured values from the FFT spectrum match expected theoretical values perfectly.
# TASK 3 Investigate Spectral Leakage
## Parameters
- Student Number Last Digit ($d$): $5$
- Calculated Frequency ($f_2$):$$f_2 = 13.2 + 0.17 \cdot 5 = 14.05\text{ Hz}$$
## Predictions
For a $1\text{-second}$ recording, the frequency-bin spacing is $\Delta f = 1\text{ Hz}$. Since $f_2 = 14.05\text{ Hz}$ is not an integer, it does not land directly on a DFT grid bin, causing spectral leakage (energy spreading across surrounding frequency bins). Furthermore, the frequency difference between $f_1 = 15\text{ Hz}$ and $f_2 = 14.05\text{ Hz}$ is $\Delta f_{sig} = 0.95\text{ Hz}$, which is less than the bin spacing ($\Delta f = 1\text{ Hz}$). Consequently, the two peaks will merge into a single broad lump on a $1\text{-second}$ FFT plot.
## Results and Explanation
1. Second Spectrum ($\Delta f = 1\text{ Hz}$): Physical frequency resolution is insufficient ($1\text{ Hz}$). The energy of $14.05\text{ Hz}$ leaks into adjacent bins, and the $14.05\text{ Hz}$ and $15\text{ Hz}$ signals merge into one broad peak.
2. 4-Second Spectrum ($\Delta f = 0.25\text{ Hz}$): Increasing the observation time to $T = 4\text{ s}$ increases the total samples to $N = 800$, improving bin spacing to $\Delta f = 200 / 800 = 0.25\text{ Hz}$. With finer resolution, two distinct, sharp peaks appear at $14.05\text{ Hz}$ and $15\text{ Hz}$.
3. Zero-Padded Spectrum (fft(x, 4*N)): Zero-padding interpolates the DTFT spectrum by evaluating it at 4 times more points, making the plot smoother. However, it does not add new time-domain information or improve physical frequency resolution. The underlying $1\text{-second}$ recording still cannot resolve the two merged peaks.
# TASK 4 Compare the DTFT and DFT
## Predictions
The DTFT represents the continuous spectrum of a finite sequence, whereas the DFT samples the DTFT at discrete frequency points. fft(x, 64) will sample the continuous DTFT curve much more densely than fft(x, 4).
## Results
- Comparison of DTFT and DFT Values (Task 4): All discrete DFT samples calculated using fft(x, 4) and fft(x, 64) lie directly on the continuous magnitude curve of the DTFT.
- Why fft(x, 64) produces more points (Task 5): Calling fft(x, 64) appends 60 zeros to the original 4-sample sequence (zero-padding). This evaluates the DFT at 64 frequency bins instead of 4 ($\Delta \omega = 2\pi/64$). It does not add new non-zero samples or new physical information to the original signal; it only provides higher density spectral sampling (interpolation).
- Zeros of the DTFT Magnitude (Task 6): For $x = [1, 1, 1, 1]$, the magnitude spectrum is given by $\vert{}X(\omega)\vert{} = \vert{}\sin(2\omega)/\sin(\omega/2)\vert{}$. On the range $[-\pi, \pi]$, the magnitude becomes zero at:$$\omega = -\pi, \quad -\frac{\pi}{2} \,\, (-1.57\text{ rad/sample}), \quad \frac{\pi}{2} \,\, (1.57\text{ rad/sample}), \quad \pi$$The maximum peak magnitude is $\vert{}X(0)\vert{} = 4$ at $\omega = 0$.
## AI Tools Used
Gemini was used to clarify MATLAB syntax and polish technical explanations for this README.
