using DATA.EF;
using System.Collections.Generic;
using System.Linq;

namespace BIZ.Search
{
    public class ResourceServices
    {
        private RAMEntities db = new RAMEntities();


        public List<RamResource> GetResourceByKeywords(string keywords, string lang, string token)
        {
            var response = db.Proc_Get_Resource_by_Cluster_Search_Keywords(keywords, lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "keywords", "Resource", keywords);

            return response;

        }

        public List<RamResource> GetAllResources(string token)
        {
            var response = db.Proc_Get_All_RamResource("en", token).ToList();
           // db.Proc_apilog("GET", "en", token, "all", "Resource", string.Empty);

            return response;
        }


        public List<RamResource> GetAllResourcesByLang(string lang, string token)
        {
            var response = db.Proc_Get_All_RamResource_by_Lang(lang , token).ToList();
            //db.Proc_apilog("GET", lang, token, "Language", "Resource", lang);

            return response;
        }

        public RamResource GetResourcesByID(string lang, int rid, string token)
        {
            var response = db.Proc_Get_Resource_by_ID(rid,lang, token).FirstOrDefault();
           // db.Proc_apilog("GET", lang, token, "the", "Resource", rid.ToString());

            return response;
        }


        public List<RamResource> GetResourcesByCity(int cid, string lang, string token)
        {
            List<RamResource> response = new List<RamResource>();
            if (cid > 0)
            { 
                response = db.Proc_Get_Resource_by_City(cid, lang, token).ToList();
                //db.Proc_apilog("GET", lang, token, "city", "Resource", cid.ToString());

                return response;
            }
            else
            {
                //db.Proc_apilog("GET", lang, token, "city", "Resource", cid.ToString());

                return response;
            }
        }


        public List<RamResource> GetResourcesByProvince(int pid, string lang, string token)
        {
            List<RamResource> response = new List<RamResource>();
            if ( (pid > 0) && (pid < 14) )
            {
                response = db.Proc_Get_Resource_by_Province(pid, lang, token).ToList();
                //db.Proc_apilog("GET", lang, token, "Province", "Resource", pid.ToString());

                return response;
            }
            else
            {
                //db.Proc_apilog("GET", lang, token, "Province", "Resource", pid.ToString());

                return response;
            }
        }


        public List<RamResource> GetResourcesBySubCategory(int sid, string lang, string token)
        {
            List<RamResource> response = new List<RamResource>();

            response = db.Proc_Get_Resource_by_SubCategory(sid, lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Subcategory", "Resource", sid.ToString());

            return response;

        }


        public List<RamResource> GetResourcesByTopCategory(int tid, string lang, string token)
        {
            List<RamResource> response = new List<RamResource>();

            response = db.Proc_Get_Resource_by_TopCategory(tid, lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Topcategory", "Resource", tid.ToString());

            return response;

        }



        public List<RamResource> GetResourcesInRadiusList(string lang, decimal latitude, decimal longitude, decimal radius, string token)
        {
            List<RamResource> response = new List<RamResource>();

            response = db.Proc_Get_All_Resources_In_Radius(latitude, longitude, radius, lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Radius", "Resource", string.Empty);

            return response;

        }


        public List<RamResource> GetResourcesInRadiusBoundaryBoxList(string lang, decimal latitude, decimal longitude, decimal radius, string token)
        {
            List<RamResource> response = new List<RamResource>();

            response = db.Proc_Get_All_Resource_In_Radius_boundary_Box(latitude, longitude, radius, lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Box", "Resource", string.Empty);

            return response;

        }


        public List<RamResource> GetUniqueResources(string map, string resourceAgencyNum,int subcategoryid, int topcategoryid,string lang, string token)
        {
            List<RamResource> response = new List<RamResource>();

            response = db.Proc_Get_Unique_Resource(map,resourceAgencyNum,subcategoryid,topcategoryid,lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Unique", "Resource", map + "/" + topcategoryid + "/" + subcategoryid + "/" + resourceAgencyNum + "/" + lang);

            return response;

        }



        public List<RamResource> GetResourceByCoverage(string coverager, string lang, string token)
        {
            List<RamResource> response = new List<RamResource>();
            response = db.Proc_Get_Resource_By_Coverage(coverager, lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Coverage", "Resource", coverager);

            return response;
        }


        public List<RamResource> GetResourceByType(string type, string lang, string token)
        {
            List<RamResource> response = new List<RamResource>();
            response = db.Proc_Get_Resource_by_Classification(type, lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Classification", "Resource", type);

            return response;
        }


    }
}