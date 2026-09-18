x = -10:0.5:10;
y = x;
[X, Y] = meshgrid(x, y);
R = sqrt(X.^2 + Y.^2) + eps; % eps mencegah pembagian dengan nol
Z = sin(2*R)./R;

figure;
mesh(X, Y, Z);
xlabel('Sumbu X');
ylabel('Sumbu Y');
zlabel('Sumbu Z');
title('Grafik 3D Mesh Plot (Muka Gelombang)');
colorbar;
grid on;
