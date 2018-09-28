var Resource  ;
var ServiceURL_All_EN = "http://localhost:56971/WebServices/MapService.asmx/getmapen";

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
    overviewMapControl: true,
    minZoom: 3,
    maxZoom: 22,
    overviewMapControl: true,
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

function CallService() {
    Web.WebServices.MapService.getmapen(Callback);
};
function Callback(result) {
    Resource = result;
    //alert("hello call --- "+ Resource);
    mapInit();
};




    function mapInit() {
         //alert("in mapInit  1  --- " + Resource);
         
        //Resource = JSON.parse(document.getElementById("Hidden1").value);



        // Create map
        myMap = new google.maps.Map(document.getElementById("MapCanvas"), mapOptions);
               
        google.maps.event.addListener(myMap, 'click', function () {
            infowindow.close();
        });
     
        
        addLocation();
 
        //google.maps.event.addDomListener(window, 'load', mapInit);

        var markerCluster = new MarkerClusterer(myMap, clusterMarkers, mcOptions);


        //
        // will use Resource here
        //
        

        function addLocation(place, category) {

            //alert("in mapInit  2  --- " + Resource);
            Resource = JSON.parse(Resource);
            for (var x in Resource) {
                var _resource = Resource[x];
                var location = new google.maps.LatLng(_resource.Latitude, _resource.Longitude);
                //addMarker(myMap, _resource, location);
                storeMarker(location, _resource);
            }
        }


        // *
        // START INFOWINDOW CUSTOMIZE.
        // The google.maps.event.addListener() event expects
        // the creation of the infowindow HTML structure 'domready'
        // and before the opening of the infowindow, defined styles are applied.
        // *   
        infowindow = new google.maps.InfoWindow({ maxWidth: 450 });
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
 









 
 