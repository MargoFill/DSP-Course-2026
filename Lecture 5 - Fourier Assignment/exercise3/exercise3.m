clear;
close all;

d = 5;   
f2 = 13.2 + 0.17*d;
fs = 200;


T = 1;
t = 0:1/fs:T-1/fs;

x = 0.8*sin(2*pi*15*t) + 0.4*sin(2*pi*f2*t);

N = length(x);
Y = fft(x);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:N/2)/N;

subplot(3, 1, 1);
plot(f, P1); grid on;
title('1-Second Spectrum'); xlabel('Frequency (Hz)'); ylabel('Amplitude');

%% 2. 4 sec
T = 4;
t = 0:1/fs:T-1/fs;
x = 0.8*sin(2*pi*15*t) + 0.4*sin(2*pi*f2*t);

N = length(x);
Y = fft(x);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:N/2)/N;

subplot(3, 1, 2);
plot(f, P1); grid on;
title('4-Second Spectrum'); xlabel('Frequency (Hz)'); ylabel('Amplitude');

%% 3. Zero-padding 
T = 1;
t = 0:1/fs:T-1/fs;
x = 0.8*sin(2*pi*15*t) + 0.4*sin(2*pi*f2*t);

N = length(x);
N_fft = 4 * N;              
Y = fft(x, N_fft);          

P2 = abs(Y/N);              
P1 = P2(1:N_fft/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:N_fft/2)/N_fft;   

subplot(3, 1, 3);
plot(f, P1); grid on;
title('1-Second Spectrum with Zero-Padding'); xlabel('Frequency (Hz)'); ylabel('Amplitude');
