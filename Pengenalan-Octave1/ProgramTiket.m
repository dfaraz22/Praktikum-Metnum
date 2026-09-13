x = input('Masukkan umur pengunjung (Tahun): ');
if(x > 70)
    fprintf('Maaf, batas maksimum umur menonton adalah 70 tahun\n');
elseif(x < 12)
    fprintf('Maaf, batas minimal umur menonton bioskop ini adalah 12 tahun\n');
else
    fprintf('1. Reguler Studio\n2. Sweetbox 2D\n3. Velvet Class VIP\n');
    y = input('Tentukan pilihan studio: ');
    switch(y)
        case 1
            z = 50000;
            fprintf('Harga tiket Reguler Studio: Rp%g\n', z);
        case 2
            z = 75000;
            fprintf('Harga tiket Sweetbox 2D: Rp%g\n', z);
        case 3
            z = 120000;
            fprintf('Harga tiket Velvet Class VIP: Rp%g\n', z);
        otherwise
            fprintf('Pilihan studio tidak ada!\n');
    end
end
