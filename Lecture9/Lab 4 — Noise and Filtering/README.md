# Noise and Filtering
---

## Add Different Noise Types
Loaded `peppers.png` as a normalized grayscale image (`[0, 1]`) and simulated two common degradation models using `imnoise`:
* **Gaussian Noise (`mean = 0, var = 0.01`):** Additive white Gaussian noise (AWGN) affecting every pixel with small random intensity fluctuations (modeling thermal/sensor noise).
* **Salt & Pepper Noise (`density = 0.05`):** Impulse noise that randomly corrupts 5% of pixels into pure black (`0`) or pure white (`1`) extremes (modeling bit errors or faulty sensor pixels).

### Noisy Images Comparison
<img width="680" height="198" alt="image" src="https://github.com/user-attachments/assets/29c4a0c8-b7a7-4683-be9f-c02d95b25d1a" />

---

## Compute Simple Quality Metrics
Quantified baseline image degradation relative to the clean reference image using Mean-Square Error (`immse`), where $\text{MSE} = \frac{1}{MN}\sum (I_{\text{noisy}} - I)^2$ (lower MSE corresponds to higher Signal-to-Noise Ratio, $\text{SNR} = 10\log_{10}(P_{\text{signal}} / \text{MSE})$):

* **Console output:** `MSE Gaussian: 0.0096 | MSE S&P: 0.0158`*

---

## Linear vs. Non-Linear Filtering
Applied spatial $3 \times 3$ filters to both noisy images and compared their restoration quality:
* **Linear Filters (`average` $3\times 3$ and `gaussian` $3\times 3, \sigma=0.7$):** Smooth out additive Gaussian noise reasonably well by averaging local fluctuations, but fail on salt-and-pepper noise—smearing extreme black/white impulses into gray blotches while blurring edges.
* **Non-Linear Filter (`medfilt2` $3\times 3$):** Replaces each pixel with the median of its $3 \times 3$ neighborhood. It completely eliminates isolated salt-and-pepper impulses while keeping object edges sharp, though it is slightly less effective than linear averaging at smoothing continuous Gaussian noise.

### Linear vs Non-Linear Filtering
<img width="683" height="536" alt="image" src="https://github.com/user-attachments/assets/7500ec1c-d120-47df-8e9f-e15565511d17" />


---

## Compare Metrics After Filtering
Evaluated the MSE improvement on the salt-and-pepper degraded image after linear averaging vs. non-linear median filtering:

* **Console output:** `After filtering, MSE S&P avg=0.0021, med=0.0001`*

Median filtering achieves a substantially lower MSE than mean filtering because it rejects impulse outliers outright rather than diffusing their energy into neighboring pixels.

---

## Reflections

**1. Which noise is best removed by median filter? Why?**  
The median filter is best at removing **salt-and-pepper (impulse) noise**. Because corrupted pixels take extreme values (`0` or `1`), sorting the 9 pixel intensities inside a $3 \times 3$ window pushes all impulse outliers to the very beginning or end of the sorted list. Selecting the middle (5th) value completely discards isolated outliers and replaces them with an uncorrupted neighboring intensity, whereas linear filters include those extreme values in the average.

**2. Why does linear filtering blur edges more?**  
Linear filters compute a weighted sum across all pixels inside the kernel window regardless of image structure. When the window straddles a sharp edge, bright pixels on one side and dark pixels on the other are averaged together, turning an abrupt step transition into a gradual intensity ramp (attenuating high spatial frequencies). In contrast, a median filter preserves monotonic step transitions without creating intermediate gray values.

**3. How could we design adaptive filters to preserve detail?**  
An adaptive filter adjusts its smoothing strength based on **local image statistics** (such as local variance $\sigma_L^2$ or gradient magnitude) measured inside each sliding window:
* **In flat, homogeneous regions** where local variance matches the estimated noise variance ($\sigma_L^2 \approx \sigma_{\text{noise}}^2$), the filter applies full smoothing to suppress noise.
* **Near sharp edges or fine textures** where $\sigma_L^2 \gg \sigma_{\text{noise}}^2$, the filter reduces smoothing weights (e.g., **Wiener filter**), weights neighbors by intensity similarity as well as spatial distance (**Bilateral filter**), or dynamically expands/shrinks the window only when needed (**Adaptive Median Filter**).****
