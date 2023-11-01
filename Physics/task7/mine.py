import matplotlib.pyplot as plt
import numpy as np

#const
n = 40
h = 1 / n
T_left = 100
T_right = 50
T_top = 200
T_bottom = 150

#arr
A = np.zeros((n * 2, n * 2))

for i in range(0, n):
    for j in range(0, n):
        index = i  + j
        if i == 0:
            A[i, j] = T_top
        elif i == n - 1:
            A[i, j] = T_bottom
        elif j == 0:
            A[i, j] = T_left
        elif j == n - 1:
            A[i, j] = T_right
        else:
            A[i, j] = (A[i-1, j] + A[i+1, j] + A[i, j-1] + A[i, j+1]) / 4

#plot
plt.imshow(A)
plt.colorbar()
plt.show()