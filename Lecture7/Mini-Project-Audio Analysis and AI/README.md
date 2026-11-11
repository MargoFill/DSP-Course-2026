# Audio Signal Processing — Mini Project

## Selected Option
**Option B — Compare Noise Reduction Settings**

## Overview & Audio Files Used
- **Input Audio:** Synthetic mixture (`noisy.wav`) consisting of clean speech (`05_speech.wav`), additive white noise (5 dB nominal SNR), and a 50 Hz power-line hum.
- **Reference Audio:** Clean speech (`clean_reference.wav`).
- **Processed Audio Files:**
  - `results/gated_05.wav` (Spectral gating with `prop_decrease=0.5`)
  - `results/gated_10.wav` (Spectral gating with `prop_decrease=1.0`)

## Settings & Parameters
- **Algorithm:** Spectral Gating (`noisereduce.reduce_noise`)
- **Sampling Rate:** 16,000 Hz
- **Noise Estimation:** Stationary lead-in noise profile (`y_noise = noisy[:FS//2]`, 0.5 seconds)
- **Comparison Parameter:** `prop_decrease=0.5` vs `prop_decrease=1.0`

## How to Run the Notebook
1. Open `analysis.ipynb` in Google Colab or a local Jupyter Environment (Python 3.10–3.12).
2. Upload `Audio_Course_Package.zip` when prompted by the setup cell.
3. Execute cells sequentially from top to bottom.

## Main Conclusion
`prop_decrease=0.5` is the preferred setting for this example. 
While aggressive suppression (`prop_decrease=1.0`) removes slightly more background hum, it severely distorts the speech signal by weakening high-frequency consonants and introducing artificial metallic "musical noise". The moderate setting (`0.5`) retains a subtle background noise floor but maintains high speech naturalness and intelligibility.

## Limitation of Analysis
The spectral gating approach relies strictly on the assumption of **stationary noise** estimated during the initial 0.5-second lead-in silence. It fails to eliminate non-stationary, transient, or dynamic acoustic interference (such as background chatter, impulse clicks, or varying traffic noise).

## AI Assistance Disclosure
AI (Gemini / ChatGPT) was used as a supportive tool to assist in debugging environment errors and help format this `README.md` documentation.
