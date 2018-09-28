<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Floatmenu.ascx.cs" Inherits="Web.Controls.Floatmenu" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<style>
    .floatMenu {
        /*background-color: White;  
             border: solid 1px #666666;*/
        padding: 10px;
        left: 10px;
        top: 30px;
        z-index: 1;
        /*border-radius:5px;
              box-shadow: -5px -5px  10px #555555; 
              background:rgba(255,255,255,0.7);*/
    }

    .floatitem {
        /*position: fixed;*/
        top: 400px !important;
        left: 10px;
        z-index: 1;
      
        width: 45px;
        border-radius: 5px;
        box-shadow: -3px -3px 10px #555555;
        background: rgba(255,255,255,0.1);
        border: solid 1px #999;
    }

    #m, #pw, #s {
        margin-bottom: 5px;
    }

    .cs2{
        margin: 1px;
        padding:8px; 
        float:left;
        background: rgba(255,255,255,0.7);
        border-radius: 5px;
        box-shadow: 5px 5px 10px #555555; 
        width:223px;
    }
    .cs1{
        margin:8px;
        float:left;
    }
    /*#ContentPlaceHolder1_UCfloatmenu_floatMenu{

}*/
</style>


<div id="floatitem" class="floatitem">
    <asp:Panel ID="floatMenu" CssClass="floatitem" runat="server">
        <div id="m">

            <a href="../RAM/Default.aspx" ><img src="../Images/maplogo.png" alt="Resource on the map" title="Resource on the Map" style="Width:42px; border:none; padding:10px 2px;"/> </a>
        </div>
        <div id="pw">
            <a href="#phoneWeb" ><img src="../Images/pw.png" alt="Phone and Web" title="Phone and Web"  style="Width:35px; border:none; padding:10px 2px;"/> </a>
        </div>
        <div id="s">

            <a href="#shelter" ><img src="../Images/shelter1_small.png" alt="Shelter" title="Shelter"  style="Width:40px; border:none; padding:10px 2px;"/> </a>
        </div>

    </asp:Panel>
</div>


<cc1:AlwaysVisibleControlExtender
    ID="AlwaysVisibleControlExtender1"
    runat="server"
    TargetControlID="floatMenu"
    VerticalSide="Middle"
    VerticalOffset="10"
    HorizontalSide="Right"
    HorizontalOffset="10"
    ClientIDMode="Static" ViewStateMode="Disabled" />

        <script>

            function setBodyHeightToContentHeight() {
                document.body.style.height = Math.max(document.documentElement.scrollHeight, document.body.scrollHeight) + "px";
            }
            setBodyHeightToContentHeight();
            $addHandler(window, "resize", setBodyHeightToContentHeight);

        </script>