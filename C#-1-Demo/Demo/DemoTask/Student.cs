using System;
using System.Collections.Generic;
using System.Text;

namespace DemoTask
{
    class Student
    {
        string name, address, mobile;

        public void GetData()
        {
            Console.WriteLine("Enter your name: ");
            name = Console.ReadLine();
            Console.WriteLine("Enter your address: ");
            address = Console.ReadLine();
            Console.WriteLine("Enter your mobile: ");
            mobile = Console.ReadLine();
        }

        public void DisplayData()
        {
            Console.WriteLine("Student Name: " + name);
            Console.WriteLine("Student Address: " + address);
            Console.WriteLine("Student Mobile: " + mobile);
        }
    }
}
