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

