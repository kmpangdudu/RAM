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
    /// Get provincial information.
    /// </summary>
    [AuthorizeIPAddress]
    [FilterIP]
    public class ProvinceController : ApiController
    {
        private ProvinceServices provincesrvice = new ProvinceServices();
        HttpResponseMessage response = new HttpResponseMessage();
        HttpRequest request = HttpContext.Current.Request;
        LogServices logservices = new LogServices();

        #region Get Province List
        #region JSON
        //Friendly
        /// <summary>
        /// Get allowable province list in JSON format filter by language.
        /// </summary>
        /// <param name="lang">Language. English = "en"; French = "fr"</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a province list, [ProvinceID], [Province], [Province ALias],format in JSON</returns>
        [ActionName("json")]
            [Route("api/v2/Province/json/{lang}/{token}")]
            [ResponseType(typeof(ProvinceList))]
            [HttpGet]
            [AuthorizeIPAddress]
            public HttpResponseMessage GetAllProvince(string lang, string token)
            {
                //var json = provincesrvice.GetAllProvinces(lang).ToList();
                var json = provincesrvice.GetAllProvinces(lang, token);
                response = toJson(json, lang);
                request = HttpContext.Current.Request;
                logservices.logservices(request, response, "dbo", "json", "path", lang, token, "all", "province", string.Empty);

                return response;
            }

        //Query String
        /// <summary>
        /// Query String style gets allowable province list in JSON format filter by language.
        /// </summary>
        /// <param name="lang">Language. English = "en"; French = "fr"</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a province list, [ProvinceID], [Province], [Province ALias],format in JSON</returns>
        [ResponseType(typeof(ProvinceList))]
            [ActionName("json")]
            [Route("api/v2/Province/json")]
            [HttpGet]
            public HttpResponseMessage GetAllProvince_QS(string lang, string token)
            {
                var json = provincesrvice.GetAllProvinces(lang, token).ToList();
            response = toJson(json, lang);
            request = HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "json", "query", lang, token, "all", "province", string.Empty);

            return response;
            }

        #endregion JSON

            #region XML
        //Friendly
        /// <summary>
        /// Get allowable province list in XML format filter by language.
        /// </summary>
        /// <param name="lang">Language. English = "en"; French = "fr"</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a province list, [ProvinceID], [Province], [Province ALias],format in XML</returns>
        [ActionName("xml")]
                [ResponseType(typeof(ProvinceList))]
                [Route("api/v2/Province/xml/{lang}/{token}")]
                [HttpGet]
                public HttpResponseMessage GetAllProvinces_XML(string lang, string token)
                {
                    response = createProvince_XML(lang, token);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "xml", "path", lang, token, "all", "province", string.Empty);

                    return response;
                }

        //Query String
        /// <summary>
        /// Query String Style gets allowable province list in XML format filter by language.
        /// </summary>
        /// <param name="lang">Language. English = "en"; French = "fr"</param>
        ///  <param name="token">Language. English = "en"; French = "fr"</param>
        /// <returns>Return a province list, [ProvinceID], [Province], [Province ALias],format in XML</returns>
        [ActionName("xml")]
                [Route("api/v2/Province/xml")]
                [ResponseType(typeof(ProvinceList))]
                [HttpGet]
                public HttpResponseMessage GetAllProvinces_XML_QS(string lang, string token)
                {
                    response = createProvince_XML(lang, token);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "xml", "query", lang, token, "all", "province", string.Empty);

                    return response;
                }
                private HttpResponseMessage createProvince_XML(string lang, string token)
                {
                    lang = lang.ToLower();
                    if ((lang == "en") || (lang == "fr"))
                    {
                        var xml = provincesrvice.GetAllProvinces(lang, token).ToList();
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
        #endregion Get Province List

        #region Get Province By ID
        #region JSON
        //Friendly
        /// <summary>
        /// Get allowable provincial info by Province ID and language format in JSON.
        /// </summary>
        /// <param name="lang">Language. English = "en"; French = "fr"</param>
        /// <param name="pid">provincial ID. AB = 1, BC = 2, .... , On = 9,.....</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a province infor, [ProvinceID], [Province], [Province ALias], format in JSON</returns>
        [ActionName("json")]
                [ResponseType(typeof(ProvinceList))]
                [Route("api/v2/Province/json/{token}/{lang}/{pid}")]
                [HttpGet]
                public HttpResponseMessage GetProvincesByID(string lang, int pid, string token)
                {
                    var json = provincesrvice.GetProvinceByID(lang, pid, token);
                    response = toJson(json, lang);
                    request = HttpContext.Current.Request;

                    logservices.logservices(request, response, "dbo", "json", "query", lang, token, "this", "province", pid.ToString());
                    return response;
                }
        //Query String
        /// <summary>
        /// Query String style gets allowable provincial info by Province ID and language format in JSON.
        /// </summary>
        /// <param name="lang">Language. English = "en"; French = "fr"</param>
        /// <param name="pid">provincial ID. AB = 1, BC = 2, .... , On = 9,.....</param>
        /// <param name="token"> Access token</param>
        /// <returns>Return a province infor, [ProvinceID], [Province], [Province ALias], format in JSON</returns>
        [ActionName("json")]
                [ResponseType(typeof(ProvinceList))]
                [Route("api/v2/Province/json")]
                [HttpGet]
                public HttpResponseMessage GetProvincesByID_QS(string lang, int pid, string token)
                {
                    var json = provincesrvice.GetProvinceByID(lang, pid, token);
                    response = toJson(json, lang);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "json", "query", lang, token, "this", "province", pid.ToString());

                    return response;
                }
        #endregion JSON

        #region XML
        //Friendly
        /// <summary>
        /// Get allowable province list in XML format filter by language.
        /// </summary>
        /// <param name="lang">Language. English = "en"; French = "fr"</param>
        /// <param name="pid">provincial ID. AB = 1, BC = 2, .... , On = 9,.....</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a province infor, [ProvinceID], [Province], [Province ALias], format in XML</returns>
        [ActionName("xml")]
                [ResponseType(typeof(ProvinceList))]
                [Route("api/v2/Province/xml/{token}/{lang}/{pid}")]
                [HttpGet]
                public HttpResponseMessage GetAllProvincesByID_XML(string lang, int pid, string token)
                {
                    response = createProvinceByID_XML(lang, pid, token);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "xml", "path", lang, token, "this", "province", pid.ToString());

                    return response;
                }
        //Query String
        /// <summary>
        /// Query String style gets allowable province list in XML format filter by language.
        /// </summary>
        /// <param name="lang">Language. English = "en"; French = "fr"</param>
        /// <param name="pid">provincial ID. AB = 1, BC = 2, .... , On = 9,.....</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a province infor, [ProvinceID], [Province], [Province ALias], format in XML</returns>
        [ActionName("xml")]
                [ResponseType(typeof(ProvinceList))]
                [Route("api/v2/Province/xml")]
                [HttpGet]
                public HttpResponseMessage GetAllProvincesByID_XML_QS(string lang, int pid, string token)
                {
                    response = createProvinceByID_XML(lang, pid, token);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "xml", "query", lang, token, "this", "province", pid.ToString());

                    return response;
                }
                private HttpResponseMessage createProvinceByID_XML(string lang, int pid, string token)
                {
                    lang = lang.ToLower();
                    if ((lang == "en") || (lang == "fr"))
                    {
                        var xml = provincesrvice.GetProvinceByID(lang, pid, token);
                        if (xml != null)
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
        #endregion get Province By ID

                private HttpResponseMessage toJson(Object r, string lang)
                {
                    lang = lang.ToLower();
                    if ((lang == "en") || (lang == "fr"))
                    {
                        var thisJson = JsonConvert.SerializeObject(r, Formatting.None);

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
