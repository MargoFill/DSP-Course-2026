# Z Transform and Sample Delays
## Tasks
### 1. Identify the sample represented by each term in X(z).
- The term $1$ represents the sample at $n=0$, where $x[0] = 1$.
- The term $2z^{-1}$ represents the sample at $n=1$, where $x[1] = 2$.
- The term $z^{-2}$ represents the sample at $n=2$, where $x[2] = 1$.
### 2. Write the Z-transform of the delayed signal.
` X(z) = z⁻¹ + 2z⁻²+z^{-3}$ `
### 3. Explain why delaying the signal by one sample multiplies X(z) by z⁻¹.


### 4. Calculate y[0], y[1], y[2] and y[3] by hand. Compare them with MATLAB.

### 5. Explain how b = [0.5 0.5] represents the two terms in H(z).

### 6. Change the system to H(z) = 0.8 + 0.2z⁻¹. Update b, run the code again, and explain which input sample now has more influence on the output.

## Input, Delayed and Output Signals

<img width="932" height="482" alt="image" src="https://github.com/user-attachments/assets/83965a73-bfb3-4b28-9af1-10b9e8e62527" />
<img width="932" height="492" alt="image" src="https://github.com/user-attachments/assets/ff0cf25c-b374-4281-a612-7e6f814917bf" />
