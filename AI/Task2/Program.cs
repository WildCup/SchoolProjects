using System.Globalization;

var data = File.ReadLines("data.csv").ToList();
var test = File.ReadLines("test.csv").ToList();

for (int i = 0; i < test.Count(); i++)
{
    var lineTest = test[i];
    if (lineTest.EndsWith(",")) lineTest = lineTest.Remove(lineTest.Length - 1);
    var tmp = lineTest.Split(",").Where(s => !string.IsNullOrWhiteSpace(s));
    var numbers = tmp.Select(s => double.Parse(s, CultureInfo.InvariantCulture)).ToArray();

    var result = Classify(numbers, data);
    test[i] = lineTest + "," + result;
}

//save
File.WriteAllLines("test.csv", test);

Console.WriteLine("Write vector of 4 numbers:");
var input = Console.ReadLine();
if (input == null) return;
var tmp2 = input.Split(",").Where(s => !string.IsNullOrWhiteSpace(s));
var numbers2 = tmp2.Select(s => double.Parse(s, CultureInfo.InvariantCulture)).ToArray();
System.Console.WriteLine("result: " + Classify(numbers2, data));


string Classify(double[] numbers, List<string> data)
{
    var result = new (double, string)[3]; //number k = 3

    for (int j = 0; j < data.Count(); j++)
    {
        var lineData = data[j];
        if (lineData.EndsWith(",")) lineData = lineData.Remove(lineData.Length - 1);
        var tmp = lineData.Split(",").Where(s => !string.IsNullOrWhiteSpace(s));
        var answer = tmp.Last();
        var numbersData = tmp.Take(tmp.Count() - 1).Select(s => double.Parse(s, CultureInfo.InvariantCulture)).ToArray();

        double knn = 0;
        for (int k = 0; k < numbers.Length; k++)
            knn += Math.Pow(numbers[k] - numbersData[k], 2);
        knn = Math.Sqrt(knn);

        UpdateResult(result, knn, answer);
    }

    return result.GroupBy<(double, string), string>((x) => x.Item2)
        .OrderByDescending(grp => grp.Count())
        .Select(grp => grp.Key)
        .First();
}

void UpdateResult((double, string)[] result, double knn, string answer)
{
    var added = false;
    for (int k = 0; k < result.Length; k++)
    {
        if (result[k].Item1 == 0)
        {
            result[k].Item1 = knn;
            result[k].Item2 = answer;
            added = true;
            break;
        }
    }
    if (added) return;
    //sort the result
    result.OrderByDescending(r => r.Item1);
    if (knn < result[0].Item1)
    {
        result[0].Item1 = knn;
        result[0].Item2 = answer;
    }
   
}