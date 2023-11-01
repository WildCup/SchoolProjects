import random
import threading
import time
import tkinter as tk

# Initialize the grid with default size and all cells set to False (red)
GRID_SIZE = 5
grid = [[False for j in range(GRID_SIZE)] for i in range(GRID_SIZE)]

# Define a function that updates the grid based on the current input values
def update_grid():
    global GRID_SIZE, grid
    # Get the current values of the input fields
    try:
        new_size = int(size_input.get())
        if new_size < 1 or new_size > 10:
            raise ValueError
    except ValueError:
        size_input.delete(0, tk.END)
        size_input.insert(0, str(GRID_SIZE))
        return
    # Update the grid size if it has changed
    if new_size != GRID_SIZE:
        GRID_SIZE = new_size
        grid = [[False for j in range(GRID_SIZE)] for i in range(GRID_SIZE)]
        draw_grid()
    # Redraw the grid to reflect any changes
    draw_grid()

# Define a function that draws the grid based on the current state of the grid array
def draw_grid():
    global GRID_SIZE, grid
    # Remove any existing cells from the grid frame
    for cell in grid_frame.winfo_children():
        cell.destroy()
    # Add a new cell for each element of the grid array
    for i in range(GRID_SIZE):
        for j in range(GRID_SIZE):
            cell = tk.Frame(grid_frame, width=30, height=30, bg="red", bd=1, relief="solid")
            cell.grid(row=i, column=j)
            # Set the background color of the cell based on the corresponding element of the grid array
            if grid[i][j]:
                cell.config(bg="green")
            # Bind a click event to the cell that toggles its state in the grid array
            def toggle_cell(event, i=i, j=j):
                grid[i][j] = not grid[i][j]
                draw_grid()
            cell.bind("<Button-1>", toggle_cell)

# Define a function that updates the grid every second based on some calculation
def update_grid_periodically():
    global grid
    while True:
        # Do some calculation that updates the grid
        for i in range(GRID_SIZE):
            for j in range(GRID_SIZE):
                grid[i][j] = random.choice([True, False])
        # Update the grid
        grid_frame.after(0, draw_grid)
        # Wait for 1 second before doing the calculation again
        time.sleep(1)

# Define a function that updates the loading bar every second
def update_loading_bar():
    while True:
        # Update the loading bar
        loading_bar["value"] = (loading_bar["value"] + 1) % 101
        # Wait for 1 second before updating the loading bar again
        time.sleep(1)

# Create the main window
root = tk.Tk()
root.title("Interactive Grid")

# Create the input fields for the grid size
size_label = tk.Label(root, text="Grid Size:")
size_label.grid(row=0, column=0)
size_input = tk.Entry(root, width=3)
size_input.grid(row=0, column=1)
size_input.insert(0, str(GRID_SIZE))
size_input.bind("<Return>", lambda event: update_grid())

# Create the loading bar
loading_bar = tk.Progressbar(root, length=200, mode="determinate")
loading_bar.grid(row=0, column=2)

# Create the grid frame
grid_frame = Frame(root, bg='black', highlightthickness=1, highlightbackground='white')

# Add the cells to the grid frame
draw_grid()
grid_frame.grid(row=1, column=0, columnspan=3)

# Start a thread to update the grid periodically
grid_thread = threading.Thread(target=update_grid_periodically)
grid_thread.daemon = True
grid_thread.start()

# Start a thread to update the loading bar periodically
loading_thread = threading.Thread(target=update_loading_bar)
loading_thread.daemon = True
loading_thread.start()

# Start the main event loop
root.mainloop()