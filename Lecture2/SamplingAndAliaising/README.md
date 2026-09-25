# Lecture 02 – Sampling and Aliasing

 ## Objective

The objective is to investigate how different sampling frequencies affect signal representation and determine which sampling frequency would be appropriate for a practical engineering system.

 ## Nyquist Analysis

 $` fs=2fmax `$
 
 $` fN=fs/2 `$ 
 =>
 $` fs=10Hz*2=20Hz `$
 $` fN=20Hz/2 =10Hz `$

1) Which sampling frequencies satisfy the Nyquist criterion?
   The frequencies 20 Hz, 25 Hz, 50 Hz, and 100 Hz satisfy the criterion because they are strictly greater than or equal to 20 Hz. 15 Hz does not satisfy the criterion.
2) Is sampling exactly at the Nyquist rate recommended in practice? Explain your answer.
   No. In practice, sampling exactly at the Nyquist rate can result in capturing only the zero-crossings of the signal, which would output a flat line of zeros. Furthermore, real-world systems need a transition band for anti-aliasing filters to work properly, so oversampling (using a frequency much higher than the Nyquist rate) is standard engineering practice.

 ## Results

* **15 Hz:** The signal shape is completely lost. It looks like a sine wave of a much lower frequency (aliasing is present).
* **20 Hz:** Barely satisfies the Nyquist rate. The sampled points form a harsh triangular shape rather than a smooth wave.
* **25 Hz:** Slightly better, but still very distorted in the time domain.
* **50 Hz:** The original sine wave shape is clearly visible, though slightly jagged.
* **100 Hz:** Provides an excellent representation of the original continuous signal.

 ## Aliasing Discussion

Aliasing occurs at a sampling frequency of 15 Hz. This happens because the sampling rate is less than the Nyquist rate (20 Hz). The samples are taken so far apart that they fail to capture the peaks and valleys of the 10 Hz signal. When these discrete points are reconstructed, they mimic a completely different, lower-frequency signal.

 ## Engineering Recommendation

For a real engineering system, I would recommend a sampling frequency of 100 Hz. While 20 Hz is mathematically sufficient, 100 Hz provides a 10x oversampling rate, ensuring high accuracy and a smooth signal representation. It provides robustness against phase shifts and simplifies the design of anti-aliasing filters. Furthermore, 100 samples per second is an extremely low data rate for modern microcontrollers, meaning the processing requirements are negligible while the signal fidelity is improved.

 ## AI Usage

 - AI Tool Used -> Gemini

- Prompt -> "Explain aliasing specifically in the context of sampling a 10 Hz sine wave at 15 Hz."

- Summary of AI Response -> The AI explained that aliasing is a phenomenon where a high-frequency signal takes on a "false identity" of a lower-frequency signal due to a low sampling rate. It occurs when the sampling frequency falls below the Nyquist rate (20 Hz in this case). The AI specifically pointed out that sampling my 10 Hz signal at 15 Hz creates too large of a gap between samples. When these points are reconstructed, they fail to capture the true peaks and valleys, instead forming a false, lower-frequency sine wave (an alias of 5 Hz).

- What I Modified -> I used the AI's explanation to better understand the visual distortion I saw in my 15 Hz MATLAB plot, and I adapted the AI's real-world examples into my own words for the Task 4 Aliasing Discussion.
  
- How I Verified the Results -> I verified the AI's explanation by looking at my MATLAB plot for the 15 Hz sampling frequency. I could visually confirm that the sampled stems (markers) formed a sine wave that was much slower than the original 10 Hz continuous wave, exactly as the AI described.

