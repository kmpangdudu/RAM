<%@ Page Title="" Language="C#" MasterPageFile="~/RAM.Master" AutoEventWireup="true" CodeBehind="dragpanel.aspx.cs" Inherits="Web.WebForm1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
<cc1:DragPanelExtender ID="DragPanelExtender1" runat="server" TargetControlID="Panel1"
    DragHandleID="Panel2">
</cc1:DragPanelExtender>
<asp:Panel ID="Panel1" runat="server" CssClass="outerPanel">
    <asp:Panel ID="Panel2" runat="server" CssClass="dragPanel">
        <b>Dragable Panel</b>
    </asp:Panel>
    <p>
        Sample text Sample text Sample text
        Sample text Sample text Sample text
        Sample text Sample text Sample text
        Sample text Sample text Sample text            
    </p>
</asp:Panel>

    <script type="text/javascript">
        // The following snippet works around a problem where FloatingBehavior
        // doesn't allow drops outside the "content area" of the page - where "content
        // area" is a little unusual for our sample web pages due to their use of CSS
        // for layout.
        function setBodyHeightToContentHeight() {
            document.body.style.height = Math.max(document.documentElement.scrollHeight, document.body.scrollHeight)+"px";
        }
        setBodyHeightToContentHeight();
        $addHandler(window, "resize", setBodyHeightToContentHeight);    
    </script>
    <style>
  .outerPanel {
    border: solid 1px #C0C0C0;
    background-color: #e1e1e1;
    width: 200px;
    height: 300px;
    z-index:20;
    padding: 2px;
    }
    
    .dragPanel {
    border: solid 1px #FFFFFF;
    background-color: #C0C0C0;
    width: 194px;
    height: 15px;
    color: #FFFFFF;
    font-weight:bold;
    padding: 2px;
    cursor: move;
    }
    
</style>
</asp:Content>
