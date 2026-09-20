import math

# Nilai x dan nilai eksak
x = 1
nilai_eksak = math.sin(x)

print(f"Nilai Eksak sin({x}) = {nilai_eksak:.10f}\n")
print(
    f"{'N':<4} | {'Nilai Hampiran':<15} | {'Galat Mutlak':<15} | {'Galat Relatif (%)':<18}"
)
print("-" * 60)

# Menghitung deret Taylor untuk N = 1, 2, 3, 4, 5
for N in range(1, 6):
    # Rumus Deret Taylor sin(x): sum((-1)^n * x^(2n+1) / (2n+1)!) dari n=0 sampai N
    hampiran = sum(
        ((-1) ** n) * (x ** (2 * n + 1)) / math.factorial(2 * n + 1)
        for n in range(N + 1)
    )

    # Perhitungan Galat
    galat_mutlak = abs(nilai_eksak - hampiran)
    galat_relatif = (galat_mutlak / nilai_eksak) * 100

    print(
        f"{N:<4} | {hampiran:<15.7f} | {galat_mutlak:<15.7f} | {galat_relatif:<18.5f}%"
    )