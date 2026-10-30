clear; clc;

disp('Sound generation with 50 Hz interference...');

load handel; 
x = y;


t_signal = (0:length(x)-1)'/Fs;


x = x + 0.15 * sin(2 * pi * 50 * t_signal); 


x = x / max(abs(x));

filename = 'audio.wav';
audiowrite(filename, x, Fs);