% Grafik 2DB
x = 0:1:50;
y = x.^3 + 3*x.^2 - 20*x;

figure;
plot(x, y, 'b-', 'LineWidth', 1.5);
xlabel('Sumbu X');
ylabel('Sumbu Y');
title('Grafik Garis 2D');
grid on;
