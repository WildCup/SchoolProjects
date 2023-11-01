System.Console.WriteLine(CalculateSin(0)); //0
System.Console.WriteLine(CalculateSin(Math.PI / 2)); //1
System.Console.WriteLine(CalculateSin(Math.PI / 6)); //0.5
System.Console.WriteLine(CalculateSin(2 * Math.PI)); //0

static double CalculateSin(double x)
{
    double sinx = 0;
    x = x % (2 * Math.PI);
    for (int i = 0; i < 10; i++)
        sinx += Math.Pow(-1, i) * Math.Pow(x, 2 * i + 1) / Factorial(2 * i + 1);
    return sinx;
}

static int Factorial(int x)
{
    int result = 1;
    for (int i = 1; i <= x; i++)
        result *= i;

    return result;
}