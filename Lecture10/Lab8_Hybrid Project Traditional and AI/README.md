# Hybrid Computer Vision Pipeline: Traditional Segmentation + AI Classification

---

## 1. Setup: Load Image and Pre-Trained AI Network
Loaded the sample RGB image `peppers.png` and initialized **SqueezeNet** (`squeezenet`), a lightweight pre-trained Convolutional Neural Network (CNN) trained on ImageNet for 1000-class object recognition.

---

## 2. Traditional Method: Color Segmentation using K-Means
Used classical unsupervised clustering to isolate the foreground objects from the background before passing the image to the neural network:
1. Converted the image from RGB to the **CIE $L^*a^*b^*$ color space** (`rgb2lab`) and extracted only the chrominance channels (`a*` and `b*`), making segmentation invariant to lighting/brightness variations.
2. Applied **K-Means clustering** (`imsegkmeans(ab, 2)`) to group pixels into two dominant color clusters (foreground vs. background).
3. Generated a binary mask (`pixelLabels == 2`) and zeroed out background pixels (`0` / black) to suppress irrelevant background clutter.

---

## 3. AI Method: Image Classification (SqueezeNet)
Prepared the segmented foreground image for deep learning inference:
* Resized `isolatedObject` to match SqueezeNet's required input tensor dimensions (`227 x 227 x 3`) via `imresize`.
* Ran forward inference using `classify(net, resizedObject)` to obtain the top predicted class label (`YPred`) and class probability distribution (`probs`).

![Hybrid Pipeline Images](screenshots/hybrid_pipeline.png)

---

## 4. Results Analysis

* **Console Output:**
  * **Predicted Class:** `bell pepper` *(замените на класс, который выведет ваша консоль)*
  * **Confidence (Probability):** `84.52%` *(замените на ваш процент из консоли)*

### Why Combining Traditional + AI Methods Helps
* **Reduced Background Distraction:** Pre-trained CNNs evaluate the entire frame; complex backgrounds can activate unrelated feature maps and lower prediction confidence. K-Means color segmentation acts as an attention mechanism that removes background noise before classification.
* **Complementary Strengths:** Traditional color-space clustering is fast, interpretable, and requires zero training data to separate distinct color regions, while the pre-trained CNN provides high-level semantic recognition without needing manual feature engineering.
* **Observed Limitations:** Because `imsegkmeans` initializes cluster centroids randomly, cluster indices (`1` vs. `2`) can swap between runs. Additionally, setting background pixels to hard black (`0`) introduces sharp artificial edges around the mask boundary, which can occasionally bias CNN feature extraction if the segmentation mask is fragmented.
