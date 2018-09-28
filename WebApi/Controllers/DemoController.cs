using DATA.EF;
using Newtonsoft.Json;
using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;

namespace WebApi.Controllers
{
    public class DemoController : ApiController
    {

        private RAMEntities db = new RAMEntities();
#region response JSON
    //Friendly
        [ActionName("json")]
        [Route("api/v1/Demo/json/{lang}")]
        [HttpGet]
        public HttpResponseMessage Demo(string lang)
        {

            var en = db.getProvinceList(lang);
            return toJson(en,lang);
        }
    //Query String
        [ActionName("json")]
        [Route("api/v1/Demo/json")]
        [HttpGet]
        public HttpResponseMessage Demo_QS(string lang)
        {
            var en = db.getProvinceList(lang);
            return toJson(en,lang);
        }
#endregion

#region Response XML
    //Friendly
        [ActionName("value")]
        [Route("api/v1/Demo/xml/{lang}")]
        [HttpGet]
        public HttpResponseMessage DemoX(string lang)
        {
            return createDemo(lang);
        }
    //Query String
        [ActionName("value")]
        [Route("api/v1/Demo/xml")]
        [HttpGet]
        public HttpResponseMessage DemoX_QS(string lang)
        {
            return createDemo(lang);
        }

        private HttpResponseMessage createDemo(string lang)
        {
            lang = lang.ToLower();
            if ((lang == "en") || (lang == "fr"))
            {
                var xml = db.getProvinceList(lang).ToList();
                if (xml.Count > 0)
                {
                    var response = Request.CreateResponse(HttpStatusCode.OK, xml, "application/xml");
                    return response;
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound);
                }
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }
        }
#endregion Response XML


        private HttpResponseMessage toJson(Object r, string lang)
        {
            lang = lang.ToLower();
            if ((lang == "en") || (lang =="fr"))
            {
                string thisJson = null;
                thisJson = JsonConvert.SerializeObject(r, Formatting.None);

                if (thisJson.Length < 5)
                {
                    var response = this.Request.CreateResponse(HttpStatusCode.NotFound);
                    response.Content = new StringContent(string.Empty, Encoding.UTF8, "application/json");
                    return response;
                }
                else
                {
                    var response = this.Request.CreateResponse(HttpStatusCode.OK);
                    response.Content = new StringContent(thisJson, Encoding.UTF8, "application/json");
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
