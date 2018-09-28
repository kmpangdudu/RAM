using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Web.Services;
using Newtonsoft.Json;

namespace Web.WebServices
{
    /// <summary>
    /// Summary description for MapService
    /// </summary>
    [WebService(Namespace = "http://mainri.servehttp.com/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class MapService : System.Web.Services.WebService
    {

        [WebMethod(MessageName = "Demo_Comsume_WebServices_JSON", Description = "A Demo Comsumes a JSON WebServices")]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string DemoJSON()
        {
            string r = "[{ \"cityid\": 11133, \"ProvinceID\": 6, \"CityName\": \"Tor Bay, NS\" },  { \"cityid\": 11135, \"ProvinceID\": 9, \"CityName\": \"Toronto, ON\" }, { \"cityid\": 11138, \"ProvinceID\": 1, \"CityName\": \"Torrington, AB\" }]";
            return r;
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string getmapen()
        {
            DataSet dsen = new DataSet();
            dsen = (DataSet)Application["mapdataset"];
            //string enAll = "\"Resource\":"
            //        + JsonConvert.SerializeObject(dsen.Tables["tableen"], Formatting.Indented)
            //        ;
            //return enAll;
            return JsonConvert.SerializeObject(dsen.Tables["tableen"], Formatting.Indented);
        }


        [WebMethod]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string getmapenbyCategories(int[] categories)
        {
            DataSet dsen = (DataSet) Application["mapdataset"];;

            string exp = "";
            //exp = "(KHPCategoryID =categories [0] )||(KHPCategoryID =categories [1]  ||( KHPCategoryID =categories [2] ||(KHPCategoryID =categories [3] )||(KHPCategoryID =categories [4] )||(KHPCategoryID =categories [5] )||(KHPCategoryID =categories [6] )||( KHPCategoryID =categories [7] )||(KHPCategoryID =categories [8]) ";
            DataRow[] r;
            List<DataRow> foundRows = new List<DataRow>();
            for (int i =0; i < categories.Length ;i++)
            {
                 r = dsen.Tables["tableen"].Select("KHPCategoryID =" + categories[i]);
                 if (r != null)
                     foreach (DataRow j in r)
                     {
                         foundRows.Add(j);
                     }
            }



            DataTable dt = new DataTable();
            dt.Columns.Add("ETLLoadId", typeof(int));
            dt.Columns.Add("KHPCategoryID", typeof(int));
            dt.Columns.Add("PublicName", typeof(string));
            dt.Columns.Add("AgencyDescription", typeof(string));
            dt.Columns.Add("PhysicalAddress", typeof(string));
            dt.Columns.Add("CityName", typeof(string));
            dt.Columns.Add("Province", typeof(string));
            dt.Columns.Add("PhysicalCountry", typeof(string));
            dt.Columns.Add("PhysicalPostalCode", typeof(string));
            dt.Columns.Add("Latitude", typeof(decimal));
            dt.Columns.Add("Longitude", typeof(decimal));
            dt.Columns.Add("HoursOfOperation", typeof(string));
            dt.Columns.Add("Phone", typeof(string));
            dt.Columns.Add("WebsiteAddress", typeof(string));
            dt.Columns.Add("Eligibility", typeof(string));
            dt.Columns.Add("DisabilitiesAccess", typeof(string));
            dt.Columns.Add("FeeStructureSource", typeof(string));
            dt.Columns.Add("ApplicationProcess", typeof(string));
            dt.Columns.Add("DocumentsRequired", typeof(string));
            dt.Columns.Add("LanguagesOfferedList", typeof(string));
            dt.Columns.Add("LanguageOfRecord", typeof(string));
            dt.Columns.Add("WorkHours", typeof(string));
            dt.Columns.Add("CustomEligibilitybyAge", typeof(string));
            dt.Columns.Add("createdDate", typeof(DateTime));
            dt.Columns.Add("KHPCategory", typeof(string));

            foreach (var itemen in foundRows)
            {
                var row = dt.NewRow();
                row["ETLLoadId"] = itemen.Field<int>("ETLLoadID");
                row["KHPCategoryID"] = itemen.Field<int>("KHPCategoryID");
                row["PublicName"] = itemen.Field<string>("PublicName");
                row["AgencyDescription"] = itemen.Field<string>("AgencyDescription");
                row["PhysicalAddress"] = itemen.Field<string>("PhysicalAddress");
                row["CityName"] = itemen.Field<string>("CityName");
                row["Province"] = itemen.Field<string>("Province");
                row["PhysicalCountry"] = itemen.Field<string>("PhysicalCountry");
                row["PhysicalPostalCode"] = itemen.Field<string>("PhysicalPostalCode");
                row["Latitude"] = itemen.Field<decimal>("Latitude");
                row["Longitude"] = itemen.Field<decimal>("Longitude");
                row["HoursOfOperation"] = itemen.Field<string>("HoursOfOperation");
                row["Phone"] = itemen.Field<string>("Phone");
                row["WebsiteAddress"] = itemen.Field<string>("WebsiteAddress");
                row["Eligibility"] = itemen.Field<string>("Eligibility");
                row["DisabilitiesAccess"] = itemen.Field<string>("DisabilitiesAccess");
                row["FeeStructureSource"] = itemen.Field<string>("FeeStructureSource");
                row["ApplicationProcess"] = itemen.Field<string>("ApplicationProcess");
                row["DocumentsRequired"] = itemen.Field<string>("DocumentsRequired");
                row["LanguagesOfferedList"] = itemen.Field<string>("LanguagesOfferedList");
                row["LanguageOfRecord"] = itemen.Field<string>("LanguageOfRecord");
                row["WorkHours"] = itemen.Field<string>("WorkHours");
                row["CustomEligibilitybyAge"] = itemen.Field<string>("CustomEligibilitybyAge");
                row["createdDate"] = itemen.Field<DateTime>("createdDate");
                row["KHPCategory"] = itemen.Field<string>("KHPCategory");


                dt.Rows.Add(row);
            }


            string encategories = "\"Resource\":"
                    + JsonConvert.SerializeObject(dt, Formatting.Indented)
                    ;

            return encategories;
        }
    }
}
