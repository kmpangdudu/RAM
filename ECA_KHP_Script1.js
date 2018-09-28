// JavaScript source code
/* ---------------------------------- */
/* Initialize */
jQuery(
    function ($) {
        $.Body = $('body');
        $.Window = $(window);
        $.Mobile = ($.Body.hasClass('webkit-mobile') || (navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i)) || (navigator.userAgent.match(/iPad/i)));
        google.maps.visualRefresh = true;
    }
);

/**
 * Protect window.console method calls, e.g. console is not defined on IE
 * unless dev tools are open, and IE doesn't define console.debug */
(function () {
    if (!window.console) {
        window.console = {};
    }
    // union of Chrome, FF, IE, and Safari console methods
    var m = [
        "log", "info", "warn", "error", "debug", "trace", "dir", "group",
        "groupCollapsed", "groupEnd", "time", "timeEnd", "profile", "profileEnd",
        "dirxml", "assert", "count", "markTimeline", "timeStamp", "clear"
    ];
    // define undefined methods as noops to prevent errors
    for (var i = 0; i < m.length; i++) {
        if (!window.console[m[i]]) {
            window.console[m[i]] = function () { };
        }
    }
})();

var myListDetailArr = [];

/* ---------------------------------- */
/* MAP */
var khpMap = function () {
    google.maps.visualRefresh = true;
    var home = new google.maps.LatLng(57.749986, -96.544028),
        view = 'map',
        geocoder,
        mapOptions = {
            center: home,
            zoom: 4,
            minZoom: 4,
            maxZoom: 16,
            streetViewControl: false,
            mapTypeControl: false,
            overlayMapControl: false,
            panControl: false,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            mapTypeControlOptions: {
                mapTypeIds: [google.maps.MapTypeId.HYBRID, 'grey_map']
            }
        },
        $clicked = false,
        $self = $(this);


    var myStyles = [{
        featureType: "poi",
        elementType: "labels",
        stylers: [{
            visibility: "off"
        }]
    }];



    khpRAM.map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
    //Remove Points of Interest
    var mapType = new google.maps.StyledMapType(myStyles, {
        name: "POI"
    });
    khpRAM.map.mapTypes.set('updated_map', mapType);
    khpRAM.map.setMapTypeId('updated_map');


    khpRAM.currentMarkers = [];

    var isInit = true,
        global_init = true;
    // Initialize Map  
    geocoder = new google.maps.Geocoder();

    // Geolocation, getting co-ords.
    function SetDefaultPos(position) {
        var center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        khpRAM.map.setCenter(center);
        khpRAM.map.setZoom(7);
        //after pos set, plot map with markers.
    }
    // Geolocation Error - TO-DO: Set error handler and display
    function SetDefaultPosError(error) {
        var errors = {
            1: 'Permission denied',
            2: 'Position unavailable',
            3: 'Request timeout'
        };
        alert("Error: " + errors[error.code]);
    }

    //Toggle Map views
    $('#map-toggle li').click(function () {
        var el = $(this);
        if (el.hasClass('active')) return false;
        var el_id = el.attr('id');
        if (el_id === "btn-map-view") {
            view = 'map';
            $('#non-map-view').hide();
            el.addClass('active').siblings('li').removeClass('active');
        } else if (el_id === "btn-non-map-view") {
            $('#non-map-view').show();
            $('#city-select').fadeOut();
            el.addClass('active').siblings('li').removeClass('active');
            view = 'non-map';
        }
    });

    //**************************/
    // Verfiy the location
    //**************************
    $('#city_select_field, #search_term').val('');
    khpRAM.verifyLocation = function () {
        if (skipCitySelect) {
            var setLat = lat,
                setLng = lng,
                myLatLng = new google.maps.LatLng(setLat, setLng);
            khpRAM.map.setCenter(myLatLng);
            khpRAM.map.setZoom(16);
        } else {
            var place = khpRAM.autocomplete.getPlace();
            // Inform the user that a place was not found and return.
            if (!place.geometry) {
                // TODO: Handle place error in the UI
                alert(msg_map_no_results);
                $('#city_select_field').focus();
                return;
            }

            // If the place has a geometry, then present it on a map.
            if (place.geometry.viewport) {
                // Use the viewport if it is provided.
                khpRAM.map.fitBounds(place.geometry.viewport);
            } else {
                // Otherwise use the location and set a chosen zoom level.
                khpRAM.map.setCenter(place.geometry.location);
                khpRAM.map.setZoom(15);
            }
        }

        //Fade out city selection, then fade in search bar
        $('#actions').fadeIn(_options.global.speed);
        $('#map-toggle').fadeIn(_options.global.speed);
        if (isInit) {
            $('#city-select').fadeOut(_options.global.speed);
            if (global_init) {
                loadCategories();
            }
            isInit = false;
            global_init = false;
        }
    }


    //**************************/
    //Initiate map elements
    //**************************/
    khpRAM.init = function () {
        //Fade in suggest resource button			
        khpRAM.updateList();
        $('#my-list').css('display', 'block');
        $('#map-toggle').fadeIn(_options.global.speed);
        $('footer div.btn, #legend').fadeIn(_options.global.speed, function () {
            $('#results').fadeIn(_options.global.speed, function () {
                $('#map-toggle').fadeIn(_options.global.speed);
                $('#actions').fadeIn(_options.global.speed, function () {
                    $('#my-list').addClass('in-view');
                });
            });
        });
        khpRAM.Plot();
    }
    //**************************/
    // Plot Non Face to Face Resources
    //**************************/
    var non_mapped = [];
    var provinces_in_view;
    khpRAM.PlotNonMap = function () {
        var options,
            data = {},
            bounds = khpRAM.map.getBounds();
        data.Term = search_term;
        data.CategoryCodes = khpRAM.getActiveCats();
        data.Provinces = provinces_in_view;

        // Ajax Config Object
        options = {
            data: JSON.stringify(data),
            url: api_path + '/api/NonFace2FaceSearch',
            type: "POST",
            crossDomain: true,
            dataType: 'json',
            contentType: "application/json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader("Authorization", "Bearer 28D3091E-7D69-4DE2-A164-AFD179B66388");
                if (!lang_en) {
                    xhr.setRequestHeader("Accept-Language", "fr");
                }
            },
            error: function (xhr) {
                alert(err_txt_api);
            },
            success: function (response) {
                khpRAM.AddNonMap(response.ResourcesServingArea);
            }
        };
        $.ajax(options);
    }

    // ******************************
    // Add Non-Mapped Resources to tab
    // ******************************
    khpRAM.AddNonMap = function (non_mapped) {
        var el = $('#non-map-view');
        $('p.center span span.val', el).text(non_mapped.length);
        var elem = $('.scrollable ul', el);
        $('.scrollable ul', el).html('');

        var i = 0,
            align = 'first';
        if (non_mapped.length > 0) {
            $.each(non_mapped, function (e) {
                i++;
                var value = non_mapped[e];
                var html = '';
                if (i === 3) {
                    align = 'last';
                } else {
                    align = 'first';
                }
                html += '<li data-id=' + value.Id + ' class="' + align + '">';


                html += '<h4><span class="cat"><img src="img/mkr/' + khpRAM.catIcon(value.CategoryCodes) + '.png"></span> ' + value.PublicName + '</h4>';
                html += '<span class="category ' + khpRAM.catIcon(value.CategoryCodes) + '">' + khpRAM.listCats(value, value.CategoryCodes) + '</span>';

                html += '<span class="address">';
                if (value.AgencyName) {
                    html += '<strong>' + value.AgencyName + "</strong><br/>";
                }


                if (value.PhoneNumber) {
                    html += '<span>' + value.PhoneNumber + '</span>';
                }

                if (value.Description) {
                    var txt = value.Description;
                    if (txt.length > 130) {
                        txt = txt.substr(0, 130) + "...";
                    }
                    html += '<span class="desc">' + txt + '<br/><br/><a href="javascript: void(0);" class="more-info">&rarr; ' + btn_more_info + '</a></span>';
                } else {
                    html += '<span class="desc"><a href="javascript: void(0);" class="more-info">&rarr; ' + btn_more_info + '</a></span>';
                }

                if (khpRAM.disableSave(value.Id)) {
                    html += '<div class="btn save-program disabled" data-save-id="' + value.Id + '"><a href="javascript:void(0)">' + btn_save_list + ' <i class="icon-star"></i></a></div>';
                } else {
                    html += '<div class="btn save-program" data-save-id="' + value.Id + '"><a href="javascript:void(0)">' + btn_save_list + ' <i class="icon-star"></i></a></div>';
                }
                html += '</li>';
                if (i === 3) {
                    html += '<div class="clear"></div>';
                    i = 0;
                }

                elem.append(html);

            });
        } else {
            elem.append('<p class="empty_resource">' + msg_resources_not_found + '.</p>');
        }
    }

    //**************************/
    // Plot Markers
    //**************************/
    khpRAM.Plot = function maps_renderMarkers() {
        //console.log('running Plot func');
        var options,
            data = {},
            bounds = khpRAM.map.getBounds();

        if (!_options.global.blockAjax) {


            // prep screen
            khpRAM.clearMarkers();
            // data required for API request
            data.Bounds = {
                North: bounds.getNorthEast().lat(),
                East: bounds.getNorthEast().lng(),
                South: bounds.getSouthWest().lat(),
                West: bounds.getSouthWest().lng()
            };
            data.Term = search_term;
            data.CategoryCodes = khpRAM.getActiveCats();
            // Ajax Config Object
            options = {
                data: JSON.stringify(data),
                url: api_path + '/api/Search',
                type: "POST",
                dataType: 'json',
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("Authorization", "Bearer 28D3091E-7D69-4DE2-A164-AFD179B66388");
                    if (!lang_en) {
                        xhr.setRequestHeader("Accept-Language", "fr");
                    }
                },
                success: function (response) {
                    //console.log('response = ' + response.ResourcesInBounds.length);
                    if (response.ResourcesInBounds.length === 0) {
                        if ($('#btn-map-view').hasClass('active')) {
                            if ($('.alert').length) {
                                $('.alert').fadeIn();
                            } else {
                                $('body #wrapper').append('<div class="alert">' + msg_resources_not_found + '</div>');
                                $('.alert').fadeIn();
                            }
                        }
                    } else {
                        $('.alert').fadeOut();
                    }
                    options.error = function (e) {
                        //console.log(e.message);
                    }
                    khpRAM.addMarkers(response.ResourcesInBounds);
                    //Get value for face to face - then get the list
                    provinces_in_view = response.ProvincesContainingSearchResults;
                    //console.log('Provinces in View ' + provinces_in_view);
                    khpRAM.PlotNonMap();
                },
                error: function (xhr, status, error) {
                    alert(err_txt_api);
                }
            };
            // Call API
            _options.global.blockAjax = true; // prevent multiple ajax calls from occurring if the user moves around too quickly
            $.ajax(options);
        }
    };
    // Redraw sub-Functions
    // --------------------
    khpRAM.addMarkers = function (ary) {
        //console.log('running addMarkers func');
        var i, length = ary.length,
            j, jL = codeArr.length,
            cat_id,
            image, markerImage,
            latlng, marker,
            clusterOptions = {
                zoomOnClick: false,
                styles: [{
                    url: 'img/mkr/mkr-100.png',
                    height: 26,
                    width: 26,
                    anchor: [7, 10],
                    textColor: '#ffffff',
                    textSize: 11
                }, {
                    url: 'img/mkr/mkr-200.png',
                    height: 52,
                    width: 52,
                    anchor: [19, 18],
                    textColor: '#ffffff',
                    textSize: 13
                }, {
                    url: 'img/mkr/mkr-300.png',
                    height: 78,
                    width: 78,
                    anchor: [30, 25],
                    textColor: '#ffffff',
                    textSize: 15
                }]
            };

        for (i = 0; i < length; i++) {
            if (ary[i].CategoryCodes.length > 1) cat_id = "mkr-100"; //"" is a value for multiple cats
            else {
                for (j = 0; j < jL; j++) {
                    if (codeArr[j] == ary[i].CategoryCodes) cat_id = codeArr[j];
                }
            }
            image = 'img/mkr/' + cat_id + '.png';
            markerImage = new google.maps.MarkerImage(image, new google.maps.Size(28, 28));
            latlng = new google.maps.LatLng(ary[i].Latitude, ary[i].Longitude);
            marker = new google.maps.Marker({
                id: ary[i].Id,
                cat_id: cat_id,
                position: latlng,
                title: ary[i].PublicName,
                icon: markerImage
            });
            google.maps.event.addListener(marker, 'click', function (event) {
                //console.dir(marker);
                khpRAM.showInfo(this.id, 'results');
                khpRAM.loadingIn();
                khpRAM.closeFilters();
            });
            khpRAM.currentMarkers.push(marker);
        }
        if (khpRAM.cluster) {
            khpRAM.cluster.clearMarkers();
            delete khpRAM.cluster;
        }
        khpRAM.cluster = new MarkerClusterer(khpRAM.map, khpRAM.currentMarkers, clusterOptions);
        google.maps.event.addListener(khpRAM.cluster, 'click', function (cluster) {
            var markers;
            //console.log('clicked a cluster');
            //console.dir(cluster);
            if (khpRAM.map.getZoom() < 15) {
                khpRAM.map.setCenter(cluster.getCenter());
                var currZoom = khpRAM.map.getZoom()
                //khpRAM.map.setZoom(15);					  
                khpRAM.map.setZoom(currZoom + 3);
            } else {
                markers = cluster.getMarkers();
                khpRAM.showMultipleInfo(markers);
            }
        });
        _options.global.blockAjax = false;
        khpRAM.loadingOut();
    };

    khpRAM.clearMarkers = function () {
        console.log('running clearMarkers func');
        var i, length = khpRAM.currentMarkers.length;
        if (length > 0) {
            delete khpRAM.currentMarkers;
            khpRAM.currentMarkers = [];
        }
        khpRAM.loading();
    };

    khpRAM.CreateMarker = function (resource, cat_id) {

        image = 'img/mkr-' + cat_id + '.png';
        markerImage = new google.maps.MarkerImage(image, new google.maps.Size(28, 28));
        var marker = new google.maps.Marker({
            id: resource.Id,
            position: new google.maps.LatLng(resource.Latitude, resource.Longitude),
            map: map,
            'icon': markerImage,
            title: resource.PublicName
        });
        //category.markers.push(marker);
        markersArray.push(marker);
        markers.push(marker);

        //var markerCluster = new MarkerClusterer(map, markers);

    }

    //**************************/
    //Autocomplete
    //**************************/
    khpRAM.citySelect = (document.getElementById('city_select_field'));
    khpRAM.autoCompleteOptions = {
        types: ['(regions)'],
        //types: ['(cities)'],
        componentRestrictions: {
            country: 'ca'
        }
    };
    khpRAM.autocomplete = new google.maps.places.Autocomplete(khpRAM.citySelect, khpRAM.autoCompleteOptions);
    google.maps.event.addListener(khpRAM.autocomplete, 'place_changed', khpRAM.verifyLocation);
    if (skipCitySelect) {
        khpRAM.verifyLocation();
    }


    // Initialize Marker Management
    // ----------------------------
    khpRAM.initMarkerMgmt = function () {
        google.maps.event.addListener(khpRAM.autocomplete, 'place_changed', khpRAM.initMarkerRefresh);
    };
    khpRAM.initMarkerRefresh = function () {
        google.maps.event.addListener(khpRAM.map, 'idle', khpRAM.Plot);
    };
    google.maps.event.addDomListener(window, 'load', khpRAM.initMarkerMgmt);

    //$('.testid').hide();
    //<a class="testid" href="#" rel="sr10639341_en">Test</a>  <a class="testid" href="#" rel="sr10639341_en">Test Hours</a>  
    $('.testid').click(function () {
        var id = $(this).attr('rel');
        khpRAM.showInfo(id, 'detail');
    })

    //Show info by resource Id
    khpRAM.showInfo = function (id, container) {
        $.ajax({
            dataType: "json",
            url: api_path + '/api/Resource/' + id,
            crossDomain: true,
            type: 'GET',
            contentType: 'application/json;charset=utf-8',
            beforeSend: function (xhr) {
                xhr.setRequestHeader("Authorization", "Bearer 28D3091E-7D69-4DE2-A164-AFD179B66388");
            },
            error: function (xhr) {
                alert(err_txt_api);
            },
            success: function (value) {
                console.log(value);
                var el = '#' + container;
                khpRAM.loadingOut();
                switch (container) {
                    //Single result click
                    case 'results':
                        var html = '<li data-id=' + id + ' class="clearfix">';

                        html += '<h4><span class="cat"><img src="img/mkr/' + khpRAM.catIcon(value.CategoryCodes) + '.png"></span> ' + value.PublicName + '</h4>';

                        //html += '<span class="category"><span><img src="img/'+khpRAM.catIcon(value.CategoryCodes)+'.png"></span>'+khpRAM.listCats(value, value.CategoryCodes)+'</span>';
                        html += '<span class="category ' + khpRAM.catIcon(value.CategoryCodes) + '">' + khpRAM.listCats(value, value.CategoryCodes) + '</span>';

                        html += '<span class="address">';
                        if (value.AgencyName) {
                            html += '<strong>' + value.AgencyName + "</strong><br/>";
                        }
                        if (value.AddressLine1) {
                            html += value.AddressLine1 + "<br/>";
                        }
                        if (value.City) {
                            html += value.City;
                        }
                        if (value.Province) {
                            html += ", " + value.Province;
                        }
                        if (value.PostalCode) {
                            html += ", " + value.PostalCode;
                        }

                        if (value.PhoneNumber) {
                            html += '<br/>' + value.PhoneNumber;
                        }
                        html += '</span>';

                        if (value.Description) {
                            var txt = value.Description;
                            if (txt.length > 130) {
                                txt = txt.substr(0, 130) + "...</p>";
                            }
                            html += '<span class="desc">' + txt + '<br/><br/><a href="javascript: void(0);" class="more-info">&rarr; ' + btn_more_info + '</a></span>';
                        } else {
                            html += '<span class="desc"><a href="javascript: void(0);" class="more-info">&rarr; ' + btn_more_info + '</a></span>';
                        }


                        if (khpRAM.disableSave(id)) {
                            html += '<div class="btn save-program disabled" data-save-id="' + id + '"><a href="javascript:void(0)">' + btn_save_list + ' <i class="icon-star"></i></a></div>';
                        } else {
                            html += '<div class="btn save-program" data-save-id="' + id + '"><a href="javascript:void(0)">' + btn_save_list + ' <i class="icon-star"></i></a></div>';
                        }
                        html += '</li>';

                        //$('.scrollable ul', el).html('').append(html);
                        var elem = $('.scrollable ul', el);
                        var wrapper = $('.container', el);
                        khpRAM.displayResults(elem, wrapper, html);

                        break;

                        // * DETAIL SCREEN * //              
                    case 'detail':
                        var html = '';
                        html += '<h1><span class="cat"><img src="img/mkr/' + khpRAM.catIcon(value.CategoryCodes) + '.png"></span> ' + value.PublicName + '</h1>';
                        html += '<span class="category">' + khpRAM.listCats(value, value.CategoryCodes) + '</span>';

                        html += '<div class="detail-wrap">';

                        html += '<div class="content-col">';

                        if (value.AgencyName) {
                            html += '<strong>' + value.AgencyName + "</strong><br/>";
                        }
                        if (value.AddressLine1) {
                            html += value.AddressLine1 + "<br/>";
                        }
                        if (value.City) {
                            html += value.City;
                        }
                        if (value.Province) {
                            html += ", " + value.Province;
                        }
                        if (value.PostalCode) {
                            html += ", " + value.PostalCode;
                        }
                        //If resource is mapped 
                        if (value.AddressLine1) {
                            html += '<br/><a href="http://maps.google.com/maps?z=12&t=m&f=d&daddr=' + value.AddressLine1 + '+' + value.City + '+' + value.Province + '" target="_blank">' + txt_directions + '</a>';
                        }

                        var hours = false;
                        if (typeof value.HoursOfOperation != 'undefined' && value.HoursOfOperation.length > 0) {
                            hours = true;
                        }
                        if (hours) {
                            if (typeof value.HoursOfOperation != 'undefined' && value.HoursOfOperation.length > 0) {
                                html += '<br><br><span class="hours"><strong style="display: block; margin-bottom:5px;">' + txt_hours + ':</strong>' + khpRAM.getHours(value, value.HoursOfOperation) + '</span>';
                            }
                        }

                        html += '</div>';

                        //Description                       
                        if (value.Description) {
                            html += '<div class="content-col wide"><strong style="display: block; margin-bottom:5px;">' + txt_description + ': </strong>' + value.Description + '</div>';
                        }

                        if (value.WebsiteAddress || value.PhoneNumber || value.EligibilityByAge || value.Eligibility) {
                            html += '<div class="content-col">';

                            if (value.PhoneNumber) {
                                html += '<strong style="display: block; margin-bottom:5px;">' + txt_phone + ':</strong>' + value.PhoneNumber + '<br/><br/>';
                            }
                            if (value.WebsiteAddress) {
                                var web_str = value.WebsiteAddress.toLowerCase();
                                if (web_str && !web_str.match(/^http([s]?):\/\/.*/)) {
                                    web_str = 'http://' + web_str;
                                }
                                html += '<strong style="display: block; margin-bottom:5px;">' + txt_website + ': </strong><a href="' + web_str + '" target="_blank">' + web_str + '</a><br/><br/>';
                            }

                            if (value.Eligibility) {
                                html += '<strong style="display: block; margin-bottom:5px;">' + txt_eligibilty + ': </strong>' + value.Eligibility + '<br/><br/>';
                            }

                            if (value.EligibilityByAge) {
                                var eba_length = value.EligibilityByAge.length;

                                var eba_1 = value.EligibilityByAge[1];
                                eba_1 = eba_1.replace(">", "").replace("<", "");

                                var eba_2 = value.EligibilityByAge[eba_length - 1];
                                eba_2 = eba_2.replace(">", "").replace("<", "");

                                html += '<strong style="display: block; margin-bottom:5px;">' + txt_ages + ': </strong>' + eba_1 + ' - ' + eba_2 + '<br/><br/>';
                            }

                            html += '</div>';
                        }

                        if (value.ApplicationProcess || value.ProgramFees || value.DocumentsRequired) {
                            html += '<div class="content-col">';

                            if (value.ProgramFees) {
                                html += '<strong style="display: block; margin-bottom:5px;">' + txt_fees + ': </strong>' + value.ProgramFees + '<br/><br/>';
                            }

                            if (value.ApplicationProcess) {
                                html += '<strong style="display: block; margin-bottom:5px;">' + txt_application + ': </strong>' + value.ApplicationProcess + '<br/><br/>';
                            }

                            if (value.DocumentsRequired) {
                                html += '<strong style="display: block; margin-bottom:5px;">' + txt_documents + ': </strong>' + value.DocumentsRequired + '<br/><br/>';
                            }

                            html += '</div>';
                        }
                        html += '</div>';
                        //Close .detail-wrap                                        
                        html += '<div class="clear"></div><hr/>';


                        if (lang_en) {
                            html += '<div class="btn suggest-update" data-id="' + id + '"><a href="http://www.kidshelpphone.ca/suggest-an-update/?id=' + id + '" target="_blank">' + btn_suggest_update + ' <i class="icon-edit"></i></a></div>';
                        } else {
                            html += '<div class="btn suggest-update" data-id="' + id + '"><a href="http://jeunessejecoute.ca/suggest-an-update/?id=' + id + '" target="_blank">' + btn_suggest_update + ' <i class="icon-edit"></i></a></div>';
                        }
                        if (khpRAM.disableSave(id)) {
                            html += '<div class="btn save-program disabled" data-save-id="' + id + '"><a href="javascript:void(0)">' + btn_save_list + ' <i class="icon-star"></i></a></div>';
                        } else {
                            html += '<div class="btn save-program" data-save-id="' + id + '"><a href="javascript:void(0)">' + btn_save_list + ' <i class="icon-star"></i></a></div>';
                        }
                        html += '</div>';

                        // .detail-wrap
                        html += '</div>';

                        html += '<div class="clear"></div>';

                        $('#info-modal div.scrollable').append(html);
                        khpRAM.displayInfoModal();

                        break;

                        // * My List * // 
                    case 'my-list':
                        var myListDetailItem = new Object();
                        myListDetailItem.id = id;
                        var categories = khpRAM.listCats(value, value.CategoryCodes);
                        myListDetailItem.categories = categories;
                        myListDetailItem.publicName = value.PublicName;

                        var html = '<li data-id=' + id + ' class="clearfix">';
                        html += '<div class="remove" data-id=' + id + '><i class="icon-remove"></i></div>';
                        html += '<h4><span class="cat"><img src="img/mkr/' + khpRAM.catIcon(value.CategoryCodes) + '.png"></span> ' + value.PublicName + '</h4>';
                        html += '<span class="category">' + categories + '</span>';

                        html += '<span class="address">';
                        if (value.AgencyName) {
                            html += '<strong>' + value.AgencyName + "</strong><br/>";
                            myListDetailItem.agencyName = value.AgencyName;
                        }
                        //If resource is mapped 
                        if (value.AddressLine1) {
                            if (value.AddressLine1) {
                                var addrLine1 = value.AddressLine1;
                                html += addrLine1 + "<br/>";
                                myListDetailItem.addressLine1 = addrLine1;
                            }
                            if (value.City) {
                                var city = value.City;
                                html += city;
                                myListDetailItem.city = city;
                            }
                            if (value.Province) {
                                var prov = value.Province;
                                html += ", " + prov;
                                myListDetailItem.province = prov;
                            }
                            if (value.PostalCode) {
                                var pc = value.PostalCode;
                                html += ", " + pc;
                                myListDetailItem.postalCode = pc;
                            }
                        }

                        //Phone Number
                        if (value.PhoneNumber) {
                            var phone = value.PhoneNumber;
                            html += '<br/>' + phone;
                            myListDetailItem.phoneNumber = phone;
                        }

                        //website
                        if (value.WebsiteAddress) {
                            var web = value.WebsiteAddress;
                            html += '<div class="website"><strong style="display: block; margin-bottom:5px;">' + txt_website + ': </strong><a href="' + web + '" target="_blank">' + web + '</a></div>';
                            myListDetailItem.websiteAddress = web;
                        }

                        //Hours of Operation                           		
                        if (typeof value.HoursOfOperation != 'undefined' && value.HoursOfOperation.length > 0) {
                            var hours = khpRAM.getHours(value, value.HoursOfOperation);
                            html += '<div class="hours"><p style="display: block; font-weight:bold; margin-bottom:5px;">' + txt_hours + ':</p>' + hours + '</p></div>';
                            myListDetailItem.hoursOfOperation = hours;
                        }

                        html += '</span>';


                        if (value.Description) {
                            var txt = value.Description;
                            myListDetailItem.description = txt;
                            if (txt.length > 130) {
                                txt = txt.substr(0, 130) + "...</p>";
                            }
                            html += '<span class="desc">' + txt + '<br/><br/><a href="javascript: void(0);" class="more-info">&rarr; ' + btn_more_info + '</a></span>';
                        } else {
                            html += '<span class="more-info"><a href="javascript: void(0);">&rarr; ' + btn_more_info + '</a></span>';
                        }
                        html += '</li>';
                        myListDetailArr.push(myListDetailItem);
                        $('.scrollable ul', el).append(html);
                        khpRAM.updateList();
                        break;
                }
            }
        });
        khpRAM.loadingOut();
    }


    //Show info by resource Id
    khpRAM.showMultipleInfo = function (arr) {
        var arrLength = arr.length;
        var i = 0;
        var html = '';
        var el = '#results';
        var type = 'multiple';
        khpRAM.loadingIn();

        function loopResults() {
            if (i < arr.length) {
                khpRAM.closeFilters();
                var id = arr[i].id;
                console.log('array = ' + id)
                var val = arr[i];
                $.ajax({
                    dataType: "json",
                    url: api_path + '/api/Resource/' + id,
                    crossDomain: true,
                    type: 'GET',
                    contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("Authorization", "Bearer 28D3091E-7D69-4DE2-A164-AFD179B66388");
                    },
                    error: function (xhr) {
                        alert(err_txt_api);
                    },
                    success: function (value) {
                        html += '<li data-id=' + value.Id + ' class="expanding clearfix">';
                        html += '<h4><span class="cat"><img src="img/mkr/' + khpRAM.catIcon(value.CategoryCodes) + '.png"></span>' + value.PublicName + '<i class="icon-chevron-down"></i><i class="icon-chevron-up"></i></h4>';
                        html += '<div class="expand">';

                        html += '<span class="category">' + khpRAM.listCats(value, value.CategoryCodes) + '</span>';

                        html += '<span class="address">';
                        if (value.AgencyName) {
                            html += '<strong>' + value.AgencyName + "</strong><br/>";
                        }
                        if (value.AddressLine1) {
                            html += value.AddressLine1 + "<br/>";
                        }
                        if (value.City) {
                            html += value.City;
                        }
                        if (value.Province) {
                            html += ", " + value.Province;
                        }
                        if (value.PostalCode) {
                            html += ", " + value.PostalCode;
                        }
                        html += '</span>';

                        if (value.PhoneNumber) {
                            html += '<span class="phone">' + value.PhoneNumber + '</span>';
                        }

                        if (value.Description) {
                            var txt = value.Description;
                            if (txt.length > 130) {
                                txt = txt.substr(0, 130) + "...</p>";
                            }
                            html += '<span class="desc">' + txt + '<br/><br/><a href="javascript: void(0);" class="more-info">&rarr; ' + btn_more_info + '</a></span>';
                        } else {
                            html += '<span class="desc"><a href="javascript: void(0);" class="more-info">&rarr; ' + btn_more_info + '</a></span>';
                        }

                        if (khpRAM.disableSave(id)) {
                            html += '<div class="btn save-program disabled" data-save-id="' + value.Id + '"><a href="javascript:void(0)">' + btn_save_list + ' <i class="icon-star"></i></a></div>';
                        } else {
                            html += '<div class="btn save-program" data-save-id="' + value.Id + '"><a href="javascript:void(0)">' + btn_save_list + ' <i class="icon-star"></i></a></div>';
                        }
                        html += '</div>';

                        html += '</li>';
                        i++;
                        loopResults();
                    }
                });
            } else {
                var elem = $('.scrollable ul', el);
                var wrapper = $('.container', el);
                khpRAM.displayResults(elem, wrapper, html);
            }
        }
        loopResults();
    }

    $(document.body).on('click', '.expanding h4', function () {
        var parent = $(this).parent('li');
        if (parent.hasClass('active')) {
            $(this).next('.expand').slideUp(_options.global.slideSpeed, 'easeInOutQuad', function () {
                parent.removeClass('active');
            });
        } else {
            $(this).next('.expand').slideDown(_options.global.slideSpeed, 'easeInOutQuad', function () {
                parent.addClass('active');
            });
        }


    });

    //***********************************************
    // Display Results after clicking a marker
    //***********************************************
    khpRAM.displayResults = function (elem, wrapper, html) {
        if (wrapper.hasClass('active')) {
            wrapper.slideUp(_options.global.slideSpeed, _options.global.easing, function () {
                elem.html('').append(html);
                wrapper.delay(250).slideDown(_options.global.slideSpeed, _options.global.easing, function () {
                    wrapper.addClass('active');
                });
            });
        } else {
            wrapper.hide();
            elem.html('').append(html);
            wrapper.delay(250).slideDown(_options.global.slideSpeed, _options.global.easing, function () {
                wrapper.addClass('active');
            });
        }
        khpRAM.loadingOut();
    }

    $('#results .close').click(function () {
        $('#results .container').slideUp(_options.global.slideSpeed, _options.global.easing, function () {
            $('.scrollable ul', this).html('');
            $('#results .container').removeClass('active');
        });
    });

    $(document.body).on('click', '.more-info a, a.more-info', function () {
        var id = $(this).closest('li').data('id');
        khpRAM.loadingIn();
        khpRAM.showInfo(id, 'detail');
    });

    //***********************************************
    // '+btn_more_info+' Modal
    //***********************************************
    khpRAM.displayInfoModal = function (id) {
        var el = $('#info-modal');
        el.attr('data-id', id);
        el.addClass('active');
        el.fadeIn(_options.global.speed, function () {
            if (!isInit) {
                //khpRAM.loading();
            }
        });

    }
    $('.info-modal-wrap .close-modal').click(function () {
        var el = $('#info-modal');
        el.removeClass('active');
        el.fadeOut(_options.global.speed, function () {
            $('.info-modal-wrap .scrollable', el).html('');
        });
    });

    //khpRAM.showInfo('sr13345944_en', 'detail');
    //khpRAM.showInfo('sr10639340_en', 'detail');

    //***********************************************
    // Get Hours of Operation
    //***********************************************
    khpRAM.getHours = function (value, arr) {
        //Get Cat Codes
        var theCats = [],
            theHours = '';
        $.each(arr, function (e) {
            if (arr[e].DayOfWeek) {
                var day = arr[e].DayOfWeek;
                theHours += '<span class="day">' + khpRAM.getDayofWeek(day) + '</span> ';
            }
            if (arr[e].Opens) {
                theHours += arr[e].Opens + 'am';
            }
            if (arr[e].Closes) {
                theHours += ' - ' + arr[e].Closes + 'pm<br/>';
            }
        });

        return theHours;
    }

    khpRAM.getDayofWeek = function (day) {

        if (day == "M") day = txt_mon;
        if (day == "T") day = txt_tues;
        if (day == "W") day = txt_weds;
        if (day == "TH") day = txt_thurs;
        if (day == "F") day = txt_fri;
        if (day == "S") day = txt_sat;
        if (day == "SU") day = txt_sun;
        return day;
    }


    //***********************************************
    // Get Categoy list for use in results, my list and '&rarr; '+btn_more_info+'' lightbox
    //***********************************************
    khpRAM.listCats = function (value, arr) {
        //Get Cat Codes
        var theCats = [];
        $.each(arr, function (e) {
            var loop = e;
            var item = value.CategoryCodes[e];
            //Find current cat code and trnaform that into the cat name            
            $.each(codeArr, function (i) {
                if (codeArr[i] == item) {
                    if (loop > 0) {
                        theCats.push(' ' + categoryArr[i]);
                    } else {
                        theCats.push(categoryArr[i]);
                    }
                }
            });
        });

        return theCats;
    }

    //***********************************************
    // Get category icons for results, my-list and model window
    //*********************************************** 	
    khpRAM.catIcon = function (categories) {
        var theLength = categories.length;
        var catIcon = 'mkr-100';
        if (theLength == 1) {
            $.each(codeArr, function (i) {
                //console.log(codeArr[i]);                        
                if (categories[0] == codeArr[i]) {
                    catIcon = codeArr[i];
                }
            });
        }
        return catIcon;
    }


    //***********************************************
    // Program Types
    //***********************************************

    //Get Active Categories for the filtering of Program Types
    var uncheck_all = false;
    khpRAM.getActiveCats = function () {
        var catArray = [];
        $('#program-type ul li:not(.all)').each(function () {
            var $el = $(this),
                code = $el.data('type');
            if (!$(this).hasClass('inactive')) {
                catArray.push(code);
            }
        });
        if (uncheck_all && catArray.length === 0) {
            catArray.push('blah');
        }
        //console.log(catArray);
        return catArray;
    }


    //***********************************************
    // My List
    //***********************************************

    var myListArr = [];
    //Open List Menu
    $('#my-list .list-btn').click(function () {
        var $container = $('#my-list .container');
        var $parent = $('#my-list');
        var $el = $(this);
        if ($parent.hasClass('active')) {
            $container.slideUp(_options.global.slideSpeed, _options.global.easing, function () {
                $parent.removeClass('active');
            });

        } else {
            $container.slideDown(_options.global.slideSpeed, _options.global.easing, function () {
                $parent.addClass('active');
            });
        }
    });
    khpRAM.closeMyList = function () {
        $('#my-list .container').slideUp(_options.global.slideSpeed, _options.global.easing, function () {
            $('#my-list').removeClass('active');
        });

    };
    //***********************************************
    // Save to My List
    //***********************************************		
    var found;
    $(document.body).on('click', '.save-program a', function () {
        found = false;
        $(this).closest('.save-program').addClass('disabled');
        var id = $(this).closest('.save-program').data('save-id');

        //Loop thru each Save Program btn.
        $('.save-program').each(function () {
            if ($(this).data('save-id') === id) {
                $(this).addClass('disabled');
            }
        })
        //alert(myListArr.length);
        //If myListArr is null, add the first element	
        if (myListArr.length < 1) {
            myListArr.push(id);
            var el = $('#my-list ul');
            khpRAM.showInfo(id, 'my-list');
            khpRAM.highlight($('#my-list .list-btn span.total'));
        } else {
            //Loop thru the myListArr to locate a match
            $.each(myListArr, function (i) {
                if (myListArr[i] == id) {
                    found = true;
                }
            });
            if (!found) {
                myListArr.push(id);
                var el = $('#my-list ul');
                khpRAM.showInfo(id, 'my-list');
                console.log(id + ' added to my list');
                khpRAM.highlight($('#my-list .list-btn span.total'));
            }
        }
    });

    //***********************************************
    // Update My-List
    //***********************************************
    khpRAM.updateList = function () {
        $('#my-list .list-btn span.total').text(myListArr.length);
        if (myListArr.length === 0) {
            $('#my-list .list-btn').removeClass('active');
            $('.save-program').removeClass('disabled');
            $('#my-list ul').html('').append('<div class="empty"><p>' + my_list_msg + '</p></div>');
            $('#my-list ul div.empty').slideDown(_options.global.slideSpeed, _options.global.easing);
            $('#my-list .clear-list').addClass('disabled');
            $('#my-list .print-list').addClass('disabled');
            $('#my-list .email-list').addClass('disabled');
        } else {
            $('#my-list .list-btn').addClass('active');
            $('#my-list .clear-list').removeClass('disabled');
            $('#my-list .print-list').removeClass('disabled');
            $('#my-list .email-list').removeClass('disabled');
            $('#my-list ul div.empty').remove();
        }
    }

    khpRAM.highlight = function (el) {
        el.addClass("active").delay(1000).queue(function () {
            $(this).removeClass("active");
            $(this).dequeue();
        });
    }


    khpRAM.clearFields = function () {
        // clear email field & email validation message 		
        $('#email-address').val('');
        $('#email-list-form .validation').html('').hide();
    }

    khpRAM.hideEmailContent = function () {
        $('#my-list #email-list-fields').hide();
        $('#my-list .intro').html('');
        $('#email-list-fields .message').html('');
        khpRAM.clearFields();
    }

    khpRAM.showMyListContent = function () {
        $('#my-list #printable').show();
        $('#my-list .intro').html(my_list_intro);
    }

    //***********************************************
    // Clear My-List - remove the entire myListArr[] Array
    //***********************************************

    $('#my-list .clear-list').click(function () {
        if (!$(this).hasClass('disabled')) {
            var result = confirm(clear_list_msg);
            if (result) {
                if (!$(this).parent().hasClass('disabled')) {
                    $('#my-list li').each(function () {
                        $(this).addClass('removing');
                        $(this).delay(150).slideUp(350, 'easeOutQuad', function () {
                            myListArr = [];
                            myListDetailArr = [];
                            khpRAM.updateList();
                        });
                    });

                    khpRAM.hideEmailContent();
                    khpRAM.showMyListContent();

                }

            }
        }
    });

    //***********************************************
    // Remove from My-List
    //***********************************************
    $(document.body).on('click', '#my-list ul li .remove', function () {
        var id = $(this).parent('li').data("id");
        var el = $(this).parent('li');
        khpRAM.removeFromList(id, el);

        if ($('li').data('id') == id || $('li').data('save-id') == id) {
            $('#results .save-program').removeClass('disabled');
        }

    });

    //Remove Item from myListArr[] Array
    khpRAM.removeFromList = function (id, el) {
        el.addClass('removing');
        el.delay(150).slideUp(350, 'easeOutQuad', function () {
            var removeItem = id;
            myListArr.splice($.inArray(removeItem, myListArr), 1);

            myListDetailArr = myListDetailArr.filter(function (obj) {
                return obj.id !== id;
            });

            console.log(myListArr);
            khpRAM.updateList();
        });
    }

    //***********************************************
    // Disable 'Add to List' btn
    //***********************************************
    khpRAM.disableSave = function (id) {
        var isActive = false;
        //Loop current My List Array
        $.each(myListArr, function (i) {
            if (id == myListArr[i]) isActive = true;
        });
        return isActive;
    }

    //***********************************************
    // Search term
    //*********************************************** 
    var search_term = '';
    $('.search-box input.submit').click(function () {
        term = $('.search-box input[type=text]').val();
        if (term !== '') {
            search_term = term;
            khpRAM.Plot();
            $('#results .close').click();
            $('.clear-search').fadeIn();
        }
    })
    $('.clear-search').click(function () {
        term = '';
        search_term = '';
        $('.search-box input[type=text]').val('');
        khpRAM.Plot();
        $('.clear-search').fadeOut();
    });

    $('.search-box input[type=text]').keypress(function (event) {
        if (event.keyCode == 13) {
            $('.search-box input.submit').click();
        }
    });

    //***********************************************
    // Create Categories/Program Types
    //***********************************************
    var categoryArr = [];
    var codeArr = [];
    function loadCategories() {
        $.support.cors = true;
        $.ajax({
            dataType: "json",
            url: api_path + '/api/Category',
            cache: false,
            crossDomain: true,
            type: 'GET',
            contentType: 'application/json;charset=utf-8',
            beforeSend: function (xhr) {
                xhr.setRequestHeader("Authorization", "Bearer 28D3091E-7D69-4DE2-A164-AFD179B66388");
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(err_txt_api);
            },
            success: function (catValue) {
                var count = catValue.length;
                console.log("VALUE LENGTH = " + catValue.length);
                $.each(catValue, function (c) {
                    if (lang_en) {
                        categoryArr.push(catValue[c]['DescriptionEN']);
                    } else {
                        categoryArr.push(catValue[c]['DescriptionFR']);
                    }
                    codeArr.push(catValue[c]['Code']);
                    if (!--count) khpRAM.createCats();
                });
            },
            statusCode: {
                403: function () { },
                200: function (data) { },
                500: function (data) { }
            }
        });
    }

    //Create categories
    khpRAM.createCats = function () {
        var el = $('#program-type ul');
        var el_legend = $('#legend ul');

        if (categoryArr.length > 1) {
            var count = categoryArr.length,
                num = 0,
                append = '',
				legend = '';

            $.each(categoryArr, function (cat) {
                num++;
                legend = '<li title="' + categoryArr[cat] + '"><img src="img/mkr/' + codeArr[cat] + '.png"><span><div class="arrow"></div>' + categoryArr[cat] + '</span></li>';
                append = '<li data-type="' + codeArr[cat] + '" class="' + codeArr[cat] + '"><a href="javascript:void(0)"><div class="mkr-wrap"><img src="img/mkr/' + codeArr[cat] + '.png"></div>' + categoryArr[cat] + '</a></li>';

                el.append(append);
                el_legend.append(legend);
            });
            khpRAM.init();
            alphaProgramCats()
        }
    }

    //Alphabetize the categories
    function alphaProgramCats() {
        //Order program categories by alpha
        var proglist = $('#prog-cats');
        /*
var listitems = proglist.children('li').get();
        listitems.sort(function (a, b) {
            return $(a).text().toUpperCase().localeCompare($(b).text().toUpperCase());
        })
        $.each(listitems, function (idx, itm) {
            proglist.append(itm);
        });
*/
        proglist.append('<li class="all"><a href="javascript:void(0)">' + btn_select_all + '</a></li>');
        alphaLegendCats();
    }

    function alphaLegendCats() {
        //Order program categories by alpha
        var legendlist = $('#legend-cats');
        /*
var listitems = legendlist.children('li').get();
        listitems.sort(function (a, b) {
            return $(a).text().toUpperCase().localeCompare($(b).text().toUpperCase());
        })
        $.each(listitems, function (idx, itm) {
            legendlist.append(itm);
        });
*/
        legendlist.prepend('<li class="legend">' + ttl_legend + '</li>');
        legendlist.append('<li title="' + btn_multiple_resources + '"><img src="img/mkr/mkr-100.png"><span><div class="arrow"></div>' + btn_multiple_resources + '</span></li>');
    }


    // Category Filtering
    $(document.body).on('click', '#program-type ul li', function () {
        var catArray = [];
        var catActive = 0;
        var el = $(this);
        var list = $('#program-type ul');

        if (el.hasClass('all')) {
            if (el.hasClass('inactive')) {
                $('li', list).removeClass('inactive');
            } else {
                $('li', list).addClass('inactive');
            }
        } else {
            if (el.hasClass('inactive')) {
                el.removeClass('inactive');
                $('li.all', list).addClass('inactive');
            } else {
                el.addClass('inactive');
                $('li.all', list).addClass('inactive');
            }
        }
        // Loop thru links to get active btns
        $('#program-type ul li:not(.all)').each(function () {
            if (!$(this).hasClass('inactive')) catActive++;
        });

        uncheck_all = false;
        if (catActive === 0) {
            uncheck_all = true;
            $('li.all', list).addClass('inactive');
        }
        khpRAM.Plot();
    });


    //Open/Close Program Menu
    $('#program-type .list-btn').click(function () {
        var $container = $('#program-type ul');
        var $parent = $('#program-type');
        var $el = $(this);
        if ($parent.hasClass('active')) {
            $container.slideUp(_options.global.slideSpeed, _options.global.easing, function () {
                $parent.removeClass('active');
            });
        } else {
            $parent.addClass('active');
            $container.slideDown(_options.global.slideSpeed, _options.global.easing, function () { });

        }
    });

    khpRAM.closeFilters = function () {
        if ($('#program-type').hasClass('active')) {
            $('#program-type ul').slideUp(_options.global.slideSpeed, _options.global.easing, function () {
                $('#program-type').removeClass('active');
            });
        }
    }


    //Loading Animation
    khpRAM.loading = function () {
        var l = $('#loading');
        if (l.hasClass('load')) l.removeClass('load').fadeOut(_options.global.speed);
        else l.addClass('load').fadeIn(_options.global.speed);
    }
    khpRAM.loadingIn = function () {
        var l = $('#loading');
        l.addClass('load').fadeIn(_options.global.speed);
    }
    khpRAM.loadingOut = function () {
        var l = $('#loading');
        l.removeClass('load').fadeOut(_options.global.speed);
    }

    //**************************/
    //Lightbox
    //**************************/
    $(document.body).on('click', '.suggest-resource', function () {
        var url;
        if (lang_en) {
            url = "https://webapp.icarol.com/pub/VerifyResourcePublic2.aspx?org=2308&r=0&k=9ue3Klc11P&culture=en&IntroText=No";
        } else {
            url = "https://webapp.icarol.com/pub/VerifyResourcePublic2.aspx?org=2308&r=0&k=9ue3Klc11P&culture=fr&IntroText=No";
        }
        khpRAM.lightbox(url, 'suggest');
    });

    khpRAM.lightbox = function (url, clicked) {
        var intro_paragraph = '';
        if (clicked == 'suggest') {
            intro_paragraph = '<p>' + txt_lightbox_intro + '</p>';
        }

        if ($('#lightbox').length === 0) {
            $('body').append('<div id="lightbox"><div class="lb-wrap">' + intro_paragraph + '<iframe src="' + url + '"></iframe><div class="btn close-lightbox"><a href="javascript:void(0)">' + btn_close + ' <i class="icon-remove"></i></a></div></div></div>');
            $('#lightbox').fadeIn(_options.global.slideSpeed);
        }
    }
    khpRAM.closeLB = function () {
        $('#lightbox').fadeOut(_options.global.slideSpeed, function () {
            $('#lightbox').remove();
        });
    };
    $(document.body).on('click', '#lightbox, .close-lightbox', khpRAM.closeLB);
    $(document.body).on('click', '.lb-wrap', function (event) {
        event.stopPropagation();
    });

    $('#browser-alert .close').click(function () {
        $('#browser-alert').slideUp();
    });

    $('.search-again').click(function () {
        isInit = true;
        $('#city-select .remove').show();
        $('#city_select_field').val('');
        $('#map-toggle li#btn-map-view').click();
        $('#map-toggle').fadeOut(_options.global.speed);
        khpRAM.closeFilters();
        khpRAM.closeMyList();
        $('#results .close').click();
        $('#actions').fadeOut();
        $('#city-select').fadeIn(300, function () {
            $('#city_select_field').focus();
        });
        //location.reload(); 
    });
    $('#city-select .remove').click(function () {
        $('#city-select').fadeOut(300);
        $('#actions').fadeIn(300);
        $('#map-toggle').fadeIn(_options.global.speed);
    })
    //Resize handler		
    var bodyH = $(window).height();
    var h = bodyH - 420;
    $("#non-map-view .scrollable").css('max-height', h + 'px');
    $("#results .scrollable").css('max-height', h + 'px');

    $(window).resize(function () {
        bodyH = $(window).height();
        h = bodyH - 420;
        $("#non-map-view .scrollable").css('max-height', h + 'px');
        $("#results .scrollable").css('max-height', h + 'px');
    });
    emailListArr = myListArr;
};
khpMap();