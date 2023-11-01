import matplotlib.pyplot as plt
import numpy as np

#const
g = 9.81  # m/s^2
L = 1.0   # m
alpha = np.pi / 3.0  # rad
omega = 0.0  # rad per second
t = 0.0  # s
dt = 0.01

# arrays for graphs
arr_t = []
arr_alpha = []
arr_omega = []
arr_potential_energy = []
arr_kinetic_energy = []
arr_total_energy = []

while t < 10:
    # improved Euler method
    alpha_mid = alpha + 0.5 * omega * dt
    omega_mid = omega - 0.5 * g / L * np.sin(alpha) * dt
    alpha = alpha + omega_mid * dt
    omega = omega - g / L * np.sin(alpha_mid) * dt

    potential_energy = g * L * (1 - np.cos(alpha))
    kinetic_energy = 0.5 * L**2 * omega**2

    # Append the new values to the arrays
    t += dt
    arr_t.append(t)
    arr_alpha.append(alpha)
    arr_omega.append(omega)
    arr_potential_energy.append(potential_energy)
    arr_kinetic_energy.append(kinetic_energy)
    arr_total_energy.append(potential_energy + kinetic_energy)

# Plot the results
plt.plot(arr_t, arr_potential_energy, label='Potential energy')
plt.plot(arr_t, arr_kinetic_energy, label='Kinetic energy')
plt.plot(arr_t, arr_total_energy, label='Total energy')
plt.xlabel('Time (s)')
plt.ylabel('Energy (J)')
plt.legend()
plt.show()