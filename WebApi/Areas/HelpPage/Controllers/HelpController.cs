using BIZ.Log;
using System;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using WebApi.Areas.HelpPage.ModelDescriptions;
using WebApi.Areas.HelpPage.Models;
using WebApi.Filters;
using WebApi.Models;

namespace WebApi.Areas.HelpPage.Controllers
{
    /// <summary>
    /// The controller that will handle requests for the help page.
    /// </summary>
    ///[FilterIP(
    ///     ConfigurationKeyAllowedSingleIPs = "AllowedAdminSingleIPs",
    ///     ConfigurationKeyAllowedMaskedIPs = "AllowedAdminMaskedIPs",
    ///     ConfigurationKeyDeniedSingleIPs = "DeniedAdminSingleIPs",
    ///     ConfigurationKeyDeniedMaskedIPs = "DeniedAdminMaskedIPs"
    ///)]


    [AuthorizeIPAddress]
    public class HelpController : Controller
    {
        private const string ErrorViewName = "Error";
        LogServices logservices = new LogServices();

        public HelpController()
            : this(GlobalConfiguration.Configuration)
        {
        }

        public HelpController(HttpConfiguration config)
        {
            Configuration = config;
        }

        public HttpConfiguration Configuration { get; private set; }

        
        public ActionResult Index()
        {
            ViewBag.DocumentationProvider = Configuration.Services.GetDocumentationProvider();
            HttpResponseMessage response = new HttpResponseMessage();
            HttpRequest request = System.Web.HttpContext.Current.Request;
            logservices.logservices(request, response, "dbo", "page", "display", request.UserHostName, string.Empty, request.UserHostAddress, "help", "quick start");

            return View(Configuration.Services.GetApiExplorer().ApiDescriptions);
        }

        public ActionResult Api(string apiId)
        {
            if (!String.IsNullOrEmpty(apiId))
            {
                HelpPageApiModel apiModel = Configuration.GetHelpPageApiModel(apiId);
                if (apiModel != null)
                {
                    return View(apiModel);
                }
            }

            return View(ErrorViewName);
        }

        public ActionResult ResourceModel(string modelName)
        {
            if (!String.IsNullOrEmpty(modelName))
            {
                ModelDescriptionGenerator modelDescriptionGenerator = Configuration.GetModelDescriptionGenerator();
                ModelDescription modelDescription;
                if (modelDescriptionGenerator.GeneratedModels.TryGetValue(modelName, out modelDescription))
                {
                    return View(modelDescription);
                }
            }

            return View(ErrorViewName);
        }
    }
}