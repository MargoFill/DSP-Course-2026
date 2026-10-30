% In-class task: Inspect and filter a WAV file
clear; clc; close all;

filename = 'audio.wav'; 

[y, Fs] = audioread(filename);

if size(y, 2) > 1
    y = mean(y, 2);
end

N = length(y);
duration = N / Fs;

disp('--- Information about audio file ---');
fprintf('Sampling rate: %d Гц\n', Fs);
fprintf('Duration: %.2f s\n', duration);
fprintf('Number of channels: 1 (downmixed to mono)\n');


f0 = 50;               
w0 = f0 / (Fs/2);   
bw = w0 / 35;         
[b, a] = iirnotch(w0, bw); 

y_filtered = filtfilt(b, a, y);


t = (0:N-1) / Fs; 

figure('Name', 'Audio Analysis: Before and After', 'Position', [100, 100, 1000, 600]);


subplot(2, 2, 1);
plot(t, y, 'b');
title('Original: Waveform');
xlabel('Time (s)'); ylabel('Amplitude');
ylim([-max(abs(y)), max(abs(y))]); 


subplot(2, 2, 2);
spectrogram(y, 1024, 512, 1024, Fs, 'yaxis');
title('Original: Spectrogram');


subplot(2, 2, 3);
plot(t, y_filtered, 'r');
title('After the filter (Notch 50Hz): Waveform');
xlabel('Time (s)'); ylabel('Amplitude');
ylim([-max(abs(y)), max(abs(y))]); 


subplot(2, 2, 4);
spectrogram(y_filtered, 1024, 512, 1024, Fs, 'yaxis');
title('After the filter: Spectrogram');

% Playback (uncomment to listen)
% disp('Playing original sound...');
% sound(y, Fs);
% pause(duration + 1);
% disp('Playing filtered sound...');
% sound(y_filtered, Fs);