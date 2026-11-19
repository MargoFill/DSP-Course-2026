
#Image as a 2D Signal

---

## Load and Inspect an Image
Loaded the test image `peppers.png` and converted it from RGB to a 2D grayscale luminance matrix using `rgb2gray`.

* **Console output:** `Class: uint8 | Range: [8, 255] | Size: 384 x 512`
### Original RGB
<img width="660" height="466" alt="image" src="https://github.com/user-attachments/assets/46cba609-1eaa-4637-b585-a655892ff44b" />

### Grayscale
<img width="661" height="460" alt="image" src="https://github.com/user-attachments/assets/5d8b3453-7d98-45ab-abc8-05a223a2ec79" />


---

## Quantization and Dynamic Range
Reduced the bit-depth of the grayscale image by flooring pixel intensities into discrete steps:
* **8-bit (`I8`):** 256 gray levels (smooth gradients).
* **~6-bit (`I6`, step 4):** 64 gray levels (slight tonal stepping appears).
* **~4-bit (`I4`, step 16):** 16 gray levels (strong false contouring / posterization).

### Quantization comparison
<img width="680" height="198" alt="image" src="https://github.com/user-attachments/assets/aa0f8449-cb31-4516-83c5-87deab66c460" />



---

## Histogram and Contrast Stretching
Applied linear intensity remapping using `imadjust(I, [0.2 0.8], [0 1])`. The original histogram is concentrated in the mid-tones; stretching expands the pixel values across the full `[0, 255]` dynamic range, producing a wider histogram and stronger local contrast (at the cost of clipping very dark and very bright pixels).

### Histogram
<img width="661" height="460" alt="image" src="https://github.com/user-attachments/assets/5d8b3453-7d98-45ab-abc8-05a223a2ec79" />
<img width="661" height="460" alt="image" src="https://github.com/user-attachments/assets/5d8b3453-7d98-45ab-abc8-05a223a2ec79" />
### Contrast Stretching
<img width="680" height="198" alt="image" src="https://github.com/user-attachments/assets/1818476f-b9b1-4f2f-be41-5672f2cbd5ee" />


---

## Gamma Correction (Nonlinear Amplitude Scaling)
Applied nonlinear power-law transformation ($s = c \cdot r^\gamma$):
* **$\gamma = 0.6$ (`gamma < 1`):** Expands dark gray levels and compresses bright ones, making shadow details more visible.
* **$\gamma = 1.6$ (`gamma > 1`):** Compresses dark gray levels and expands bright ones, darkening the overall image.

### Gamma Correction
<img width="680" height="198" alt="image" src="https://github.com/user-attachments/assets/27a1b2c2-3921-49d3-b468-2463845555d6" />




---

## Sampling and Aliasing
Downsampled the image to 10% of its original resolution using nearest-neighbor interpolation (`'nearest'`) without anti-aliasing filtering, then upscaled it back to the original dimensions. This creates severe pixelation (blocking artifacts), jagged edges, and loss of fine spatial details.
### Sampling and Aliasing
<img width="680" height="198" alt="image" src="https://github.com/user-attachments/assets/81f6d75b-2dbf-4921-9bb5-4db447df879f" />


---

## Reflections

**1. Relate bit-depth to visible banding/posterization you observed.**  
Bit-depth determines the number of discrete intensity levels available to represent brightness ($2^n$ levels for $n$ bits). While 8-bit images (256 levels) appear smooth to the human eye, reducing the depth to 4 bits (16 levels) creates large quantization steps. Smooth gradients break into distinct, abrupt bands of uniform color—an artifact known as **posterization** or **false contouring**.

**2. How does contrast stretching change the histogram and visibility of details?**  
Linear contrast stretching maps a narrow range of input intensities (`[0.2, 0.8]`) to the full output range (`[0, 1]`). On the histogram, the bars spread out across the entire horizontal axis with gaps between bins. Visually, mid-tone details become much sharper and easier to distinguish, though values outside the `[0.2, 0.8]` bounds get clipped to pure black (`0`) or pure white (`255`), losing detail in extreme shadows and highlights.

**3. Explain why aggressive downsampling causes aliasing (reference Nyquist).**  
According to the **Nyquist–Shannon sampling theorem**, the sampling rate must be at least twice the highest spatial frequency present in the image ($f_s > 2f_{\max}$) to reconstruct the signal accurately. Aggressive downsampling (to 10%) drastically lowers the spatial sampling rate without applying a low-pass anti-aliasing filter first. High-frequency details (sharp edges, fine textures) exceed the new Nyquist limit and fold back into lower frequencies, causing **aliasing** (jagged stair-step edges, distortion, and moiré patterns).
