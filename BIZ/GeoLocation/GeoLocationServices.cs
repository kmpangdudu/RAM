using DATA.EF;
using System.Collections.Generic;
using System.Linq;
using System.Net;

namespace BIZ.GeoLocation
{
    public class GeoLocationServices
    {
        private RAMEntities db = new RAMEntities();

        public List<geolocation> GetIPCountry(string ip, string token)
        {
            long ipnum = 0;
            ipnum = (long)(uint)IPAddress.NetworkToHostOrder((int)IPAddress.Parse(ip).Address);
            var response = db.Proc_Get_Canadaip(ipnum,token).ToList()  ;
            //db.Proc_apilog("GET", string.Empty, token, "IPlookup", "geolocation", ip);

            return response;
        }
    }
}