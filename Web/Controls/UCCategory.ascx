<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCCategory.ascx.cs" Inherits="Web.Controls.UCCategory" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<link href="../Content/FloatCategory.css" rel="stylesheet" />
<div id="over_map">


 


    <div id="filterTitle">
        <asp:Panel ID="PanelFilter" runat="server">
            <img alt="Category" src="../Images/Taxonomy.png" title ="Category" border="0" width="32" />
            <asp:Label ID="lblFilter" runat="server" Font-Size="7pt"> (expand) </asp:Label>
        </asp:Panel>
    </div>

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
  
    <cc1:collapsiblepanelextender id="CollapsiblePanelExtender1" runat="server"
        collapsed="True"
        textlabelid="lblFilter"
        targetcontrolid="PanelCBL"
        expandcontrolid="PanelFilter"
        collapsecontrolid="PanelFilter"
        expandedtext="(collapse)"
        collapsedtext="(expand)"
        behaviorid="_content_CollapsiblePanelExtender1" />
 


</div>
 

 