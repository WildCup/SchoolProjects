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
    # Calculate the next step using RK4
    k1_alpha = omega
    k1_omega = -(g/L) * np.sin(alpha)
    k2_alpha = omega + 0.5*dt*k1_omega
    k2_omega = -(g/L) * np.sin(alpha + 0.5*dt*k1_alpha)
    k3_alpha = omega + 0.5*dt*k2_omega
    k3_omega = -(g/L) * np.sin(alpha + 0.5*dt*k2_alpha)
    k4_alpha = omega + dt*k3_omega
    k4_omega = -(g/L) * np.sin(alpha + dt*k3_alpha)
    alpha += (dt/6) * (k1_alpha + 2*k2_alpha + 2*k3_alpha + k4_alpha)
    omega += (dt/6) * (k1_omega + 2*k2_omega + 2*k3_omega + k4_omega)
    t += dt

    potential_energy = g * L * (1 - np.cos(alpha))
    kinetic_energy = 0.5 * L**2 * omega**2
    
    # Store the results
    arr_t.append(t)
    arr_alpha.append(alpha)
    arr_omega.append(omega)
    arr_potential_energy.append(potential_energy)
    arr_kinetic_energy.append(kinetic_energy)
    arr_total_energy.append(potential_energy + kinetic_energy)

# Plot the results
plt.plot(arr_t, arr_kinetic_energy, label='Kinetic')
plt.plot(arr_t, arr_potential_energy, label='Potential')
plt.plot(arr_t, arr_total_energy, label='Total')
plt.ylabel('Energy (J)')
plt.xlabel('Time (s)')
plt.legend()

plt.show()
