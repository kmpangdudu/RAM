<%@ Page Title="" Language="C#" MasterPageFile="~/RAM.Master" AutoEventWireup="true" CodeBehind="15.aspx.cs" Inherits="Web._15" %>
<%@ Register Src="~/Controls/UCfloatmenu.ascx" TagPrefix="uc1" TagName="UCfloatmenu" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/UCCategory.ascx" TagPrefix="uc1" TagName="UCCategory" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    shelter
        <uc1:ucfloatmenu runat="server" id="UCfloatmenu" />
  
</asp:Content>
