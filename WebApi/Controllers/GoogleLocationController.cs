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
    /// Get Google Location information, response JSON or XML format. This location comes from Google, it does not fully match RAM resources location. For reference only.
    /// </summary>
    [AuthorizeIPAddress]
    [FilterIP]
    public class GoogleLocationController : ApiController
    {
        LocationServices locationservice = new LocationServices();
        HttpResponseMessage response = new HttpResponseMessage();
        HttpRequest request = HttpContext.Current.Request;
        LogServices logservices = new LogServices();

        #region get all Google cities list
        #region response JSON
        /// <summary>
        /// Get Google City location list, response format in JSON
        /// </summary>
        /// <returns>return google city list format in JSON</returns>
        [ActionName("json")]
            [Route("api/v2/google/city/json")]
            [ResponseType(typeof(GoogleCityList))]
            [HttpGet]
            public HttpResponseMessage GetAllGoogleCitis()
            {
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var resoult = locationservice.GetAllGoogleCitis();
                response = toJson(resoult);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "path", string.Empty, string.Empty, "all", "google", "city");

                return toJson(response);
            }
            #endregion response JSON


        #region response XML
            /// <summary>
            /// Get Google City location list, response format in XML
            /// </summary>
            /// <returns>Google city list format in xml</returns>
            [ActionName("xml")]
            [Route("api/v2/google/city/xml")]
            [ResponseType(typeof(GoogleCityList))]
            [HttpGet]
            public HttpResponseMessage GetAllGoogleCitis_XML()
            {
                request = HttpContext.Current.Request;
                HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
                var xml = locationservice.GetAllGoogleCitis().ToList();
                if (xml.Count > 0)
                {
                    var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                    logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, string.Empty, "all", "google", "city");

                    return response;
                }
                else
                {
                    response = Request.CreateResponse(HttpStatusCode.NoContent);
                    logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, string.Empty, "all", "google", "city");

                    return response;
                }
            }
        #endregion response XML
        #endregion get all Google cities list



        #region Get GoogleCity By ProvinceID
        #region response JSON
        #region path
        /// <summary>
        /// Get google location list under certain province by provincial ID， response a json list.
        /// </summary>
        /// <param name="pid">Provincial ID</param>
        /// <returns>return provincial cities, formation in JSON</returns>
        [ActionName("json")]
        [Route("api/v2/google/province/json/{pid}")]
        [ResponseType(typeof(GoogleCityList))]
        [HttpGet]
        public HttpResponseMessage GetGoogleCityByProvinceID(int pid)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = locationservice.GetGoogleCityByProvinceID(pid).ToList();
            response = toJson(r);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "json", "path", string.Empty, string.Empty, "Provincal", "google", pid.ToString());
            return response;
        }
        #endregion path

        #region querystring
        /// <summary>
        /// Query string style, get google location list under certain province by provincial ID， response a json list.
        /// </summary>
        /// <param name="pid">Provincial ID</param>
        /// <returns>return provincial cities, formation in JSON</returns>
        [ActionName("json")]
        [Route("api/v2/google/province/json")]
        [ResponseType(typeof(GoogleCityList))]
        [HttpGet]
        public HttpResponseMessage GetGoogleCityByProvinceID_QS(int pid)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = locationservice.GetGoogleCityByProvinceID(pid).ToList();
            response = toJson(r);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "json", "query", string.Empty, string.Empty, "Provincal", "google", pid.ToString());
            return response;
        }
        #endregion querystring
        #endregion response JSON


        #region response XML
        #region path
        /// <summary>
        /// Get Google City location list by provincial ID, response format in XML
        /// </summary>
        /// <param name="pid">Provincial ID</param>
        /// <returns>return provincial city list format in XML</returns>
        [Route("api/v2/google/province/xml/{pid}")]
        [ResponseType(typeof(GoogleCityList))]
        [HttpGet]
        public HttpResponseMessage GetGoogleCityByProvince_XML(int pid)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            request = HttpContext.Current.Request;
            var xml = locationservice.GetGoogleCityByProvinceID(pid).ToList();
            if (xml.Count > 0)
            {
                var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, string.Empty, "Provincal", "google", pid.ToString());

                return response;
            }
            else
            {
                response = Request.CreateResponse(HttpStatusCode.NoContent);
                logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, string.Empty, "Provincal", "google", pid.ToString());

                return response;
            }

        }
        #endregion path

        #region Querystring
        /// <summary>
        /// Query string style, get Google City location list by provincial ID, response format in XML.
        /// </summary>
        /// <param name="pid">provincial ID</param>
        /// <returns>return provincial city list format in XML</returns>
        [Route("api/v2/google/province/xml")]
        [ResponseType(typeof(GoogleCityList))]
        [HttpGet]
        public HttpResponseMessage GetGoogleCityByProvince_XML_QS(int pid)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            request = HttpContext.Current.Request;

            var xml = locationservice.GetGoogleCityByProvinceID(pid).ToList();
            if (xml.Count > 0)
            {
                var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, string.Empty, "Provincal", "google", pid.ToString());

                return response;
            }
            else
            {
                response = Request.CreateResponse(HttpStatusCode.NoContent);
                logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, string.Empty, "Provincal", "google", pid.ToString());

                return response;
            }

        }
        #endregion Querystring
        #endregion resopnse XML
        #endregion Get GoogleCity By ProvinceID



        #region Get GoogleCity By GoogleCityid
        #region response JSON
        #region path
        /// <summary>
        /// Get google city info by its ID, response format in JSON
        /// </summary>
        /// <param name="cid">Google City ID</param>
        /// <returns>return city info format in JSON</returns>
        [ActionName("json")]
        [Route("api/v2/google/location/json/{cid}")]
        [ResponseType(typeof(GoogleCityList))]
        [HttpGet]
        public HttpResponseMessage GetGoogleCityByCid(int cid)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = locationservice.GetGoogleCityByCid(cid);
            response = toJson(r);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "json", "path", string.Empty, string.Empty, "this", "google", cid.ToString());
            return response;
        }
        #endregion path

        #region querystring
        /// <summary>
        /// Query string style, get google city info by its ID, response format in JSON
        /// </summary>
        /// <param name="cid">Google City ID</param>
        /// <returns>return city info format in JSON</returns>
        [ActionName("json")]
        [Route("api/v2/google/location/json")]
        [ResponseType(typeof(GoogleCityList))]
        [HttpGet]
        public HttpResponseMessage GetGoogleCityByCid_QS(int cid)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = locationservice.GetGoogleCityByCid(cid);
            response = toJson(r);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "json", "query", string.Empty, string.Empty, "this", "google", cid.ToString());
            return response;
        }
        #endregion querystring
        #endregion response JSON


        #region response XML
        #region path
        /// <summary>
        /// Get google city info by its ID, response format in XML
        /// </summary>
        /// <param name="cid">Google City ID</param>
        /// <returns>Return city info format in XML</returns>
        [Route("api/v2/google/location/xml/{cid}")]
        [ResponseType(typeof(GoogleCityList))]
        [HttpGet]
        public HttpResponseMessage GetGoogleCityByCid_XML(int cid)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            request = HttpContext.Current.Request;
            var xml = locationservice.GetGoogleCityByCid(cid);
            if (xml != null)
            {
                var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, string.Empty, "this", "google", cid.ToString());

                return response;
            }
            else
            {
                response = Request.CreateResponse(HttpStatusCode.NoContent);
                logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, string.Empty, "this", "google", cid.ToString());

                return response;
            }
        }
        #endregion path

        #region querystring
        /// <summary>
        /// Query string style, get google city info by its ID, response format in XML.
        /// </summary>
        /// <param name="cid">Google City ID</param>
        /// <returns>Return city info format in XML</returns>
        [Route("api/v2/google/location/xml")]
        [ResponseType(typeof(GoogleCityList))]
        [HttpGet]
        public HttpResponseMessage GetGoogleCityByCid_XML_QS(int cid)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            request = HttpContext.Current.Request;
            var xml = locationservice.GetGoogleCityByCid(cid);
            if (xml != null)
            {
                var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, string.Empty, "this", "google", cid.ToString());

                return response;
            }
            else
            {
                response =  Request.CreateResponse(HttpStatusCode.NoContent);
                logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, string.Empty, "this", "google", cid.ToString());
                return response;
            }
        }
        #endregion querystring
        #endregion response XML
        #endregion GetG oogleCity By GoogleCityid




        #region Get Increment GoogleCity List
        #region response JSON
        #region path
        /// <summary>
        /// Increment get google location list, response format in JSON
        /// </summary>
        /// <param name="cl">Google City Name</param>
        /// <returns>return Google city location list in jsno list.</returns>
        [ActionName("json")]
        [Route("api/v2/google/suggestion/json/{cl}")]
        [ResponseType(typeof(GoogleCityList))]
        [HttpGet]
        public HttpResponseMessage GetIncrementGoogleCityList(string cl)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var json = locationservice.GetIncrementGoogleCityList(cl).ToList();
            response = toJson(json);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "json", "path", string.Empty, string.Empty, "increment", "google", cl);
            return response;
        }
        #endregion path

        #region querystring
        /// <summary>
        /// Query string style, increment get google location list, response format in JSON
        /// </summary>
        /// <param name="cl"></param>
        /// <returns>return Google city location list in jsno list.</returns>
        [ActionName("json")]
        [Route("api/v2/google/suggestion/json")]
        [ResponseType(typeof(GoogleCityList))]
        [HttpGet]
        public HttpResponseMessage GetIncrementGoogleCityList_QS(string cl)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var json = locationservice.GetIncrementGoogleCityList(cl).ToList();
            response = toJson(json);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "json", "query", string.Empty, string.Empty, "increment", "google", cl);

            return response;
        }
        #endregion querystring
        #endregion response JSON


        #region response xml
        #region path
        /// <summary>
        /// Increment get Google city location list, response format in xml
        /// </summary>
        /// <param name="cl">Google City Name</param>
        /// <returns>return Google city location list in xml list.</returns>
        [ActionName("xml")]
        [Route("api/v2/google/suggestion/xml/{cl}")]
        [ResponseType(typeof(GoogleCityList))]
        [HttpGet]
        public HttpResponseMessage GetIncrementGoogleCityList_XML(string cl)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            request = HttpContext.Current.Request;
            var xml = locationservice.GetIncrementGoogleCityList(cl).ToList(); 
            if (xml != null)
            {
                var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, string.Empty, "increment", "google", cl);

                return response;
            }
            else
            {
                response = Request.CreateResponse(HttpStatusCode.NoContent);
                logservices.logservices(request, response, "dbo", "xml", "path", string.Empty, string.Empty, "increment", "google", cl);

                return response;
            }
        }
        #endregion path

        #region querystring
        /// <summary>
        /// Query String style, increment get Google city location list, response format in xml
        /// </summary>
        /// <param name="cl">Google City Name</param>
        /// <returns>return Google city location list in xml list.</returns>
        [ActionName("xml")]
        [Route("api/v2/google/suggestion/xml")]
        [ResponseType(typeof(GoogleCityList))]
        [HttpGet]
        public HttpResponseMessage GetIncrementGoogleCityList_XML_QS(string cl)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            request = HttpContext.Current.Request;
            var xml = locationservice.GetIncrementGoogleCityList(cl).ToList();
            if (xml != null)
            {
                var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, string.Empty, "increment", "google", cl);

                return response;
            }
            else
            {
                response = Request.CreateResponse(HttpStatusCode.NoContent);
                logservices.logservices(request, response, "dbo", "xml", "query", string.Empty, string.Empty, "increment", "google", cl);

                return response;
            }
        }
        #endregion querystring
        #endregion response xml
        #endregion Get Increment GoogleCity List




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
