x = -4:0.2:4;
y = -4:0.2:4;
[X, Y] = meshgrid(x, y);
Z = 2.0 .^ (-1.2*sqrt(X.^2 + Y.^2)) .* cos(0.8*Y) .* sin(X);

figure;
contour3(X, Y, Z, 20);
xlabel('Sumbu X');
ylabel('Sumbu Y');
zlabel('Sumbu Z');
title('Grafik 3D Contour Plot');
colorbar;
grid on;
