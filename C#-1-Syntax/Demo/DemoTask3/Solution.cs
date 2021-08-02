using System;
using System.Collections.Generic;
using System.Text;

namespace DemoTask3
{
    class Solution
    {
        public string str;

        public Solution(string initStr)
        {
            str = initStr;
        }

        public void Reverse()
        {
            char temp;
            char[] strAsChars = str.ToCharArray();
            for (int i = 0, j = strAsChars.Length - 1; i < j; i++, j--)
            {
                temp = strAsChars[i];
                strAsChars[i] = strAsChars[j];
                strAsChars[j] = temp;
            }
            string reversedStr = new string(strAsChars);
            Console.WriteLine("Original string: {0} => \nReversed string: {1}", str, reversedStr);
        }
    }
}
