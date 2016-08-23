using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;
using System.Threading.Tasks;
using System.IO;
using System.Net;
using System.Diagnostics;


    public class clrFunctions
    {

        [Microsoft.SqlServer.Server.SqlProcedure]
        public static void uspDownloadData()
        {
            //Create sql-stock-crawler directory within the C:\ drive 
            //(Future code : pass the directory of where the master database is)
            string dataDirectory = @"C:\sql-stock-crawler\";
            string filename = "data.csv";
            if (!Directory.Exists(dataDirectory))
            {
                Directory.CreateDirectory(dataDirectory);
            }

            var webClient = new WebClient();
            //string url = @"http://ichart.yahoo.com/table.csv?s=SPY&a=0&b=1&c=2009&d=6&e=25&f=2016"; 
            string url = string.Format(@"http://ichart.yahoo.com/table.csv?s={0}&a={1}&b={2}&c={3}&d={4}&e={5}&f={6}", 
            "SPY", "1","1","2009","8","30","2016");
            webClient.DownloadFile(url, dataDirectory + filename);
        }
    }
