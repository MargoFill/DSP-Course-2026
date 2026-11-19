# Image Processing Experiment — Option A: Compare Denoising Filters

**Selected Option:** Option A — Compare denoising filters  
**Supplied Image:** `rice.png` (MATLAB Image Processing Toolbox built-in sample image; not uploaded to the repository)  
**MATLAB Version:** R2026b 

---

## Repository Structure
* `analysis.mlx` — Executed MATLAB Live Script containing the code, quantitative PSNR/SSIM table, full and zoomed (`80x80`) visual comparisons, and written interpretation/limitations at the end.
* `analysis.pdf` — PDF export of the executed Live Script for viewing directly on GitHub without MATLAB.
* `results/` — Saved processed images:
  * `denoised_median_3x3.png` — Output of the $3 \times 3$ median filter.
  * `denoised_gaussian_sigma1_5.png` — Output of the Gaussian filter ($\sigma = 1.5$).
  * `denoised_median_then_gaussian.png` — Output of the cascaded $3 \times 3$ median + Gaussian ($\sigma = 1$) filter.
* `README.md` — Experiment documentation, parameters, quantitative summary, instructions, and AI usage note.

---

## Experimental Settings
* **Reference Image (`Iref`):** `rice.png` ($256 \times 256$ `uint8` grayscale).
* **Random Seed:** `rng(42)`
* **Degradation Model (`Id`):** Mixed additive white Gaussian noise (`mean = 0`, `variance = 0.01`) followed by salt-and-pepper impulse noise (`density = 0.02`):
  ```matlab
  Id = imnoise(imnoise(Iref, 'gaussian', 0, 0.01), 'salt & pepper', 0.02);

## Filters Evaluated:

- Median Filter: medfilt2(Id, [3 3])

- Gaussian Filter: imgaussfilt(Id, 1.5)

- Cascaded Filter: imgaussfilt(medfilt2(Id, [3 3]), 1)

## Visualizations: 
Full-image montage (1×5) and a zoomed 80×80 pixel crop (rows 80:159, cols 80:159, satisfying the ≥ 60×60 requirement).

## Quantitative Results (vs. Iref)
Method	PSNR (dB)	SSIM
| Method | PSNR (dB) | SSIM |
| :--- | :---: | :---: |
| Degraded (Gaussian + Salt & Pepper) | 18.0880 | 0.3696 |
| Median (3x3) | 25.3700 | 0.6232 |
| Gaussian (sigma = 1.5) | 25.7550 | 0.6921 |
| **Median (3x3) + Gaussian (sigma = 1)** | **26.3680** | **0.7051** |

## How to Run the Live Script
Open MATLAB with the Image Processing Toolbox installed.

Clone or download this repository and set it as your Current Folder in MATLAB.

Open analysis.mlx in the MATLAB Live Editor and click Run (or Run All).

The script reproduces the degraded image Id, displays the metrics table and both montage figures, and saves the three denoised PNG files (located in results/ in this repository).

## Main Conclusion & Limitation
### Main Conclusion: 
The cascaded filter (3×3 Median followed by Gaussian σ = 1) is the best choice for this mixed-noise degradation, achieving both the highest PSNR (26.3680 dB, an improvement of +8.28 dB over the degraded image) and the highest SSIM (0.7051). In the 80×80 zoomed region, the 3×3 median filter alone removes impulse spikes while keeping edges sharp, but leaves noticeable Gaussian graininess; the σ = 1.5 Gaussian filter alone smooths graininess, but blurs grain boundaries and smears salt-and-pepper impulses into blotches. Combining them allows the non-linear median stage to reject impulse outliers first, so the mild σ = 1 Gaussian pass can clean up residual Gaussian noise with minimal edge softening.

### Limitation: 
PSNR and SSIM are global full-reference metrics averaged equally across all 256×256 pixels (dominated by smooth dark background regions). Consequently, they do not directly measure localized boundary sharpness or downstream task accuracy (such as rice grain segmentation), and real-world noise parameters are rarely known in advance.

## Use of AI Assistance
AI assistance (Gemini) was used to help structure the MATLAB Live Script workflow and format the Markdown documentation. All code was executed, verified, and visually inspected independently by the author.
