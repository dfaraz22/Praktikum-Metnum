import math

# Nilai x dan nilai eksak
x = 0.3
nilai_eksak = math.exp(x)

print(f"Nilai Eksak e^({x}) = {nilai_eksak:.7f}\n")
print(
    f"{'n':<4} | {'Nilai Hampiran':<15} | {'Galat Mutlak':<15} | {'Galat Relatif (%)':<18}"
)
print("-" * 60)

# Menghitung deret Taylor untuk n = 0, 1, 2, 3, 4
for n in range(5):
    # Rumus Deret Taylor: sum(x^i / i!) dari i=0 sampai n
    hampiran = sum((x**i) / math.factorial(i) for i in range(n + 1))

    # Perhitungan Galat
    galat_mutlak = abs(nilai_eksak - hampiran)
    galat_relatif = (galat_mutlak / nilai_eksak) * 100

    print(
        f"{n:<4} | {hampiran:<15.7f} | {galat_mutlak:<15.7f} | {galat_relatif:<18.5f}%"
    )