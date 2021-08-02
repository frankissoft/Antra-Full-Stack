using System;
using System.Collections.Generic;
using System.Text;

namespace Exercise5
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
            //int zeros = rows / 2;
            //int ones = zeros + 1;
            for (int i = 1; i <= rows; i++)
            {
                for (int j = 1; j <= i; j++)
                {
                    if (j % 2 == 1)
                    {
                        Console.Write(1);
                    } else
                    {
                        Console.Write(0);
                    }
                }
                Console.WriteLine();
            }
        }
    }
}
