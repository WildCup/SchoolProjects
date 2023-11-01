import matplotlib.pyplot as plt
import numpy as np

#const
n = 40
T_left = 100
T_right = 50
T_top = 200
T_bottom = 150

#arr
A = np.zeros((n ** 2, n ** 2))
b = np.zeros(n ** 2)

#logic
for i in range(0, n):
    for j in range(0, n):
        k = i * n + j
        if i == 0:
            A[k, k] = 1
            b[k] = T_bottom
        elif i == n - 1:
            A[k, k] = 1
            b[k] = T_top
        elif j == 0:
            A[k, k] = 1
            b[k] = T_left
        elif j == n - 1:
            A[k, k] = 1
            b[k] = T_right
        else:
            A[k, (i - 1) * n + j] = n ** 2
            A[k, (i + 1) * n + j] = n ** 2
            A[k, i * n + (j - 1)] = n ** 2
            A[k, i * n + (j + 1)] = n ** 2
            A[k, k] = -4 * n ** 2

#transform
T = np.linalg.solve(A, b)
T = np.reshape(T, (n, n))
x = np.linspace(0, 1, n)
y = np.linspace(0, 1, n)
X, Y = np.meshgrid(x, y)

#plot
plt.pcolormesh(x, y, T, cmap='seismic')
plt.colorbar()
plt.xlabel('X')
plt.ylabel('Y')
plt.title('Temperature Distribution')
plt.show()
