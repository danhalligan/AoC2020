import numpy as np

f = open('input.txt', 'r')
l = np.array([list(line.rstrip()) for line in f])

def ntrees(r, d):
	x = (0, 0)
	count = 0
	while x[0] < l.shape[0] - 1:
		x = (x[0] + d, (x[1] + r) % l.shape[1])
		if l[x] == "#":
			count = count + 1
	return count

# Part 1
ntrees(3, 1)

# Part 2
np.prod([ntrees(*p) for p in [(1,1), (3,1), (5,1), (7,1), (1,2)]])
