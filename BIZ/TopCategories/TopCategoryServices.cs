using DATA.EF;
using System.Collections.Generic;
using System.Linq;
//using MyResult = DATA.EF.Proc_Get_TopCategory_Result;

namespace BIZ.TopCategories
{
    public class TopCategoryServices
    {
        private RAMEntities db = new RAMEntities();



        public List<TopCategoryList> GetAllTopCategories(string lang, string token)
        {
            var response = db.Proc_Get_TopCategory(lang,token).ToList();
            //db.Proc_apilog("GET", lang, token, "all", "Topcategory", string.Empty);

            return response;
        }

        public TopCategoryList GetTopCategoryByID(string lang, int tid, string token)
        {
            var response = db.Proc_TopCategory_by_ID(tid,lang, token).FirstOrDefault();
            //db.Proc_apilog("GET", lang, token, "the", "Topcategory", tid.ToString());

            return response;
        }

    }
}