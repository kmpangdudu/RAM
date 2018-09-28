using BIZ.Log;
using BIZ.Search;
using DATA.EF;
using Newtonsoft.Json;
using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;
using System.Web.Http.Description;
using WebApi.Filters;

namespace WebApi.Controllers
{
    /// <summary>
    /// Search resource by using interest keyword(s), category, city, province location etc. 
    /// </summary>
    [AuthorizeIPAddress]
    [FilterIP]
    public class SearchController : ApiController
    {
        private SearchServices searchservice = new SearchServices();
        HttpResponseMessage response = new HttpResponseMessage();
        HttpRequest request = HttpContext.Current.Request;
        LogServices logservices = new LogServices();


        #region Search
        #region JSON
        //Friendly
        /// <summary>
        /// Search resource by using interest key word(s).  
        /// </summary>
        /// <param name="kws">interest key words to be search. Multiple interesting kords could be split by using Space, comma, semicolon</param>
        /// <param name="lang">Language. English = "en"; French = "fr"</param>
        /// <param name="token">Access token</param>
        /// <returns>Return resource list. Returned resource includes any interest search key words or their synonym in his name, description, location, term, category etc. Format in JSON</returns>
        [ActionName("search")]
        [Route("api/v2/Search/json/{token}/{lang}/{kws}")]
        [Route("api/v2/Chercher/json/{token}/{lang}/{kws}")]
        [ResponseType(typeof(Search_Result))]
        [HttpGet]
        public HttpResponseMessage search(string kws,string lang, string token )
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var json = searchservice.SearchByKeywords(kws, lang, token).ToList();
            response = toJson(json, lang);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "json", "path", lang, token, "search", "search", kws);
            return response;
        }
        //Query String
        /// <summary>
        /// Query String style cluster search resource by using interest key word(s).  
        /// </summary>
        /// <param name="kws">interest key words to be search. Multiple interesting kords could be split by using Space, comma, semicolon</param>
        /// <param name="lang">Language. English = "en"; French = "fr"</param>
        /// <param name="token">Access token</param>
        /// <returns>Return resource list. Returned resource includes any interest search key words or their synonym in his name, description, location, term, category etc. Format in JSON</returns>
        [ActionName("search")]
        [Route("api/v2/Search/json")]
        [Route("api/v2/Chercher/json")]
        [ResponseType(typeof(Search_Result))]
        [HttpGet]
        public HttpResponseMessage search_QS(string lang, string kws, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var json = searchservice.SearchByKeywords(kws, lang, token).ToList();
            response = toJson(json, lang);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "json", "query", lang, token, "search", "search", kws);
            return response;
        }
            #endregion JSON

        #region XML
        //Friendly
            /// <summary>
            /// Cluster search resource by using interest key word(s). XML response. 
            /// </summary>
            /// <param name="kws">interest key words to be search. Multiple interesting kords could be split by using Space, comma, semicolon</param>
            /// <param name="lang">Language. English = "en"; French = "fr"</param>
            /// <param name="token">Access token</param>
            /// <returns>Return resource list. Returned resource includes any interest search key words or their synonym in his name, description, location, term, category etc. Format in XML</returns>
            [ActionName("xml")]
            [Route("api/v2/Search/xml/{token}/{lang}/{kws}")]
            [Route("api/v2/Chercher/xml/{token}/{lang}/{kws}")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage search_XML(string lang, string kws, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                response = createSearchResult(kws, lang, token);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "xml", "path", lang, token, "search", "search", kws);
                return response;
            }
        //Query String
        /// <summary>
        /// Query String style cluster search resource by using interest key word(s).  XML response 
        /// </summary>
        /// <param name="kws">interest key words to be search. Multiple interesting kords could be split by using Space, comma, semicolon</param>
        /// <param name="lang">Language. English = "en"; French = "fr"</param>
        /// <param name="token">Access token</param>
        /// <returns>Return resource list. Returned resource includes any interest search key words or their synonym in his name, description, location, term, category etc. Format in XML</returns>
        [ActionName("xml")]
        [Route("api/v2/Search/xml")]
        [Route("api/v2/Chercher/xml")]
        [ResponseType(typeof(Search_Result))]
        [HttpGet]
        public HttpResponseMessage search_XML_QS(string lang, string kws, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            response = createSearchResult(kws, lang, token);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "xml", "query", lang, token, "search", "search", kws);
            return response;
        }
        #endregion XML

            private HttpResponseMessage createSearchResult(string kws, string lang, string token)
            {
                lang = lang.ToLower();
                if ((lang == "en") || (lang == "fr"))
                {
                    var xml = searchservice.SearchByKeywords(kws, lang, token).ToList();

                    if (xml.Count > 0)
                    {
                        var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                        return response;
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.NoContent);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound);
                }
            }

        #endregion Search


        #region Search_Resources_In_Radius
            #region JSON
            //Friendly
            /// <summary>
            /// Search allowable resources which locate in a circular area. current location is center of the circle; radius (Km) is distance. 
            /// </summary>
            /// <param name="lang">Language: English = "en" ;  French = "fr"</param>
            /// <param name="lat">Latitude of current location </param>
            /// <param name="lon">Longitude of current location </param>
            /// <param name="radius">radius: How many Kilometre from current location</param>
            /// <param name="token">access token</param>
            /// <returns>Return a resource list in a circular area, current location is center, radius  is the distance,fromat in JSON </returns>
            [ActionName("json")]
            [Route("api/v2/Search/circular/json/{token}/{lang}/{lat}/{lon}/{radius}")]
            [Route("api/v2/Chercher/circulaire/json/{token}/{lang}/{lat}/{lon}/{radius}")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetResourcesInRadiusList(string lang, decimal lat, decimal lon, decimal radius, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetResourcesInRadiusList(lang, lat, lon, radius, token).ToList();
                response = toJson(json, lang);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "path", lang, token, "circular", "search", lat.ToString() + "/" + lon.ToString() + "/" + radius.ToString());
                return response;
            }

            //Query String
            /// <summary>
            /// Query String style, searching allowable resources which locate in a circular area. current location is center of the circle; radius (Km) is distance. 
            /// </summary>
            /// <param name="lang">Language: English = "en" ;  French = "fr"</param>
            /// <param name="lat">Latitude of current location</param>
            /// <param name="lon">Longitude of current location</param>
            /// <param name="radius">radius: How many Kilometre from current location</param>
            /// <param name="token">access token</param>
            /// <returns>Return a resource list in a circular area, current location is center, radius is the distance, fromat in JSON </returns>
            [ActionName("json")]
            [Route("api/v2/Search/circular/json")]
            [Route("api/v2/Chercher/circulaire/json")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetResourcesInRadiusList_QS(string lang, decimal lat, decimal lon, decimal radius,  string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetResourcesInRadiusList(lang, lat, lon, radius, token).ToList();
                response = toJson(json, lang);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "query", lang, token, "circular", "search", lat.ToString() + "/" + lon.ToString() + "/" + radius.ToString());
                return response;
            }
            #endregion JSON

            #region XML
            //Friendly
            /// <summary>
            /// Search allowable resources which locate in a circular area. current location is center of the circle; radius (Km) is distance. 
            /// </summary>
            /// <param name="lang">Language: English = "en" ;  French = "fr"</param>
            /// <param name="lat">Latitude of current location </param>
            /// <param name="lon">Longitude of current location </param>
            /// <param name="radius">radius: How many Kilometre from current location</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a resource list, current location is center, wish distance is the radius, fromat in XML </returns>
            [ActionName("xml")]
            [Route("api/v2/Search/circular/xml/{token}/{lang}/{lat}/{lon}/{radius}")]
            [Route("api/v2/Chercher/circulaire/xml/{token}/{lang}/{lat}/{lon}/{radius}")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetResourcesInRadiusList_XML(string lang, decimal lat, decimal lon, decimal radius, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                response = createCircularResult(lang, lat, lon, radius, token);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "xml", "path", lang, token, "circular", "search", lat.ToString() + "/" + lon.ToString() + "/" + radius.ToString());
                return response;
            }

            //Query String
            /// <summary>
            /// Query String style, Searching resources which locate in a circular area. current location is center of the circle; radius (Km) is distance. 
            /// </summary>
            /// <param name="lang">Language: English = "en" ;  French = "fr"</param>
            /// <param name="lat">Latitude of current location</param>
            /// <param name="lon">Longitude of current location</param>
            /// <param name="radius">radius: How many Kilometre from current location</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a resource list, current location is center, wish distance is the radius, fromat in XML</returns>
            [ActionName("xml")]
            [Route("api/v2/Search/circular/xml")]
            [Route("api/v2/Chercher/circulaire/xml")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetResourcesInRadiusList_XML_QS(string lang, decimal lat, decimal lon, decimal radius, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                response = createCircularResult(lang, lat, lon, radius, token);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "xml", "query", lang, token, "circular", "search", lat.ToString() + "/" + lon.ToString() + "/" + radius.ToString());
                return response;
            }
            #endregion XML
            private HttpResponseMessage createCircularResult(string lang, decimal lat, decimal lon, decimal radius, string token)
            {
                lang = lang.ToLower();
                if ((lang == "en") || (lang == "fr"))
                {
                    HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                    var xml = searchservice.GetResourcesInRadiusList(lang, lat, lon, radius, token).ToList();

                    if (xml.Count > 0)
                    {
                        var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                        return response;
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.NoContent);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound);
                }
            }
        #endregion Search_Resources_In_Radius


        #region Search_Resource_In_boundary_Box
            #region JSON
            //Friendly
            /// <summary>
            /// Search allowable resources locate in a Boundary-Box area. current location is center of the boundary box; Radius (Km) is center to Northern, Southern, Eastern and Western boundary. 
            /// </summary>
            /// <param name="lang">Language: English = "en" ;  French = "fr"</param>
            /// <param name="lat">Latitude of current location </param>
            /// <param name="lon">Longitude of current location </param>
            /// <param name="radius">Radius: How many Kilometre from current location</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a resource list in Boundary-Box area, current location is center. Radius (Km) is the distance to Northern, Southern, Eastern and Western, fromat in JSON </returns>
            [ActionName("json")]
            [Route("api/v2/Search/box/json/{token}/{lang}/{lat}/{lon}/{radius}")]
            [Route("api/v2/Chercher/boîte/json/{token}/{lang}/{lat}/{lon}/{radius}")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetResourcesInBoxList(string lang, decimal lat, decimal lon, decimal radius, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetResourcesInRadiusBoundaryBoxList(lang, lat, lon, radius, token).ToList();
                response = toJson(json, lang);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "path", lang, token, "box", "search", lat.ToString() + "/" + lon.ToString() + "/" + radius.ToString());
                return response;
            }

            //Query String
            /// <summary>
            /// Query String style, searching allowable resources locate in a Boundary-Box area. current location is center of the boundary box; Radius (Km) is center to Northern, Southern, Eastern and Western boundary.  
            /// </summary>
            /// <param name="lang">Language: English = "en" ;  French = "fr"</param>
            /// <param name="lat">Latitude of current location</param>
            /// <param name="lon">Longitude of current location</param>
            /// <param name="radius">radius: How many Kilometre from current location</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a resource list in Boundary-Box area, current location is center. Radius (Km) is the distance to Northern, Southern, Eastern and Western, fromat in JSON </returns>
            [ActionName("json")]
            [Route("api/v2/Search/box/json")]
            [Route("api/v2/Chercher/boîte/json")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetResourcesInBoxList_QS(string lang, decimal lat, decimal lon, decimal radius, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetResourcesInRadiusBoundaryBoxList(lang, lat, lon, radius, token).ToList();
                response = toJson(json, lang);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "query", lang, token, "box", "search", lat.ToString() + "/" + lon.ToString() + "/" + radius.ToString());
                return response;
            }
            #endregion JSON

            #region XML
            //Friendly
            /// <summary>
            /// Searching resources which locate in a Boundary-Box area. current location is center of the boundary box; Radius (Km) is center to Northern, Southern, Eastern and Western boundary.  
            /// </summary>
            /// <param name="lang">Language: English = "en" ;  French = "fr"</param>
            /// <param name="lat">Latitude of current location </param>
            /// <param name="lon">Longitude of current location </param>
            /// <param name="radius">radius: How many Kilometre from current location</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a resource list in Boundary-Box area, current location is center. Radius (Km) is the distance to Northern, Southern, Eastern and Western, ,fromat in XML </returns>
            [ActionName("xml")]
            [Route("api/v2/Search/box/xml/{token}/{lang}/{lat}/{lon}/{radius}")]
            [Route("api/v2/Chercher/boîte/xml/{token}/{lang}/{lat}/{lon}/{radius}")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetResourcesInBoxList_XML(string lang, decimal lat, decimal lon, decimal radius, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                response = createBoxResult(lang, lat, lon, radius, token);
                request = HttpContext.Current.Request;  
                logservices.logservices(request, response, "dbo", "xml", "path", lang, token, "box", "search", lat.ToString() + "/" + lon.ToString() + "/" + radius.ToString());
                return response;
            }

            //Query String
            /// <summary>
            /// Query String style, Searching resources which locate in a Boundary-Box area. current location is center of the boundary box; Radius (Km) is center to Northern, Southern, Eastern and Western boundary.   
            /// </summary>
            /// <param name="lang">Language: English = "en" ;  French = "fr"</param>
            /// <param name="lat">Latitude of current location</param>
            /// <param name="lon">Longitude of current location</param>
            /// <param name="radius">radius: How many Kilometre from current location</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a resource list in Boundary-Box area, current location is center. Radius (Km) is the distance to Northern, Southern, Eastern and Western, fromat in XML</returns>
            [ActionName("xml")]
            [Route("api/v2/Search/box/xml")]
            [Route("api/v2/Chercher/boîte/xml")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetResourcesInBoxList_XML_QS(string lang, decimal lat, decimal lon, decimal radius, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                response = createBoxResult(lang, lat, lon, radius, token);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "xml", "query", lang, token, "box", "search", lat.ToString() + "/" + lon.ToString() + "/" + radius.ToString());
                return response;
            }
            #endregion XML
            private HttpResponseMessage createBoxResult(string lang, decimal lat, decimal lon, decimal radius, string token)
            {
                lang = lang.ToLower();
                if ((lang == "en") || (lang == "fr"))
                {
                    var xml = searchservice.GetResourcesInRadiusBoundaryBoxList(lang, lat, lon, radius, token).ToList();

                    if (xml.Count > 0)
                    {
                        var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                        return response;
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.NoContent);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound);
                }
            }
         #endregion Search_Resource_In_boundary_Box


        #region Search_Resource_By_City
            #region JSON
            // Friendly
            /// <summary>
            ///  Search allowable resource list in the specific allowable city filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="cid">city id</param>
            /// <param name="token">Access token</param>
            /// <returns>return a JSON format resource list, located in a specific city</returns>
            [ActionName("json")]
            [Route("api/v2/search/city/json/{token}/{lang}/{cid}")]
            [Route("api/v2/Chercher/ville/json/{token}/{lang}/{cid}")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesByCity(string lang, int cid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetResourcesByCity(cid, lang, token).ToList();
                response = toJson(json, lang);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "path", lang, token, "city", "search", cid.ToString());

                return response;
            }
            // Query String
            /// <summary>
            ///  Query String style getting resource list in the specific allowable city filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="cid">city id</param>
            /// <param name="token">Access token</param>
            /// <returns>return a JSON format resource list, located in a specific city</returns>
            [ActionName("json")]
            [Route("api/v2/search/city/json")]
            [Route("api/v2/Chercher/ville/json")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesByCity_QS(string lang, int cid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetResourcesByCity(cid, lang, token).ToList();
                response = toJson(json, lang);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "query", lang, token, "city", "search", cid.ToString());

                return response;
            }
            #endregion JSON

            #region XML
            // Friendly
            /// <summary>
            ///  Get resource list in the specific allowable city filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="cid">city id</param>
            /// <param name="token">Access token</param>
            /// <returns>return a XML format, resource list located in a specific city</returns>
            [ActionName("xml")]
            [Route("api/v2/search/city/xml/{token}/{lang}/{cid}")]
            [Route("api/v2/Chercher/ville/xml/{token}/{lang}/{cid}")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesByCity_XML(string lang, int cid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                response = createResourcesByCityResult(cid, lang, token);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "xml", "path", lang, token, "city", "search", cid.ToString());
                return response;
            }
            // Query String
            /// <summary>
            ///  Query String style getting resource list in the specific allowable city filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="cid">city id</param>
            /// <param name="token">Access token</param>
            /// <returns>return a XML format, resource list located in a specific city</returns>
            [ActionName("xml")]
            [Route("api/v2/search/cityid/xml")]
            [Route("api/v2/Chercher/villeid/xml")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesByCity_XML_QS(string lang, int cid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                response = createResourcesByCityResult(cid, lang, token);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "xml", "query", lang, token, "city", "search", cid.ToString());
                return response;
            }
            private HttpResponseMessage createResourcesByCityResult(int cid, string lang, string token)
            {
                lang = lang.ToLower();
                if ((lang == "en") || (lang == "fr"))
                {
                    var xml = searchservice.GetResourcesByCity(cid, lang, token).ToList();

                    if (xml.Count > 0)
                    {
                        var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                        return response;
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.NoContent);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound);
                }
            }
            #endregion XML
       #endregion Search_Resource_By_City


        #region Search Resource By Province ID
            #region JSON
            // Friendly
            /// <summary>
            ///  Searching resources in the single province filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="pid">province id</param>
            /// <param name="token">Access token</param>
            /// <returns>return a JSON format resource list located in a specific province</returns>
            [ActionName("json")]
            [Route("api/v2/search/province/json/{token}/{lang}/{pid}")]
            [Route("api/v2/Chercher/province/json/{token}/{lang}/{pid}")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesByProvince(string lang, int pid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetResourcesByProvince(pid, lang, token).ToList();
                response = toJson(json, lang);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "path", lang, token, "province", "search", pid.ToString());
                return response;
            }
            // Query String
            /// <summary>
            ///  Query String style searching resources in the specific province filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="pid">province id</param>
            /// <param name="token">Access token</param>
            /// <returns>return a XML format resource list located in this province</returns>
            [ActionName("json")]
            [Route("api/v2/search/province/json")]
            [Route("api/v2/Chercher/province/json")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesByProvince_QS(string lang, int pid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetResourcesByProvince(pid, lang, token).ToList();
                response = toJson(json, lang);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "query", lang, token, "province", "search", pid.ToString());
                return response;
            }
            #endregion JSON

            #region XML
            // Friendly
            /// <summary>
            ///  Search resources in a expected province filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="pid">province id</param>
            /// <param name="token">Access token</param>
            /// <returns>return a XML format resource list located in expected province</returns>
            [ActionName("xml")]
            [Route("api/v2/search/province/xml/{token}/{lang}/{pid}")]
            [Route("api/v2/Chercher/province/xml/{token}/{lang}/{pid}")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesByProvince_XML(string lang, int pid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                response = createResourcesByProvinceResult(pid, lang, token);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "xml", "path", lang, token, "province", "search", pid.ToString());
                return response;
            }
            // Query String
            /// <summary>
            ///  Query String style searching resources in single province filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="pid">province id</param>
            /// <param name="token">Access token</param>
            /// <returns>return a XML format resource list located in a specific province</returns>
            [ActionName("xml")]
            [Route("api/v2/search/province/xml")]
            [Route("api/v2/Chercher/province/xml")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesByProvince_XML_QS(string lang, int pid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                response = createResourcesByProvinceResult(pid, lang, token);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "xml", "query", lang, token, "province", "search", pid.ToString());
                return response;
            }
            private HttpResponseMessage createResourcesByProvinceResult(int pid, string lang, string token)
            {
                lang = lang.ToLower();
                if ((lang == "en") || (lang == "fr"))
                {
                    var xml = searchservice.GetResourcesByProvince(pid, lang, token).ToList();

                    if (xml.Count > 0)
                    {
                        var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                        return response;
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.NoContent);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound);
                }
            }
            #endregion XML
        #endregion Search Resource By Province ID


        #region Search Resource By SubCategory ID
            #region JSON
            // Friendly
            /// <summary>
            ///  Search resources under the SubCategory, filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="sid">SubCategory id.</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a JSON format resource list under the specific subcategory</returns>
            [ActionName("json")]
            [Route("api/v2/search/subcategory/json/{token}/{lang}/{sid}")]
            [Route("api/v2/Chercher/souscatégorie/json/{token}/{lang}/{sid}")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesBySubCategory(string lang, int sid,string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetResourcesBySubCategory(sid, lang, token).ToList();
                response = toJson(json, lang);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "path", lang, token, "subcategory", "search", sid.ToString());
                return response;
            }
            // Query String
            /// <summary>
            ///  Query String style, searching resource list under the SubCategory filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="sid">SubCategory id.</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a JSON format resource list under the specific subcategory</returns>
            [ActionName("json")]
            [Route("api/v2/search/subcategory/json")]
            [Route("api/v2/Chercher/souscatégorie/json")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesBySubCategory_QS(string lang, int sid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetResourcesBySubCategory(sid, lang, token).ToList();
                response = toJson(json, lang);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "query", lang, token, "subcategory", "search", sid.ToString());
                return response;
            }
            #endregion JSON

            #region XML
            // Friendly
            /// <summary>
            ///  Search resources under the SubCategory, filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="sid">SubCategory id.</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a XML format resource list under the specific subcategory</returns>
            [ActionName("xml")]
            [Route("api/v2/search/subcategory/xml/{token}/{lang}/{sid}")]
            [Route("api/v2/Chercher/souscatégorie/xml/{token}/{lang}/{sid}")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesBySubCategory_XML(string lang, int sid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                response = createResourcesBySubcategoryResult(sid, lang, token);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "xml", "path", lang, token, "subcategory", "search", sid.ToString());
                return response;
            }
            // Query String
            /// <summary>
            ///  Query String Style. Get resource list under the SubCategory filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="sid">SubCategory id.</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a XML format resource list under the specific subcategory</returns>
            [ActionName("xml")]
            [Route("api/v2/search/subcategory/xml")]
            [Route("api/v2/Chercher/souscatégorie/xml")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesBySubCategory_XML_QS(string lang, int sid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                response = createResourcesBySubcategoryResult(sid, lang, token);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "xml", "query", lang, token, "subcategory", "search", sid.ToString());
                return response;
            }
            private HttpResponseMessage createResourcesBySubcategoryResult(int sid, string lang, string token)
            {
                lang = lang.ToLower();
                if ((lang == "en") || (lang == "fr"))
                {
                    var xml = searchservice.GetResourcesBySubCategory(sid, lang, token).ToList();

                    if (xml.Count > 0)
                    {
                        var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                        return response;
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.NoContent);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound);
                }
            }
            #endregion XML
        #endregion Search Resource By SubCategory ID


        #region Search Resource By TopCategory ID
            #region JSON
            // Friendly
            /// <summary>
            ///  Get resource list under the allowable TopCategory filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="tid">TopCategory id.</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a JSON format resource list under the specific TopCategory</returns>
            [ActionName("json")]
            [Route("api/v2/search/topcategory/json/{token}/{lang}/{tid}")]
            [Route("api/v2/Chercher/catégorie/json/{token}/{lang}/{tid}")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesByTopCategory(string lang, int tid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetResourcesByTopCategory(tid, lang, token).ToList();
                response = toJson(json, lang);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "path", lang, token, "topcategory", "search", tid.ToString());
                return response;
            }

            // Query String
            /// <summary>
            ///  Query String Style. Get resource list under the allowable TopCategory filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="tid">TopCategory id.</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a JSON format resource list under the specific TopCategory</returns>
            [ActionName("json")]
            [Route("api/v2/search/topcategory/json")]
            [Route("api/v2/Chercher/catégorie/json")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesByTopCategory_QS(string lang, int tid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetResourcesByTopCategory(tid, lang, token).ToList();
                response = toJson(json, lang);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "query", lang, token, "topcategory", "search", tid.ToString());
                return response;
            }
            #endregion JSON

            #region XML
            // Friendly
            /// <summary>
            ///  Get resource list under the allowable TopCategory filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="tid">TopCategory id.</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a XML format resource list under the specific TopCategory</returns>
            [ActionName("xml")]
            [Route("api/v2/search/topcategory/xml/{token}/{lang}/{tid}")]
            [Route("api/v2/Chercher/catégorie/xml/{token}/{lang}/{tid}")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesByTopCategory_XML(string lang, int tid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                response = createResourcesByTopcategoryResult(tid, lang, token);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "xml", "path", lang, token, "topcategory", "search", tid.ToString());
                return response;
            }


            // Query String
            /// <summary>
            ///  Query String Style. Get resource list under the allowable TopCategory filter by resource's language 
            /// </summary>
            /// <param name="lang">language. English = "en"; French = "fr"</param>
            /// <param name="tid">TopCategory id.</param>
            /// <param name="token">Access token</param>
            /// <returns>Return a XML format resource list under the specific TopCategory</returns>
            [ActionName("xml")]
            [Route("api/v2/search/topcategory/xml")]
            [Route("api/v2/Chercher/catégorie/xml")]
            [ResponseType(typeof(Search_Result))]
            [HttpGet]
            public HttpResponseMessage GetAllResourcesByTopCategory_XML_QS(string lang, int tid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                response = createResourcesByTopcategoryResult(tid, lang, token);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "xml", "query", lang, token, "topcategory", "search", tid.ToString());
                return response;
            }
            private HttpResponseMessage createResourcesByTopcategoryResult(int tid, string lang, string token)
            {
                lang = lang.ToLower();
                if ((lang == "en") || (lang == "fr"))
                {
                    var xml = searchservice.GetResourcesByTopCategory(tid, lang, token).ToList();

                    if (xml.Count > 0)
                    {
                        var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                        return response;
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.NoContent);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound);
                }
            }
            #endregion XML
        #endregion Get Resource By TopCategory ID


        #region Get Suggestion Word List
            #region JSON
            /// <summary>
             /// Get suggection key word list. the suggested words are province ,city if they have resource locate in his boundary; name, category, term, description, services etc.  
             /// </summary>
                    /// <returns>suggection key word list format in JSON</returns>
                [ActionName("suggest")]
                [Route("api/v2/Search/suggestion/json")]
                [Route("api/v2/Chercher/suggestion/json")]
                [ResponseType(typeof(SuggestionWords))]
                [HttpGet]
                public HttpResponseMessage suggestionWordList()
                {
                    HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                    var json = searchservice.GetSuggestionWordList().ToList();
                    response = toJson(json, "en");
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "json", "path", string.Empty, string.Empty, "suggest", "search", string.Empty);
                    return response;
                }
        #endregion JSON

            #region XML
            /// <summary>
            /// Get suggection key word list. the suggested words are province ,city if they have resource locate in his boundary; name category, term, description, services etc.  
            /// </summary>
            /// <returns>suggection key word list format in XML</returns>
            [ActionName("suggest")]
            [Route("api/v2/Search/suggestion/xml")]
            [Route("api/v2/Chercher/suggestion/xml")]
            [ResponseType(typeof(SuggestionWords))]
            [HttpGet]
            public HttpResponseMessage suggestionWordList_XML()
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                    var xml = searchservice.GetSuggestionWordList().ToList();
                    request = HttpContext.Current.Request;

                    if (xml.Count > 0)
                    {
                        var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                        logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, string.Empty, "suggest", "search", string.Empty);

                        return response;
                    }
                    else
                    {
                        response = Request.CreateResponse(HttpStatusCode.NoContent);
                        logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, string.Empty, "suggest", "search", string.Empty);

                        return response;
                    }
            }
        #endregion XML
        #endregion Get Suggestion Word List


        #region Get Increment Suggestion Word List
            #region JSON
            //Friendly
            /// <summary>
            ///  incrementally return interest key words for searching (auto-complete searching key word(s) 
            /// </summary>
            /// <param name="sw">incremental letter(s) of interest key word</param>
            /// <returns>retun suggested key word(s), format in JSON</returns>
            [ActionName("json")]
            [Route("api/v2/Search/suggestion/json/{sw}")]
            [Route("api/v2/Chercher/suggestion/json/{sw}")]
            [ResponseType(typeof(SuggestionWords))]
            [HttpGet]
            public HttpResponseMessage IncrementSuggestionWordList(string sw)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetIncrementSuggestionWordList(sw).ToList();
                response = toJson(json, "en");
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "path", string.Empty, string.Empty, "increment", "search", sw);
                return response;
            }
            //Query String
            /// <summary>
            ///  Query String style,  incrementally return interest key words for searching (auto-complete searching key word(s) 
            /// </summary>
            /// <param name="sw">incremental letter(s) of interest key word</param>
            /// <returns>retun suggested key word(s), format in JSON</returns>
            [ActionName("json")]
            [Route("api/v2/Search/suggestion/json")]
            [Route("api/v2/Chercher/suggestion/json")]
            [ResponseType(typeof(SuggestionWords))]
            [HttpGet]
            public HttpResponseMessage IncrementSuggestionWordList_QS(string sw)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = searchservice.GetIncrementSuggestionWordList(sw).ToList();
                response = toJson(json, "en");
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "query", string.Empty, string.Empty, "increment", "search", sw);
                return response;
            }
            #endregion JSON

            #region XML
            //Friendly
            /// <summary>
            ///  incrementally return interest key words for searching (auto-complete searching key word(s) 
            /// </summary>
            /// <param name="sw">incremental letter(s) of interest key word</param>
            /// <returns>retun suggested key word(s), format in JSON</returns>
            [ActionName("xml")]
            [Route("api/v2/Search/suggestion/xml/{sw}")]
            [Route("api/v2/Chercher/suggestion/xml/{sw}")]
            [ResponseType(typeof(SuggestionWords))]
            [HttpGet]
            public HttpResponseMessage IncrementSuggestionWordList_XML(string sw)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var xml = searchservice.GetIncrementSuggestionWordList(sw).ToList();
                request = HttpContext.Current.Request;
                if (xml.Count > 0)
                {
                    var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                    logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, string.Empty, "increment", "search", sw);

                    return response;
                }
                else
                {
                    response = Request.CreateResponse(HttpStatusCode.NoContent);
                    logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, string.Empty, "increment", "search", sw);

                    return response;
                }
            }
            //Query String
            /// <summary>
            ///  Query String style,  incrementally return interest key words for searching (auto-complete searching key word(s) 
            /// </summary>
            /// <param name="sw">incremental letter(s) of interest key word</param>
            /// <returns>retun suggested key word(s), format in XML</returns>
            [ActionName("xml")]
            [Route("api/v2/Search/suggestion/xml")]
            [Route("api/v2/Chercher/suggestion/xml")]
            [ResponseType(typeof(SuggestionWords))]
            [HttpGet]
            public HttpResponseMessage IncrementSuggestionWordList_XML_QS(string sw)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var xml = searchservice.GetIncrementSuggestionWordList(sw).ToList();
                request = HttpContext.Current.Request;
            if (xml.Count > 0)
                {
                    var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                    logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, string.Empty, "increment", "search", sw);

                    return response;
                }
                else
                {
                    response = Request.CreateResponse(HttpStatusCode.NoContent); 
                    logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, string.Empty, "increment", "search", sw);

                    return response;
                }
            }
        #endregion XML
        #endregion Get Increment Suggestion Word List


        #region Search Resource by Coverage
        #region JSON
        // Friendly
        /// <summary>
        ///  Searching resources by its coverage   
        /// </summary>
        /// <param name="lang">language. English = "en"; French = "fr"</param>
        /// <param name="coverage">coverage</param>
        /// <param name="token">Access token</param>
        /// <returns>return a JSON format resource list</returns>
        [ActionName("json")]
        [Route("api/v2/search/coverage/json/{token}/{lang}/{coverage}")]
        [Route("api/v2/Chercher/couverture/json/{token}/{lang}/{coverage}")]
        [ResponseType(typeof(Search_Result))]
        [HttpGet]
        public HttpResponseMessage GetAllResourcesByCoverage(string lang, string coverage, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var json = searchservice.GetResourcesByCoverage(coverage, lang, token).ToList();
            response = toJson(json, lang);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "json", "path", lang, token, "coverage", "search", coverage);
            return response;
        }
        // Query String
        /// <summary>
        ///  Query String style searching resources by its coverage   
        /// </summary>
        /// <param name="lang">language. English = "en"; French = "fr"</param>
        /// <param name="coverage">coverage</param>
        /// <param name="token">Access token</param>
        /// <returns>return a XML format resource list</returns>
        [ActionName("json")]
        [Route("api/v2/search/coverage/json")]
        [Route("api/v2/Chercher/couverture/json")]
        [ResponseType(typeof(Search_Result))]
        [HttpGet]
        public HttpResponseMessage GetAllResourcesByCoverage_QS(string lang, string coverage, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var json = searchservice.GetResourcesByCoverage(coverage, lang, token).ToList();
            response = toJson(json, lang);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "json", "query", lang, token, "coverage", "search", coverage);
            return response;
        }
        #endregion JSON

        #region XML
        // Friendly
        /// <summary>
        ///  Search resources by its coverage 
        /// </summary>
        /// <param name="lang">language. English = "en"; French = "fr"</param>
        /// <param name="coverage">coverage</param>
        /// <param name="token">Access token</param>
        /// <returns>return a XML format resource list</returns>
        [ActionName("xml")]
        [Route("api/v2/search/coverage/xml/{token}/{lang}/{coverage}")]
        [Route("api/v2/Chercher/couverture/xml/{token}/{lang}/{coverage}")]
        [ResponseType(typeof(Search_Result))]
        [HttpGet]
        public HttpResponseMessage GetAllResourcesByProvince_XML(string lang, string coverage, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            response = createResourcesByCoverageResult(coverage, lang, token);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "xml", "path", lang, token, "coverage", "search", coverage);
            return response;
        }
        // Query String
        /// <summary>
        ///  Query String style searching resources in single province filter by resource's language 
        /// </summary>
        /// <param name="lang">language. English = "en"; French = "fr"</param>
        /// <param name="coverage">Coverage</param>
        /// <param name="token">Access token</param>
        /// <returns>return a XML format resource list located in a specific province</returns>
        [ActionName("xml")]
        [Route("api/v2/search/coverage/xml")]
        [Route("api/v2/Chercher/couverture/xml")]
        [ResponseType(typeof(Search_Result))]
        [HttpGet]
        public HttpResponseMessage GetAllResourcesByCoverage_XML_QS(string lang, string coverage, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            response = createResourcesByCoverageResult(coverage, lang, token);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "xml", "query", lang, token, "coverage", "search", coverage);
            return response;
        }
        private HttpResponseMessage createResourcesByCoverageResult(string coverage, string lang, string token)
        {
            lang = lang.ToLower();
            if ((lang == "en") || (lang == "fr"))
            {
                var xml = searchservice.GetResourcesByCoverage(coverage, lang, token).ToList();

                if (xml.Count > 0)
                {
                    var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                    return response;
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NoContent);
                }
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }
        }
        #endregion XML

        #endregion Search Resource by Coverage



        private HttpResponseMessage toJson(Object r, string lang)
        {
            lang = lang.ToLower();
            if ((lang == "en") || (lang == "fr"))
            {
                string thisJson = JsonConvert.SerializeObject(r, Formatting.None);

                if (thisJson.Length < 5)
                {
                    var response = this.Request.CreateResponse(HttpStatusCode.NoContent);
                    response.Content = new StringContent(string.Empty, Encoding.UTF8, "application/json");
                    return response;
                }
                else
                {
                    var response = this.Request.CreateResponse(HttpStatusCode.OK);
                    response.Content = new StringContent(thisJson, Encoding.UTF8, "text/html");
                    return response;
                }
            }
            else
            {
                var response = this.Request.CreateResponse(HttpStatusCode.NotFound);
                response.Content = new StringContent(string.Empty, Encoding.UTF8, "application/json");
                return response;
            }

        }
    }
}
