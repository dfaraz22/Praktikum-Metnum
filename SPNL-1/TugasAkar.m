% TUGAS METODE NUMERIK - Biseksi & Regula-Falsi (Octave)
% Jalankan: tugas_akar
clc; clear; close all;

% ---- Fungsi f(x) = 0 (y target sudah dipindah ke ruas kiri) ----
f1 = @(x) 3*x.^3 - 5*x.^2 + 4*x - 7 - 1;   % y = 1
f2 = @(x) exp(x) - x.^2;                   % y = 0
f3 = @(x) log(x+2) + 2*x - 3;              % y = 0  (log = ln di Octave)

F    = {f1, f2, f3};
nama = {'y = 3x^3-5x^2+4x-7 (y=1)', 'y = e^x - x^2 (y=0)', 'y = log(x+2)+2x-3 (y=0)'};
% selang awal [a b] hasil metode grafik
AB   = [1 2; -1 0; 0 2];
% titik potong grafik ganda: f(x) = g(x) , dengan g(x)= ruas kanan
% (f ganda: y1 = bagian kiri, y2 = bagian kanan)
G1 = {@(x) 3*x.^3-5*x.^2+4*x-7, @(x) exp(x), @(x) log(x+2)};
G2 = {@(x) ones(size(x)),       @(x) x.^2,   @(x) 3-2*x};

% label legend grafik ganda
lab1 = {'y_1 = 3x^3-5x^2+4x-7', 'y_1 = e^x', 'y_1 = log(x+2)'};
lab2 = {'y_2 = 1', 'y_2 = x^2', 'y_2 = 3-2x'};

maxIter = 20;  tol = 1e-4;

% penampung hasil akhir: [akar, iterasi, f(akar), error] untuk tiap metode
% kolom 1-4 = biseksi, kolom 5-8 = regula-falsi
hasil = zeros(3,8);

for k = 1:3
  f = F{k}; a = AB(k,1); b = AB(k,2);

  %% ===== 1. GRAFIK TUNGGAL & GANDA =====
  x = linspace(a-1, b+1, 400);
  figure(k);
  subplot(1,2,1);
  plot(x, f(x), 'b', 'LineWidth', 2); hold on; grid on;
  plot(x, zeros(size(x)), 'k--');
  title(['Grafik tunggal: ' nama{k}]); xlabel('x'); ylabel('f(x)');
  subplot(1,2,2);
  plot(x, G1{k}(x), 'r', 'LineWidth', 2); hold on; grid on;
  plot(x, G2{k}(x), 'g', 'LineWidth', 2);
  title('Grafik ganda (titik potong = akar)'); xlabel('x');
  legend(lab1{k}, lab2{k}, 'Location', 'best');

  %% ===== 2a. BISEKSI =====
  printf('\n=== Persamaan %d: %s ===\n', k, nama{k});
  printf('--- BISEKSI ---\n');
  printf('%3s %10s %10s %10s %12s %10s\n','i','a','b','c','f(c)','error');
  A = a; B = b; cLama = A;
  for i = 1:maxIter
    c = (A+B)/2;
    err = abs(c - cLama);
    if i == 1, err = NaN; end
    printf('%3d %10.6f %10.6f %10.6f %12.6f %10.6f\n', i, A, B, c, f(c), err);
    if abs(f(c)) < tol || (i > 1 && err < tol), break; end
    if f(A)*f(c) < 0, B = c; else A = c; end
    cLama = c;
  end
  printf('Akar biseksi = %.6f (iterasi ke-%d)\n', c, i);
  hasil(k,1:4) = [c, i, f(c), err];

  %% ===== 2b. REGULA-FALSI =====
  printf('--- REGULA-FALSI ---\n');
  printf('%3s %10s %10s %10s %12s %10s\n','i','a','b','c','f(c)','error');
  A = a; B = b; cLama = A;
  for i = 1:maxIter
    c = (A*f(B) - B*f(A)) / (f(B) - f(A));
    err = abs(c - cLama);
    if i == 1, err = NaN; end
    printf('%3d %10.6f %10.6f %10.6f %12.6f %10.6f\n', i, A, B, c, f(c), err);
    if abs(f(c)) < tol || (i > 1 && err < tol), break; end
    if f(A)*f(c) < 0, B = c; else A = c; end
    cLama = c;
  end
  printf('Akar regula-falsi = %.6f (iterasi ke-%d)\n', c, i);
  hasil(k,5:8) = [c, i, f(c), err];
end

%% ===== 3. TABEL KESIMPULAN =====
metode = {'Biseksi', 'Regula-Falsi'};
printf('\n\n================ TABEL KESIMPULAN ================\n');
printf('%-10s %-14s %12s %8s %12s %12s\n', 'Persamaan', 'Metode', 'Akar', 'Iterasi', 'f(akar)', 'Error');
printf('%s\n', repmat('-', 1, 72));
for k = 1:3
  for m = 1:2
    col = (m-1)*4;
    printf('%-10d %-14s %12.6f %8d %12.6f %12.6f\n', k, metode{m}, ...
           hasil(k,col+1), hasil(k,col+2), hasil(k,col+3), hasil(k,col+4));
  end
  printf('%s\n', repmat('-', 1, 72));
end
printf('Maks. iterasi = %d, toleransi = %g\n', maxIter, tol);
