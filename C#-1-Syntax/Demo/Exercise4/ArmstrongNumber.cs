using System;
using System.Collections.Generic;
using System.Text;

namespace Exercise4
{
    class ArmstrongNumber
    {
        public int lowerBound = 0;
        public int upperBound = 1000;
        public ArmstrongNumber(int lower, int upper)
        {
            lowerBound = lower;
            upperBound = upper;
        }

        public int[] AllResults()
        {
            List<int> aNums = new List<int>();
            for (int i = lowerBound; i < upperBound; i++)
            {
                if (CubeSum(i) == i) aNums.Add(i);
            }
            int[] results = aNums.ToArray();
            return results;
        }

        public int CubeSum(int num)
        {
            int digits = 0;
            int temp = num;
            while (temp != 0)
            {
                temp /= 10;
                digits++;
            }
            int cubeSum = 0;
            for (; num != 0; num /= 10)
            {
                cubeSum += Convert.ToInt32(Math.Pow((num % 10), digits));
            }
            return cubeSum;
        }
    }
}
