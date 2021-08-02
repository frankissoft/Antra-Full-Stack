using System;

namespace Exercise5
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Binary Triangle");
            Console.WriteLine("Type in the row number: ");
            int rows = Convert.ToInt32(Console.ReadLine());
            Solution solution = new Solution(rows);
            solution.Build();
        }
    }
}
