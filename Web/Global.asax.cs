using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Linq;
using System.Web;
using Web.App_Start;

namespace Web
{
    public class Global : HttpApplication
    {
//        void Application_Start(object sender, EventArgs e)
//        {
//            DataSet mapDs = new DataSet();
//            // Code that runs on application startup
//            LQDataContext lq = new LQDataContext();
//            ISingleResult<Proc_Get_All_PinnedResult> resultEN = lq.Proc_Get_All_Pinned("en");
//            ISingleResult<Proc_Get_All_PinnedResult> resultFR = lq.Proc_Get_All_Pinned("fr");



//DataTable Map_en = createTableCol ();
//            foreach (Proc_Get_All_PinnedResult itemen in resultEN)
//            {
//                DataRow rowen = Map_en.NewRow();
//                rowen["ETLLoadId"] = itemen.ETLLoadID;
//                rowen["SubCategoryID"] = itemen.SubCategoryID;
//                rowen["SubCategory"] = itemen.SubCategory;
//                rowen["TopCategoryID"] = itemen.TopCategoryID;
//                rowen["TopCategory"] = itemen.TopCategory;
//                rowen["PublicName"] = itemen.PublicName;
//                rowen["AgencyDescription"] = itemen.AgencyDescription;
//                rowen["PhysicalAddress"] = itemen.PhysicalAddress;
//                rowen["PhysicalCityID"] = itemen.PhysicalCityID;
//                rowen["CityName"] = itemen.PhysicalCity;
//                rowen["PhysicalProvinceID"] = itemen.PhysicalProvinceID;
//                rowen["Province"] = itemen.PhysicalProvince;
//                rowen["PhysicalCountry"] = itemen.PhysicalCountry;
//                rowen["PhysicalPostalCode"] = itemen.PhysicalPostalCode;
//                rowen["Latitude"] = itemen.Latitude;
//                rowen["Longitude"] = itemen.Longitude;
//                rowen["HoursOfOperation"] = itemen.HoursOfOperation;
//                rowen["Phone"] = itemen.Phone;
//                rowen["WebsiteAddress"] = itemen.WebsiteAddress;
//                rowen["Eligibility"] = itemen.Eligibility;
//                rowen["DisabilitiesAccess"] = itemen.DisabilitiesAccess;
//                rowen["FeeStructureSource"] = itemen.FeeStructureSource;
//                rowen["ApplicationProcess"] = itemen.ApplicationProcess;
//                rowen["DocumentsRequired"] = itemen.DocumentsRequired;
//                rowen["LanguagesOfferedList"] = itemen.LanguagesOfferedList;
//                rowen["LanguageOfRecord"] = itemen.LanguageOfRecord;
//                rowen["WorkHours"] = itemen.WorkHours;
//                rowen["CustomEligibilitybyAge"] = itemen.CustomEligibilitybyAge;
//                rowen["createdDate"] = itemen.createdDate;


//                Map_en.Rows.Add(rowen);
//            }
//            mapDs.Tables.Add(Map_en);
//            mapDs.Tables[0].TableName = "Map_en";

//            DataTable Map_fr = createTableCol();
//            foreach (Proc_Get_All_PinnedResult itemfr in resultFR)
//            {
//                DataRow rowfr = Map_fr.NewRow();
//                rowfr["ETLLoadId"] = itemfr.ETLLoadID;
//                rowfr["SubCategoryID"] = itemfr.SubCategoryID;
//                rowfr["SubCategory"] = itemfr.SubCategory;
//                rowfr["TopCategoryID"] = itemfr.TopCategoryID;
//                rowfr["TopCategory"] = itemfr.TopCategory;
//                rowfr["PublicName"] = itemfr.PublicName;
//                rowfr["AgencyDescription"] = itemfr.AgencyDescription;
//                rowfr["PhysicalAddress"] = itemfr.PhysicalAddress;
//                rowfr["PhysicalCityID"] = itemfr.PhysicalCityID;
//                rowfr["CityName"] = itemfr.PhysicalCity;
//                rowfr["PhysicalProvinceID"] = itemfr.PhysicalProvinceID;
//                rowfr["Province"] = itemfr.PhysicalProvince;
//                rowfr["PhysicalCountry"] = itemfr.PhysicalCountry;
//                rowfr["PhysicalPostalCode"] = itemfr.PhysicalPostalCode;
//                rowfr["Latitude"] = itemfr.Latitude;
//                rowfr["Longitude"] = itemfr.Longitude;
//                rowfr["HoursOfOperation"] = itemfr.HoursOfOperation;
//                rowfr["Phone"] = itemfr.Phone;
//                rowfr["WebsiteAddress"] = itemfr.WebsiteAddress;
//                rowfr["Eligibility"] = itemfr.Eligibility;
//                rowfr["DisabilitiesAccess"] = itemfr.DisabilitiesAccess;
//                rowfr["FeeStructureSource"] = itemfr.FeeStructureSource;
//                rowfr["ApplicationProcess"] = itemfr.ApplicationProcess;
//                rowfr["DocumentsRequired"] = itemfr.DocumentsRequired;
//                rowfr["LanguagesOfferedList"] = itemfr.LanguagesOfferedList;
//                rowfr["LanguageOfRecord"] = itemfr.LanguageOfRecord;
//                rowfr["WorkHours"] = itemfr.WorkHours;
//                rowfr["CustomEligibilitybyAge"] = itemfr.CustomEligibilitybyAge;
//                rowfr["createdDate"] = itemfr.createdDate;

//                Map_fr.Rows.Add(rowfr);
//            }
//            mapDs.Tables.Add(Map_fr);
//            mapDs.Tables[1].TableName = "Map_fr";



//            Application["mapdataset"] = mapDs;
  
//        }

//        public DataTable createTableCol ()
//        {
//            DataTable result = new DataTable();

//            result.Columns.Add("ETLLoadId", typeof(int));
//            result.Columns.Add("ResourceAgencyNum", typeof(string));
//            result.Columns.Add("Map", typeof(bool));
//            result.Columns.Add("SubCategoryID", typeof(int));
//            result.Columns.Add("SubCategory", typeof(string));
//            result.Columns.Add("TopCategoryID", typeof(int));
//            result.Columns.Add("TopCategory", typeof(string));
//            result.Columns.Add("PublicName", typeof(string));
//            result.Columns.Add("AgencyDescription", typeof(string));
//            result.Columns.Add("PhysicalAddress", typeof(string));
//            result.Columns.Add("PhysicalCityID", typeof(int));
//            result.Columns.Add("CityName", typeof(string));
//            result.Columns.Add("PhysicalProvinceID", typeof(int));
//            result.Columns.Add("Province", typeof(string));
//            result.Columns.Add("PhysicalCountry", typeof(string));
//            result.Columns.Add("PhysicalPostalCode", typeof(string));
//            result.Columns.Add("Latitude", typeof(decimal));
//            result.Columns.Add("Longitude", typeof(decimal));
//            result.Columns.Add("HoursOfOperation", typeof(string));
//            result.Columns.Add("Phone", typeof(string));
//            result.Columns.Add("WebsiteAddress", typeof(string));
//            result.Columns.Add("Eligibility", typeof(string));
//            result.Columns.Add("DisabilitiesAccess", typeof(string));
//            result.Columns.Add("FeeStructureSource", typeof(string));
//            result.Columns.Add("ApplicationProcess", typeof(string));
//            result.Columns.Add("DocumentsRequired", typeof(string));
//            result.Columns.Add("LanguagesOfferedList", typeof(string));
//            result.Columns.Add("LanguageOfRecord", typeof(string));
//            result.Columns.Add("WorkHours", typeof(string));
//            result.Columns.Add("CustomEligibilitybyAge", typeof(string));
//            result.Columns.Add("createdDate", typeof(DateTime));

//            return result;
//        }


        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

        }
    }
}
