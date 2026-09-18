x = linspace(-5, 5, 80);
y = 2*x.^2 + 4;

figure;
plot(x, y, 'm--', 'LineWidth', 1.5);
xlabel('Sumbu X');
ylabel('Sumbu Y');
title('Grafik Linspace Parabola 2D');
grid on;
