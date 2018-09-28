using DATA.EF;
using System.Collections.Generic;
using System.Linq;

namespace BIZ.Locations
{
    public class CityServices
    {

        private RAMEntities db = new RAMEntities();

        public List<CityList> GetAllCitis(string token)
        {
            var response = db.AllCitiesList(token).ToList();
            //db.Proc_apilog("GET", string.Empty, token, "all", "city", string.Empty);

            return response;

        }

        public List<CityList> GetCityByProvince(int pid, string token)
        {
            var response = db.GetCityByProvince(pid,token).ToList();
            //db.Proc_apilog("GET", string.Empty, token, "province city", "city", pid.ToString());

            return response;
        }


        public CityResult GetCityByCid(int cid, string token)
        {
            var response = db.Get_City_By_CId(cid, token).FirstOrDefault();
            //db.Proc_apilog("GET", string.Empty, token, "the", "city", cid.ToString());

            return response;
        }


        #region Incrementlocation
        public List<CityList> GetIncrementCityLocationList(string cl, string token)
        {
            var response = db.Proc_Increment_Loaction_Search(token, cl).ToList();
            //db.Proc_apilog("GET", string.Empty, token, "incerment", "city", cl);

            return response;
        }
        #endregion Incrementlocation
    }
}