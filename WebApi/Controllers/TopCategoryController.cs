using BIZ.Log;
using BIZ.TopCategories;
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
    /// Get TopCategory information.
    /// </summary>
    [AuthorizeIPAddress]
    [FilterIP]
    public class TopCategoryController : ApiController
    {
        private TopCategoryServices topCategorysercice = new TopCategoryServices();
        HttpResponseMessage response = new HttpResponseMessage();
        HttpRequest request = HttpContext.Current.Request;
        LogServices logservices = new LogServices();

        #region GetAllTopCategory List
        #region json

        // Friendly
        /// <summary>
        /// Get allowable TopCategory JSON list by language.
        /// </summary>
        /// <param name="lang">Language. English = "en", French = "fr"</param>
        /// <param name="token">Acess token </param>
        /// <returns>Authorized user get JSON style allowable Topcategory list, [TopCategoryID], [TOpCategory]. Filter by language and access token</returns>
        [ActionName("json")]
                [Route("api/v2/TopCategory/json/{token}/{lang}")]
                [Route("api/v2/catégorie/json/{token}/{lang}")]
                [ResponseType(typeof(TopCategoryList))]
                [HttpGet]
                public HttpResponseMessage GetAllTopCategories(string lang, string token)
                {
                    var json = topCategorysercice.GetAllTopCategories(lang, token).ToList();
                    response = toJson(json, lang);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "json", "path", lang, token, "all", "TopCategory", string.Empty);

                    return response;
                }
                //Query String
                /// <summary>
                /// Query String Style. Get allowable TopCategory JSON list by language.
                /// </summary>
                /// <param name="lang">Language. English = "en", French = "fr"</param>
                /// <param name="token">Acess token </param>
                /// <returns>Authorized user get JSON style allowable Topcategory list, [TopCategoryID], [TopCategory]. Filter by language</returns>
                [ActionName("json")]
                [Route("api/v2/TopCategory/json")]
                [Route("api/v2/catégorie/json")]
                [ResponseType(typeof(TopCategoryList))]
                [HttpGet]
                public HttpResponseMessage GetAllTopCategories_QS(string lang, string token)
                {
                    var json = topCategorysercice.GetAllTopCategories(lang,token).ToList();
                    response = toJson(json, lang);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "json", "query", lang, token, "all", "TopCategory", string.Empty);
                    return response;
                }
            #endregion json

            #region xml
                // Friendly
                /// <summary>
                /// Get allowable TopCategory list by language. Fromat in XML
                /// </summary>
                /// <param name="lang">Language. English = "en", French = "fr"</param>
                /// <param name="token">Acess token </param>
                /// <returns>Return XML style TopCategory list, [TopCategoryID], [TopCategory]. Filter by language</returns>
                [ActionName("xml")]
                [Route("api/v2/TopCategory/xml/{token}/{lang}")]
                [Route("api/v2/catégorie/xml/{token}/{lang}")]
                [ResponseType(typeof(TopCategoryList))]
                [HttpGet]
                public HttpResponseMessage GetAllTopCategories_xml(string lang, string token)
                {
                    response = createAllTopCategory_XML(lang, token);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "xml", "path", lang, token, "all", "TopCategory", string.Empty);

                    return response;
                }

                // Query String
                /// <summary>
                /// Query String Style. Get TopCategory list by language.
                /// </summary>
                /// <param name="lang">Language. English = "en", French = "fr"</param>
                /// <param name="token">Acess token.</param>
                /// <returns>Return XML style TopCategory list, [TopCategoryID], [TopCategory]. Filter by language</returns>
                [ActionName("xml")]
                [Route("api/v2/TopCategory/xml")]
                [Route("api/v2/catégorie/xml")]
                [ResponseType(typeof(TopCategoryList))]
                [HttpGet]
                public HttpResponseMessage GetAllTopCategories_xml_QS(string lang, string token)
                {
                    response = createAllTopCategory_XML(lang, token);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "xml", "query", lang, token, "all", "TopCategory", string.Empty);

                    return response;
                }
                private HttpResponseMessage createAllTopCategory_XML(string lang, string token)
                {
                    lang = lang.ToLower();
                    if ((lang == "en") || (lang == "fr"))
                    {
                        var xml = topCategorysercice.GetAllTopCategories(lang,token).ToList();

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
            #endregion xml
        #endregion GetAllTopCategory List


        #region GetTopCategoryByID
            #region JSON
                // Friendly
                /// <summary>
                /// Get TopCategory by TopCategoryID, Return a json format
                /// </summary>
                /// <param name="lang">Language. English = "en", French = "fr"</param>
                /// <param name="tid">TopCategory ID.</param>
                /// <param name="token">access token</param>
                /// <returns>return TopCategory format in json </returns>
                [ActionName("json")]
                [Route("api/v2/TopCategory/json/{token}/{lang}/{tid}")]
                [Route("api/v2/catégorie/json/{token}/{lang}/{tid}")]
                [ResponseType(typeof(TopCategoryList))]
                [HttpGet]
                public HttpResponseMessage GetTopCategoryByID(string lang, int tid, string token)
                {
                    var json = topCategorysercice.GetTopCategoryByID(lang, tid, token);
                    response = toJson(json, lang);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "json", "path", lang, token, "this", "TopCategory", tid.ToString());

                    return response;
                }
                // Query String
                /// <summary>
                /// Query String Style. Get TopCategory by TopCategoryID Return a json format
                /// </summary>
                /// <param name="lang">Language. English = "en", French = "fr"</param>
                /// <param name="tid">TopCategory ID.</param>
                /// <param name="token">access token</param>
                /// <returns>return TopCategory format in json </returns>
                [ActionName("json")]
                [Route("api/v2/TopCategory/json")]
                [Route("api/v2/catégorie/json")]
                [ResponseType(typeof(TopCategoryList))]
                [HttpGet]
                public HttpResponseMessage GetTopCategoryByID_QS(string lang, int tid, string token)
                {
                    var json = topCategorysercice.GetTopCategoryByID(lang, tid, token);
                    response = toJson(json, lang);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "json", "query", lang, token, "this", "TopCategory", tid.ToString());

                    return response;
                }
            #endregion JSON

            #region XML
                // Friendly
                /// <summary>
                /// Get TopCategory by TopCategoryID
                /// </summary>
                /// <param name="lang">Language. English = "en", French = "fr"</param>
                /// <param name="tid">TopCategory ID.</param>
                /// <param name="token">access token</param>
                /// <returns>return TopCategory format in XML </returns>
                [ActionName("xml")]
                [Route("api/v2/TopCategory/xml/{token}/{lang}/{tid}")]
                [Route("api/v2/catégorie/xml/{token}/{lang}/{tid}")]
                [ResponseType(typeof(TopCategoryList))]
                [HttpGet]
                public HttpResponseMessage GetTopCategoryByID_XML(string lang, int tid, string token)
                {
                    response = getTopCategoryByID_XML(lang, tid, token);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "xml", "path", lang, token, "this", "TopCategory", tid.ToString());

                    return response;
                }

                // Query String
                /// <summary>
                /// Query String style. Get TopCategory by TopCategoryID
                /// </summary>
                /// <param name="lang">Language. English = "en", French = "fr"</param>
                /// <param name="tid">TopCategory ID.</param>
                /// <param name="token">access token</param>
                /// <returns>return TopCategory format in XML </returns>
                [ActionName("xml")]
                [Route("api/v2/TopCategory/xml")]
                [Route("api/v2/catégorie/xml")]
                [ResponseType(typeof(TopCategoryList))]
                [HttpGet]
                public HttpResponseMessage GetTopCategoryByID_XML_QS(string lang, int tid, string token)
                {
                    response = getTopCategoryByID_XML(lang,tid, token);
                    request = HttpContext.Current.Request;
                    logservices.logservices(request, response, "dbo", "xml", "query", lang, token, "this", "TopCategory", tid.ToString());

                    return response;
                }
                private HttpResponseMessage getTopCategoryByID_XML(string lang, int tid, string token)
                {
                    lang = lang.ToLower();
                    if ((lang == "en") || (lang == "fr"))
                    {
                        var xml = topCategorysercice.GetTopCategoryByID(lang, tid, token);
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
        #endregion GetTopCategoryByID

        private HttpResponseMessage toJson(Object r,string lang)
        {
            lang = lang.ToLower();
            if ((lang == "en") || (lang =="fr"))
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
