using BIZ.Locations;
using BIZ.Log;
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
    /// Get allowable city’s information based on user's access privilege, response JSON or XML format.
    /// </summary>
    [AuthorizeIPAddress]
    [FilterIP]
    public class CityController : ApiController
    {
        CityServices citysercice = new CityServices();
        HttpResponseMessage response = new HttpResponseMessage();
        HttpRequest request = HttpContext.Current.Request;
        LogServices logservices = new LogServices();

        #region get all cities list
            #region response JSON
            #region url friendly
            /// <summary>
            /// Get all allowable city list based on user's access privilege, response JSON format.
            /// </summary>
            /// <param name="token">Access token</param>
            /// <returns>return an allowable city list, [CityID], [City Name] and [Provincial Alias], fromat in JSON</returns>
            [ActionName("json")]
                    [Route("api/v2/city/json/{token}")]
                    [Route("api/v2/ville/json/{token}")]
                    [ResponseType(typeof(CityList))]
                    [HttpGet]
                    public HttpResponseMessage GetAllCitis(string token)
                            {

                                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                                var r = citysercice.GetAllCitis(token);
                                response = toJson(r);
                                request = HttpContext.Current.Request;
                                logservices.logservices(request, response, "dbo", "json", "path", string.Empty, token, "all", "city", string.Empty);

                                return response;
                            }
            #endregion url friendly

            #region query string
            /// <summary>
            /// Query String gets all allowable city list based on user's access privilege, response JSON format. 
            /// </summary>
            /// <param name="token">Access token</param>
            /// <returns>return an allowable city list, [CityID], [City Name] and [Provincial Alias], fromat in JSON</returns>
                        [ActionName("json")]
                        [Route("api/v2/city/json")]
                        [Route("api/v2/ville/json")]
                        [ResponseType(typeof(CityList))]
                        [HttpGet]
                        public HttpResponseMessage GetAllCitis_QS(string token)
                        {

                            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                            var r = citysercice.GetAllCitis(token);
                            response = toJson(r);
                            request = HttpContext.Current.Request;
                            logservices.logservices(request, response, "dbo", "json", "query", string.Empty, token, "all", "city", string.Empty);

                            return response;
                        }
            #endregion query string
            #endregion get all cities list

            #region response XML
            #region url friendly
            /// <summary>
            /// Get all allowable city list based on user's access privilege, response XML format. 
            /// </summary>
            /// <param name="token">Access token</param>
            /// <returns>return an allowable city list, [City ID], [City Name] and [provincial Alias], format in XML</returns>
                            [Route("api/v2/city/xml/{token}")]
                            [Route("api/v2/ville/xml/{token}")]
                            [ResponseType(typeof(CityList))]
                            [HttpGet]
                            public HttpResponseMessage GetAllCitis_XML(string token)
                            {
                                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                                var xml = citysercice.GetAllCitis(token).ToList();
                                request = HttpContext.Current.Request;
                                if (xml.Count > 0)
                                {
                                    var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                                    logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, token, "all", "city", string.Empty);

                                    return response;
                                }
                                else
                                {

                                    response = Request.CreateResponse(HttpStatusCode.NoContent);
                                    logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, token, "all", "city", string.Empty);

                                    return response;
                                }
                            }
            #endregion url friendly

            #region query string
            /// <summary>
            /// Querystring style gets all allowable city list based on user's access privilege, response XML format. 
            /// </summary>
            /// <param name="token">Access token</param>
            /// <returns>return an allowable city list, [City ID], [City Name] and [provincial Alias], format in XML</returns>
                            [Route("api/v2/city/xml")]
                            [Route("api/v2/ville/xml")]
                            [ResponseType(typeof(CityList))]
                            [HttpGet]
                            public HttpResponseMessage GetAllCitis_XML_QS(string token)
                            {
                                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                                request = HttpContext.Current.Request;

                                var xml = citysercice.GetAllCitis(token).ToList();
                                if (xml.Count > 0)
                                {
                                    var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                                    logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, token, "all", "city", string.Empty);

                                    return response;
                                }
                                else
                                {
                                    response = Request.CreateResponse(HttpStatusCode.NoContent);
                                    logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, token, "all", "city", string.Empty);

                                    return response;
                                }
                            }
                        #endregion query string
                #endregion response XML
        #endregion



        #region get cities list by province
            #region response JSON
                // Friendly
                /// <summary>
                /// Looks up allowable provincial city list by ProvinceID, format in JSON.
                /// </summary>
                /// <param name="pid">Province ID. Alberta = 1, BC = 2,..., Ontario = 9, ....</param>
                /// <param name="token">Access token</param>
                /// <returns>return all allowable cities in this province, [cityID], [city Name], and [Provincial Alias], format in json</returns>
                [ActionName("json")]
                [Route("api/v2/city/province/json/{token}/{pid}")]
                [Route("api/v2/ville/province/json/{token}/{pid}")]
                [ResponseType(typeof(CityList))]
                [HttpGet]
                public HttpResponseMessage GetCityByProvince(int pid, string token)
                {
                    HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                    var r = citysercice.GetCityByProvince(pid, token).ToList();
                    response = toJson(r);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "json", "path", string.Empty, token, "Provincal", "city", pid.ToString());

                    return response;
                }
            // Query String 
                /// <summary>
                /// Querystring style looks up allowable provincial city list by ProvinceID, format in JSON.
                /// </summary>
                /// <param name="pid">Province ID. Alberta = 1, BC = 2,..., Ontario = 9, ....</param>
                /// <param name="token">Access token</param>
                /// <returns>return all allowable cities in this province, [cityID], [City Name] and [Provincial Alias], format in JSON</returns>
                [ActionName("json")]
                [Route("api/v2/city/province/json")]
                [Route("api/v2/ville/province/json")]
                [ResponseType(typeof(CityList))]
                [HttpGet]
                public HttpResponseMessage GetCityByProvince_QS(int pid, string token)
                {
                    HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                    var r = citysercice.GetCityByProvince(pid, token).ToList();
                    response = toJson(r);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "json", "query", string.Empty, token, "Provincal", "city", pid.ToString());

                    return response;
    }
    #endregion response JSON

            #region response XML
            // Friendly
            /// <summary>
            /// Looks up allowable provincial city list by ProvinceID, format in XML.
            /// </summary>
            /// <param name="pid">Province ID. Alberta = 1, BC = 2,..., Ontario = 9, ....</param>
            /// <param name="token">Access token</param>
            /// <returns>return all allowable cities in this province, [cityID], [Provincial Alias], format in XML</returns>
            [Route("api/v2/city/province/xml/{token}/{pid}")]
            [Route("api/v2/ville/province/xml/{token}/{pid}")]
            [ResponseType(typeof(CityList))]
            [HttpGet]
            public HttpResponseMessage GetCityByProvince_XML(int pid, string token)
            {
                request = HttpContext.Current.Request;
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var xml = citysercice.GetCityByProvince(pid, token).ToList();
                if (xml.Count > 0)
                {
                    var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                    logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, token, "Provincal", "city", pid.ToString());

                    return response;
                }
                else
                {
                    response = Request.CreateResponse(HttpStatusCode.NoContent);
                    logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, token, "Provincal", "city", pid.ToString());

                    return response;
                }
   
            }
            //Query String 
            /// <summary>
            /// QueryString style Looks up allowable provincial city list by ProvinceID, format in XML.
            /// </summary>
            /// <param name="pid">Province ID. Alberta = 1, BC = 2,..., Ontario = 9, ....</param>
            /// <param name="token">Access token</param>
            /// <returns>return an allowable city list in this province, [cityID], [Provincial Alias],  format in XML</returns>
            [Route("api/v2/city/province/xml")]
            [Route("api/v2/ville/province/xml")]
            [ResponseType(typeof(CityList))]
            [HttpGet]
            public HttpResponseMessage GetCityByProvince_XML_QS(int pid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                request = HttpContext.Current.Request;
                var xml = citysercice.GetCityByProvince(pid, token).ToList();
                if (xml.Count > 0)
                {
                    var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                    logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, token, "Provincal", "city", pid.ToString());

                    return response;
                }
                else
                {
                    response = Request.CreateResponse(HttpStatusCode.NotFound);
                    logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, token, "Provincal", "city", pid.ToString());

                    return response;
                }

            }
            #endregion response XML
        #endregion


        #region get city by city ID
            #region response JSON
            //Friendly
            /// <summary>
            /// Looks up particular allowable city's information in detail by using cityID, format in JSON.
            /// </summary>
            /// <param name="cid">City ID. </param>
            /// <param name="token">Access token</param>
            /// <returns>return the city's information in detail, [city name], [provincial alias], [latitude] and [longgitude], formation in JSON</returns>
            [ActionName("json")]
            [Route("api/v2/city/json/{token}/{cid}")]
            [Route("api/v2/ville/json/{token}/{cid}")]
            [ResponseType(typeof(CityResult))]
            [HttpGet]
            public HttpResponseMessage GetCityByCid(int cid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var r = citysercice.GetCityByCid(cid , token);
                response = toJson(r);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "path", string.Empty, token, "this", "city", cid.ToString());

                return response;
            }
            // Query String
            /// <summary>
            /// Querystring style gets allowable city's detail information by using cityID, format in JSON.
            /// </summary>
            /// <param name="cid">City ID. </param>
            /// <param name="token">Access token.</param>
            /// <returns>return the city's information in detail, [city name], [provincial alias], [latitude] and [longgitude], formation in JSON</returns>
            [ActionName("json")]
            [Route("api/v2/city/json")]
            [Route("api/v2/ville/json")]
            [ResponseType(typeof(CityResult))]
            [HttpGet]
            public HttpResponseMessage GetCityByCid_QS(int cid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var r = citysercice.GetCityByCid(cid, token);
                response = toJson(r);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "query", string.Empty, token, "this", "city", cid.ToString());
                return response;
            }
        #endregion response JSON

            #region response XML
            //Friendly
            /// <summary>
            /// Get the allowable city's detail information by using cityID, format in XML.
            /// </summary>
            /// <param name="cid">City ID</param>
            /// <param name="token">Access token</param>
            /// <returns>return the city's information in detail, [city name], [provincial alias], [latitude] and [longgitude], formation in XML</returns>
            [Route("api/v2/city/xml/{token}/{cid}")]
            [Route("api/v2/ville/xml/{token}/{cid}")]
            [ResponseType(typeof(CityResult))]
            [HttpGet]
            public HttpResponseMessage GetCityByCid_XML(int cid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var xml = citysercice.GetCityByCid(cid, token);
                if (xml != null)
                {
                    var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, token, "this", "city", cid.ToString());

                    return response;
                }
                else
                {
                    response = Request.CreateResponse(HttpStatusCode.NoContent);
                    logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, token, "this", "city", cid.ToString());

                    return response;
                }
            }

            // Query String
            /// <summary>
            /// Querystring style gets the city's detail information by using cityID, format in XML.
            /// </summary>
            /// <param name="cid">City ID</param>
            /// <param name="token">Access token</param>
            /// <returns>return the city's information in detail, [city name], [provincial alias], [latitude] and [longgitude], formation in XML</returns>
            [Route("api/v2/city/xml")]
            [Route("api/v2/ville/xml")]
            [ResponseType(typeof(CityResult))]
            [HttpGet]
            public HttpResponseMessage GetCityByCid_XML_QS(int cid, string token)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                request = HttpContext.Current.Request;
                var xml = citysercice.GetCityByCid(cid, token);
                if (xml != null)
                {
                    var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                    logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, token, "this", "city", cid.ToString());

                    return response;
                }
                else
                {
                    response = Request.CreateResponse(HttpStatusCode.NoContent);
                    logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, token, "this", "city", cid.ToString());

                    return response;
                }
            }
        #endregion response XML
        #endregion



        #region Increment City location
            #region JSON
            //Friendly
            /// <summary>
            /// Increment get city location list by path city name and access token, response format in JSON
            /// </summary>
            /// <param name="token">access token</param>
            /// <param name="cl">city location name</param>
            /// <returns>Return a JSON format city province list</returns>
            [ActionName("json")]
            [Route("api/v2/city/suggestion/json/{token}/{cl}")]
            [Route("api/v2/ville/suggestion/json/{token}/{cl}")]
            [ResponseType(typeof(CityList))]
            [HttpGet]
            public HttpResponseMessage IncrementCityLocationList(string token, string cl)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = citysercice.GetIncrementCityLocationList(cl,token).ToList();
                response = toJson(json);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "path", string.Empty, token, "increment", "city", cl);

                return response;
            }

            //Query String
            /// <summary>
            /// Query string style, Increment get city location list by query city name and access token, response format in JSON
            /// </summary>
            /// <param name="token">access token</param>
            /// <param name="cl">city location name</param>
            /// <returns>Return a JSON format city province list</returns>
            [ActionName("json")]
            [Route("api/v2/city/suggestion/json")]
            [Route("api/v2/ville/suggestion/json")]
            [ResponseType(typeof(CityList))]
            [HttpGet]
            public HttpResponseMessage IncrementCityLocation_QS(string token, string cl)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var json = citysercice.GetIncrementCityLocationList(cl, token).ToList();
                response = toJson(json);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "query", string.Empty, token, "increment", "city", cl);
                return response;
            }
        #endregion JSON

            #region XML
            //Friendly
            /// <summary>
            /// Increment get city location list by path city name and access token, response format in XML
            /// </summary>
            /// <param name="token">Access token</param>
            /// <param name="cl">city loaction name</param>
            /// <returns>Return a XML format city province list</returns>
            [ActionName("xml")]
            [Route("api/v2/city/suggestion/xml/{token}/{cl}")]
            [Route("api/v2/ville/suggestion/xml/{token}/{cl}")]
            [ResponseType(typeof(CityList))]
            [HttpGet]
            public HttpResponseMessage IncrementCityLocation_XML(string token, string cl)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                request = HttpContext.Current.Request;
                var xml = citysercice.GetIncrementCityLocationList(cl, token);
                if (xml != null)
                {
                    var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                    logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, token, "increment", "city", cl);

                    return response;
                }
                else
                {
                    response = Request.CreateResponse(HttpStatusCode.NoContent);
                    logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, token, "increment", "city", cl);

                    return response;
                }
            }


            //Query String
            /// <summary>
            /// Query String Style, increment get city location list by query city name and access token, response format in XML
            /// </summary>
            /// <param name="token">Access Token</param>
            /// <param name="cl">city location name</param>
            /// <returns>Return a XML format city province list</returns>
            [ActionName("xml")]
            [Route("api/v2/city/suggestion/xml")]
            [Route("api/v2/ville/suggestion/xml")]
            [ResponseType(typeof(CityList))]
            [HttpGet]
            public HttpResponseMessage IncrementCityLocation_XML_QS(string token, string cl)
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                request = HttpContext.Current.Request;
                var xml = citysercice.GetIncrementCityLocationList(cl, token);
                if (xml != null)
                {
                    var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                    logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, token, "increment", "city", cl);

                    return response;
                }
                else
                {
                    response = Request.CreateResponse(HttpStatusCode.NoContent);
                    logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, token, "increment", "city", cl);

                    return response;
                }
            }
            #endregion XML
        #endregion Increment City location



        private HttpResponseMessage toJson(Object r)
            {
                string thisJson = null;
                thisJson = JsonConvert.SerializeObject(r, Formatting.None);

                if (thisJson.Length < 5)
                {

                    var response = this.Request.CreateResponse(HttpStatusCode.NoContent);
                    // RAM code
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
    }
}
