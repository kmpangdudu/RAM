using DATA.EF;
using System.Collections.Generic;
using System.Linq;
using System.Web.Caching;

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

        // 2020-11-07 add subset of RAM Resoucre by 4D asked
        public List<SubRamResource> GetAllSubResourcesByLang(string lang, string token)
        {
            var response = db.Proc_Get_All_SubRamResource_by_Lang(lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Language", "Resource", lang);
            return response;
        }

        public RamResource GetResourcesByID(string lang, int rid, string token)
        {
            // rid = ETLLOADID in Table RAMResource
            var response = db.Proc_Get_Resource_by_ID(rid,lang, token).FirstOrDefault();
           // db.Proc_apilog("GET", lang, token, "the", "Resource", rid.ToString());

            return response;
        }
        //2021-03-17
        public SubRamResource Get_Subset_ResourcesByID(string lang, int rid, string token)
        {
            // rid = ETLLOADID in Table RAMResource
            var response = db.Proc_Get_SubResource_by_ID(rid, lang, token).FirstOrDefault();
            // db.Proc_apilog("GET", lang, token, "the", "Resource", rid.ToString());

            return response;
        }

        //2021-03-26
        public V3_Full_Resource Get_full_ResourcesByID(string lang, int rid, string token)
        {
            // rid = ETLLOADID in Table RAMResource
            var response = db.Proc_Get_V3_Resource_by_ID(rid, lang, token).FirstOrDefault();
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

        //2020-12-01 Add
        public List<SubRamResource> GetSubResourcesByCity(int cid, string lang, string token)
        {
            List<SubRamResource> response = new List<SubRamResource>();
            if (cid > 0)
            {
                response = db.Proc_Get_SubResource_by_City(cid, lang, token).ToList();
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

        //2020-12-01 add
        public List<SubRamResource> GetSubResourcesByProvince(int pid, string lang, string token)
        {
            List<SubRamResource> response = new List<SubRamResource>();
            if ((pid > 0) && (pid < 14))
            {
                response = db.Proc_Get_SubResource_by_Province(pid, lang, token).ToList();
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

        //2020-11-20 add for V3 by 4D asked
        public List<SubRamResource> GetSubResourcesBySubCategory(int sid, string lang, string token)
        {
            List<SubRamResource> response = new List<SubRamResource>();

            response = db.Proc_Get_SubResource_by_SubCategory(sid, lang, token).ToList();
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

        //2020-11-20 add for V3 by 4D asked
        public List<SubRamResource> GetSubResourcesByTopCategory(int tid, string lang, string token)
        {
            List<SubRamResource> response = new List<SubRamResource>();

            response = db.Proc_Get_SubResource_by_TopCategory(tid, lang, token).ToList();
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

        //2020-11-08 add
        public List<SubRamResource> GetResourcesInRadiusbyKwsList(string kws, string lang, decimal latitude, decimal longitude, decimal radius, string token)
        {
            List<SubRamResource> response = new List<SubRamResource>();

            response = db.Proc_Search_Sub_Resource_In_circular_by_kws( kws, latitude, longitude, radius, lang, token).ToList();
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

        //2020-12-01
        public List<SubRamResource> Get_subResource_ByCoverage(string coverager, string lang, string token)
        {
            List<SubRamResource> response = new List<SubRamResource>();
            response = db.Proc_Get_SubResource_By_Coverage(coverager, lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Coverage", "Resource", coverager);

            return response;
        }
        //2021-06-13
        public List<SubRamResource> Get_subResource_Helpline(string lang, string token)
        {
            List<SubRamResource> response = new List<SubRamResource>();
            response = db.Proc_Get_SubResource_by_Helpline( lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Coverage", "Resource", coverager);

            return response;
        }



        //2021-01-06
        public List<SubRamResource> Get_subResource_ByPhone(string phone, string lang, string token)
        {
            List<SubRamResource> response = new List<SubRamResource>();
            response = db.Proc_Get_SubResource_by_Phone(phone, lang, token).ToList();
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

        //2020-11-30 Added for construct APIlog Keywords
        // input a ETLLoadID , return a keywords for APIlog "TID/Language/ResourceAgencyNum/Map/SID"

        public string constructKeywords(int ETLLoadID)
        {
            string keywords = "";
            keywords = db.Proc_Construct_APIlogKeywords_by_ETLLoadid(ETLLoadID).First();
           


            return keywords;
        }


    }
}