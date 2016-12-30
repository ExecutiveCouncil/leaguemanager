using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerDB.Clases
{
    public static class RandomGenerator
    {
        public static int RandomNumber(int min, int max)
        {
            Random random = new Random();
            return random.Next(min, max);
        }
    }
}