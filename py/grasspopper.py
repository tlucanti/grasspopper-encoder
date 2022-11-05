
from functools import reduce
import numpy as np

galois_table = {i: np.load(f'mul{i}.npy') for i in (16, 32, 133, 148, 192, 194, 251)}
galois_table[1] = list(range(256))
keys = np.load('key.npy')
sbox = np.load('sbox.npy')

np.set_printoptions(formatter={'int':lambda a: f'{a:02x}'})

def debug_print(*args):
    print(*args)


def galois_mul(data):
    galois_muls = (148, 32, 133, 16, 194, 192, 1, 251, 1, 192, 194, 16, 133, 32, 148, 1)
    ml = np.array([galois_table[i][x] for i, x in zip(galois_muls, data)])
    return reduce(lambda a, b: a ^ b, ml)


def galois_mul_fast(data):
    galois_muls = (148, 32, 133, 16, 194, 192, 1, 251, 1, 192, 194, 16, 133, 32, 148, 1)
    tbl = np.array([f'{data[b]:X} -> {galois_table[a][data[b]]:X}' for a, b in zip(galois_muls, range(16))])
    # debug_print(f'table: {tbl}')
    # debug_print(f'reduce: {reduce(lambda a, b: a ^ b, tbl):X}')

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
        galois_table[194][data[10]] ^ \
        galois_table[ 16][data[11]] ^ \
        galois_table[133][data[12]] ^ \
        galois_table[ 32][data[13]] ^ \
        galois_table[148][data[14]] ^ \
                          data[15]

    data = np.concatenate(([mul], data[:15]))
    return data


def gp_encode(number):
    d = np.array(list(number.to_bytes(16, 'big')))
    debug_print(f'input:    {d}')
    debug_print()

    for i in range(10):
        d = d ^ keys[i]
        debug_print(f'xor    {i:01}: {d}')

        if i == 9:
            return int.from_bytes(d, 'big')

        d = np.array([sbox[x] for x in d])
        debug_print(f'sbox   {i:01}: {d}')

        for j in range(16):
            d = galois_mul_fast(d)
            print(f'gal {i:01}:{j:02}: {d}')
            # mul = galois_mul(d)
            # d = np.roll(d, 1)
            # d[0] = mul
        debug_print()

print(f'{gp_encode(0x1122334455667700ffeeddccbbaa9988):x}')
#print(f'{gp_encode(0x00112233445566778899AABBCCDDEEFF):x}')
