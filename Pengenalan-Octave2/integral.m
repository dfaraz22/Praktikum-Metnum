% =========================================================
%   INTEGRAL
%   Praktikum Metode Numerik
% =========================================================

pkg load symbolic

f = input('Masukkan bentuk persamaan f(x) = ', 's');
f_asli = sym(f);
f_integral = int(f_asli, 'x');

disp('Hasil integralnya adalah: ');
disp(f_integral);
