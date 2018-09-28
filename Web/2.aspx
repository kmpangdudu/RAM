<%@ Page Title="" Language="C#" MasterPageFile="~/2.Master" AutoEventWireup="true" CodeBehind="2.aspx.cs" Inherits="Web._2" %>
<%@ Register Src="~/Controls/UCfloatmenu.ascx" TagPrefix="uc1" TagName="UCfloatmenu" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/UCCategory.ascx" TagPrefix="uc1" TagName="UCCategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="Content/2.css" rel="stylesheet" />
 <style>
     #floatitem,#ContentPlaceHolder1_UCfloatmenu_floatMenu{
          top: 165px !important; 
     }
     #pac-input{
          margin: 10px;
          position: absolute;
          z-index: 1;
     }
 </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!---  Main Panel    -------->
    <div id="mainContainer13">
            <uc1:ucfloatmenu runat="server" id="UCfloatmenu" />
        <!---  map Panel    -------->
            <div id="mapPanel1" class="clsMapPanel">
        

               

 <input id="pac-input" class="controls" type="text" style="width:240px;height:45px;box-shadow: -5px -5px 10px #555555;border-radius: 5px;" placeholder="Enter a city" autofocus title="Type city name,select from below list.">
 <div id="MapCanvas"></div>
            </div>
        <!--map Panel-->
    </div>
    <!--Main Panel-->
</asp:Content>
