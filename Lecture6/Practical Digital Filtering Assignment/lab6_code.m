% Digital Filter Design and Application Assignment
% Requires Signal Processing Toolbox
clear; clc; close all;

%% Part A: Filter a Sensor Signal
disp('--- Part A: Sensor Filtering ---');
Fs = 1000;
t = (0:1/Fs:2-1/Fs)';
rng(7); % Seed for reproducible noise

% Signal generation
clean = sin(2*pi*5*t) + 0.35*sin(2*pi*12*t);
noise = 0.35*sin(2*pi*50*t) + 0.20*sin(2*pi*137*t) + 0.25*randn(size(t));
x = clean + noise;

% Filter design
fc = 20;
bFIR = fir1(60, fc/(Fs/2), 'low');
[bIIR, aIIR] = butter(4, fc/(Fs/2), 'low');

% Filtering (offline, zero-phase)
yFIR = filtfilt(bFIR, 1, x);
yIIR = filtfilt(bIIR, aIIR, x);

% 1. Sensor time-domain comparison
figure('Name', 'Part A: Sensor Time-Domain');
idx = 1:round(0.2*Fs); % 0.2 s section
plot(t(idx), clean(idx), 'k', 'LineWidth', 1.5); hold on;
plot(t(idx), x(idx), 'Color', [0.7 0.7 0.7]);
plot(t(idx), yFIR(idx), 'b--', 'LineWidth', 1.5);
plot(t(idx), yIIR(idx), 'r:', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude');
title('Sensor Signal: 0.2s Section Comparison');
legend('Clean Reference', 'Noisy Input', 'FIR Output', 'IIR Output', 'Location', 'best');
grid on;

% 2. Sensor frequency responses
figure('Name', 'Part A: Filter Magnitude Responses');
[hFIR, fFIR] = freqz(bFIR, 1, 1024, Fs);
[hIIR, fIIR] = freqz(bIIR, aIIR, 1024, Fs);
plot(fFIR, 20*log10(abs(hFIR)), 'b', 'LineWidth', 1.5); hold on;
plot(fIIR, 20*log10(abs(hIIR)), 'r', 'LineWidth', 1.5);
xline(fc, 'k--', '20 Hz Cutoff');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
title('Magnitude Response of LPF Designs');
legend('FIR (Order 60)', 'IIR (Butterworth Order 4)', 'Location', 'southwest');
grid on; xlim([0 150]); ylim([-100 10]);

% 3. Sensor single-sided amplitude spectra
N = length(x);
f = (0:N/2-1)*(Fs/N);
X_mag = 2/N * abs(fft(x)); X_mag = X_mag(1:N/2);
YFIR_mag = 2/N * abs(fft(yFIR)); YFIR_mag = YFIR_mag(1:N/2);
YIIR_mag = 2/N * abs(fft(yIIR)); YIIR_mag = YIIR_mag(1:N/2);

figure('Name', 'Part A: Single-Sided Amplitude Spectra');
plot(f, X_mag, 'Color', [0.7 0.7 0.7]); hold on;
plot(f, YFIR_mag, 'b');
plot(f, YIIR_mag, 'r--');
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Spectra of Noisy and Filtered Signals');
legend('Noisy Input', 'FIR Output', 'IIR Output');
xlim([0 160]); grid on;

% 4. RMSE Calculation
rmse_noisy = sqrt(mean((clean - x).^2));
rmse_FIR = sqrt(mean((clean - yFIR).^2));
rmse_IIR = sqrt(mean((clean - yIIR).^2));

fprintf('RMSE Noisy Input: %.4f\n', rmse_noisy);
fprintf('RMSE FIR Output:  %.4f\n', rmse_FIR);
fprintf('RMSE IIR Output:  %.4f\n', rmse_IIR);

%% Part B: Reduce a 50 Hz Hum in Audio
disp('--- Part B: Audio Hum Reduction ---');
load handel; % Provides y and Fs
xClean = y;
tAudio = (0:numel(xClean)-1)'/Fs;

% Add 50 Hz Hum
hum_amp = 0.15;
xHum = xClean + hum_amp*sin(2*pi*50*tAudio);

% Design narrow band-stop (49-51 Hz)
[bN, aN] = butter(2, [49 51]/(Fs/2), 'stop');
yAudio = filtfilt(bN, aN, xHum);

% Design wider band-stop (45-55 Hz) for comparison
[bW, aW] = butter(2, [45 55]/(Fs/2), 'stop');
yAudioW = filtfilt(bW, aW, xHum);

% 1. Audio waveform comparison
figure('Name', 'Part B: Audio Waveform');
idxA = round(1*Fs) : round(1.05*Fs); % 0.05s section
plot(tAudio(idxA), xClean(idxA), 'k', 'LineWidth', 1.5); hold on;
plot(tAudio(idxA), xHum(idxA), 'Color', [0.7 0.7 0.7]);
plot(tAudio(idxA), yAudio(idxA), 'b--');
xlabel('Time (s)'); ylabel('Amplitude');
title('Audio Waveform: 0.05s Section Comparison');
legend('Clean', 'With 50 Hz Hum', 'Narrow Filtered', 'Location', 'best');
grid on;

% 2. Audio spectrum
N_aud = length(xHum);
f_aud = (0:N_aud/2-1)*(Fs/N_aud);
Hum_mag = 2/N_aud * abs(fft(xHum)); Hum_mag = Hum_mag(1:N_aud/2);
Filt_mag = 2/N_aud * abs(fft(yAudio)); Filt_mag = Filt_mag(1:N_aud/2);

figure('Name', 'Part B: Audio Spectra');
plot(f_aud, Hum_mag, 'Color', [0.7 0.7 0.7]); hold on;
plot(f_aud, Filt_mag, 'b');
xline(50, 'r--', '50 Hz');
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Audio Spectra: Hum vs Filtered');
legend('With Hum', 'Narrow Filtered');
xlim([0 200]); grid on;

% Optional playback (uncomment to listen)
% sound(xHum, Fs); pause(length(xHum)/Fs + 1);
% sound(yAudio, Fs);