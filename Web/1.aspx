<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="1.aspx.cs" Inherits="Web._1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>1 RAM</title>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <!--<script src="markerclusterer.js" type="text/javascript"></script>-->
    <script src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/markerclusterer/src/markerclusterer.js" type="text/javascript"></script>
    <link href='http://fonts.googleapis.com/css?family=Oswald:400,300,700|Open+Sans+Condensed:700,300,300italic|Open+Sans:400,300italic,400italic,600,600italic,700,700italic,800,800italic|PT+Sans:400,400italic,700,700italic' rel='stylesheet' type='text/css'>
  	<link href='http://fonts.googleapis.com/css?family=Rock+Salt' rel='stylesheet' type='text/css'/>
    <script src="Scripts/jquery-1.8.2.min.js"></script>
    <%--<script type="text/javascript" src="data.js"></script>--%>
    <script src="Scripts/RAMcluster.js"></script>
    <link href="Content/Site.css" rel="stylesheet" />
</head>
<body  onload="initialize()">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <input id="Hidden1" type="hidden" runat="server"  />

        <div id="myContent">
        <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" Width="100%"  >
            <cc1:TabPanel runat="server" HeaderText="Map" ID="TabPanelMap">
               <ContentTemplate>


 
        <div id="wrapper">
                    <div id="mapArea"></div>


                    <div id="over_map">
                        
                        <div id="filterTitle">
                            <asp:Panel ID="PanelFilter" runat="server">
                                Categories
                                <span id="hand"><asp:Label ID="lblFilter" runat="server" Font-Size="9pt"> (Show) </asp:Label></span>
                            </asp:Panel>
                        </div>
                        
                        <div id="myChoice" >
                            <asp:Panel ID="PanelCBL" runat="server">
                                <asp:CheckBoxList ID="cbl" runat="server"
                                    Width="100%"
                                    OnDataBound="cbl_DataBound"
                                    AutoPostBack="True"
                                    OnSelectedIndexChanged="cbl_SelectedIndexChanged" Font-Size="9pt">
                                </asp:CheckBoxList>
                            </asp:Panel>
                        </div>
                        <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" 
                             Collapsed="True"
                            TextLabelID="lblFilter"
                            TargetControlID="PanelCBL"
                            ExpandControlID="PanelFilter"
                            CollapseControlID="PanelFilter" 
                            ExpandedText="(Hide)"
                            CollapsedText="(Show)" BehaviorID="_content_CollapsiblePanelExtender1"
                            />
                    </div>
        </div>

               </ContentTemplate>
            </cc1:TabPanel>
            
            <cc1:TabPanel ID="TabPanelPW" runat="server" HeaderText="Phonw & Web">
            </cc1:TabPanel>
            
            <cc1:TabPanel ID="TabPanelShelter" runat="server" HeaderText="Shelter">
            </cc1:TabPanel>

        </cc1:TabContainer>

        </div>
    </form>
</body>
</html>
