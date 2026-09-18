x = 1:20:100;
y = 2*x.^3 - 5*x.^2 + 10*x;

% Menampilkan nilai x dan y di Command Window
disp('Nilai X:');
disp(x);
disp('Nilai Y:');
disp(y);

% Plot Grafik
figure;
plot(x, y, 'b-o', 'LineWidth', 1.5);
xlabel('Sumbu X');
ylabel('Sumbu Y');
title('Grafik Polinomial Diskrit');
grid on;
