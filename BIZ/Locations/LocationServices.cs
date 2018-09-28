using DATA.EF;
using System.Collections.Generic;
using System.Linq;

namespace BIZ.Locations
{
    public class LocationServices
    {
        private RAMEntities db = new RAMEntities();
        #region GoogleLocation
            public List<GoogleCityList> GetAllGoogleCitis()
            {
                var response = db.Proc_Get_Google_All_City().ToList();
            //db.Proc_apilog("GET", string.Empty, string.Empty, "all city", "google", string.Empty);

            return response;

            }


            public List<GoogleCityList> GetGoogleCityByProvinceID(int pid)
            {
                var response = db.Proc_Get_Google_City_By_ProvinceID(pid).ToList();
                //db.Proc_apilog("GET", string.Empty, string.Empty, "province city", "google", pid.ToString());

            return response;
            }


            public List<GoogleCityList> GetGoogleCityByCid(int cid)
            {
                var response = db.Proc_Get_Google_City_By_GoogleCityID(cid).ToList();
                //db.Proc_apilog("GET", string.Empty, string.Empty, "the", "google", cid.ToString());

            return response;
            }

            public List<GoogleCityList> GetIncrementGoogleCityList(string gc)
            {
                var response = db.Proc_Increment_Google_City(gc).ToList();
                //db.Proc_apilog("GET", string.Empty, string.Empty, "incerment", "google", gc);

            return response;
            }
        #endregion googleLocation



    }
}