<%@ Page Title="" Language="C#" MasterPageFile="~/RAM.Master" AutoEventWireup="true" CodeBehind="13.aspx.cs" Inherits="Web._13" %>
<%@ Register Src="~/Controls/UCfloatmenu.ascx" TagPrefix="uc1" TagName="UCfloatmenu" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/UCCategory.ascx" TagPrefix="uc1" TagName="UCCategory" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/13.css" rel="stylesheet" />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!---  Main Panel    -------->
    <div id="mainContainer13">
            <uc1:ucfloatmenu runat="server" id="UCfloatmenu" />
        <!---  map Panel    -------->
            <div id="mapPanel1" class="clsMapPanel">
   
                <%--                    <iframe id="if123" width="100%" height="100%" scrolling="no" src="map.aspx" />--%>
                <%--           <div style="background-color:lightpink; min-height:200px; min-width :300px;">map Panel</div>--%>

                <div id="MapCanvas"></div>
            <%--    <uc1:UCCategory runat="server" id="UCCategory" />--%>


            </div>
        <!--map Panel-->
    </div>
    <!--Main Panel-->
</asp:Content>
