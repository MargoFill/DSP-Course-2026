t = linspace(-1, 1, 4000);
H3 = 9;
H1 = 1;
H2 = 3;
H4 = 25;
x1 = zeros(size(t));
x2 = zeros(size(t));
x3 = zeros(size(t));
x4 = zeros(size(t));

for k = 1:2:H1
    x1 = x1 + (4/pi) * sin(2*pi*k*t) / k;
end
for k = 1:2:H2
    x2 = x2 + (4/pi) * sin(2*pi*k*t) / k;
end
for k = 1:2:H3
    x3 = x3 + (4/pi) * sin(2*pi*k*t) / k;
end
for k = 1:2:H4
    x4 = x4 + (4/pi) * sin(2*pi*k*t) / k;
end

plot(t, x1, 'b')
hold on
plot(t, x2, 'r')
hold on
plot(t, x3, 'm')
hold on
plot(t, x4, 'y')
grid on
xlabel('Time (s)')
ylabel('Amplitude')
title('Square wave approximation')
legend('H1','H2','H3','H4')

