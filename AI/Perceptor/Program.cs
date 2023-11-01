int length = 4;

var arr1 = new double[] {7.0,3.2,4.7,1.4};
var answer1 = "Iris-versicolor";
var arr2 = new double[] {6.0,3.4,4.5,1.6};
var answer2 = "Iris-versicolor";

// create a training set
var dataset = new List<Tuple<double[], int>>();
dataset.Add(new Tuple<double[], int>(new double[] { 0, 0 }, 0));
dataset.Add(new Tuple<double[], int>(new double[] { 0, 1 }, 1));
dataset.Add(new Tuple<double[], int>(new double[] { 1, 0 }, 1));
dataset.Add(new Tuple<double[], int>(new double[] { 1, 1 }, 1));

// create a perceptron with 2 input nodes and a learning rate of 0.1
Perceptron p = new Perceptron(0.1, 2);

// train the perceptron
p.Train(dataset, 0.01, 1000);

// test the perceptron
Console.WriteLine("0 0 => " + p.Predict(new double[] { 0, 0 }));
Console.WriteLine("0 1 => " + p.Predict(new double[] { 0, 1 }));
Console.WriteLine("1 0 => " + p.Predict(new double[] { 1, 0 }));
Console.WriteLine("1 1 => " + p.Predict(new double[] { 1, 1 }));


double Predict(double[] x, double[] w, double theta)
{
    double net = 0;

    // calculate net input
    for (int i = 0; i < x.Length; i++)
    {
        net += x[i] * w[i];
    }
    net -= theta;

    // apply step function to net input
    double y = (net >= 0) ? 1 : 0;

    return y;
}

void Train(List<Vector> data, Vector vector, double threshold, int maxIterations) {
    int iterations = 0;
    double error = threshold + 1;

    while (iterations < maxIterations && error > threshold) {
        error = 0;
        for (int i = 0; i < dataset.Count; i++) {
            double[] input = dataset[i].Item1;
            int expectedOutput = dataset[i].Item2;
            int actualOutput = Predict(input, perceptron);
            int delta = expectedOutput - actualOutput;

            // update weights and bias using delta rule
            for (int j = 0; j < length; j++) {
                weights[j] += alpha * delta * input[j];
            }
            bias -= alpha * delta;

            // accumulate squared error
            error += Math.Pow(delta, 2);
        }
        error /= dataset.Count;    // calculate mean squared error
        iterations++;
    }
}