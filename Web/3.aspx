<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="3.aspx.cs" Inherits="Web._3" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

 
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>3 Resource Around Me.html</title>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.20&sensor=false"></script>
    <!--<script src="markerclusterer.js" type="text/javascript"></script>-->
    <script src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/markerclusterer/src/markerclusterer.js" type="text/javascript"></script>
    <link href='http://fonts.googleapis.com/css?family=Oswald:400,300,700|Open+Sans+Condensed:700,300,300italic|Open+Sans:400,300italic,400italic,600,600italic,700,700italic,800,800italic|PT+Sans:400,400italic,700,700italic' rel='stylesheet' type='text/css'>
  	<link href='http://fonts.googleapis.com/css?family=Rock+Salt' rel='stylesheet' type='text/css'/>
    <script src="Scripts/jquery-1.8.2.min.js"></script>
    <%--<script type="text/javascript" src="data.js"></script>--%>
 
    <link href="Content/Site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
            <Services>
                <asp:ServiceReference Path="WebServices/MapService.asmx" />
            </Services>
        </asp:ScriptManager>
        <div id="outputDiv" ></div><div id="outputDiv1" style="min-width:20px;max-height:100px;min-height:20px;background-color:blue;color:white;" ></div>
        <div id="outputDiv2" style="min-width:20px;min-height:20px;max-height:100px;background-color:yellow;" ></div>
        <div id="outputDiv3" style="min-width:20px;min-height:20px;max-height:100px;background-color:green;color:white" ></div>
        <div id="outputDiv4" style="min-width:20px;min-height:20px;max-height:100px;background-color:grey;color:white;" ></div>
        <div id="outputDiv5" style="min-width:20px;min-height:20px;max-height:100px;background-color:green;color:white;

" ></div>
<%-- <div id="div1" style="max-height:50px;width:95%; background-color:yellow;border:2px solid blue;padding:5px;overflow:auto;">
     <asp:GridView ID="GridView1" runat="server"></asp:GridView>
 </div>--%>

        <div id="myContent">
        <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" Width="100%"  >
            <cc1:TabPanel runat="server" HeaderText="Map" ID="TabPanelMap">
               <ContentTemplate>


 
        <div id="wrapper">
                    <div id="MapCanvas"></div>
 
                    <div id="over_map">
                        
                        <div id="filterTitle">
                            <asp:Panel ID="PanelFilter" runat="server">
                                Categories
                                <span id="hand"><asp:Label ID="lblFilter" runat="server" Font-Size="9pt"> (Show) </asp:Label></span>
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

<script>



    var KHPRAM = function () {


        var Resource;
        var ServiceURL_All_EN = "http://localhost:56971/WebServices/MapService.asmx/getmapen";

        //var getAllresourceEN = getwebjson();
        var locations = [];
        var markers = [];
        var message;
        var CenterLat = 57.001294;
        var CenterLong = -92.892295;
        var ZoomLevel = 4;
        var mapOptions = {
            center: new google.maps.LatLng(CenterLat, CenterLong),
            zoom: ZoomLevel,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            panControl: false,
            zoomControl: true,
            zoomControlOptions: {
                style: google.maps.ZoomControlStyle.SMALL,
                position: google.maps.ControlPosition.RIGHT_BOTTOM
            }
        };
        var mymap;
        var image = [];
        var infowindow;
        var gmarkers = [];
        var clusterMarkers = [];
        var categoryIcons = {
            "1": "Images/Distress.png",
            "2": "Images/Sexual Health.png",
            "3": "Images/LGBT.png",
            "4": "Images/Legal Help.png",
            "5": "Images/Youth Shelters.png",
            "6": "Images/Housing Help.png",
            "7": "Images/Counselling.png",
            "8": "Images/Family Violence Shelters.png",
            "9": "Images/Drugs, Alcohol and Gambling.png",
        };

        var mcOptions = {
            gridSize: 120, maxZoom: 15,
            styles: [
                    {
                        height: 52,
                        url: "Images/m5-52x52.png",
                        width: 52
                    },
                    {
                        height: 78,
                        url: "Images/m5-78x78.png",
                        width: 78
                    },
                    {
                        height: 90,
                        url: "Images/m5-90x90.png",
                        width: 90
                    }
            ]
        };



        //var getdate = function () {
        //    function CallService() {

        //        Web.WebServices.MapService.getmapen(Callback);
        //    };

        //    function Callback(result) {

        //        Resource = JSON.parse(result);

        //        $("#outputDiv2").html("callback result:-->" + Resource.substring(0, 100));

        //    };
        //}();

        function mapInit() {
            var v = function () {
                $.ajax({
                    type: "POST",
                    url: "http://localhost:56971/WebServices/MapService.asmx/getmapen",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        Resource = JSON.parse(data.d);
                    },
                    error: function (xmlHttpRequest, textStatus, errorThrown) {
                        console.log(xmlHttpRequest.responseText);
                        console.log(textStatus);
                        console.log(errorThrown);
                    }
                });
            }();

            //var obj = function () {
            //    var value = "";
            //    return {
            //        setValue: function (val) {
            //            value = val;
            //        },

            //        getValue: function () {
            //            return value;
            //        }
            //    }
            //}();



            //Resource = JSON.parse(document.getElementById("Hidden1").value);
            v();
            alert(v());
            Resource = v();


            // Create map
            myMap = new google.maps.Map(document.getElementById("MapCanvas"), mapOptions);
            var markerCluster = new MarkerClusterer(myMap, clusterMarkers, mcOptions);

            google.maps.event.addListener(myMap, 'click', function () {
                infowindow.close();
            });






            function addLocation(place, category) {
                for (var x in Resource) {
                    var _resource = Resource[x];
                    var location = new google.maps.LatLng(_resource.Latitude, _resource.Longitude);
                    //addMarker(myMap, _resource, location);
                    storeMarker(location, _resource);
                }
            }

            addLocation();




            // *
            // START INFOWINDOW CUSTOMIZE.
            // The google.maps.event.addListener() event expects
            // the creation of the infowindow HTML structure 'domready'
            // and before the opening of the infowindow, defined styles are applied.
            // *   
            //infowindow = new google.maps.InfoWindow({ maxWidth: 450 });
            function infowindowstyle() {
                google.maps.event.addListener(infowindow, 'domready', function () {

                    // Reference to the DIV that wraps the bottom of infowindow
                    var iwOuter = $('.gm-style-iw');

                    /* Since this div is in a position prior to .gm-div style-iw.
                     * We use jQuery and create a iwBackground variable,
                     * and took advantage of the existing reference .gm-style-iw for the previous div with .prev().
                    */
                    var iwBackground = iwOuter.prev();

                    // Removes background shadow DIV
                    iwBackground.children(':nth-child(2)').css({ 'display': 'none' });

                    // Removes white background DIV
                    iwBackground.children(':nth-child(4)').css({ 'display': 'none' });

                    // Moves the infowindow 115px to the right.
                    iwOuter.parent().parent().css({ left: '115px' });

                    // Moves the shadow of the arrow 76px to the left margin.
                    iwBackground.children(':nth-child(1)').attr('style', function (i, s) { return s + 'left: 76px !important;' });

                    // Moves the arrow 76px to the left margin.
                    iwBackground.children(':nth-child(3)').attr('style', function (i, s) { return s + 'left: 76px !important;' });

                    // Changes the desired tail shadow color.
                    iwBackground.children(':nth-child(3)').find('div').children().css({ 'box-shadow': 'rgba(72, 181, 233, 0.6) 0px 1px 6px', 'z-index': '1' });

                    // Reference to the div that groups the close button elements.
                    var iwCloseBtn = iwOuter.next();

                    // Apply the desired effect to the close button
                    iwCloseBtn.css({ opacity: '1', right: '38px', top: '3px', border: '7px solid #48b5e9', 'border-radius': '13px', 'box-shadow': '0 0 5px #3990B9' });

                    // If the content of infowindow not exceed the set maximum height, then the gradient is removed.
                    if ($('.iw-content').height() < 320) {
                        $('.iw-bottom-gradient').css({ display: 'none' });
                    }

                    // The API automatically applies 0.7 opacity to the button after the mouseout event. This function reverses this event to the desired value.
                    iwCloseBtn.mouseout(function () {
                        $(this).css({ opacity: '1' });
                    });
                });
            };






            //build marker
            function storeMarker(location, development) {
                var latLng = location;
                _website = "<a target='_blank' href = 'http://" + development.WebsiteAddress + "' >" + development.WebsiteAddress + "</a>";
                // InfoWindow content
                var message = '<div id="iw-container">' +
                            '<div class="iw-title">' + development.PublicName + '</div>' +
                                '<div class="iw-content">' +

                                    '<p>' + development.AgencyDescription + '</p>' +
                                    '<p><strong>Address:</strong> ' + development.PhysicalAddress + '</p>' +
                                    '<p>' + development.CityName + ', ' + development.Province + ', ' + development.PhysicalCountry + ' ' + development.PhysicalPostalCode + '</p>' +
                                    '<p><strong>Phone:</strong> ' + development.Phone + '</p>' +
                                    '<p><strong>Eliibility:</strong> ' + development.Eligibility + '</p>' +
                                    '<p><strong>Disabilities Access:</strong> ' + development.DisabilitiesAccess + '</p>' +
                                    '<p><strong>Fee:</strong> ' + development.FeeStructureSource + '</p>' +
                                    '<p><strong>Application Process:</strong> ' + development.ApplicationProcess + '</p>' +
                                    '<p><strong>Documents Required:</strong> ' + development.DocumentsRequired + '</p>' +
                                    '<p><strong>Language:</strong> ' + development.LanguagesOfferedList + '</p>' +
                                    '<p><strong>Work Hours:</strong> ' + development.WorkHours + '</p>' +
                                    '<p><strong>Eligibility Age:</strong> ' + development.CustomEligibilitybyAge + '</p>' +
                                    '<p><strong>Website:</strong>' + _website + '</p>' +
                                '</div>' +
                            '<div class="iw-bottom-gradient"></div>' +
                            '</div>'
                ;
                var marker = new google.maps.Marker({ "position": latLng, "title": development.PublicName, "icon": categoryIcons[development.KHPCategoryID] });

                marker.mycategory = development.KHPCategoryID;
                //marker.setTitle((development.Name).toString());

                google.maps.event.addListener(marker, 'click', function () {
                    if (typeof infowindow != 'undefined') infowindow.close();
                    infowindow = new google.maps.InfoWindow({
                        content: message,
                        maxWidth: 450
                    });
                    infowindowstyle();
                    infowindow.open(myMap, marker);
                });

                clusterMarkers.push(marker);
            }

            function toggle(category, show) {

                var markers = [];

                for (var i = 0; i < clusterMarkers.length; i++) {
                    if (clusterMarkers[i].mycategory == category) {
                        markers.push(clusterMarkers[i]);
                        clusterMarkers[i].setVisible(show);
                    }
                }
                if (markers.length) {
                    markerCluster[(show) ? 'addMarkers' : 'removeMarkers'](markers);
                }

                if (!show && infowindow) infowindow.close();

            }


            function boxclick(box, category) {

                toggle(category, box.checked);

            }

            jQuery(document).ready(function ($) {
                $('.b2bfilter').click(function () {
                    boxclick(this, this.value);
                });
            });

        }


        function callMapInit() {

            jQuery(document).ready(function () {
                mapInit();
            });
        };

        callMapInit();
    };

    KHPRAM();






</script>
