% =====================================================================
%  spl_lengkap.m
%  Penyelesaian SPL 5 variabel (p,q,r,s,t) dengan 5 metode:
%  Gauss, Gauss-Jordan, Dekomposisi LU, Jacobi, Gauss-Seidel
%  + Soal 2 (galat) + Soal 3 (running time)
%
%  CARA PAKAI : simpan file ini, lalu ketik di Command Window:
%                  spl_lengkap
%  (jalan di MATLAB maupun Octave, cukup 1 file ini saja)
% =====================================================================
function spl_lengkap()
    clc;
    nama    = {'p','q','r','s','t'};
    maxIter = 20;        % petunjuk soal 1
    tol     = 0.001;     % petunjuk soal 1

    % ---------------- DATA SPL ----------------
    A = [ 5 -1 -1  0  0;
         -1  5 -1 -1  0;
         -1 -1  4 -1 -1;
          0  0  1  4 -2;
          0  1 -1  1  4];
    b = [-1; 2; 6; 2; -1];

    garis('=');
    fprintf('   PENYELESAIAN SISTEM PERSAMAAN LINIER (SPL)\n');
    garis('=');
    fprintf('Sistem persamaan:\n');
    fprintf('   5p -  q -  r            = -1\n');
    fprintf('  -p + 5q -  r -  s        =  2\n');
    fprintf('  -p -  q + 4r -  s -  t   =  6\n');
    fprintf('             r + 4s - 2t   =  2\n');
    fprintf('        q -  r +  s + 4t   = -1\n\n');
    fprintf('Bentuk matriks A*x = b, dengan x = [p q r s t]''\n');
    fprintf('Matriks A:\n');   cetak_mat(A);
    fprintf('Vektor b:\n');    cetak_mat(b);
    fprintf('Cek dominan diagonal (syarat cukup konvergensi Jacobi/Gauss-Seidel):\n');
    for i = 1:5
        dg = abs(A(i,i));
        lw = sum(abs(A(i,:))) - dg;
        if dg > lw, ket = 'dominan kuat';
        elseif dg == lw, ket = 'dominan lemah (=)';
        else ket = 'TIDAK dominan'; end
        fprintf('  Baris %d: |a_ii| = %g, jumlah |lainnya| = %g  -> %s\n', i, dg, lw, ket);
    end

    % =================================================================
    %                           SOAL 1
    % =================================================================
    fprintf('\n\n');
    garis('#');
    fprintf('   SOAL 1 : HIMPUNAN PENYELESAIAN\n');
    garis('#');

    fprintf('\n');  garis('=');  fprintf(' [1] METODE ELIMINASI GAUSS\n');  garis('=');
    x_gauss = m_gauss(A, b, true, nama);
    cetak_solusi(x_gauss, nama);

    fprintf('\n');  garis('=');  fprintf(' [2] METODE GAUSS-JORDAN\n');  garis('=');
    x_gj = m_gauss_jordan(A, b, true, nama);
    cetak_solusi(x_gj, nama);

    fprintf('\n');  garis('=');  fprintf(' [3] METODE DEKOMPOSISI LU (Doolittle)\n');  garis('=');
    x_lu = m_lu(A, b, true, nama);
    cetak_solusi(x_lu, nama);

    fprintf('\n');  garis('=');
    fprintf(' [4] METODE JACOBI  (maks iterasi = %d, toleransi = %g)\n', maxIter, tol);
    garis('=');
    [x_jac, it_jac, ok_jac] = m_jacobi(A, b, maxIter, tol, true, nama);
    cetak_solusi(x_jac, nama);

    fprintf('\n');  garis('=');
    fprintf(' [5] METODE GAUSS-SEIDEL  (maks iterasi = %d, toleransi = %g)\n', maxIter, tol);
    garis('=');
    [x_gs, it_gs, ok_gs] = m_gauss_seidel(A, b, maxIter, tol, true, nama);
    cetak_solusi(x_gs, nama);

    fprintf('\n');  garis('-');
    fprintf(' RINGKASAN SOAL 1 : Himpunan penyelesaian tiap metode\n');
    garis('-');
    fprintf('%-14s', 'Metode');
    for i = 1:5, fprintf('%13s', nama{i}); end
    fprintf('\n');
    cetak_baris('Gauss',        x_gauss);
    cetak_baris('Gauss-Jordan', x_gj);
    cetak_baris('LU',           x_lu);
    cetak_baris('Jacobi',       x_jac);
    cetak_baris('Gauss-Seidel', x_gs);
    garis('-');

    % =================================================================
    %                           SOAL 2
    % =================================================================
    fprintf('\n\n');
    garis('#');
    fprintf('   SOAL 2 : GALAT METODE LANGSUNG vs METODE ITERATIF\n');
    garis('#');
    fprintf('Nilai eksak diambil dari metode analitik/langsung (Gauss-Jordan).\n');
    fprintf('Galat abstrak = abs(nilai eksak - nilai hampiran)\n\n');
    x_eks = x_gj;

    fprintf('Nilai eksak (Gauss-Jordan):\n');
    for i = 1:5, fprintf('   %s = %.10f\n', nama{i}, x_eks(i)); end

    fprintf('\n(a) Galat metode langsung terhadap nilai eksak\n');
    garis('-');
    fprintf('%-6s %-18s %-18s\n', 'Var', 'Galat Gauss', 'Galat LU');
    for i = 1:5
        fprintf('%-6s %-18.6e %-18.6e\n', nama{i}, abs(x_eks(i)-x_gauss(i)), abs(x_eks(i)-x_lu(i)));
    end
    garis('-');
    fprintf('(galat ~1e-16 = hanya galat pembulatan komputer, praktis nol)\n');

    fprintf('\n(b) Galat metode iteratif terhadap nilai eksak\n');
    garis('-');
    fprintf('%-5s %-13s %-13s %-15s %-13s %-15s\n', 'Var', 'Eksak', 'Jacobi', 'Galat Jacobi', 'Gauss-Seidel', 'Galat G-Seidel');
    for i = 1:5
        fprintf('%-5s %-13.7f %-13.7f %-15.6e %-13.7f %-15.6e\n', nama{i}, x_eks(i), ...
            x_jac(i), abs(x_eks(i)-x_jac(i)), x_gs(i), abs(x_eks(i)-x_gs(i)));
    end
    garis('-');
    gj = max(abs(x_eks - x_jac));   gg = max(abs(x_eks - x_gs));
    fprintf('Galat maksimum Jacobi       : %.6e  (%d iterasi)\n', gj, it_jac);
    fprintf('Galat maksimum Gauss-Seidel : %.6e  (%d iterasi)\n', gg, it_gs);

    fprintf('\n(c) Perkembangan galat tiap iterasi (max|eksak - hampiran|)\n');
    garis('-');
    gJ = galat_per_iter(A, b, maxIter, tol, x_eks, 'jacobi');
    gG = galat_per_iter(A, b, maxIter, tol, x_eks, 'seidel');
    fprintf('%-8s %-18s %-18s\n', 'Iterasi', 'Galat Jacobi', 'Galat G-Seidel');
    for k = 1:max(length(gJ), length(gG))
        sj = '-';  sg = '-';
        if k <= length(gJ), sj = sprintf('%.6e', gJ(k)); end
        if k <= length(gG), sg = sprintf('%.6e', gG(k)); end
        fprintf('%-8d %-18s %-18s\n', k, sj, sg);
    end
    garis('-');

    fprintf('\nResidual ||A*x - b|| (tak perlu nilai eksak):\n');
    fprintf('   Gauss        : %.3e\n', norm(A*x_gauss - b, inf));
    fprintf('   Gauss-Jordan : %.3e\n', norm(A*x_gj    - b, inf));
    fprintf('   LU           : %.3e\n', norm(A*x_lu    - b, inf));
    fprintf('   Jacobi       : %.3e\n', norm(A*x_jac   - b, inf));
    fprintf('   Gauss-Seidel : %.3e\n', norm(A*x_gs    - b, inf));

    fprintf('\nKESIMPULAN SOAL 2:\n');
    fprintf(' - Metode langsung (Gauss, Gauss-Jordan, LU) memberi solusi eksak (galat ~ 0).\n');
    fprintf(' - Metode iteratif memberi hampiran; galat bergantung toleransi & jumlah iterasi.\n');
    if gg < gj
        fprintf(' - Gauss-Seidel lebih akurat (galat %.2e) dibanding Jacobi (%.2e).\n', gg, gj);
    else
        fprintf(' - Jacobi lebih akurat (galat %.2e) dibanding Gauss-Seidel (%.2e).\n', gj, gg);
    end

    % =================================================================
    %                           SOAL 3
    % =================================================================
    fprintf('\n\n');
    garis('#');
    fprintf('   SOAL 3 : RUNNING TIME (tic toc)\n');
    garis('#');
    fprintf('Hanya proses algoritma yang diukur (tanpa input/output/tampil).\n');
    fprintf('Karena SPL kecil (5x5), tiap metode diulang N kali lalu dirata-rata.\n\n');

    N = 2000;
    % pemanasan agar pengukuran stabil
    for k = 1:50
        m_gauss(A,b,false,nama); m_gauss_jordan(A,b,false,nama); m_lu(A,b,false,nama);
        m_jacobi(A,b,maxIter,tol,false,nama); m_gauss_seidel(A,b,maxIter,tol,false,nama);
    end

    tic; x = m_gauss(A,b,false,nama);                     t_single(1) = toc;
    tic; x = m_gauss_jordan(A,b,false,nama);              t_single(2) = toc;
    tic; x = m_lu(A,b,false,nama);                        t_single(3) = toc;
    tic; x = m_jacobi(A,b,maxIter,tol,false,nama);        t_single(4) = toc;
    tic; x = m_gauss_seidel(A,b,maxIter,tol,false,nama);  t_single(5) = toc;

    tic; for k=1:N, m_gauss(A,b,false,nama);                    end; t(1) = toc/N;
    tic; for k=1:N, m_gauss_jordan(A,b,false,nama);             end; t(2) = toc/N;
    tic; for k=1:N, m_lu(A,b,false,nama);                       end; t(3) = toc/N;
    tic; for k=1:N, m_jacobi(A,b,maxIter,tol,false,nama);       end; t(4) = toc/N;
    tic; for k=1:N, m_gauss_seidel(A,b,maxIter,tol,false,nama); end; t(5) = toc/N;

    metode = {'Gauss','Gauss-Jordan','LU','Jacobi','Gauss-Seidel'};
    garis('-');
    fprintf('%-15s %-22s %-22s\n', 'Metode', 'Sekali jalan (detik)', sprintf('Rata-rata %dx (detik)', N));
    garis('-');
    for i = 1:5
        fprintf('%-15s %-22.4e %-22.4e\n', metode{i}, t_single(i), t(i));
    end
    garis('-');
    [ts, urut] = sort(t);
    fprintf('Urutan tercepat -> terlambat (rata-rata):\n');
    for i = 1:5
        fprintf('   %d. %-14s %.4e detik  (%.2fx dari tercepat)\n', i, metode{urut(i)}, ts(i), ts(i)/ts(1));
    end

    fprintf('\nKESIMPULAN SOAL 3:\n');
    fprintf(' - Tercepat : %s, paling lambat : %s (pada SPL 5x5 ini).\n', metode{urut(1)}, metode{urut(5)});
    fprintf(' - Jacobi butuh %d iterasi, Gauss-Seidel %d iterasi; Gauss-Seidel biasanya lebih\n', it_jac, it_gs);
    fprintf('   cepat konvergen karena langsung memakai nilai terbaru.\n');
    fprintf(' - Kompleksitas: Gauss/LU ~ O(n^3) (LU ~ 2n^3/3), Gauss-Jordan ~ n^3,\n');
    fprintf('   iteratif ~ O(n^2) per iterasi (untuk matriks penuh). Untuk n besar & matriks\n');
    fprintf('   jarang (sparse), metode iteratif jauh lebih hemat waktu dan memori.\n');
    fprintf(' - Pada n sekecil ini selisih waktu sangat kecil dan bisa berubah antar komputer;\n');
    fprintf('   overhead pemanggilan fungsi ikut memengaruhi hasil.\n');
    fprintf('\n');  garis('=');  fprintf(' SELESAI\n');  garis('=');
end

% =====================================================================
%                    FUNGSI-FUNGSI METODE
% =====================================================================

% ---------------- 1. GAUSS ----------------
function x = m_gauss(A, b, tampil, nama)
    n = length(b);
    Ab = [A b];
    if tampil
        fprintf('Matriks augmented awal [A | b]:\n');  cetak_aug(Ab);
    end
    % ---- eliminasi maju ----
    for k = 1:n-1
        [~, idx] = max(abs(Ab(k:n, k)));
        idx = idx + k - 1;
        if idx ~= k
            Ab([k idx], :) = Ab([idx k], :);
            if tampil, fprintf('\n[Pivoting] tukar baris %d <-> baris %d\n', k, idx); end
        end
        if tampil
            fprintf('\n--- Langkah %d : pivot a(%d,%d) = %.4f ---\n', k, k, k, Ab(k,k));
        end
        for i = k+1:n
            m = Ab(i,k) / Ab(k,k);
            Ab(i,:) = Ab(i,:) - m * Ab(k,:);
            Ab(i,k) = 0;
            if tampil
                fprintf('  m(%d,%d) = %.4f ;  R%d <- R%d - (%.4f) * R%d\n', i, k, m, i, i, m, k);
            end
        end
        if tampil
            fprintf('  Matriks setelah langkah %d:\n', k);  cetak_aug(Ab);
        end
    end
    if tampil
        fprintf('\nMatriks segitiga atas:\n');  cetak_aug(Ab);
        fprintf('\n--- Substitusi mundur ---\n');
    end
    % ---- substitusi mundur ----
    x = zeros(n,1);
    x(n) = Ab(n,n+1) / Ab(n,n);
    if tampil
        fprintf('  %s = %.4f / %.4f = %.8f\n', nama{n}, Ab(n,n+1), Ab(n,n), x(n));
    end
    for i = n-1:-1:1
        jml = Ab(i,i+1:n) * x(i+1:n);
        x(i) = (Ab(i,n+1) - jml) / Ab(i,i);
        if tampil
            fprintf('  %s = (%.4f - %.6f) / %.4f = %.8f\n', nama{i}, Ab(i,n+1), jml, Ab(i,i), x(i));
        end
    end
end

% ---------------- 2. GAUSS-JORDAN ----------------
function x = m_gauss_jordan(A, b, tampil, nama)
    n = length(b);
    Ab = [A b];
    if tampil
        fprintf('Matriks augmented awal [A | b]:\n');  cetak_aug(Ab);
    end
    for k = 1:n
        [~, idx] = max(abs(Ab(k:n, k)));
        idx = idx + k - 1;
        if idx ~= k
            Ab([k idx], :) = Ab([idx k], :);
            if tampil, fprintf('\n[Pivoting] tukar baris %d <-> baris %d\n', k, idx); end
        end
        if tampil
            fprintf('\n--- Langkah %d : kolom %d ---\n', k, k);
            fprintf('  Normalisasi: R%d <- R%d / %.4f\n', k, k, Ab(k,k));
        end
        Ab(k,:) = Ab(k,:) / Ab(k,k);
        for i = 1:n
            if i ~= k
                f = Ab(i,k);
                Ab(i,:) = Ab(i,:) - f * Ab(k,:);
                Ab(i,k) = 0;
                if tampil
                    fprintf('  R%d <- R%d - (%.4f) * R%d\n', i, i, f, k);
                end
            end
        end
        if tampil
            fprintf('  Matriks setelah langkah %d:\n', k);  cetak_aug(Ab);
        end
    end
    x = Ab(:, n+1);
    if tampil
        fprintf('\nMatriks sudah menjadi [I | x], sehingga solusi = kolom terakhir.\n');
    end
end

% ---------------- 3. LU DOOLITTLE ----------------
function x = m_lu(A, b, tampil, nama)
    n = length(b);
    L = eye(n);
    U = zeros(n);
    for i = 1:n
        for j = i:n
            U(i,j) = A(i,j) - L(i,1:i-1) * U(1:i-1,j);
        end
        for j = i+1:n
            L(j,i) = (A(j,i) - L(j,1:i-1) * U(1:i-1,i)) / U(i,i);
        end
        if tampil
            fprintf('Langkah %d : baris ke-%d dari U dan kolom ke-%d dari L dihitung\n', i, i, i);
        end
    end
    if tampil
        fprintf('\nMatriks L (segitiga bawah, diagonal = 1):\n');  cetak_mat(L);
        fprintf('Matriks U (segitiga atas):\n');                  cetak_mat(U);
        fprintf('Pemeriksaan max|A - L*U| = %.3e\n', max(max(abs(A - L*U))));
        fprintf('\n--- Substitusi maju  L*y = b ---\n');
    end
    y = zeros(n,1);
    for i = 1:n
        y(i) = b(i) - L(i,1:i-1) * y(1:i-1);
        if tampil, fprintf('  y%d = %.8f\n', i, y(i)); end
    end
    if tampil, fprintf('\n--- Substitusi mundur  U*x = y ---\n'); end
    x = zeros(n,1);
    for i = n:-1:1
        x(i) = (y(i) - U(i,i+1:n) * x(i+1:n)) / U(i,i);
        if tampil, fprintf('  %s = %.8f\n', nama{i}, x(i)); end
    end
end

% ---------------- 4. JACOBI ----------------
function [x, iter, ok] = m_jacobi(A, b, maxIter, tol, tampil, nama)
    n = length(b);
    x = zeros(n,1);
    ok = false;
    if tampil
        fprintf('Rumus: x_i(k+1) = ( b_i - sum_{j~=i} a_ij * x_j(k) ) / a_ii\n');
        fprintf('Tebakan awal x(0) = [0 0 0 0 0],  berhenti jika max|x(k+1)-x(k)| < %g\n\n', tol);
        cetak_header_iter(nama);
        cetak_iter(0, x, NaN);
    end
    for iter = 1:maxIter
        xb = x;
        for i = 1:n
            jml = A(i,:) * xb - A(i,i) * xb(i);
            x(i) = (b(i) - jml) / A(i,i);
        end
        galat = max(abs(x - xb));
        if tampil, cetak_iter(iter, x, galat); end
        if galat < tol
            ok = true;
            break;
        end
    end
    if tampil
        if ok
            fprintf('\n>> KONVERGEN pada iterasi ke-%d (galat %.6f < %g)\n', iter, galat, tol);
        else
            fprintf('\n>> BELUM konvergen setelah %d iterasi (galat %.6f)\n', maxIter, galat);
        end
    end
end

% ---------------- 5. GAUSS-SEIDEL ----------------
function [x, iter, ok] = m_gauss_seidel(A, b, maxIter, tol, tampil, nama)
    n = length(b);
    x = zeros(n,1);
    ok = false;
    if tampil
        fprintf('Rumus: x_i(k+1) = ( b_i - sum_{j<i} a_ij*x_j(k+1) - sum_{j>i} a_ij*x_j(k) ) / a_ii\n');
        fprintf('Tebakan awal x(0) = [0 0 0 0 0],  berhenti jika max|x(k+1)-x(k)| < %g\n\n', tol);
        cetak_header_iter(nama);
        cetak_iter(0, x, NaN);
    end
    for iter = 1:maxIter
        xb = x;
        for i = 1:n
            jml = A(i,:) * x - A(i,i) * x(i);
            x(i) = (b(i) - jml) / A(i,i);
        end
        galat = max(abs(x - xb));
        if tampil, cetak_iter(iter, x, galat); end
        if galat < tol
            ok = true;
            break;
        end
    end
    if tampil
        if ok
            fprintf('\n>> KONVERGEN pada iterasi ke-%d (galat %.6f < %g)\n', iter, galat, tol);
        else
            fprintf('\n>> BELUM konvergen setelah %d iterasi (galat %.6f)\n', maxIter, galat);
        end
    end
end

% =====================================================================
%                    FUNGSI BANTU TAMPILAN
% =====================================================================
function garis(c)
    fprintf('%s\n', repmat(c, 1, 78));
end

function cetak_mat(M)
    for i = 1:size(M,1)
        fprintf('   ');
        for j = 1:size(M,2), fprintf('%11.4f', M(i,j)); end
        fprintf('\n');
    end
end

function cetak_aug(Ab)
    n = size(Ab,1);
    for i = 1:n
        fprintf('   ');
        for j = 1:n, fprintf('%11.4f', Ab(i,j)); end
        fprintf('  |%11.4f\n', Ab(i,n+1));
    end
end

function cetak_solusi(x, nama)
    fprintf('\nHimpunan penyelesaian:\n');
    for i = 1:length(x)
        fprintf('   %s = %.8f\n', nama{i}, x(i));
    end
end

function cetak_baris(namaMetode, x)
    fprintf('%-14s', namaMetode);
    for i = 1:length(x), fprintf('%13.7f', x(i)); end
    fprintf('\n');
end

function cetak_header_iter(nama)
    fprintf('%-5s', 'Iter');
    for i = 1:5, fprintf('%12s', nama{i}); end
    fprintf('%14s\n', 'max|dx|');
    fprintf('%s\n', repmat('-', 1, 79));
end

function cetak_iter(k, x, galat)
    fprintf('%-5d', k);
    for i = 1:length(x), fprintf('%12.6f', x(i)); end
    if isnan(galat)
        fprintf('%14s\n', '-');
    else
        fprintf('%14.6f\n', galat);
    end
end

% galat terhadap nilai eksak pada tiap iterasi (untuk Soal 2c)
function g = galat_per_iter(A, b, maxIter, tol, x_eks, jenis)
    n = length(b);
    x = zeros(n,1);
    g = [];
    for k = 1:maxIter
        xb = x;
        for i = 1:n
            if strcmp(jenis, 'jacobi')
                jml = A(i,:) * xb - A(i,i) * xb(i);
            else
                jml = A(i,:) * x - A(i,i) * x(i);
            end
            x(i) = (b(i) - jml) / A(i,i);
        end
        g(end+1) = max(abs(x_eks - x));
        if max(abs(x - xb)) < tol, break; end
    end
end
