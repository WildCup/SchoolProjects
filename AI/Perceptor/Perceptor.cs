class Perceptron {
    private double[] weights;   // weight vector
    private double bias;        // bias term
    private double alpha;       // learning rate

    public Perceptron(double alpha, int numInputs) {
        this.alpha = alpha;
        this.bias = 0;
        this.weights = new double[numInputs];

        // initialize weights randomly
        Random rand = new Random();
        for (int i = 0; i < numInputs; i++) {
            this.weights[i] = rand.NextDouble() * 2 - 1;
        }
    }

    // predict output given an input vector
    public int Predict(double[] input) {
        double net = 0;
        for (int i = 0; i < this.weights.Length; i++) {
            net += this.weights[i] * input[i];
        }
        net -= this.bias;
        return net >= 0 ? 1 : 0;    // apply step function
    }

    // train the perceptron on a dataset
    public void Train(List<Tuple<double[], int>> dataset, double threshold, int maxIterations) {
        int numInputs = this.weights.Length;
        int numSamples = dataset.Count;
        int iterations = 0;
        double error = threshold + 1;

        while (iterations < maxIterations && error > threshold) {
            error = 0;
            for (int i = 0; i < numSamples; i++) {
                double[] input = dataset[i].Item1;
                int expectedOutput = dataset[i].Item2;
                int actualOutput = this.Predict(input);
                int delta = expectedOutput - actualOutput;

                // update weights and bias using delta rule
                for (int j = 0; j < numInputs; j++) {
                    this.weights[j] += this.alpha * delta * input[j];
                }
                this.bias -= this.alpha * delta;

                // accumulate squared error
                error += Math.Pow(delta, 2);
            }
            error /= numSamples;    // calculate mean squared error
            iterations++;
        }
    }
}