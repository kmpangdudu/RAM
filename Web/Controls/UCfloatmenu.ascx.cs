using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class UCfloatmenu : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ibtnMap_Click(object sender, ImageClickEventArgs e)
        {
            //Server.Transfer("13.aspx");
             //Response.Redirect("13.aspx");
        }

        protected void ibtnShelter_Click(object sender, ImageClickEventArgs e)
        {
            //Server.Transfer("15.aspx");
            //Response.Redirect("15.aspx");
        }

        protected void ibtnPW_Click(object sender, ImageClickEventArgs e)
        {
            //Server.Transfer("14.aspx");
            //Response.Redirect("14.aspx");
        }
    }
}