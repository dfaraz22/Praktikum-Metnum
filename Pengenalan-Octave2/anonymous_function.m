% =========================================================
%   FUNCTION
%   Anonymous Function
%   Praktikum Metode Numerik
% =========================================================

% Anonymous Function 1: Pangkat 4
squared = @(x) x.^4

% Pemanggilan nilai tunggal (x = 4)
squared(4)

% Pemanggilan nilai vektor/rentang (x = 1 sampai 4)
squared(1:4)

% Anonymous Function 2: Penjumlahan dua variabel
additon = @(x,y) x+y

% Pemanggilan penjumlahan (x = 5, y = 10)
additon(5, 10)
