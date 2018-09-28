using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Web.App_Start
{
    public class clsDataTable
    {
            DataTable tableen = new DataTable();
            public  clsDataTable ()
            {
                tableen.Columns.Add("ETLLoadId", typeof(int));
                tableen.Columns.Add("KHPCategoryID", typeof(int));
                tableen.Columns.Add("PublicName", typeof(string));
                tableen.Columns.Add("AgencyDescription", typeof(string));
                tableen.Columns.Add("PhysicalAddress", typeof(string));
                tableen.Columns.Add("CityName", typeof(string));
                tableen.Columns.Add("Province", typeof(string));
                tableen.Columns.Add("PhysicalCountry", typeof(string));
                tableen.Columns.Add("PhysicalPostalCode", typeof(string));
                tableen.Columns.Add("Latitude", typeof(decimal));
                tableen.Columns.Add("Longitude", typeof(decimal));
                tableen.Columns.Add("HoursOfOperation", typeof(string));
                tableen.Columns.Add("Phone", typeof(string));
                tableen.Columns.Add("WebsiteAddress", typeof(string));
                tableen.Columns.Add("Eligibility", typeof(string));
                tableen.Columns.Add("DisabilitiesAccess", typeof(string));
                tableen.Columns.Add("FeeStructureSource", typeof(string));
                tableen.Columns.Add("ApplicationProcess", typeof(string));
                tableen.Columns.Add("DocumentsRequired", typeof(string));
                tableen.Columns.Add("LanguagesOfferedList", typeof(string));
                tableen.Columns.Add("LanguageOfRecord", typeof(string));
                tableen.Columns.Add("WorkHours", typeof(string));
                tableen.Columns.Add("CustomEligibilitybyAge", typeof(string));
                tableen.Columns.Add("createdDate", typeof(DateTime));
                tableen.Columns.Add("KHPCategory", typeof(string));
            }
    }
}