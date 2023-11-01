
import matplotlib.pyplot as plt
import csv

x = [1, 2, 3] 
y = [0,0,0] 
labels = ["Iris-setosa", "Iris-versicolor", "Iris-virginica"] 

with open('data.csv','r') as csvfile:
    plots = csv.reader(csvfile, delimiter = ',')
    for row in plots:
        if (row[4] == labels[0]):
            y[0] = y[0] + 1
        if (row[4] == labels[1]):
            y[1] = y[1] + 1
        if (row[4] == labels[2]):
            y[2] = y[2] + 1
  
plt.bar(x, y, align='center') 
plt.xticks(x, labels) 
plt.show()