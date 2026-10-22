clear;
close all;
x = [1 1 1 1];
n = 0:length(x)-1;

w = linspace(-pi, pi, 1000);
X = x * exp(-1j * (n.' * w));


Y4 = abs(fft(x, 4));
Y4 = fftshift(Y4);                   
w4 = (-4/2 : 4/2 - 1) * (2*pi / 4);


Y64 = abs(fft(x, 64));
Y64 = fftshift(Y64);                   
w64 = (-64/2 : 64/2 - 1) * (2*pi / 64);




plot(w, abs(X), 'b')
hold on
plot(w64, abs(Y64), 'r.')   
plot(w4, abs(Y4), 'c.', 'MarkerSize', 20) 
hold off

grid on
xlabel('Angular frequency (rad/sample)')
ylabel('Magnitude')
title('DTFT vs DFT')
legend('DTFT', 'DFT (64)', 'DFT (4)')