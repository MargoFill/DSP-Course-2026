# Discrete-Time Signal Operations and Convolution

## 1. Which operation changed the signal amplitude?
Amplitude scaling (specifically, multiplying the noisy signal by 2 in Task 1) changed the signal amplitude.
## 2. How did the five-sample delay change the signal?
   The delay shifted the entire signal to the right along the time axis (x-axis) by 5 sample indices. It did not change the shape, frequency, or amplitude of the signal, but simply pushed it forward in time, typically padding the beginning with zeros.

   <img width="931" height="495" alt="image" src="https://github.com/user-attachments/assets/04b9e9e8-a32f-4c0f-bc16-5aaff88cd884" />

## 3. What does the impulse response ` h[n] ` represent?

The impulse response h[n] represents the weights or coefficients of the moving-average filter. It defines exactly how the filter behaves by indicating what fraction of the current and past samples are added together (e.g., ones(1,5)/5 means 5 sequential samples are each multiplied by 0.2 and summed).
   
## 4. How did convolution change the noisy signal?

Convolution applied the moving-average filter to the noisy signal, which smoothed out the rapid, high-frequency random fluctuations. This process averaged neighboring data points, causing the resulting signal to look much closer to the original clean sine wave.
   
## 5. What differences did you observe between the 5-point and 15-point filters?
  
   The 15-point filter created a visibly smoother curve than the 5-point filter because it averaged data across a larger window. However, the 15-point filter likely flattened the peaks and reduced the overall amplitude of the underlying sine wave much more noticeably than the 5-point filter.
## 6. Which filter removed more noise?

The 15-point filter removed more noise because averaging over a longer sequence of samples cancels out random variations more effectively.
    
## 7. Did the longer filter remove or distort useful signal information?

Yes. Because the 15-point window covers a large portion of the sine wave's actual period, the "excessive smoothing" mentioned in the assignment's engineering observation caused the peaks of the sine wave to be averaged down, reducing the true amplitude and distorting the clean signal.
    
## 8. Which filter would you recommend for this signal? Explain your decision.

I would recommend the 5-point filter. The original clean signal has a period of 20 samples. A 15-point filter averages across 75% of the entire wave cycle at once, which severely flattens the wave. The 5-point filter provides a much better balance: it is long enough to reduce the random noise, but short enough to preserve the natural amplitude and shape of the original sine wave.
    
## 9. Give one real engineering application for moving-average filtering.

It is commonly used for smoothing raw sensor data, such as stabilizing temperature readings from a digital weather sensor, removing high-frequency electronic interference from biomedical devices (like heart rate monitors), or smoothing stock market price trends over time.


## AI Usage

Tool used: Gemini
How I used it: I used the AI to explain the syntax of specific MATLAB plotting commands and to help me understand the theoretical concepts behind convolution and filter lengths.
What I verified or changed: I reviewed the AI's explanations for the theoretical questions and rewrote aome of the final answers in my own words.
