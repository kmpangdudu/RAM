using BIZ.Log;
using System.Net.Http;
using System.Web;
using System.Web.Mvc;
using WebApi.Filters;

namespace WebApi.Controllers
{
    /// <summary>
    /// 
    /// </summary>
    public class DocController : Controller
    {

        LogServices logservices = new LogServices();

        // GET: Doc
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        [AuthorizeIPAddress]
        [FilterIP]
        public ActionResult Index()
        {
            HttpResponseMessage response = new HttpResponseMessage();
            HttpRequest request = System.Web.HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "page", "display", request.UserHostName, string.Empty, request.UserHostAddress, "doc", "sandbox");

            return View();
        }
    }
}