cells = [[False]*5 for i in range(5)]
cells[2][2] = True
cells[2][3] = True

def update(cells, min, fine, max):
	count = [[0]*len(cells) for i in range(len(cells[0]))]
	for i in range(len(cells)):
		for j in range(len(cells[0])):
			if not cells[i][j]:
				continue
			if i > 0: #up
					count[i-1][j] += 1
			if i < len(cells)-1: #down
					count[i+1][j] += 1
			if j > 0: #left
					count[i][j-1] += 1
			if j < len(cells)-1: #right
					count[i][j+1] += 1
			if i > 0 and j > 0: #up left
					count[i-1][j-1] += 1
			if i < len(cells)-1 and j < len(cells)-1: #down right
					count[i+1][j+1] += 1
			if i > 0 and j < len(cells)-1: #up right
					count[i-1][j+1] += 1
			if i < len(cells)-1 and j > 0: #down left
					count[i+1][j-1] += 1

	for i in range(len(cells)):
		for j in range(len(cells[0])):
			if count[i][j] < min or count[i][j] > max:
				cells[i][j] = False
			elif count[i][j] == fine:
				cells[i][j] = True


while(True):
	update(cells,2,3,3)