t = linspace(0, 1, 1000);

%% Task 1: Create a Sine Wave
A1 = 1;      
f1 = 5;      
y1 = A1 * sin(2 * pi * f1 * t);

figure('Name', 'Task 1: Sine Wave');
plot(t, y1, 'LineWidth', 1.5);
title('Sinusoidal Signal (5 Hz)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

%% Task 2: Compare Different Frequencies
f2_1 = 2;  y2_1 = sin(2 * pi * f2_1 * t);
f2_2 = 5;  y2_2 = sin(2 * pi * f2_2 * t);
f2_3 = 10; y2_3 = sin(2 * pi * f2_3 * t);

figure('Name', 'Task 2: Frequencies');
subplot(3, 1, 1);
plot(t, y2_1, 'b'); title('Frequency: 2 Hz'); ylabel('Amplitude'); grid on;

subplot(3, 1, 2);
plot(t, y2_2, 'r'); title('Frequency: 5 Hz'); ylabel('Amplitude'); grid on;

subplot(3, 1, 3);
plot(t, y2_3, 'g'); title('Frequency: 10 Hz'); xlabel('Time (s)'); ylabel('Amplitude'); grid on;

%% Task 3: Compare Different Amplitudes
f3 = 5; 
A3_1 = 0.5; y3_1 = A3_1 * sin(2 * pi * f3 * t);
A3_2 = 1;   y3_2 = A3_2 * sin(2 * pi * f3 * t);
A3_3 = 2;   y3_3 = A3_3 * sin(2 * pi * f3 * t);

figure('Name', 'Task 3: Amplitudes');
subplot(3, 1, 1);
plot(t, y3_1, 'b'); title('Amplitude: 0.5'); ylabel('Amplitude'); grid on;

subplot(3, 1, 2);
plot(t, y3_2, 'r'); title('Amplitude: 1'); ylabel('Amplitude'); grid on;

subplot(3, 1, 3);
plot(t, y3_3, 'g'); title('Amplitude: 2'); xlabel('Time (s)'); ylabel('Amplitude'); grid on;

%% Task 4: Add Noise
y4_clean = sin(2 * pi * 5 * t); 
noise = 0.3 * randn(size(t)); 
y4_noisy = y4_clean + noise;

figure('Name', 'Task 4: Noise');
subplot(2, 1, 1);
plot(t, y4_clean, 'LineWidth', 1.2);
title('Clean Signal');
ylabel('Amplitude');
grid on;

subplot(2, 1, 2);
plot(t, y4_noisy, 'r');
title('Noisy Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;