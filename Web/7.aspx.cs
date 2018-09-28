using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.App_Start;
using Web.WebServices;


namespace Web
{
    public partial class _7 : System.Web.UI.Page
    {
        MapService ms = new MapService();
        LQDataContext lq = new LQDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                //this.Hidden1.Value =  JsonConvert.SerializeObject(ms.getmapen(), Formatting.Indented);
                this.Hidden1.Value = JsonConvert.SerializeObject(lq.Proc_Get_All_Pinned("en"), Formatting.Indented);
                //this.cbl.DataSource = lq.getCategories();
                //cbl.DataTextField = "KHPCategory";
                //cbl.DataValueField = "KHPCategoryID";
                //cbl.DataMember = "ImageSrc";
                //cbl.DataBind();

                 
            }
        }

    }
}