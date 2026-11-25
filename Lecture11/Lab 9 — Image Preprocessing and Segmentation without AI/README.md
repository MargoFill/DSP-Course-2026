# Tire Stud Detector

A MATLAB script that detects metal studs on tires using grayscale thresholding, morphological filtering, and connected-component analysis (`regionprops`).

## Files
- `tire_stud_detector.m` — main detection and classification script
- `studded_tire_cmprs.jpeg` — MATLAB 3-panel output figure for the studded tire (input image, binary candidate mask, and final detection)
- `summer_tire_cmprs.jpg` — MATLAB 3-panel output figure for the non-studded tire (input image, binary candidate mask, and final detection)

## How to Run
1. Place all files in the same MATLAB working directory.
2. Run `tire_stud_detector.m`.
3. Inspect the generated figures displaying the input image, binary candidate mask, detected studs, and classification result (`STUDDED TIRE` or `NON-STUDDED TIRE`).
