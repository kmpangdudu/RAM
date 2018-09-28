using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.App_Start;

namespace Web.Squad
{
    public partial class Default : System.Web.UI.Page
    {
        LQDataContext lq = new LQDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // Phone and Web dropdown
                PWInitDDL();
                PWResource(0);

                //shelter dropdown
                ShelterInitDDL();
                ShelterResource(0);


            }//ispostback
        }//pageload

        void PWInitDDL()
        {
            ddlProvince.DataSource = lq.getProvince_EN();
            ddlProvince.DataTextField = "Province";
            ddlProvince.DataValueField = "ProvinceID";
            ddlProvince.DataBind();

            ddlCity.DataSource = lq.GetCityAll();
            ddlCity.DataTextField = "CityName";
            ddlCity.DataValueField = "CityId";
            ddlCity.DataBind();
        }


        void resetPWPanelVisible()
        {
            PanelDistress.Visible = false;
            PanelDrugs.Visible = false;
            PanelHousing.Visible = false;
            PanelLegal.Visible = false;
            Panellgbt.Visible = false;
            PanelSexual.Visible = false;
            PanelShelters.Visible = false;
            PanelViolence.Visible = false;
            PanelCounselling.Visible = false;

            gvpwCounselling.DataSource = null;
            gvpwDistress.DataSource = null;
            gvpwDrugs.DataSource = null;
            gvpwHousing.DataSource = null;
            gvpwLegal.DataSource = null;
            gvpwlgbt.DataSource = null;
            gvpwSexual.DataSource = null;
            gvpwShelters.DataSource = null;
            gvpwViolence.DataSource = null;

            gvpwCounselling.DataBind();
            gvpwDistress.DataBind();
            gvpwDrugs.DataBind();
            gvpwHousing.DataBind();
            gvpwLegal.DataBind();
            gvpwlgbt.DataBind();
            gvpwSexual.DataBind();
            gvpwShelters.DataBind();
            gvpwViolence.DataBind();
        }
        void resetShelterPanelVisible()
        {


            Panel_S_Distress.Visible = false;
            Panel_S_Drugs.Visible = false;
            Panel_S_Housing.Visible = false;
            Panel_S_Legal.Visible = false;
            Panel_S_lgbt.Visible = false;
            Panel_S_Sexual.Visible = false;
            Panel_S_Shelters.Visible = false;
            Panel_S_Violence.Visible = false;
            Panel_S_Counselling.Visible = false;

           
            gv_S_Distress.DataSource = null;
            gv_S_Drugs.DataSource = null;
            gv_S_Housing.DataSource = null;
            gv_S_Legal.DataSource = null;
            gv_S_LGBT.DataSource = null;
            gv_S_Sexual.DataSource = null;
            gv_S_Shelters.DataSource = null;
            gv_S_Violence.DataSource = null;
            gv_S_Counselling.DataSource = null;

            gv_S_Distress.DataBind();
            gv_S_Drugs.DataBind();
            gv_S_Housing.DataBind();
            gv_S_Legal.DataBind();
            gv_S_LGBT.DataBind();
            gv_S_Sexual.DataBind();
            gv_S_Shelters.DataBind();
            gv_S_Violence.DataBind();
            gv_S_Counselling.DataBind();
   
        }


        void PWResource(int CityID)
        {
            resetPWPanelVisible();
            //PW  Distress
            var distress = lq.getPWByCityIDCateID(1, CityID, 1, "en").ToList(); ;
            //ISingleResult<getPWNameByCityIDCateIDResult> distress = lq.getPWNameByCityIDCateID(0, 0, 1, "en").ToList();
            if (distress.Count() > 0)
            {
                PanelDistress.Visible = true;
                gvpwDistress.DataSource = distress;
                gvpwDistress.DataBind();
                lblDistressNum.Text = distress.Count() + "";
            }



            //PW Sexual
            var sexual = lq.getPWByCityIDCateID(1, CityID, 2, "en").ToList();
            if (sexual.Count() > 0)
            {
                PanelSexual.Visible = true;
                gvpwSexual.DataSource = sexual;
                gvpwSexual.DataBind();
                lblSexualNum.Text = sexual.Count() + "";
            }
           

            //PW LGBT
            var lgbt = lq.getPWByCityIDCateID(1, CityID, 3, "en").ToList();
            if (lgbt.Count() > 0)
            {
                Panellgbt.Visible = true;
                gvpwlgbt.DataSource = lgbt;
                gvpwlgbt.DataBind();
                lbllgbtNum.Text = lgbt.Count() + "";
            }
 

            //Legal
            var legal = lq.getPWByCityIDCateID(1, CityID, 4, "en").ToList();
            if (legal.Count() > 0)
            {
                PanelLegal.Visible = true;
                gvpwLegal.DataSource = legal;
                gvpwLegal.DataBind();
                lblLegalNum.Text = legal.Count() + "";
            }


            //Shelters
            var shelters = lq.getPWByCityIDCateID(1, CityID, 5, "en").ToList();
            if (shelters.Count() > 0)
            {
                PanelShelters.Visible = true;
                gvpwShelters.DataSource = shelters;
                gvpwShelters.DataBind();
                lblSheltersNum.Text = shelters.Count() + "";
            }
 

            //Housing
            var housing = lq.getPWByCityIDCateID(1, CityID, 6, "en").ToList();
            if (housing.Count() > 0)
            {
                PanelHousing.Visible = true;
                gvpwHousing.DataSource = housing;
                gvpwHousing.DataBind();
                lblHousingNum.Text = housing.Count() + "";
            }
 

            //Counselling
            var counselling = lq.getPWByCityIDCateID(1, CityID, 7, "en").ToList();
            if (counselling.Count() > 0)
            {
                PanelCounselling.Visible = true;
                gvpwCounselling.DataSource = counselling;
                gvpwCounselling.DataBind();
                lblCounsellingNum.Text = counselling.Count() + "";
            }
 

            //Violence
            var violence = lq.getPWByCityIDCateID(1, CityID, 8, "en").ToList();
            if (violence.Count() > 0)
            {
                PanelViolence.Visible = true;
                gvpwViolence.DataSource = violence;
                gvpwViolence.DataBind();
                lblViolenceNum.Text = violence.Count() + "";
            }
  

            //Drugs
            var drug = lq.getPWByCityIDCateID(1, CityID, 9, "en").ToList();
            if (drug.Count() > 0)
            {
                PanelDrugs.Visible = true;
                gvpwDrugs.DataSource = drug;
                gvpwDrugs.DataBind();
                lblDrugsNum.Text = drug.Count() + "";
            }
  

            lblPWTotalNum.Text = distress.Count() + sexual.Count() + lgbt.Count() + legal.Count()
                + shelters.Count() + housing.Count() + counselling.Count() + violence.Count()
                + drug.Count() + "";
        }

        void ShelterInitDDL()
        {
            ddlProvince_S.DataSource = lq.getProvince_EN();
            ddlProvince_S.DataTextField = "Province";
            ddlProvince_S.DataValueField = "ProvinceID";
            ddlProvince_S.DataBind();

            ddlCity_S.DataSource = lq.GetCityAll();
            ddlCity_S.DataTextField = "CityName";
            ddlCity_S.DataValueField = "CityId";
            ddlCity_S.DataBind();
        }

        void ShelterResource(int CithID)
        {
            resetShelterPanelVisible();
            //Shelter  Distress
            var distress = lq.getShelterByCityIDCateID(1, CithID, 1, "en").ToList(); ;
            //ISingleResult<getPWNameByCityIDCateIDResult> distress = lq.getPWNameByCityIDCateID(0, 0, 1, "en").ToList(); ;
            if (distress.Count() > 0)
            {
                Panel_S_Distress.Visible = true;
                gv_S_Distress.DataSource = distress;
                gv_S_Distress.DataBind();
                lbl_S_DistressNum.Text = distress.Count() + "";
            }



            //Shelter Sexual
            var sexual = lq.getShelterByCityIDCateID(1, CithID, 2, "en").ToList();
            if (sexual.Count() > 0)
            {
                Panel_S_Sexual.Visible = true;
                gv_S_Sexual.DataSource = sexual;
                gv_S_Sexual.DataBind();
                lbl_S_SexualNum.Text = sexual.Count() + "";
            }
        

            //Shelter LGBT
            var lgbt = lq.getShelterByCityIDCateID(1, CithID, 3, "en").ToList();
            if (lgbt.Count() > 0)
            {
                Panel_S_lgbt.Visible = true;
                gv_S_LGBT.DataSource = lgbt;
                gv_S_LGBT.DataBind();
                lbl_S_LGBT_Num.Text = lgbt.Count() + "";
            }
 

            //Shelter Legal
            var legal = lq.getShelterByCityIDCateID(1, CithID, 4, "en").ToList();
            if (legal.Count() > 0)
            {
                Panel_S_Legal.Visible = true;
                gv_S_Legal.DataSource = legal;
                gv_S_Legal.DataBind();
                lbl_S_Legal_Num.Text = legal.Count() + "";
            }
    

            // Shelter Shelters
            var shelters = lq.getShelterByCityIDCateID(1, CithID, 5, "en").ToList();
            if (shelters.Count() > 0)
            {
                Panel_S_Shelters.Visible = true;
                gv_S_Shelters.DataSource = shelters;
                gv_S_Shelters.DataBind();
                lbl_S_Shelters_Num.Text = shelters.Count() + "";
            }
   

            // Shelter Housing
            var housing = lq.getShelterByCityIDCateID(1, CithID, 6, "en").ToList();
            if (housing.Count() > 0)
            {
                Panel_S_Housing.Visible = true;
                gv_S_Housing.DataSource = housing;
                gv_S_Housing.DataBind();
                lbl_S_Housing_Num.Text = housing.Count() + "";
            }
           

            //Shelter Counselling
            var counselling = lq.getShelterByCityIDCateID(1, CithID, 7, "en").ToList();
            if (counselling.Count() > 0)
            {
                Panel_S_Counselling.Visible = true;
                gv_S_Counselling.DataSource = counselling;
                gv_S_Counselling.DataBind();
                lbl_S_Counselling_Num.Text = counselling.Count() + "";
            }
 

            //Shelter Violence
            var violence = lq.getShelterByCityIDCateID(1, CithID, 8, "en").ToList();
            if (violence.Count() > 0)
            {
                Panel_S_Violence.Visible = true;
                gv_S_Violence.DataSource = violence;
                gv_S_Violence.DataBind();
                lbl_S_Violence_Num.Text = violence.Count() + "";
            }
      

            //Shelter Drugs
            var drug = lq.getShelterByCityIDCateID(1, CithID, 9, "en").ToList();
            if (drug.Count() > 0)
            {
                Panel_S_Drugs.Visible = true;
                gv_S_Drugs.DataSource = drug;
                gv_S_Drugs.DataBind();
                lbl_S_Drugs_Num.Text = drug.Count() + "";
            }


            lblShelterTotalNum.Text = distress.Count() + sexual.Count() + lgbt.Count() + legal.Count()
                + shelters.Count() + housing.Count() + counselling.Count() + violence.Count()
                + drug.Count() + "";

        }

        protected void ddlProvince_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCity.Items.Clear();
            ddlCity_S.Items.Clear();
            try 
            { 
                ddlCity.DataSource = lq.GetCityByProvince(Convert.ToInt32(ddlProvince.SelectedValue));
                ddlCity_S.DataSource = lq.GetCityByProvince(Convert.ToInt32(ddlProvince.SelectedValue));
            }
            catch
            {
                ddlCity.DataSource = lq.GetCityAll();
                ddlCity_S.DataSource = lq.GetCityAll();
            }

            ddlCity.DataTextField = "CityName";
            ddlCity.DataValueField = "CityId";
            ddlCity.DataBind();
            ddlCity_S.DataTextField = "CityName";
            ddlCity_S.DataValueField = "CityId";
            ddlCity_S.DataBind();

            ddlProvince_S.SelectedValue = ddlProvince.SelectedValue;
        }

        protected void ddlProvince_S_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCity.Items.Clear();
            ddlCity_S.Items.Clear();
            try
            {
                ddlCity.DataSource = lq.GetCityByProvince(Convert.ToInt32(ddlProvince_S.SelectedValue));
                ddlCity_S.DataSource = lq.GetCityByProvince(Convert.ToInt32(ddlProvince_S.SelectedValue));
            }
            catch
            {
                ddlCity.DataSource = lq.GetCityAll();
                ddlCity_S.DataSource = lq.GetCityAll();
            }

            ddlCity.DataTextField = "CityName";
            ddlCity.DataValueField = "CityId";
            ddlCity.DataBind();
            ddlCity_S.DataTextField = "CityName";
            ddlCity_S.DataValueField = "CityId";
            ddlCity_S.DataBind();

            ddlProvince.SelectedValue = ddlProvince_S.SelectedValue;
        }

        protected void gvpwDrugs_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = 0;  //click row index
            if (e.CommandName == "Select")
            {
                //获取被点击的imageButton所在的GridViewRow
                GridViewRow gvrow = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                index = gvrow.RowIndex; //获取到行索引 RowIndex
            }
            LinkButton d = (LinkButton)gvpwDrugs.Rows[index].Cells[0].FindControl("lbtnDrugs");

            lblDrugsNum.Text =d.CommandArgument+"<<--->>"+ d.Text +"<<-->>"+d.ToolTip;
        }

        protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCity_S.SelectedValue = ddlCity.SelectedValue;
            PWResource(Convert.ToInt32(ddlCity.SelectedValue));
            ShelterResource(Convert.ToInt32(ddlCity.SelectedValue));
        }

        protected void ddlCity_S_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCity.SelectedValue = ddlCity_S.SelectedValue;
            PWResource(Convert.ToInt32(ddlCity_S.SelectedValue));
            ShelterResource(Convert.ToInt32(ddlCity_S.SelectedValue));
        }


    }
}