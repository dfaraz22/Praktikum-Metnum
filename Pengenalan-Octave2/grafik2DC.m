x = 0:pi/50:4*pi;
y = 2*sin(2*x);

figure;
plot(x, y, 'b-', 'LineWidth', 1.5);
xlabel('Sumbu X');
ylabel('Sumbu Y');
title('Grafik Gelombang Sinus 2D');
grid on;
