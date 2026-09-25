clear;
close all;
clc;

%% Original signal
fs_original=48000;
signal_frequency = 10;   % Signal frequency: 10 Hz
duration = 1;              % Duration in seconds
amplitude = 0.20;          % Keep the volume low
fs_sampling_list= [15,20,25,50,100];


 t = 0:1/fs_original:duration-1/fs_original;
 
 x = amplitude * sin(2*pi*signal_frequency*t);
 %x1 = amplitude * sin(2*pi*f_sampling*t);

% %{ Listen to the original signal
% 
% disp('Original signal: 7 kHz');
% 
% % soundsc(x, fs_original);
% % pause(duration + 1);
% % 
% %  Select a new sampling frequency
% % 
% % % Change only this value
% % fs_low = 24000;
% % 
% % % The original frequency must be divisible by fs_low
% % M = fs_original / fs_low;
% % 
% % if mod(M,1) ~= 0
% %     error('Choose an fs_low value that divides 48000 exactly.');
% % end
% % 
% %  Downsample without an anti-aliasing filter
% % 
% % x_alias = x(1:M:end);
% % 
% % nyquist_frequency = fs_low / 2;
% % 
% % fprintf('New sampling frequency: %.0f Hz\n', fs_low);
% % fprintf('New Nyquist frequency: %.0f Hz\n', nyquist_frequency);
% % 
% %  Listen to the downsampled signal
% % 
% % disp('Downsampled signal');
% % 
% % soundsc(x_alias, fs_low);
% % 
% % %% Compare the frequency spectra
% % }%

figure;

subplot(2,1,1);

plot(t, x, "c", 'LineWidth',1.5);
title('Original Signal: 10 Hz');
xlabel("Time");
ylabel("Amplitude");
legend('10 Hz Signal');


grid on;


figure;

for i = 1:length(fs_sampling_list);
    fs=fs_sampling_list(i);

    t_sampled = 0:1/fs:duration;
    x_sampled = amplitude * sin(2*pi*signal_frequency*t_sampled);

    subplot(5,1,i);
    
    plot(t, x, "c", 'LineWidth',1.5);
    hold on;

    %plot(t, x1, "m", 'LineWidth',1.5);

    stem(t_sampled, x_sampled, 'm', 'filled', 'LineWidth', 1.2);

    hold off;
    title(sprintf('Sampling Frequency: %d Hz', fs));
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Continuous 10 Hz', 'Sampled Points', 'Location', 'northeastout');
    grid on;
end

