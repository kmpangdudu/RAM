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
    public partial class _6 : System.Web.UI.Page
    {
        MapService ms = new MapService();
        LQDataContext lq = new LQDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.Hidden1.Value =  ms.getmapen();
                //this.Hidden1.Value = JsonConvert.SerializeObject(lq.getAllMapEN(), Formatting.Indented);


            }
        }
    }
}