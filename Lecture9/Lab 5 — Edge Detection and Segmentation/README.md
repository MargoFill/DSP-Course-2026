# Edge Detection and Segmentation

---

## Basic Derivative Filters (Sobel & Prewitt)
Detected edges using first-order spatial gradient approximations (`edge(I, 'Sobel')` and `edge(I, 'Prewitt')`). Edges correspond to rapid intensity transitions (high-frequency spatial components). Both operators highlight major object boundaries, though Sobel gives slightly higher weight to center pixels, offering marginally better noise suppression than Prewitt.

### Sobel and Prewitt Edges
<img width="676" height="283" alt="image" src="https://github.com/user-attachments/assets/66e347fd-6d93-4e34-9178-42001fa60431" />


---

## Canny Edge Detector (Multi-Stage)
Applied the multi-stage Canny algorithm with hysteresis thresholds `[0.05 0.2]`. Compared to simple gradient filters, Canny produces thin, continuous 1-pixel-wide contours while suppressing false noise responses and keeping weak edges that are connected to strong edges.

### Canny Edges
<img width="678" height="535" alt="image" src="https://github.com/user-attachments/assets/334c9136-9c94-4654-8383-ee52bf541b63" />


---

## Laplacian of Gaussian (LoG)
Detected edges using a second-order isotropic derivative operator (`edge(I, 'log')`). The image is first smoothed with a Gaussian filter to reduce noise sensitivity, and edges are then located at the **zero-crossings** of the Laplacian, often forming closed contour loops around regions.

### Laplacian of Gaussian Edges
<img width="678" height="535" alt="image" src="https://github.com/user-attachments/assets/ff8b6445-ec2b-421c-bb43-2a6028014074" />


---

## 4. Automatic Thresholding (Otsu's Method)
Segmented the grayscale image into a binary foreground/background mask using Otsu's global thresholding (`graythresh` + `imbinarize`). Otsu automatically selects the optimal intensity threshold separating bright objects from darker background areas without manual tuning.

### Otsu Thresholding
<img width="679" height="283" alt="image" src="https://github.com/user-attachments/assets/d04950f0-7703-427b-a48f-5c0c50295635" />


---

## 5. Region Labeling and Visualization
Grouped connected white pixels in the binary mask into distinct objects using 8-connected component labeling (`bwlabel`) and mapped each region ID to a distinct color (`label2rgb`).

* **Detected regions:** `Labeled regions: 89` *

### Labled Regions
<img width="680" height="536" alt="image" src="https://github.com/user-attachments/assets/1b48b882-09bc-4587-a616-8313598bf556" />


---

## 6. Reflections

**1. Which operator gives the thinnest, cleanest edges?**  
The **Canny detector** produces the thinnest and cleanest edges. Its non-maximum suppression step thins thick gradient ridges down to single-pixel-wide lines, while hysteresis thresholding prevents broken contours and filters out isolated noise spikes.

**2. Why does Canny outperform simple gradient filters?**  
Simple gradient filters (Sobel, Prewitt) only compute local first-order derivatives and apply a single hard threshold, which leaves edges thick, noisy, and fragmented. Canny combines four stages:
1. **Gaussian smoothing** to suppress high-frequency noise before differentiation.
2. **Gradient magnitude and direction** calculation.
3. **Non-maximum suppression** to keep only local gradient peaks along the edge normal.
4. **Double-threshold hysteresis** (`low` and `high`), which links weak edge pixels to strong ones so real contours remain unbroken.

**3. How does Otsu relate to histogram-based thresholding?**  
Otsu's method assumes the image's intensity histogram is bimodal (composed of foreground and background pixel distributions). It exhaustively evaluates every possible threshold $T$ on the normalized histogram and selects the value that **minimizes intra-class variance** (weighted variance within foreground and background) — which is mathematically equivalent to **maximizing inter-class variance** (separation between the two histogram peaks).
