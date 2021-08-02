using System;
using System.Collections.Generic;
using System.Text;

namespace Exercise6
{
    class Solution
    {
        public int rows;
        public Solution(int rowNum)
        {
            rows = rowNum;
        }

        public void Build()
        {
            int trueRows = rows * 2 - 1;
            for (int i = 1; i <= trueRows; i++)
            {
                for (int j = 1; j <= Math.Abs(rows - i); j++)
                {
                    Console.Write(' ');
                }
                for (int k = 1; k <= 2 * (rows - Math.Abs(rows - i)) - 1; k++)
                {
                    Console.Write('*');
                }
                Console.WriteLine();
            }
        }
    }
}
