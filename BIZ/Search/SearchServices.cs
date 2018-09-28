using DATA.EF;
using System.Collections.Generic;
using System.Linq;

namespace BIZ.Search
{
    public class SearchServices
    {
        private RAMEntities db = new RAMEntities();





        public List<Search_Result> SearchByKeywords(string keywords, string lang, string token)
        {
            var response = db.Proc_Cluster_Search_Short(keywords, lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "keywords", "search ", keywords);

            return response;

        }

        public List<Search_Result> GetResourcesInRadiusList(string lang, decimal latitude, decimal longitude, decimal radius, string token)
        {
            List<Search_Result> response = new List<Search_Result>();

            response = db.Proc_Search_Resources_In_Radius(latitude, longitude, radius, lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Radius", "search ", string.Empty);

            return response;

        }

        public List<Search_Result> GetResourcesInRadiusBoundaryBoxList(string lang, decimal latitude, decimal longitude, decimal radius, string token)
        {
            List<Search_Result> response = new List<Search_Result>();

            response = db.Proc_Search_Resource_In_Radius_boundary_Box(latitude, longitude, radius, lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Box", "search", string.Empty);

            return response;

        }

        public List<Search_Result> GetResourcesByCity(int cid, string lang, string token)
        {
            List<Search_Result> response = new List<Search_Result>();
            if (cid > 0)
            {
                response = db.Proc_Search_Resource_by_City(cid, lang, token).ToList();
                //db.Proc_apilog("GET", lang, token, "city", "search", cid.ToString());

                return response;
            }
            else
            {
                //db.Proc_apilog("GET", lang, token, "city", "search", cid.ToString());

                return response;
            }
        }

        public List<Search_Result> GetResourcesByProvince(int pid, string lang, string token)
        {
            List<Search_Result> response = new List<Search_Result>();
            if ((pid > 0) && (pid < 14))
            {
                response = db.Proc_Search_Resource_by_Province(pid, lang, token).ToList();
                //db.Proc_apilog("GET", lang, token, "Province", "search", pid.ToString());

                return response;
            }
            else
            {
                //db.Proc_apilog("GET", lang, token, "Province", "search", pid.ToString());

                return response;
            }
        }

        public List<Search_Result> GetResourcesBySubCategory(int sid, string lang, string token)
        {
            List<Search_Result> response = new List<Search_Result>();

            response = db.Proc_Search_Resource_by_SubCategory(sid, lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Subcategory", "search", sid.ToString());

            return response;

        }

        public List<Search_Result> GetResourcesByTopCategory(int tid, string lang, string token)
        {
            List<Search_Result> response = new List<Search_Result>();

            response = db.Proc_Search_Resource_by_TopCategory(tid, lang, token).ToList();
            //db.Proc_apilog("GET", lang, token, "Topcategory", "search", tid.ToString());

            return response;

        }


        public List<Search_Result> GetResourcesByCoverage(string coverager, string lang, string token)
        {
            List<Search_Result> response = new List<Search_Result>();
            response = db.Proc_Search_Resource_By_Coverage(coverager, lang, token).ToList();
           // db.Proc_apilog("GET", lang, token, "Coverage", "search", coverager);

            return response;
        }


        public List<SuggestionWords> GetSuggestionWordList()
        {
            List<SuggestionWords> response = new List<SuggestionWords>();

            response = db.Proc_Get_SuggestionWord_List().ToList();
            //db.Proc_apilog("GET", string.Empty, string.Empty, "suggestion", "search", string.Empty);

            return response;

        }


        public List<SuggestionWords> GetIncrementSuggestionWordList(string sw)
        {
            List<SuggestionWords> response = new List<SuggestionWords>();

            response = db.Proc_Increment_Suggestion_Word(sw).ToList();
            //db.Proc_apilog("GET", string.Empty, string.Empty, "IncrementSuggestion", "search", sw);

            return response;

        }
 
    }
}