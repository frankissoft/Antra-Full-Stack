using System;

namespace Exercise4
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Armstrong Numbers - Type in the numbers: ");
            Console.WriteLine("Type in the first number: ");
            int num1 = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Type in the second number: ");
            int num2 = Convert.ToInt32(Console.ReadLine());

            ArmstrongNumber armstrongNumber = new ArmstrongNumber(num1, num2);
            int[] results = armstrongNumber.AllResults();
            Console.Write("All Results:\n[");
            for (int i = 0; i < results.Length - 1; i++)
            {
                Console.Write("{0} ,", results[i]);
            }
            if (results.Length > 0)
            {
                Console.WriteLine("{0}]", results[results.Length - 1]);
            } else
            {
                Console.WriteLine("]");
            }

        }
    }
}
