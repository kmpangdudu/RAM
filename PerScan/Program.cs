using System;
using System.IO;

namespace PerScan
{
    class Program
    {
        static void Main(string[] args)
        {

            string default_path =  Properties.Settings.Default.default_path; // @"D:\Users\erjun\Documents\Test\RAM\";

            string default_File = Properties.Settings.Default.default_File; // "iCarolExport-KidsHelpPhone-Resources-20160218_085149";

            int default_Col = Properties.Settings.Default.default_Col;  //int default_Col = 181 

            Char errorletter = Convert.ToChar ( Properties.Settings.Default.errorletter);  //errorletter = (char)3

            Char delimiter = Convert.ToChar ( Properties.Settings.Default.delimiter);  //Char delimiter = '|';

            #region codes
            Console.WriteLine("Defult Path = " + default_path);
            Console.WriteLine();
            Console.WriteLine("Defult File = " + default_File);
            Console.WriteLine();
            Console.WriteLine("Defult Columns = "+ default_Col);
            Console.WriteLine();

            //CSV stored path
            Console.WriteLine("File Path to be scanned: ");
            string scanpath = Console.ReadLine();
            default_path = (scanpath == "") ? default_path : scanpath;

            //CSV stored name
            Console.WriteLine("File name to be scanned (no extension): ");
            string scanfile = Console.ReadLine();
            if (scanfile == "") scanfile = default_File;

            //CSV's number os columns
            Console.WriteLine("Known columns of file: ");
            string c = Console.ReadLine();
            default_Col = (c != "") ? default_Col = Convert.ToInt32(c) : default_Col;


            string scanlog = default_path + scanfile + "_PerScan" + ".txt"; // construct the file name for log the scanning result 
            scanfile = default_path + scanfile + ".csv"; // construct the file name for scanning 

            System.IO.StreamWriter file = new System.IO.StreamWriter(scanlog);  // open a file to log the result of scanning
            file.WriteLine(DateTime.Now.ToString("MMMM dd, yyyy  hh:mm:ss")); // write scanning time
            file.WriteLine(scanfile); //write scanned file name
            file.WriteLine("");


            string log = "";
            try
            {

                int i = 0;
                var lines = File.ReadLines(scanfile);

                foreach (var line in lines)
                {
                    String[] substrings = line.Split(delimiter);
                    int errorchar = line.IndexOf(errorletter);
                    if (errorchar != -1)
                    {
                        log = "   Row#: " + i + " ;     ResourceAgencyNum: " + substrings[0] + "            ETX at Col: " + errorchar;
                        Console.WriteLine(log);
                        file.WriteLine(log);
                    }




                    if (substrings.Length != default_Col)
                    {
                        log = "   Row#: " + i + " ;     ResourceAgencyNum: " + substrings[0] + "    Column # : " + substrings.Length;
                        Console.WriteLine(log);
                        file.WriteLine(log);
                    }

                    i++;
                }

                file.Close();
                Console.WriteLine();
                Console.WriteLine("  " + DateTime.Now.ToString("MMMM dd, yyyy  hh:mm:ss"));
                Console.Read();

            }
            catch (Exception e)
            {
                file.WriteLine("The file could not be read:");
                file.WriteLine(e.Message);
                file.WriteLine();
                file.Close();

                Console.WriteLine("The file could not be read:");
                Console.WriteLine(e.Message);
                Console.WriteLine();
                Console.WriteLine("  " + DateTime.Now.ToString("MMMM dd, yyyy  hh:mm:ss"));
                Console.Read();
            }



        #endregion code

        }
    }
}
