using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.App_Start;
using Newtonsoft.Json;


namespace Web
{
    public partial class _1 : System.Web.UI.Page
    {
        LQDataContext lq = new LQDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {


                this.cbl.DataSource = lq.getCategories();
                cbl.DataTextField = "KHPCategory";
                cbl.DataValueField = "KHPCategoryID";
                cbl.DataMember = "ImageSrc";
                cbl.DataBind();

                this.Hidden1.Value = "{\"Resource\":"
                    + JsonConvert.SerializeObject(lq.Proc_Get_All_Pinned("en"), Formatting.Indented)
                    + "}";
            }

        }

        protected void cbl_DataBound(object sender, EventArgs e)
        {
            try
            {
                foreach (ListItem item in cbl.Items)
                {
                    item.Selected = true;
                    item.Text = string.Format("<img src =\"{0}\" /> {1}", this.getImageSrc(item.Text), item.Text);

                }
            }
            catch
            {

            }
        }

        private string getImageSrc(string p)
        {
            return string.Format("/Images/{0}.png", p);
        }

        protected void cbl_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.Hidden1.Value = "";
            string[] c = { "1", "2", "3", "4", "5", "6", "7" ,"8","9"};

            for (int i = 0; i < cbl.Items.Count; i++)
            {
                c[i] = cbl.Items[i].Selected ? (i + 1).ToString() : "0";
            }



            // exec stored procedure [dbo].[GetMapByCategoriesEN] 
             string a = JsonConvert.SerializeObject(lq.getMapByCategoriesEN(
                c[0],c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8]
                ), Formatting.Indented);

            this.Hidden1.Value = "{\"Resource\":" + a  + "}";
        }

         

 
    }
}