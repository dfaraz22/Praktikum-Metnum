% =========================================================
%   02. ARRAY & OPERASI MATRIKS
%   Praktikum Metode Numerik
% =========================================================
%
%   Daftar Isi:
%   1. Array & Matriks
%   2. Indexing & Slicing Matriks
%   3. Matriks Khusus (zeros, ones, rand)
%   4. Perkalian Matriks & Element-wise (.*  .^)
%   5. Determinan & Invers
%   6. Transpose Matriks
%   7. Colon Operator (Rentang Deret)
% =========================================================

clc; clear;


%% 1. ARRAY & MATRIKS
v_baris = [1 1 1]
v_kolom = [1; 2; 3]
m_2x3   = [1 1 1; 2 2 2]
m_3x2   = [1 1; 2 2; 3 3]


%% 2. INDEXING & SLICING MATRIKS
a = [4 5 6 7; 1 2 3 4; 8 9 2 1]
x = [1 2]

b = a(x, 3)    % Baris 1 & 2 di kolom 3
c = a(3, x)    % Baris 3 di kolom 1 & 2
d = a(x, :)    % Baris 1 & 2 di SEMUA kolom
e = a(:, x)    % SEMUA baris di kolom 1 & 2


%% 3. MATRIKS KHUSUS (zeros, ones, rand)
f = zeros(3)         % Matriks 0 ukuran 3x3
g = ones(2, 4)       % Matriks 1 ukuran 2x4
h = rand(3, 4)       % Matriks acak ukuran 3x4

% Penyesuaian: Mengambil 3 kolom saja dari matriks a agar muat di matriks f (3x3)
f(1:2, :) = a(x, 1:3)


%% 4. PERKALIAN MATRIKS & ELEMENT-WISE (.* .^)
m1 = [1 2; 3 4];
m2 = [5 6; 7 8];

perkalian_matriks = m1 * m2   % Perkalian matriks standar
element_wise_mul  = m1 .* m2  % Mengalikan elemen per elemen
element_wise_pow  = m1 .^ 2   % Memangkatkan elemen per elemen


%% 5. DETERMINAN & INVERS
m_persegi = [4 7; 2 6];

d_det = det(m_persegi)   % Menghitung determinan matriks
e_inv = inv(m_persegi)   % Menghitung invers matriks


%% 6. TRANSPOSE MATRIKS
a_transpose = a'   % Transpose dari matriks a
b_transpose = b'   % Transpose dari matriks b


%% 7. COLON OPERATOR (RENTANG DERET)
deret_1 = 1:10         % Deret dari 1 sampai 10 (kelipatan 1)
deret_2 = 1:2:10       % Deret dari 1 sampai 10 dengan beda/step 2
deret_3 = 1:0.2:2      % Deret dari 1 sampai 2 dengan beda/step 0.2
