# Frequency-Domain Filtering with `fft2`

---

## 1. Magnitude Spectrum (Log-Scale)
Computed the 2D Discrete Fourier Transform (`fft2`) of the grayscale image, centered the zero-frequency (DC) component using `fftshift`, and applied logarithmic compression (`log(1 + abs(Fshift))`). Because the DC component has a much larger magnitude than high-frequency details, log-scaling is necessary to make the full spectral energy distribution visible—showing strong energy concentration near the center and directional streaks corresponding to sharp edges in the image.

### Original Image
<img width="296" height="245" alt="image" src="https://github.com/user-attachments/assets/469c7e64-2aa8-4c34-b8d7-6c555756349f" />

### Magnitude Spectrum
<img width="356" height="245" alt="image" src="https://github.com/user-attachments/assets/8a8ba3b5-224f-4e72-a186-a9ea00a51719" />


---

## 2 & 3. Ideal vs. Gaussian Low-Pass Filtering
Constructed two circularly symmetric low-pass transfer functions $H(u,v)$ based on Euclidean distance $D(u,v) = \sqrt{u^2 + v^2}$ from the spectrum center, multiplied them element-wise with `Fshift`, and transformed back to the spatial domain via `ifft2`:
* **Ideal Low-Pass (`D0 = 40`):** Passes all frequencies inside radius $D_0$ (`1`) and abruptly zeros out everything outside (`0`). While it blurs fine details, it introduces prominent **ringing artifacts** (ripples) parallel to sharp edges.
* **Gaussian Low-Pass (`sigma = 20`):** Smoothly attenuates frequencies according to $H(u,v) = e^{-D^2 / (2\sigma^2)}$. It produces clean, natural smoothing with zero ringing.

### Ideal vs Gaussian Low-Pass Filtering
<img width="680" height="198" alt="image" src="https://github.com/user-attachments/assets/393b2584-046b-4df1-864e-2579a95bad26" />


---

## 4. High-Pass Filtering via Spectral Complement
Created a Gaussian high-pass filter directly as the complement of the low-pass mask (`H_gauss_HP = 1 - H_gauss_LP`). Attenuating the low-frequency components suppresses uniform regions and smooth shading, leaving only high-frequency edges, fine textures, and sharp intensity transitions.

### Gaussian High-Pass Filtering 
<img width="680" height="283" alt="image" src="https://github.com/user-attachments/assets/38c690a3-e790-4b63-b0d3-ee8be2a22e28" />

---

## 5. Spatial vs. Frequency-Domain Gaussian Low-Pass
Demonstrated the **2D Convolution Theorem**: convolution in the spatial domain ($I * h$) is equivalent to element-wise multiplication in the frequency domain ($F \cdot H$). Both `imfilter` with a spatial Gaussian kernel and `ifft2` with a frequency-domain Gaussian mask yield closely matching smoothed images (differing only in effective bandwidth/$\sigma$ scaling and boundary handling—`replicate` vs. implicit circular periodicity in FFT).

### Spatial vs frequency-domain Gaussian Low-Pass Comparison
<img width="680" height="283" alt="image" src="https://github.com/user-attachments/assets/f81cc314-098e-4b3b-8c44-ae8474f7d625" />


---

## 6. Reflections

**1. Why does ideal LP cause ringing (Gibbs phenomenon)?**  
An ideal circular low-pass filter has a sharp step discontinuity at cutoff radius $D_0$ in the frequency domain. By the inverse Fourier transform, a 2D disk function in frequency maps to an oscillating **Airy disk / $\text{sinc}$-like impulse response** ($J_1(r)/r$) in the spatial domain with alternating positive and negative sidelobes. Convolving sharp image edges with these oscillating spatial ripples produces visible concentric wave artifacts known as the **Gibbs phenomenon** (ringing).

**2. What does `fftshift` do visually?**  
By default, `fft2` places the zero-frequency (DC) component—representing the image's average brightness—at the top-left corner `(1,1)` and high frequencies in the middle. Visually, `fftshift` swaps the four quadrants of the spectrum so that the **DC component moves to the exact center** of the image, with spatial frequency increasing radially outward toward the borders. This symmetric layout makes inspecting frequency content and designing radial filters intuitive.

**3. When is frequency-domain filtering computationally preferable?**  
Direct spatial convolution with a $K \times K$ kernel on an $M \times N$ image requires $O(M \cdot N \cdot K^2)$ operations (or $O(M \cdot N \cdot 2K)$ if the kernel is separable), which grows rapidly with kernel size. In contrast, FFT-based filtering has a complexity of $O(M \cdot N \log(MN))$ **independent of kernel size**. Therefore, frequency-domain filtering becomes computationally faster and preferable when applying **large, non-separable kernels** (typically when $K > 15\text{–}30$, depending on image dimensions).
