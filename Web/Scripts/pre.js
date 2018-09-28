// nmain application namespace object
var khpRAM = {};


function getQueryVariable(variable)
{
       var query = window.location.search.substring(1),
           vars = query.split("&");
       for (var i=0;i<vars.length;i++) {
               var pair = vars[i].split("=");
               if(pair[0] == variable){return pair[1];}
       }
       return(false);
}
function getLocation(href) 
{
    var location = document.createElement("a");
    location.href = href;
    // IE doesn't populate all link properties when setting .href with a relative URL,
    // however .href will return an absolute URL which then can be used on itself
    // to populate these additional fields.
    if (location.host == "") {
      location.href = location.href;
    }
    return location;
};
var a = getLocation(window.location.pathnam);

var api_path = "http://khpapi.ecentricarts.com",
    img_path = '',
    lang = getQueryVariable("lang"),
	lat = getQueryVariable("lat"),
	lng = getQueryVariable("lng"),
	skipCitySelect = false,
	dir = '/en/';
	

if(lang === 'fr' || a.hostname == 'jeunessejecoute.ca'){
	lang_en = false;
	dir = '/fr/';
}
else{
	lang_en = true;
	dir = '/en/';
}

if(lat && lng){
	skipCitySelect = true;
}


