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
A = np.zeros((n ** 2, n ** 2))
b = np.zeros(n ** 2)

#logic
for i in range(1, n + 1):
    for j in range(1, n + 1):
        index = (i - 1) * n + (j - 1)

        if i == 1:
            A[index, index] = 1
            b[index] = T_bottom
        elif i == n:
            A[index, index] = 1
            b[index] = T_top
        elif j == 1:
            A[index, index] = 1
            b[index] = T_left
        elif j == n:
            A[index, index] = 1
            b[index] = T_right
        else:
            A[index, i * n + (j - 1)] = n ** 2
            A[index, (i - 2) * n + (j - 1)] = n ** 2
            A[index, (i - 1) * n + j] = n ** 2
            A[index, (i - 1) * n + (j - 2)] = n ** 2
            A[index, index] = -4 * n ** 2

#transform
T = np.linalg.solve(A, b)
T = np.reshape(T, (n, n))

x = np.linspace(0, 1, n)
y = np.linspace(0, 1, n)
X, Y = np.meshgrid(x, y)

#plot
plt.pcolormesh(x, y, T, cmap='coolwarm')
plt.colorbar()
plt.xlabel('X')
plt.ylabel('Y')
plt.title('Temperature Distribution')
plt.show()
