
from functools import reduce
import numpy as np

galois_table = {i: np.load(f'mul{i}.npy') for i in (16, 32, 133, 148, 192, 194, 251)}
galois_table[1] = list(range(256))
keys = np.load('key.npy')
sbox = np.load('sbox.npy')


def galois_mul(data):
    galois_muls = (148, 32, 133, 16, 194, 192, 1, 251, 1, 192, 194, 16, 133, 32, 148, 1)
    ml = np.array([galois_table[i][x] for i, x in zip(galois_muls, data)])
    return reduce(lambda a, b: a ^ b, ml)


def gp_encode(number):
    d = np.array(list(number.to_bytes(16, 'big')))
    
    for i in range(10):
        d = d ^ keys[i]
        if i == 9:
            return int.from_bytes(d, 'big')

        d = np.array([sbox[x] for x in d])

        for j in range(16):
            mul = galois_mul(d)
            d = np.roll(d, 1)
            d[0] = mul

print(f'{gp_encode(0x1122334455667700ffeeddccbbaa9988):x}')
