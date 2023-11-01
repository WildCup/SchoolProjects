import tkinter as tk

DELAY = 5
GRID_SIZE = 8
cells = [[False]*GRID_SIZE for i in range(GRID_SIZE)]

def handle_button_click(cells, row, col):
	cells[row][col] = not cells[row][col]
	update_button_colors(cells, row, col, "?")

def update_button_colors(cells, row, col, number):
	button = buttons[row][col]
	button.configure(text=f"{number}")
	if cells[row][col]:
		button.configure(bg="green")
	else:
		button.configure(bg="red")

def update_all_button_colors(cells, count):
	for row in range(GRID_SIZE):
		for col in range(GRID_SIZE):
			update_button_colors(cells, row, col, count[row][col])

def logic(cells, min, fine, max):
	count = [[0]*GRID_SIZE for i in range(len(cells[0]))]
	for i in range(GRID_SIZE):
		for j in range(len(cells[0])):
			if not cells[i][j]:
				continue
			if i > 0: #up
				count[i-1][j] += 1
			if i < GRID_SIZE-1: #down
				count[i+1][j] += 1
			if j > 0: #left
				count[i][j-1] += 1
			if j < GRID_SIZE-1: #right
				count[i][j+1] += 1
			if i > 0 and j > 0: #up left
				count[i-1][j-1] += 1
			if i < GRID_SIZE-1 and j < GRID_SIZE-1: #down right
				count[i+1][j+1] += 1
			if i > 0 and j < GRID_SIZE-1: #up right
				count[i-1][j+1] += 1
			if i < GRID_SIZE-1 and j > 0: #down left
				count[i+1][j-1] += 1

	for i in range(GRID_SIZE):
		for j in range(len(cells[0])):
			if count[i][j] < min or count[i][j] > max:
				cells[i][j] = False
			elif count[i][j] == fine:
				cells[i][j] = True
	update_all_button_colors(cells, count)

def live_cycle(cells, countdown_label, seconds_left):
	if seconds_left == 0:
		logic(cells, int(min_input.get()), int(fine_input.get()), int(max_input.get()))
		seconds_left = DELAY
	else:
		seconds_left -= 1
	countdown_label.configure(text=f"Update in {seconds_left}s")
	root.after(1000, live_cycle, cells, countdown_label, seconds_left)
root = tk.Tk()

# Add a label to show the countdown until the next color update
countdown_label = tk.Label(root, text=f"update in 1s")
countdown_label.grid(row=0, column=GRID_SIZE+1, columnspan=2)

# Add an input field for the number of seconds between color updates
min_label = tk.Label(root, text="Min:")
min_label.grid(row=1, column=GRID_SIZE+1)
min_input = tk.Entry(root)
min_input.grid(row=1, column=GRID_SIZE+2, columnspan=1)
min_input.insert(0, "2")

fine_label = tk.Label(root, text="Reproduce:")
fine_label.grid(row=2, column=GRID_SIZE+1)
fine_input = tk.Entry(root)
fine_input.grid(row=2, column=GRID_SIZE+2, columnspan=1)
fine_input.insert(0, "3")

max_label = tk.Label(root, text="Max:")
max_label.grid(row=3, column=GRID_SIZE+1)
max_input = tk.Entry(root)
max_input.grid(row=3, column=GRID_SIZE+2, columnspan=1)
max_input.insert(0, "3")

instruction_label = tk.Label(root, text="CLICK on the grid to make a cell alive")
instruction_label.grid(row=4, column=GRID_SIZE+1)

# Create a 2D list of buttons
buttons = []
for row in range(GRID_SIZE):
	button_row = []
	for col in range(GRID_SIZE):
		button = tk.Button(root, text="", width=3, height=1, bg="red", command=lambda row=row, col=col: handle_button_click(cells, row, col))
		button.grid(row=row, column=col)
		button_row.append(button)
	buttons.append(button_row)

# Start the recurring function to update the colors
root.after(1000, live_cycle, cells, countdown_label, DELAY)
root.mainloop()