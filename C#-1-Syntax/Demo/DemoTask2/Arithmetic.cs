using System;
using System.Collections.Generic;
using System.Text;

namespace DemoTask2
{
    class Arithmetic
    {
        int a, b;

        public Arithmetic(int num1, int num2)
        {
            a = num1;
            b = num2;
        }

        public int Addition()
        {
            return a + b;
        }
        public int Subtraction()
        {
            return a - b;
        }
        public int Multiplication()
        {
            return a * b;
        }
        public int Division()
        {
            return a / b;
        }
    }
}
