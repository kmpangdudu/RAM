using DATA.EF;
using System.Collections.Generic;
using System.Linq;

namespace BIZ.AccessControl
{
    public  class AuthServices
    {
        private  RAMEntities db = new RAMEntities();

        public  List<string> GetAllowIps()
        {
            var response = db.Proc_Get_Allow_IP().ToList();

            return response;
        }

        public List<string> GetBlockedIPs()
        {
            var response = db.Proc_Get_Blocked_IP().ToList();

            return response;
        }

        public  List<string> GetAllowDomains()
        {
            var response = db.Proc_Get_Allow_Domain().ToList();

            return response;
        }
    }
}