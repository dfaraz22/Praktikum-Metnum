% =========================================================
%   03. INPUT, OUTPUT & DECISION
%   Praktikum Metode Numerik
% =========================================================
%
%   Daftar Isi:
%   1. Input & Output (input, disp, fprintf)
%   2. Decision: If-Else
%   3. Decision: Switch-Case
% =========================================================

clc; clear;


%% 1. INPUT & OUTPUT
disp('=== PERCOBAAN INPUT & OUTPUT ===');

% Meminta input angka dan teks dari pengguna
nilai = input('Masukkan nilai ujian (0-100): ');
nama  = input('Masukkan nama mahasiswa: ', 's');

% Output menggunakan disp()
disp('--- Hasil Output disp ---');
disp(nama);
disp(nilai);

% Output menggunakan fprintf() (dengan format teks & variabel)
fprintf('\n--- Hasil Output fprintf ---\n');
fprintf('Mahasiswa bernama %s mendapatkan nilai: %d\n\n', nama, nilai);


%% 2. DECISION: IF-ELSE
disp('=== DECISION: IF-ELSE ===');

% Menentukan kelulusan berdasarkan nilai yang diinput
if nilai >= 75
    disp('Status: LULUS (Sangat Baik)');
elseif nilai >= 60
    disp('Status: LULUS (Cukup)');
else
    disp('Status: TIDAK LULUS');
end

fprintf('\n');


%% 3. DECISION: SWITCH-CASE
disp('=== DECISION: SWITCH-CASE ===');

% Meminta input kode menu/pilihan
pilihan = input('Pilih menu (1: Tambah, 2: Kurang, 3: Kali): ');

a = 12;
b = 4;

switch pilihan
    case 1
        hasil = a + b;
        fprintf('Hasil Penjumlahan: %d + %d = %d\n', a, b, hasil);
    case 2
        hasil = a - b;
        fprintf('Hasil Pengurangan: %d - %d = %d\n', a, b, hasil);
    case 3
        hasil = a * b;
        fprintf('Hasil Perkalian: %d * %d = %d\n', a, b, hasil);
    otherwise
        disp('Pilihan menu tidak valid!');
end
