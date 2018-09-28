<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCfloatmenu.ascx.cs" Inherits="Web.UCfloatmenu" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/UCCategory.ascx" TagPrefix="uc1" TagName="UCCategory" %>

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
        position: fixed;
        top: 115px !important;
        left: 10px;
        z-index: 1;
        height: 52px;
        width: 240px;
        border-radius: 5px;
        box-shadow: -3px -3px 10px #555555;
        background: rgba(255,255,255,0.1);
        border: solid 1px #999;
    }

    #m, #pw, #s {
        margin-bottom: 5px;
        float:left;
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
 <%--           <asp:ImageButton ID="ibtnMap" 
                runat="server" ImageUrl="~/Images/maplogo.png" 
                ToolTip="Resource on the Map" 
                Width="42" BorderStyle="None" 
                OnClick="ibtnMap_Click" 
                BackColor="Transparent" />--%>
            <a href="2.aspx" ><img src="../Images/maplogo.png" alt="Resource on the map" title="Resource on the Map" style="Width:42px; border:none; padding:10px 2px;"/> </a>
        </div>
        <div id="pw">
<%--            <asp:ImageButton 
                ID="ibtnPW" runat="server" 
                ImageUrl="~/Images/PW.png" 
                ToolTip="Phone and Web" 
                Width="35" BorderStyle="None" 
                OnClick="ibtnPW_Click" 
                BackColor="Transparent" />--%>
            <a href="2.aspx" ><img src="../Images/pw.png" alt="Phone and Web" title="Phone and Web"  style="Width:35px; border:none; padding:10px 2px;"/> </a>
        </div>
        <div id="s">
<%--            <asp:ImageButton ID="ibtnShelter" 
                runat="server" ImageUrl="~/Images/shelter1_small.png" 
                BorderStyle="None" Width="40" 
                ToolTip="Shelter" 
                OnClick="ibtnShelter_Click" 
                BackColor="Transparent" />--%>
            <a href="2.aspx" ><img src="../Images/shelter1_small.png" alt="Shelter" title="Shelter"  style="Width:40px; border:none; padding:10px 2px;"/> </a>
        </div>
<%--          <script src="http://code.jquery.com/jquery-1.10.2.js"></script>
  <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>--%>


        <div id="c" class="cs1">
            <%--        <uc1:UCCategory runat="server" ID="UCCategory" />--%>
            <div id="over_map">

                <div id="filterTitle">
                    <asp:Panel ID="PanelFilter" runat="server">
                        <img id="cate" alt="Category" src="../Images/Taxonomy.png" title="Category" border="0" width="32" onclick="expandbox()" />
                        <asp:Label ID="lblFilter" runat="server" Font-Size="7pt"> (expand) </asp:Label>
                    </asp:Panel>
                </div>
                   <script type="text/javascript" >
                        $("#filterTitle").on('click', function () {
      
                            if ($("#c").hasClass("cs1")) {
                                
                                $("#c").removeClass("cs1");
                                $("#c").addClass("cs2");
                                
                            } else {
                                $("#c").removeClass("cs2");
                                $("#c").addClass("cs1");
                                
                            }
      
                        });
                    </script> 
                <div id="myChoice">
                    <asp:Panel ID="PanelCBL" runat="server">
                        <div id="chk1" class="b2bfilter">
                            <img alt="" height="17" src="Images/Distress.png"><label><input class="b2bfilter" type="checkbox" checked id="1box" value="1"><span class="b2bfiltertext">Distress</span></span></label>
                        </div>
                        <div id="chk2" class="b2bfilter">
                            <img alt="" height="17" src="Images/Sexual Health.png"><label><input class="b2bfilter" type="checkbox" id="2box" checked value="2"><span class="b2bfiltertext">Sexual Health</span></label>
                        </div>
                        <div id="chk3" class="b2bfilter">
                            <img alt="" height="17" src="Images/LGBT.png"><label><input class="b2bfilter" type="checkbox" id="3box" checked value="3"><span class="b2bfiltertext">LGBT</span></label>
                        </div>
                        <div id="chk4" class="b2bfilter">
                            <img alt="" height="17" src="Images/Legal Help.png"><label><input class="b2bfilter" type="checkbox" id="4box" checked value="4"><span class="b2bfiltertext">Legal Help</span></label>
                        </div>
                        <div id="chk5" class="b2bfilter">
                            <img alt="" height="17" src="Images/Youth Shelters.png"><label><input class="b2bfilter" type="checkbox" id="5box" checked value="5"><span class="b2bfiltertext">Youth Shelters</span></label>
                        </div>
                        <div id="chk6" class="b2bfilter">
                            <img alt="" height="17" src="Images/Housing Help.png"><label><input class="b2bfilter" type="checkbox" id="6box" checked value="6"><span class="b2bfiltertext">Housing Help</span></label>
                        </div>
                        <div id="chk7" class="b2bfilter">
                            <img alt="" height="17" src="Images/Counselling.png"><label><input class="b2bfilter" type="checkbox" id="7box" checked value="7"><span class="b2bfiltertext">Counselling</span></label>
                        </div>
                        <div id="chk8" class="b2bfilter">
                            <img alt="" height="17" src="Images/Family Violence Shelters.png"><label><input class="b2bfilter" type="checkbox" id="8box" checked value="8"><span class="b2bfiltertext">Family Violence Shelters</span></label>
                        </div>
                        <div id="chk9" class="b2bfilter">
                            <img alt="" height="17" src="Images/Drugs, Alcohol and Gambling.png"><label><input class="b2bfilter" type="checkbox" id="9box" checked value="9"><span class="b2bfiltertext">Drugs, Alcohol and Gambling</span></label>
                        </div>
                    </asp:Panel>
                </div>

                <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
                    Collapsed="True"
                    TextLabelID="lblFilter"
                    TargetControlID="PanelCBL"
                    ExpandControlID="PanelFilter"
                    CollapseControlID="PanelFilter"
                    ExpandedText="(collapse)"
                    CollapsedText="(expand)"
                    BehaviorID="_content_CollapsiblePanelExtender1" />



            </div>
        </div>


    </asp:Panel>
</div>


<cc1:AlwaysVisibleControlExtender
    ID="AlwaysVisibleControlExtender1"
    runat="server"
    TargetControlID="floatMenu"
    VerticalSide="Bottom"
    VerticalOffset="10"
    HorizontalSide="Left"
    HorizontalOffset="10"
    ClientIDMode="Static" ViewStateMode="Disabled" />

        <script>

            function setBodyHeightToContentHeight() {
                document.body.style.height = Math.max(document.documentElement.scrollHeight, document.body.scrollHeight) + "px";
            }
            setBodyHeightToContentHeight();
            $addHandler(window, "resize", setBodyHeightToContentHeight);

        </script>