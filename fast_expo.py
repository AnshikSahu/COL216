def exponentiation(x, n):
    if n == 0:
        return 1
    t0 = n & 0x01
    n >>= 1
    s0 = x
    x *= x
    res = exponentiation(x, n)
    if t0 == 1:
        res *= s0
    return res

x = int(input("Enter x: "))
n = int(input("Enter n: "))
result = exponentiation(x, n)
print("Result:", result)
