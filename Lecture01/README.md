# MATLAB Signal Processing Assignment

## Objective
This repository contains my MATLAB code and exported figures for the signal processing assignment. The goal of this project is to learn how to create, visualize, and interpret simple signals (sine waves) in the time domain, understand concepts like amplitude, frequency, and noise, and practice using AI responsibly as an engineering tool.

---



## Task 2: Compare Different Frequencies
Three sine waves with frequencies of 2 Hz, 5 Hz, and 10 Hz were generated and plotted using subplots.

**Questions:**
*   **Which signal changes fastest?** 
    The 10 Hz signal changes the fastest.
*   **Which signal has the lowest frequency?** 
    The 2 Hz signal has the lowest frequency.
*   **How can you see the difference in the plots?** 
    The difference is visible by looking at the number of cycles (or peaks) within the 1-second timeframe. The 10 Hz plot has 10 complete cycles tightly packed together, while the 2 Hz plot only has 2 wider cycles.

---

## Task 3: Compare Different Amplitudes
Three sine waves with varying amplitudes (0.5, 1, and 2) but the same frequency (5 Hz) were generated and plotted using subplots.

**Questions:**
*   **Which signal has the largest amplitude?** 
    The signal with an amplitude of 2.
*   **Does changing amplitude change frequency?** 
    No, the frequency remains exactly the same. The peaks occur at the same points in time; only the vertical height (intensity) of the wave changes.
*   **Give one real-world example where amplitude is important.** 
    Audio volume is a great example. In sound waves, a higher amplitude means a louder sound, while a lower amplitude means a quieter sound.

---

## Task 4: Add Noise
A clean 5 Hz sine wave was generated, and random noise was added to it to simulate a real-world imperfect signal.

**Questions:**
*   **What changed after adding noise?** 
    The smooth, continuous line of the sine wave became jagged and erratic. Random vertical variations were added at every time step.
*   **Can you still recognize the original signal?** 
    Yes, despite the jaggedness, the underlying periodic shape (the peaks and valleys of the 5 Hz wave) is still clearly visible.
*   **Give one real-world source of signal noise.** 
    Electromagnetic interference (EMI) from nearby electronic devices or power lines, which can distort radio, Wi-Fi, or audio signals.

---


## Task 6: Use AI Responsibly

*   **AI Tool Used:** Google Gemini
*   **Prompt:** "How do I add random noise to a sine wave in MATLAB so that it looks like real-world interference but I can still see the sine wave?"
*   **What AI Suggested:** It suggested using the `randn` function to generate normally distributed random numbers matching the size of the time vector, and adding it to the signal: `noisy_signal = clean_signal + randn(size(t)) * noise_factor;`.
*   **Did the code work immediately?** Yes, the syntax was perfectly correct for MATLAB.
*   **What did you modify?** I adjusted the `noise_factor` multiplier to `0.3`. When I first used a factor of `1`, the noise was too strong and completely hid the original 5 Hz signal.
*   **How did you verify the result?** I plotted the clean signal and the noisy signal on separate subplots (as required in Task 4) and visually verified that the noisy signal was jagged but still followed the general path of the clean sine wave.
