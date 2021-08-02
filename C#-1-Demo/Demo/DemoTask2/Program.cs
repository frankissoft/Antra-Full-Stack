using System;

namespace DemoTask2
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Basic arithmetic calculations: + - * /");
            char sign = 'e';
            do
            {
                Console.WriteLine("Type in the first number: ");
                int num1 = Convert.ToInt32(Console.ReadLine());
                Console.WriteLine("Type in the second number: ");
                int num2 = Convert.ToInt32(Console.ReadLine());
                Arithmetic arithmetic = new Arithmetic(num1, num2);
                Console.WriteLine("Select arithmetic calculation with signs: +, -, *, /");
                sign = Console.ReadLine()[0];
                switch (sign)
                {
                    case '+':
                        Console.WriteLine("{0} {1} {2} = {3}", num1, sign, num2, arithmetic.Addition());
                        break;
                    case '-':
                        Console.WriteLine("{0} {1} {2} = {3}", num1, sign, num2, arithmetic.Subtraction());
                        break;
                    case '*':
                        Console.WriteLine("{0} {1} {2} = {3}", num1, sign, num2, arithmetic.Multiplication());
                        break;
                    case '/':
                        Console.WriteLine("{0} {1} {2} = {3}", num1, sign, num2, arithmetic.Division());
                        break;
                    default:
                        break;

                }
                Console.WriteLine("To continue, press enter. Otherwise, press any key to exit...");
            } while (Console.ReadKey().Key == ConsoleKey.Enter);
            //} while (sign != 'e');
        }
    }
}
