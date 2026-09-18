t = 0:pi/40:8*pi;
x = sqrt(2*t).*sin(3*t);
y = sqrt(2*t).*cos(3*t);
z = t;

figure;
plot3(x, y, z, 'b-', 'LineWidth', 1.5);
grid on;
xlabel('Sumbu X');
ylabel('Sumbu Y');
zlabel('Sumbu Z');
title('Grafik 3D Line Plot (Spiral/Heliks)');
