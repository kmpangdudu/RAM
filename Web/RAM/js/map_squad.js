var Resource;
var ServiceURL_All_EN = "../WebServices/MapService.asmx/getmapen";

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
    minZoom: 3,
    maxZoom: 22,
    overviewMapControl: true,
    overviewMapControlOptions: {
        opened: true,
        //position:google.maps.ControlPosition.LEFT_BOTTOM
    },
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
    "1": "../Images/Distress.png",
    "2": "../Images/Sexual Health.png",
    "3": "../Images/LGBT.png",
    "4": "../Images/Legal Help.png",
    "5": "../Images/Youth Shelters.png",
    "6": "../Images/Housing Help.png",
    "7": "../Images/Counselling.png",
    "8": "../Images/Family Violence Shelters.png",
    "9": "../Images/Drugs, Alcohol and Gambling.png",
};

var mcOptions = {
    gridSize: 120, maxZoom: 15,
    styles: [
            {
                textColor: 'white',
                height: 26,
                url: "../Images/mkr-100.png",
                width: 26
            },
            {
                textColor: 'white',
                height: 52,
                url: "../Images/mkr-200.png",
                width: 52
            },
            {
                textColor: 'white',
                height: 78,
                url: "../Images/mkr-300.png",
                width: 78
            }
    ]
};

var input;

var autocomplete;

$.ajax({
    type: "POST",
    url: ServiceURL_All_EN,
    contentType: "application/json; charset=utf-8",
    dataType: "json",
    success: function (data) {
        Resource = data.d;
        //Call Back function  
        mapInit();
    }
});

function mapInit() {
    //**********************
    //
    // Create map
    //
    //**********************

    myMap = new google.maps.Map(document.getElementById("MapCanvas"), mapOptions);

    var input = /** @type {HTMLInputElement} */(
       document.getElementById('pac-input'));

    var types = document.getElementById('type-selector');

    myMap.controls[google.maps.ControlPosition.TOP_LEFT].push(types);

    google.maps.event.addDomListener(input, 'keydown', function (e) {
        if (e.keyCode == 13) {
            e.preventDefault();
        }
    });

    //myMap.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    var searchOptions = {
        types: ['(cities)'],
        componentRestrictions: { country: "ca" }
    };

    var autocomplete = new google.maps.places.Autocomplete(input,searchOptions);
    autocomplete.bindTo('bounds', myMap);
    
    google.maps.event.addListener(myMap, 'click', function () {
        infowindow.close();
    });



    addLocation();

    

    var markerCluster = new MarkerClusterer(myMap, clusterMarkers, mcOptions);


    //****************************************
    //
    // Load marker ,  will use Resource here
    //
    //****************************************
    function addLocation(place, category) {

        Resource = JSON.parse(Resource);
        for (var x in Resource) {
            var _resource = Resource[x];
            var location = new google.maps.LatLng(_resource.Latitude, _resource.Longitude);
            //addMarker(myMap, _resource, location);
            storeMarker(location, _resource);
        }
    }

    function citychanged(_marker) {

       //var autocomplete = new google.maps.places.Autocomplete(input);
       // autocomplete.bindTo('bounds', myMap);

    google.maps.event.addListener(autocomplete, 'place_changed', function () {
        infowindow.close();
        //_marker.setVisible(false);
        var place = autocomplete.getPlace();
        //alert(JSON.stringify(place));


        if (!place.geometry) {
            window.alert("Autocomplete's returned place contains no geometry");
            return;
        }

        // If the place has a geometry, then present it on a map.
        //alert(JSON.stringify(place.geometry));

        if (place.geometry.viewport) {
            //alert(JSON.stringify(place.geometry.viewport));
            myMap.fitBounds(place.geometry.viewport);
        } else {
            myMap.setCenter(place.geometry.location);

            //alert(JSON.stringify(place.geometry.location));

            myMap.setZoom(17);  // Why 17? Because it looks good.
        }
 
       // _marker.setPosition(place.geometry.location);
        //_marker.setVisible(true);

    });
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


    //*********************
    //
    //  build marker
    //
    //*********************
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



        citychanged(marker);




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











