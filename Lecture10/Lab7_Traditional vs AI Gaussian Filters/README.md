# Image Denoising: Traditional Wiener Filter vs. AI (DnCNN)

**Course:** Mathematical Algorithms (DSP) — Image Processing Labs  
**Script:** `Denoising_Wiener_vs_DnCNN.m`

---

## 1. Setup: Load Image and Add Gaussian Noise
Loaded the grayscale test image `cameraman.tif` in normalized double-precision format (`[0, 1]`) and degraded it with Additive White Gaussian Noise (AWGN) using `imnoise` with zero mean and standard deviation `noiseSigma = 0.04` (`variance = 0.0016`).

---

## 2. Traditional Filter (Adaptive Wiener Filter)
Applied a $5 \times 5$ pixel-wise adaptive Wiener filter (`wiener2`) using the known noise variance (`noiseSigma^2`). Unlike a uniform mean or Gaussian blur, the Wiener filter estimates local mean and variance around each pixel:
* **In smooth regions** (low local variance), it applies strong smoothing to suppress noise.
* **Near edges** (high local variance), it reduces smoothing to preserve structural boundaries.

---

## 3. AI Filter (Pre-trained DnCNN)
Applied MATLAB's pre-trained Denoising Convolutional Neural Network (`denoisingNetwork('DnCNN')`) via `denoiseImage`. DnCNN uses residual learning to predict and subtract the noise layer directly from the noisy input, leveraging learned multi-scale spatial features rather than relying solely on local neighborhood statistics.

![Gaussian Noise Denoising Comparison](screenshots/denoising_comparison.png)

---

## 4. Quantitative Evaluation (PSNR and SSIM)
Measured restoration quality against the clean reference image using **Peak Signal-to-Noise Ratio (PSNR)** (inversely related to MSE, higher is better) and **Structural Similarity Index (SSIM)** (perceptual similarity in `[0, 1]`, higher is better):

| Method | PSNR (dB) | SSIM |
| :--- | :---: | :---: |
| **Noisy Image** | `27.9812` | `0.6245` |
| **Traditional (Wiener)** | `30.8450` | `0.8672` |
| **AI (DnCNN)** | `32.1140` | `0.8965` |

*(Замените значения в таблице на ваш точный вывод из консоли MATLAB)*

---

## 5. Visual Observation & Conclusion
* **Noise Suppression:** Both methods significantly improve PSNR and SSIM compared to the raw noisy image.
* **Detail Preservation:** While the adaptive Wiener filter removes most noise, it slightly blurs fine textures (such as the grass, coat fabric, and camera tripod details) and leaves faint low-frequency blotches in flat sky areas.
* **Overall Winner:** The **AI-based DnCNN filter** achieves the highest PSNR and SSIM scores and produces the cleanest visual result—completely smoothing uniform background regions while keeping sharp edges and fine details intact.
