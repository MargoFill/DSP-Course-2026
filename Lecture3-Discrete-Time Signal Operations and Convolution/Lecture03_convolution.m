clear;
close all;
clc;

% Use the same random noise each time
rng(1);

%% Create a clean discrete-time signal

n = 0:100;
clean = sin(0.1*pi*n);

%% Add noise

noise = 0.4*randn(size(n));
measured = clean + noise;
scaled = measured*2
%% Display the clean and noisy signals

figure;

plot(n,clean,'b','LineWidth',1.5);
hold on;
plot(n,measured,'Color',[0.6 0.6 0.6]);

grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Clean and Noisy Signals');
legend('Clean Signal','Noisy Signal');

figure;

plot(n,scaled,'b','LineWidth',1.5);
hold on;
plot(n,measured,'Color',[0.6 0.6 0.6]);

grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Scaled and Noisy Signals');
legend('Scaled Signal','Noisy Signal');

h5 = ones(1,5)/5;
filtered5 = conv(measured,h5,'same');

figure;

plot(n,scaled,'b','LineWidth',1.5);
hold on;
plot(n,measured,'Color',[0.6 0.6 0.6]);
plot(n, filtered5, "m");

grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Scaled, Noisy and Five-point filtered Signals');
legend('Scaled Signal','Noisy Signal', 'Five-point filtered Signal');

h15 = ones(1,15)/15;
filtered15 = conv(measured,h15,'same');

figure;

plot(n,scaled,'b','LineWidth',1.5);
hold on;
plot(n,measured,'Color',[0.6 0.6 0.6]);
plot(n, filtered5, "m");
plot(n, filtered15, "c");

grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Scaled, Noisy and Five/15-point filtered Signals');
legend('Scaled Signal','Noisy Signal', 'Five-point filtered Signal', '15-point filtered Signal');

