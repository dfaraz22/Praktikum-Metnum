x = -5:0.5:5;
y = -5:0.5:5;
[X, Y] = meshgrid(x, y);

figure;
plot(X, Y, 'r.');
xlabel('Sumbu X');
ylabel('Sumbu Y');
title('Visualisasi Titik-Titik Grid (Meshgrid)');
grid on;
