# 2D Convolution & FIR Filters (Blur, Sharpen, Edges)

---

## Delta Image & Impulse Response
Created a 2D discrete impulse $\delta[m,n]$ (a single `1` at the center of a $101 \times 101$ zero matrix) and convolved it with a $3 \times 3$ averaging filter. By definition, the output of an LTI system to a unit impulse equals its **impulse response** $h[m,n]$—directly visualizing the filter kernel weights (`1/9` across the $3 \times 3$ neighborhood).

### Impulse Response
<img width="620" height="546" alt="image" src="https://github.com/user-attachments/assets/a5547eae-1cb1-4bb6-8383-fc62c25e8058" />


---

## Low-Pass Filtering: Box vs. Gaussian & Separability
Compared linear smoothing filters of different sizes and shapes:
* **Box $3 \times 3$ and $7 \times 7$:** Equal-weight averaging blurs the image, but the larger $7 \times 7$ box introduces blocky, unnatural artifacts.
* **Gaussian ($\sigma = 1.2$, $7 \times 7$):** Constructed as an outer product of two 1D Gaussian vectors (`g1d' * g1d`). It achieves smooth, natural noise suppression while preserving edge structure much better than a box filter of the same size.

### Filters Comparison
<img width="680" height="156" alt="image" src="https://github.com/user-attachments/assets/b38ce579-3f5e-4e72-8e49-a8f13d688996" />



---

## Unsharp Masking (Sharpening)
Enhanced local contrast and fine details using high-frequency emphasis:
1. Subtracted the Gaussian-blurred image from the original (`mask = I - I_blur`) to isolate high-frequency edge details.
2. Added the scaled mask back to the original image (`I + gain * mask`, with `gain = 1.0`) and clipped values to `[0, 1]`.

### Unsharp Masking
<img width="680" height="156" alt="image" src="https://github.com/user-attachments/assets/fad5d104-9d21-4344-a1b0-296e3587c96e" />


---

## Edge Detection: Sobel & Laplacian
Extracted structural boundaries using first- and second-order spatial derivatives:
* **Sobel ($G_x$, $G_y$, and Gradient Magnitude):** First-order directional filters that highlight horizontal and vertical intensity transitions; `hypot(Gx, Gy)` combines both directions into an orientation-independent edge map.
* **Laplacian:** A second-order isotropic derivative filter that responds to rapid intensity changes in all directions simultaneously, highlighting fine zero-crossing edges.

### Edges
<img width="680" height="156" alt="image" src="https://github.com/user-attachments/assets/7b5f1916-df8f-4185-8131-2aa2ce6dc9c9" />


---

## Correlation vs. Convolution
Verified the equivalence between 2D convolution (`conv2`) and `imfilter` when the `'conv'` flag is enabled (which flips the kernel by $180^\circ$ before sliding it across the image). Because the $3 \times 3$ box kernel is symmetric, both operations yield identical results up to floating-point precision.

* **Console output:** `Max difference (conv2 vs imfilter with conv): 3.33067e-16`)*

---

## Boundary Handling
Tested how different padding strategies affect image borders using a $7 \times 7$ box filter:
* **`replicate`:** Repeats outermost border pixels outward, creating subtle streaking perpendicular to the edges.
* **`symmetric`:** Mirrors pixel values across the image boundary, maintaining smooth local continuity without artificial seams.
* **`circular`:** Wraps pixels around from the opposite edge of the image, causing noticeable color/brightness bleeding along borders when opposite sides differ in intensity.

### Boundary Handling
<img width="680" height="198" alt="image" src="https://github.com/user-attachments/assets/3fd45720-3254-4222-8561-1424a4335475" />


---

## Reflections

**1. Why is Gaussian preferred over large box LP?**  
In the spatial domain, a box filter has sharp discontinuities at its edges, which corresponds to a $\text{sinc}$ function in the frequency domain with prominent sidelobes (negative ripples). This causes **ringing artifacts** and uneven attenuation of high frequencies. In contrast, the Fourier transform of a Gaussian is another smooth Gaussian with **no sidelobes**, ensuring monotonic frequency attenuation, isotropic (rotationally symmetric) smoothing, and zero ringing.

**2. What does separability do for computational cost?**  
A 2D kernel of size $K \times K$ is separable if it can be expressed as the outer product of two 1D vectors ($h[m,n] = h_1[m] \cdot h_2[n]$). Applying a direct 2D convolution to an $M \times N$ image requires $K^2$ multiplications and additions per pixel ($O(M \cdot N \cdot K^2)$). Splitting this into two sequential 1D passes (horizontal $1 \times K$, then vertical $K \times 1$) reduces the cost to $2K$ operations per pixel ($O(M \cdot N \cdot 2K)$)—a speedup factor of $\frac{K}{2}$ (e.g., $3.5\times$ faster for a $7 \times 7$ kernel).

**3. How do boundary modes change corners/edges?**  
* **`replicate`** clamps out-of-bounds coordinates to the nearest edge pixel, which preserves overall border brightness but can smear edge features outward into flat bands.
* **`symmetric`** reflects interior pixels across the border, avoiding sharp intensity jumps and keeping edge gradients natural.
* **`circular`** treats the image as periodic (tiling it infinitely), which introduces visible wrap-around artifacts at edges and corners whenever the top/bottom or left/right borders have contrasting intensities.
