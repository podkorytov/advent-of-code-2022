using Extreme.Mathematics;

public class ThrowItem
{
    public BigInteger Item { get; set; }

    public int MonkeyIndex { get; set; }
}

public class Monkey
{
    public static int BigValue = 0;
    public enum OperationType
    {
        Multiply,
        Add,
        Squaring
    }
    // Auto-implemented properties.
    public int Age { get; set; }
    public int DivisibleNumber { get; set; }

    public int TrueThrowToMonkey { get; set; }
    public int FalseThrowToMonkey { get; set; }

    public Monkey.OperationType operationType { get; set; }
    public int operationValue { get; set; }
    public int inspectionCount { get; set; }

    public List<BigInteger> Items { get; set; }

    public Monkey()
    {
        Items = new List<BigInteger> { };
        inspectionCount = 0;
    }

    public BigInteger processWorryLevel(BigInteger val)
    {
        switch (operationType)
        {
            case Monkey.OperationType.Add:
                val += operationValue;
                break;
            case Monkey.OperationType.Multiply:
                val *= operationValue;
                break;
            case Monkey.OperationType.Squaring:
                val *= val;
                break;
        }
        return val % BigValue;
    }

    public bool testValue(BigInteger value)
    {
        return value % DivisibleNumber == 0;
    }

    public ThrowItem? throwNextItem()
    {
        if (Items.Count > 0)
        {
            var result = new ThrowItem();
            result.Item = processWorryLevel(Items[0]);
            result.MonkeyIndex = testValue(result.Item) ? TrueThrowToMonkey : FalseThrowToMonkey;
            Items.RemoveAt(0);
            inspectionCount++;
            return result;
        }
        else
        {
            return null;
        }
    }

    public void getNewItem(BigInteger item)
    {
        Items.Add(item);
    }

    public void print()
    {
        Console.WriteLine($"Inspection count {inspectionCount}");
        Console.WriteLine($"Has items {Items.Count} with operation {operationType} with value {operationValue}");
        Console.WriteLine($"If divisible by {DivisibleNumber} then throw to {TrueThrowToMonkey} else to {FalseThrowToMonkey}");
        if (Items.Count > 0)
        {
            var ids = String.Join(", ", Items.Select(i => i.ToString()).ToList());
            Console.WriteLine($"Items list {ids}");
        }
        else
        {
            Console.WriteLine($"Items list is EMPTY");
        }
    }
}

class Program
{
    public static void Main(string[] args)
    {
        var watch = new System.Diagnostics.Stopwatch();
        var stepWatch = new System.Diagnostics.Stopwatch();
        watch.Start();

        var monkeys = new List<Monkey> { };
        var buf = new List<String> { };
        foreach (string line in System.IO.File.ReadLines("../inputs/input_day11.txt"))
        {
            if (String.IsNullOrEmpty(line))
            {
                monkeys.Add(CreateMonkey(buf));
                buf.Clear();
            }
            else
            {
                buf.Add(line);
            }
        }
        if (buf.Count > 0)
        {
            monkeys.Add(CreateMonkey(buf));
        }
        // add big part 
        var coof = 1;
        foreach (int d in monkeys.Select(m => m.DivisibleNumber))
        {
            coof *= d;
        }
        Monkey.BigValue = coof;

        // Main circle 
        stepWatch.Start();
        for (var i = 0; i < 10000; i++)
        {
            monkeys.ForEach((monkey) =>
            {
                var throwItem = monkey.throwNextItem();
                while (throwItem is not null)
                {
                    monkeys[throwItem.MonkeyIndex].getNewItem(throwItem.Item);
                    throwItem = monkey.throwNextItem();
                }
            });
        }
        var monkeyInspects = monkeys.Select(m => m.inspectionCount).ToList().OrderByDescending(i => i).ToArray();
        Console.WriteLine(String.Join(", ", monkeyInspects));
        var monkeyBusiness = (BigInteger)monkeyInspects[0] * (BigInteger)monkeyInspects[1];
        Console.WriteLine(monkeyBusiness);

        watch.Stop();
        Console.WriteLine($"Execution Time: {watch.ElapsedMilliseconds} ms");
    }

    public static Monkey CreateMonkey(List<String> data)
    {
        var monkey = new Monkey();
        // add items
        var itemValues = data[1].Split(":")[1].Trim().Split(",");
        foreach (var item in itemValues)
        {
            monkey.Items.Add(Int32.Parse(item));
        }
        // parse operation 
        var operationParts = data[2].Split(":")[1].Trim().Split(" ");
        switch (operationParts[3])
        {
            case "+":
                monkey.operationType = Monkey.OperationType.Add;
                monkey.operationValue = Int32.Parse(operationParts[4]);
                break;
            case "*":
                if (operationParts[4] == "old")
                {
                    monkey.operationType = Monkey.OperationType.Squaring;
                    monkey.operationValue = 1;
                }
                else
                {
                    monkey.operationType = Monkey.OperationType.Multiply;
                    monkey.operationValue = Int32.Parse(operationParts[4]);

                }
                break;
        }
        // parse test
        var testParts = data[3].Split(":")[1].Trim().Split(" ");
        monkey.DivisibleNumber = Int32.Parse(testParts[2]);
        // parse true action
        var trueParts = data[4].Split(":")[1].Trim().Split(" ");
        monkey.TrueThrowToMonkey = Int32.Parse(trueParts[3]);
        // parse true action
        var falseParts = data[5].Split(":")[1].Trim().Split(" ");
        monkey.FalseThrowToMonkey = Int32.Parse(falseParts[3]);

        return monkey;
    }
}
