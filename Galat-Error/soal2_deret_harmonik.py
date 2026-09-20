import numpy as np

# Total suku N = 20
N = 20

# --------------------------------------------------
# a. Perhitungan Secara Eksak (Nilai Referensi)
# --------------------------------------------------
# Dihitung dengan presisi bawaan Python (float 64-bit)
eksak = sum(1 / i for i in range(1, N + 1))


# --------------------------------------------------
# b. Masing-masing Pembagian Dibulatkan (misal: 3 desimal)
# --------------------------------------------------
desimal = 3
hasil_b = sum(round(1 / i, desimal) for i in range(1, N + 1))
galat_b = abs(eksak - hasil_b)


# --------------------------------------------------
# c. Tanpa Looping (Menggunakan fungsi sum dari NumPy)
# --------------------------------------------------
# Membuat array [1, 2, ..., 20] dan membagi 1 dengan array tersebut
suku_array = 1 / np.arange(1, N + 1)
hasil_c = np.sum(suku_array)
galat_c = abs(eksak - hasil_c)


# --------------------------------------------------
# Cetak Hasil Perbandingan
# --------------------------------------------------
print(f"a. Perhitungan Eksak           : {eksak:.7f}")
print(
    f"b. Dibulatkan ({desimal} desimal)    : {hasil_b:.7f} | Galat: {galat_b:.7f}"
)
print(
    f"c. Tanpa Looping (np.sum)      : {hasil_c:.7f} | Galat: {galat_c:.2e}"
)