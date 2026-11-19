# Hybrid Computer Vision Pipeline: Traditional Segmentation + AI Classification

---

## Setup: Load Image and Pre-Trained AI Network
Loaded the sample RGB image `peppers.png` and initialized **SqueezeNet** (`squeezenet`), a lightweight pre-trained Convolutional Neural Network (CNN) trained on ImageNet for 1000-class object recognition.

---

## Traditional Method: Color Segmentation using K-Means
Used classical unsupervised clustering to isolate the foreground objects from the background before passing the image to the neural network:
1. Converted the image from RGB to the **CIE $L^*a^*b^*$ color space** (`rgb2lab`) and extracted only the chrominance channels (`a*` and `b*`), making segmentation invariant to lighting/brightness variations.
2. Applied **K-Means clustering** (`imsegkmeans(ab, 2)`) to group pixels into two dominant color clusters (foreground vs. background).
3. Generated a binary mask (`pixelLabels == 2`) and zeroed out background pixels (`0` / black) to suppress irrelevant background clutter.

---

## AI Method: Image Classification (SqueezeNet)
Prepared the segmented foreground image for deep learning inference:
* Resized `isolatedObject` to match SqueezeNet's required input tensor dimensions (`227 x 227 x 3`) via `imresize`.
* Ran forward inference using `classify(net, resizedObject)` to obtain the top predicted class label (`YPred`) and class probability distribution (`probs`).

### Hybrid Pipeline Images
<img width="671" height="491" alt="image" src="https://github.com/user-attachments/assets/42fd41b8-9a00-4e1c-b7ad-3ce6132289aa" />


---

## 4. Results Analysis

* **Console Output:**
  * **Predicted Class:** `sea slug` 
  * **Confidence (Probability):** `32.84%` 

### Analysis of Hybrid Pipeline Behavior
Interestingly, instead of improving classification accuracy, hard color segmentation caused SqueezeNet to misclassify the bell peppers as a **`sea slug`** with low confidence (`32.84%`). This highlights three important practical lessons when combining traditional pre-processing with pre-trained CNNs:

1. **Domain Shift from Artificial Black Backgrounds:** Pre-trained ImageNet models rely heavily on background context. In ImageNet, brightly colored objects floating against a pitch-black void strongly correlate with underwater macro photography of nudibranchs (`sea slug`), whereas `bell pepper` images typically appear on tables or in markets. Replacing the background with pure black (`0`) pushed the image outside the visual domain the CNN expects.
2. **Under-Segmentation with `K = 2`:** `peppers.png` contains multiple distinct hues (red, yellow, green peppers, and a dark purple background). Forcing K-Means to use only 2 clusters merges unrelated colors and cuts off parts of the vegetables, distorting their recognizable shapes.
3. **Hard Boundary Artifacts:** Zeroing out background pixels creates sharp, unnatural step edges around the mask silhouette that can trigger false high-frequency activations in early convolutional layers.

**Conclusion:** Traditional segmentation only improves AI classification when the isolated region preserves natural object boundaries and stays consistent with the training distribution of the neural network (for example, using a higher cluster count `K`, cropping a bounding box instead of blacking out pixels, or blurring the background rather than zeroing it out).
