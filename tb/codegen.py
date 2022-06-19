
import numpy as np

galois_table = {i: np.load(f'mul{i}.npy') for i in (16, 32, 133, 148, 192, 194, 251)}
galois_table[1] = list(range(256))
keys = np.load('key.npy')
sbox = np.load('sbox.npy')

galois_muls = (148, 32, 133, 16, 194, 192, 1, 251, 1, 192, 194, 16, 133, 32, 148, 1)

def xor_lookup():
	for i in range(len(keys)):
		print(f"4'h{i:X}: data_o <= data_i ^ 255'h{int.from_bytes(keys[i], 'big'):X};")

def sbox_lookup():
	for i in range(len(sbox)):
		print(f"\t8'd{i:03}: sbox_lookup <= 8'h{sbox[i]:02X};")

def sbox_application():
	for i in range(16):
		rng = f'{i * 8 + 7:03}:{i * 8:03}'
		print(f'data[{rng}] <= sbox_lookup(data[{rng}]);')

def galois_lookup(i):
	for j in range(len(galois_table[i])):
		print(f"8'd{j:03}: galois_lookup_{i} <= 8'h{galois_table[i][j]:02X};")

def galois_application():
	rng_fun = lambda i: f'{i * 8 + 7:03}:{i * 8:03}'
	rng = rng_fun(15)
	print(f'data_extra <= galois_lookup_{galois_muls[15]:03}(data[{rng}]);')
	for i in range(1, 16):
		rng = rng_fun(i)
		rng_prev = rng_fun(i - 1)
		if galois_muls[i] == 1:
			print(f'data[{rng}] <=                   data[{rng_prev}];')
		else:
			print(f'data[{rng}] <= galois_lookup_{galois_muls[i - 1]:03}(data[{rng_prev}]);')

	rng = rng_fun(0)
	all_bytes = [f'data[{rng_fun(i)}]' for i in range(1, 16)] + ['data_extra']
	print(f'data[{rng}] <= ' + ' ^ '.join(all_bytes))

if __name__ == '__main__':
	xor_lookup()
