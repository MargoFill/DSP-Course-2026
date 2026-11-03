# Practical Digital Filtering Assignment
## Part A: Sensor Filtering Analysis
### Spectra Observations:
Near 5 Hz and 12 Hz (the passband), both filters preserve the amplitude of the signal effectively with minimal distortion. At 50 Hz and 137 Hz (the stopband), the initial noisy signal shows large amplitude spikes. Both the FIR and IIR filters heavily attenuate these spikes; however, looking at the magnitude response, the IIR 4th-order Butterworth reaches a deeper stopband attenuation at 50 Hz than the 60th-order FIR, though both suppress the interference below the broadband noise floor.

### RMSE Interpretation:
The RMSE for the noisy input is large due to the high-amplitude interference. The RMSE for the FIR and IIR outputs drops significantly, indicating a much closer match to the clean reference.What RMSE tells you: It provides a single quantitative metric for the average time-domain error power between the filtered signal and the absolute truth.What RMSE cannot tell you: It does not distinguish between error caused by residual high-frequency noise and error caused by altering the target signal (e.g., slight amplitude loss at 12 Hz). It also ignores the spectral distribution of the error.

### FIR vs. IIR Comparison:

**Coefficients/Order:** The FIR filter requires 61 taps (order 60), meaning 61 multiplications per sample. The IIR filter is order 4, requiring only 5 feedforward and 5 feedback coefficients, making it vastly more computationally efficient.

**Transition & Attenuation:** The IIR Butterworth filter rolls off smoothly but achieves excellent attenuation at 50 Hz. The FIR filter has a slightly steeper initial transition but exhibits passband/stopband ripples (Gibbs phenomenon) inherent to windowed FIR design.

**Edge Effects:** Because filtfilt performs forward and backward zero-phase filtering, it artificially extends the signal at the boundaries to minimize startup transients. However, FIR filters generally exhibit longer startup transients than low-order IIR filters due to their longer memory (61 samples vs 4 samples).

**Preference:** I would prefer the IIR filter for embedded offline data processing where memory/computation limits exist. I would prefer the FIR filter in a strictly real-time streaming application where strict linear phase is required to prevent pulse-shape distortion (using standard filter, not filtfilt).

## Part B: Audio Hum Reduction Analysis
### Listening and Waveform Comparison:
The 50 Hz hum is highly audible as a low, continuous bass drone in the audio file. After applying the narrow band-stop filter, the drone is eliminated. Listening critically, the primary vocal/instrumental components of Handel's Hallelujah chorus remain mostly unchanged, though some extreme low-end warmth might feel subtly hollowed out.

### Band-stop Width Trade-off (Narrow vs Wider):
Changing the stop band to 45–55 Hz creates a wider "notch".

Why wider removes more variation: If the hum frequency drifts (e.g., generator fluctuations oscillating between 49.5 Hz and 50.5 Hz), a narrow filter will "miss" the hum, allowing it to leak into the audio. A wider filter catches these fluctuations.

Why it removes useful sound: The wider the notch, the more adjacent musical frequencies (such as bass notes around 45–55 Hz) are deleted. This degrades the fidelity of the actual recording.

## Report Questions
1. Why is a 20 Hz low-pass reasonable for Part A, and what assumption does it make about the wanted sensor signal?
A 20 Hz low-pass cutoff sits comfortably above the highest frequency of interest (12 Hz) and well below the lowest interference frequency (50 Hz). This assumes that the physical phenomenon being measured by the sensor generates no useful data above 20 Hz, and that any energy above that threshold is purely noise or interference.

2. Which filter gives the better result for the requirements you chose? Support the answer with at least two kinds of evidence.
The 4th-order IIR Butterworth filter gives the better result for this specific offline application.

**Evidence 1 (Quantitative):** It requires only 9 math operations per sample compared to the FIR's 61, while achieving a nearly identical RMSE against the clean signal.

**Evidence 2 (Frequency Response):** The freqz plot shows that the IIR filter provides deeper attenuation exactly at the primary 50 Hz interference peak than the 60th-order FIR design, suppressing the hum more aggressively.

3. How would your implementation change if the sensor had to be filtered live with low latency?
If filtered live, filtfilt cannot be used because it requires the entire future signal to filter in reverse (making it non-causal). I would have to use the standard filter(b, a, x) command. This would introduce phase delay. To preserve the time-domain waveform shape (avoiding phase distortion), I would switch to the FIR filter because it possesses strictly linear phase, ensuring all frequency components are delayed by the exact same amount of time, whereas an IIR filter would delay the 12 Hz component differently than the 5 Hz component.

4. Why is a narrow band-stop appropriate for a steady 50 Hz hum? What would you do if the interference frequency drifted?
A narrow band-stop is appropriate because mains power (the typical source of 50 Hz hum) is tightly regulated by national grids and is highly stable. Therefore, you only need to remove a tiny slice of the spectrum, preserving the rest of the audio. If the frequency drifted (e.g., running off a portable generator), I would use an adaptive filter (such as a Least Mean Squares (LMS) adaptive notch filter) that dynamically tracks the interference frequency and adjusts its center frequency in real time without widening the notch.

5. Describe one limitation of your experiments and one improvement you would make in a real measurement system.

**Limitation:** The experiment uses synthetically added, perfectly stationary sine waves for interference. Real-world 50 Hz mains hum is rarely a pure sine wave; it contains harmonics (100 Hz, 150 Hz, etc.) and its amplitude fluctuates.

**Improvement:** In a real measurement system, I would apply an analog anti-aliasing low-pass filter to the sensor before the ADC (Analog-to-Digital Converter) to ensure high-frequency interference (like radio frequencies) doesn't fold back into the 0–20 Hz band during digitization, which digital filtering cannot fix after the fact.

## AI assistance 
AI was used to provide minor assistance with MATLAB syntax and formatting, and to proofread and polish the grammar and clarity of the written report. The filter designs, parameter selections, and technical explanations represent my own understanding and work.
