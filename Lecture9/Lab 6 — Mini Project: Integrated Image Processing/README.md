# Lab 6: Mini Project – Custom Image Processing Pipeline

---

## Problem Definition & Objective
Real-world photographs (`my_image.jpeg` —  outdoor landscape) often suffer from sensor noise, flat mid-tone contrast, and soft object boundaries. 

The goal of this mini-project is to build an end-to-end 2D Digital Signal Processing (DSP) pipeline that suppresses noise, restores dynamic range, extracts clean structural contours, and isolates low-frequency spatial energy.

---

## Pipeline Stages & Experimental Results

### 1. Pre-Processing & Grayscale Conversion
Loaded `my_image.jpeg`, converted it from RGB to a single-channel luminance image (`rgb2gray`), and cast pixel intensities to normalized double-precision values in `[0, 1]` (`im2double`) for accurate numerical processing.
#### Input image
<img width="1400" height="933" alt="image" src="https://github.com/user-attachments/assets/d82ab4e3-8c9f-4ac0-ba84-9d39e3a4cb30" />


### 2. Noise Removal (Spatial Non-Linear Filtering)
Applied a $3 \times 3$ 2D median filter (`medfilt2(I, [3 3])`). Unlike linear averaging filters, median filtering removes impulse ("salt-and-pepper") noise and fine grain without blurring sharp edges.

### 3. Contrast Enhancement & Method Comparison
Applied linear contrast stretching (`imadjust(I_filt, [0.2 0.8], [0 1])`) to expand mid-tone intensities across the full `[0, 1]` dynamic range for downstream feature extraction. 

Additionally, three contrast enhancement techniques were benchmarked side-by-side:
* **`imadjust`:** Linearly stretches intensity bounds; preserves natural tonal relationships.
* **`histeq`:** Global histogram equalization; maximizes global contrast by flattening the histogram, though it can over-amplify background noise.
* **`adapthisteq` (CLAHE):** Contrast-Limited Adaptive Histogram Equalization; enhances local details in small tiles while preventing noise over-amplification.

#### Contrast Enhancment Comparison
<img width="667" height="482" alt="image" src="https://github.com/user-attachments/assets/8679036f-506c-448a-84ec-867e0c737ae6" />


### 4. Feature Extraction (Canny Edge Detection)
Extracted object boundaries from the enhanced image using the Canny edge detector (`edge(I_enh, 'Canny', [0.1 0.25])`). Hysteresis thresholding (`low = 0.1`, `high = 0.25`) suppresses weak noise-induced gradients while preserving continuous structural contours.

### 5. Frequency-Domain Filtering (2D FFT & Ideal Low-Pass Mask)
Transformed `I_enh` into the 2D spatial frequency domain (`fft2` + `fftshift`) and applied an ideal circular low-pass mask $H(u,v)$ with cutoff radius $D_0 = 60$ pixels ($\sqrt{u^2 + v^2} < 60$). Transforming back via inverse FFT (`ifft2`) retains smooth global illumination and coarse shapes while stripping fine textures and high-frequency edges.

### 6. End-to-End Pipeline Visualization
Comparison of the input image across all pipeline stages:

<img width="680" height="119" alt="image" src="https://github.com/user-attachments/assets/a2fb2bc1-7ddb-4ee8-99bc-719be5da3f81" />


---

## 7. Project Report

### Pipeline Architecture
First, spatial denoising prepares the signal so subsequent contrast stretching does not amplify noise. Next, contrast enhancement boosts local gradients before branching into two analytical outputs: binary structural edges (spatial domain) and low-frequency structural approximation (frequency domain).

### How Each Stage Relates to DSP Operations
* **Median Filtering (`medfilt2`):** A non-linear rank-order sliding-window operator. It acts as a robust outlier-rejection filter that preserves step edges (high-frequency signal transitions) far better than linear FIR low-pass kernels.
* **Contrast Enhancement (`imadjust`, `histeq`, `adapthisteq`):** Point-wise non-linear/piecewise-linear amplitude transformations $s = T(r)$ that redistribute the image's probability density function (histogram) to utilize the full quantization range.
* **Canny Edge Detection:** Combines linear Gaussian smoothing (band-limiting), 2D spatial gradient estimation ($\nabla I = [G_x, G_y]$), non-maximum suppression (local peak thinning), and dual-threshold hysteresis to isolate high-frequency spatial discontinuities.
* **2D FFT & Low-Pass Masking:** Decomposes the 2D spatial signal into complex exponentials $F(u,v)$. Multiplying by $H(u,v)$ in the frequency domain is equivalent to circular 2D convolution in the spatial domain ($I_{\text{enh}} * h_{\text{lp}}$), attenuating high spatial frequencies above the cutoff radius $D_0 = 60$.

### Limitations & Potential Improvements
1. **Ringing Artifacts in Frequency Filtering:** The ideal circular mask (`sqrt(u.^2 + v.^2) < 60`) has a sharp cutoff in the frequency domain, whose inverse Fourier transform is a $\text{sinc}$-like function. This introduces **Gibbs ringing artifacts** near strong edges. *Improvement:* Replace the ideal mask with a smooth **Gaussian** or **Butterworth** low-pass filter.
2. **Highlight/Shadow Clipping:** Hard-coded `imadjust` limits (`[0.2 0.8]`) clip pixel values below `0.2` to pure black and above `0.8` to pure white, losing detail in extreme shadows or highlights. *Improvement:* Feed the `adapthisteq` (CLAHE) output directly into the edge detector for adaptive, locally balanced contrast.
3. **Periodic Boundary Wrap-Around:** Direct `fft2` assumes the image is periodic, which can cause edge leakage when opposite borders differ in brightness. *Improvement:* Apply zero-padding or a 2D Hann/Hamming window prior to computing the FFT.
