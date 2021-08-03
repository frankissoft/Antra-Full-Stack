using System;
using System.Collections.Generic;
using System.Text;

namespace Exercise4
{
    class ArmstrongNumber
    {
        public int lowerBound = 0;                      // default value - lower bound of input pair
        public int upperBound = 1000;                   // default value - upper bound of input pair
        public ArmstrongNumber(int lower, int upper)    // class instance init
        {
            lowerBound = lower;
            upperBound = upper;
        }

        public int[] AllResults()
        {
            List<int> aNums = new List<int>();          // record qualified numbers
            for (int i = lowerBound; i < upperBound; i++)
            {
                if (CubeSum(i) == i) aNums.Add(i);      // qualify
            }
            int[] results = aNums.ToArray();            
            return results;
        }

        public int CubeSum(int num)                     // helper method to qualify armstrong numbers
        {
            int digits = 0;                             // variable to store digits of the number - exponent value
            int temp = num;                             // helper variable to traverse each digit
            while (temp != 0)                           // calculate exponent value
            {
                temp /= 10;
                digits++;
            }
            int cubeSum = 0;
            for (; num != 0; num /= 10)                 // calculate 
            {
                cubeSum += Convert.ToInt32(Math.Pow((num % 10), digits));
            }
            return cubeSum;
        }
    }
}
