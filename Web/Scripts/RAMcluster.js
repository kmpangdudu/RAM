
function initialize() {
    
    var data = JSON.parse(document.getElementById("Hidden1").value);

     var mapOptions = {
        center: new google.maps.LatLng(57.001294, -92.892295),
        zoom: 4,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        panControl: false,
 
        zoomControl: true,
        zoomControlOptions: {
            style: google.maps.ZoomControlStyle.SMALL,
            position: google.maps.ControlPosition.RIGHT_BOTTOM
        }

    };

    // Create map
    var myMap = new google.maps.Map(document.getElementById("mapArea"), mapOptions);

    var locations = [];

    var markers = [];

    var message = [];

    // InfoWindow content
    var infowindow = new google.maps.InfoWindow({
        // Assign a maximum value for the width of the infowindow allows
        // greater control over the various content elements
        maxWidth: 400
    });

    // *
    // START INFOWINDOW CUSTOMIZE.
    // The google.maps.event.addListener() event expects
    // the creation of the infowindow HTML structure 'domready'
    // and before the opening of the infowindow, defined styles are applied.
    // *   
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


    // Event that closes the Info Window with a click on the map
    google.maps.event.addListener(myMap, 'click', function () {

        infowindow.close();
    });



    //Icon images for each category
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
    }

    /* now inside your initialise function */
  
    for (var i = 0; i < data.Resource.length; i++) {
        
        var latLng = new google.maps.LatLng(data.Resource[i].Latitude, data.Resource[i].Longitude);
        var marker = new google.maps.Marker({ 'position': latLng, "icon": categoryIcons[data.Resource[i].KHPCategoryID] });
        //var category = 
        _Name = data.Resource[i].PublicName;
        _Desc = data.Resource[i].AgencyDescription;
        _Address = data.Resource[i].PhysicalAddress;
        _City = data.Resource[i].CityName;
        _Province = data.Resource[i].Province;
        _Country = data.Resource[i].PhysicalCountry;
        _PostalCode =data.Resource[i].PhysicalPostalCode;
        _Phone = data.Resource[i].Phone;
        _Eligibility = data.Resource[i].Eligibility;
        _DisabilitiesAccess = data.Resource[i].DisabilitiesAccess;
        _FeeStructureSource = data.Resource[i].FeeStructureSource;
        _ApplicationProcess = data.Resource[i].ApplicationProcess;
        _DocumentsRequired = data.Resource[i].DocumentsRequired;
        _Language = data.Resource[i].LanguagesOfferedList;
        _WorkHours = data.Resource[i].WorkHours;
        _CustomEligibilitybyAge = data.Resource[i].CustomEligibilitybyAge;
        _website = "<a target='_blank' href = 'http://" + data.Resource[i].WebsiteAddress + "' >" + data.Resource[i].WebsiteAddress + "</a>";



            // InfoWindow content
        message[i] ='<div id="iw-container">' +
                    '<div class="iw-title">' + _Name  + '</div>' +
                        '<div class="iw-content">' +
                            
                            '<p>' + _Desc + '</p>' +
                            '<p><strong>Address:</strong> ' + _Address + '</p>' +
                            '<p>' + _City + ', ' + _Province + ', ' + _Country + ' ' + _PostalCode + '</p>' +
                            '<p><strong>Phone:</strong> ' + _Phone + '</p>' +
                            '<p><strong>Eliibility:</strong> ' + _Eligibility + '</p>' +
                            '<p><strong>Disabilities Access:</strong> ' + _DisabilitiesAccess + '</p>' +
                            '<p><strong>Fee:</strong> ' + _FeeStructureSource + '</p>' +
                            '<p><strong>Application Process:</strong> ' + _ApplicationProcess + '</p>' +
                            '<p><strong>Documents Required:</strong> ' + _DocumentsRequired + '</p>' +
                            '<p><strong>Language:</strong> ' + _Language + '</p>' +
                            '<p><strong>Work Hours:</strong> ' + _WorkHours + '</p>' +
                            '<p><strong>Eligibility Age:</strong> ' + _CustomEligibilitybyAge + '</p>' +
                            '<p><strong>Website:</strong>' + _website + '</p>' +
                        '</div>' +
                    '<div class="iw-bottom-gradient"></div>' +
                    '</div>'
                    ;





        //set title
        marker.setTitle((_Name).toString());
                
        var contentString = message[i];

        google.maps.event.addListener(marker, 'click', (function (marker, contentString, infowindow) {
            return function () {
                myMap.setCenter(marker.getPosition());
                infowindow.setContent(contentString);
                infowindow.open(myMap, marker);
            };
        })(marker, contentString, infowindow));





        markers.push(marker);
    }   // for loop


  





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
    var markerCluster = new MarkerClusterer(myMap, markers,mcOptions);


}

function TypeCheckBoxListChanged()
{
    initialize();
    //alert("hello");
}