<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="map.aspx.cs" Inherits="Web.map" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>pure map</title>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.20&sensor=false"></script>
    <!--<script src="markerclusterer.js" type="text/javascript"></script>-->
    <script src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/markerclusterer/src/markerclusterer.js" type="text/javascript"></script>
    <link href='http://fonts.googleapis.com/css?family=Oswald:400,300,700|Open+Sans+Condensed:700,300,300italic|Open+Sans:400,300italic,400italic,600,600italic,700,700italic,800,800italic|PT+Sans:400,400italic,700,700italic' rel='stylesheet' type='text/css'>
  	<link href='http://fonts.googleapis.com/css?family=Rock+Salt' rel='stylesheet' type='text/css'/>
    <script src="Scripts/jquery-1.8.2.min.js"></script>
    <%--<script type="text/javascript" src="data.js"></script>--%>
    <script src="Scripts/10.js"></script>
    <link href="Content/13.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
 
            <div id="MapCanvas"></div>
            <div id="over_map">
                        
                        <div id="filterTitle">
                            <asp:Panel ID="PanelFilter" runat="server">
                                Categories  
                                <p id="hand" style="margin:2px;"><asp:Label ID="lblFilter" runat="server" Font-Size="7pt"> (expand) </asp:Label></p> 
                            </asp:Panel>
                        </div>
                        
                        <div id="myChoice" >
                            <asp:Panel ID="PanelCBL" runat="server">
                            <div id="chk1" class="b2bfilter" ><img alt="" height="17" src="Images/Distress.png"><label><input class="b2bfilter" type="checkbox" checked id="1box" value="1"><span class="b2bfiltertext">Distress</span></span></label>                                           </div>
                            <div id="chk2" class="b2bfilter" ><img alt="" height="17" src="Images/Sexual Health.png"><label><input class="b2bfilter" type="checkbox" id="2box" checked value="2"><span class="b2bfiltertext">Sexual Health</span></label>                                 </div>
                            <div id="chk3" class="b2bfilter" ><img alt="" height="17" src="Images/LGBT.png"><label><input class="b2bfilter" type="checkbox" id="3box" checked value="3"><span class="b2bfiltertext">LGBT</span></label>                                                   </div>
                            <div id="chk4" class="b2bfilter" ><img alt="" height="17" src="Images/Legal Help.png"><label><input class="b2bfilter" type="checkbox" id="4box" checked value="4"><span class="b2bfiltertext">Legal Help</span></label>                                       </div>
                            <div id="chk5" class="b2bfilter" ><img alt="" height="17" src="Images/Youth Shelters.png"><label><input class="b2bfilter" type="checkbox" id="5box" checked value="5"><span class="b2bfiltertext">Youth Shelters</span></label>                               </div>
                            <div id="chk6" class="b2bfilter" ><img alt="" height="17" src="Images/Housing Help.png"><label><input class="b2bfilter" type="checkbox" id="6box" checked value="6"><span class="b2bfiltertext">Housing Help</span></label>                                   </div>
                            <div id="chk7" class="b2bfilter" ><img alt="" height="17" src="Images/Counselling.png"><label><input class="b2bfilter" type="checkbox" id="7box" checked value="7"><span class="b2bfiltertext">Counselling</span></label>                                     </div>
                            <div id="chk8" class="b2bfilter" ><img alt="" height="17" src="Images/Family Violence Shelters.png"><label><input class="b2bfilter" type="checkbox" id="8box" checked value="8"><span class="b2bfiltertext">Family Violence Shelters</span></label>           </div>
                            <div id="chk9" class="b2bfilter" ><img alt="" height="17" src="Images/Drugs, Alcohol and Gambling.png"><label><input class="b2bfilter" type="checkbox" id="9box" checked value="9"><span class="b2bfiltertext">Drugs, Alcohol and Gambling</span></label></div>
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
                            BehaviorID="_content_CollapsiblePanelExtender1"
                            />
                    </div>

    </form>
</body>
</html>
