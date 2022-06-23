
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


def galois_mul_fast(data):
    mul = galois_table[148][data[ 0]] ^ \
        galois_table[ 32][data[ 1]] ^ \
        galois_table[133][data[ 2]] ^ \
        galois_table[ 16][data[ 3]] ^ \
        galois_table[194][data[ 4]] ^ \
        galois_table[192][data[ 5]] ^ \
                          data[ 6]  ^ \
        galois_table[251][data[ 7]] ^ \
                          data[ 8]  ^ \
        galois_table[192][data[ 9]] ^ \
        galois_table[ 16][data[11]] ^ \
        galois_table[194][data[10]] ^ \
        galois_table[133][data[12]] ^ \
        galois_table[ 32][data[13]] ^ \
        galois_table[148][data[14]] ^ \
                          data[15]

    data = np.concatenate(([mul], data[:15]))
    return data


def gp_encode(number):
    d = np.array(list(number.to_bytes(16, 'big')))
    
    for i in range(10):
        d = d ^ keys[i]
        if i == 9:
            return int.from_bytes(d, 'big')

        d = np.array([sbox[x] for x in d])

        for j in range(16):
            print(f'gal {i}:{j}: {d}')
            d = galois_mul_fast(d)
            # mul = galois_mul(d)
            # d = np.roll(d, 1)
            # d[0] = mul
        print()

print(f'{gp_encode(0x1122334455667700ffeeddccbbaa9988):x}')
