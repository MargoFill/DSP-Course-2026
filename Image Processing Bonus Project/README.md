# Engineering Memo — Studded Tire Detection & Degradation Pipeline
## Recommended System and Baseline Performance

For classifying tire images under real-world and degraded conditions, we recommend YOLO11n-cls paired with adaptive classical preprocessing (restore_lowlight followed by clahe_bgr) when lighting or motion blur degrades input quality. On clean images (original), the baseline achieves accuracy = 0.905, precision = 0.841, recall = 1.000, and F1 = 0.914. Under moderate motion blur (blur_L15), performance drops to accuracy = 0.703, precision = 0.826, recall = 0.514, and F1 = 0.633. Under combined degradations (combined), performance drops further to accuracy = 0.662, precision = 0.700, recall = 0.568, and F1 = 0.627. Because YOLO11n-cls retains higher representational capacity on complex tread patterns than Classical (HOG+SVM) while running in ~18.38 ms per image, it provides the strongest accuracy-latency trade-off once degraded frames are conditioned.

## Error Trade-Off and Threshold Selection

In automated enforcement, false positives (FPs) are worse than false negatives (FNs): a false positive issues an erroneous fine to an innocent driver, creating legal, trust, and appeal overhead, whereas a false negative misses a studded tire violation. We select the classification decision threshold on the validation set (val) to prioritize precision—keeping false alarms low even if recall is slightly more conservative—and evaluate that fixed threshold only once on the held-out test set (test) to avoid threshold leakage or overfitting. Where confidence falls near the boundary in severe degradation, flagging frames for manual review or non-automated handling is safer than issuing automatic fines.

## Reliability Limits (Blur Length and Light Level)

Reliability degrades sharply once motion blur reaches roughly L = 15 pixels (recall falls from 1.000 to 0.514, F1 drops to 0.633) and becomes unreliable for autonomous fine issuance in combined low-light, noise, and blur conditions (F1 = 0.627, precision = 0.700). Low light suppresses stud contrast and raises sensor noise, while motion blur smears small metallic studs into surrounding tread grooves. Aggressive deconvolution under heavy noise amplifies grain and ringing artifacts, so preprocessing must stay conservative rather than over-sharpening noisy dark frames.

## Edge Feasibility

Measured inference latency is 18.38 ms/image (~54.4 FPS theoretical single-image throughput) for YOLO11n-cls and 10.27 ms/image (~97.4 FPS) for Classical (HOG+SVM). Both fit comfortably within near-real-time or checkpoint batch processing budgets on edge hardware, provided classical preprocessing (restore_lowlight and clahe_bgr), image decoding, and batching overhead stay lightweight and within memory/thermal limits.

## Next Data Collection Priorities

To address blur_L15 recall loss (0.514) and combined precision/recall degradation (0.700 / 0.568), we would next collect: (1) real motion-blurred vehicles across varied speeds, distances, and blur angles; (2) low-light, night, wet-asphalt, snow, slush, and muddy tire captures; (3) hard negatives (non-studded tread blocks, stones, specular highlights) to cut false positives; (4) hard positives (worn, recessed, or low-contrast studs) to lift recall; and (5) images from the exact target edge camera setup.
