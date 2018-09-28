using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web.Http;
using Microsoft.Owin.Security.OAuth;
using Newtonsoft.Json.Serialization;
using System.Web.Http.Cors;
using Newtonsoft.Json;
using System.Net.Http.Formatting;
using BIZ.AccessControl;

namespace WebApi
{
    /// <summary>
    /// 
    /// </summary>
    public static class WebApiConfig
    {
        static AuthServices authservices = new AuthServices();

        /// <summary>
        /// get all of allowable Domains 
        /// </summary>
        /// <returns></returns>
        public static List<string> GetAuthDomains()
        {
            List<string> domains = authservices.GetAllowDomains();
            return domains;
        }




        /// <summary>
        /// 
        /// </summary>
        /// <param name="config"></param>
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services
            // Configure Web API to use only bearer token authentication.
            config.SuppressDefaultHostAuthentication();
            config.Filters.Add(new HostAuthenticationFilter(OAuthDefaults.AuthenticationType));

            // Enables CORS for the specified domains for all WebApi Classes in our project
            //string allowdomain = Properties.Settings.Default.AllowDomain;

            // Get Allowable Domain from SQL Server 
            string[] validdomains = GetAuthDomains().ToArray();
            // concatenate /Join, or link  validdomains to a comma seprate string.
            string allowdomain = String.Join(",", validdomains);

            //  [EnableCors(origins: "http://localhost:59452", headers: "*", methods: "*")]
            //  You can add multiple origins by separating them with commas:
            //  [EnableCors(origins: "http://localhost:59452,http://localhost:25495,http://localhost:8080", headers: "*", methods: "*")]
            var cors = new EnableCorsAttribute(allowdomain, "*", "*")
            {
                SupportsCredentials = true
            };
            // 上面{SupportsCredentials = true}是为FoundryBC的要求加的 ， 以前没有这行code
            //cors.SupportsCredentials = true;  // 或写成 <-- 应该也行  2017-11-1 add for FoundryBC
            //upportsCredentials = true; EnableCorsAttribute(allowdomain, "*", "*") 里面的不能是* 通配符

            config.EnableCors(cors);


            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            config.Routes.MapHttpRoute(
                name: "CustomizeApi",
                routeTemplate: "api/{controller}/{action}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );


            // remove application/x-www-form-urlencoded
            // Failed to generate the sample for media type 'application/x-www-form-urlencoded'. Cannot use formatter 'JQueryMvcFormUrlEncodedFormatter' to write type 'email'.
            //config.Formatters.Clear();
            //config.Formatters.Add(new JsonMediaTypeFormatter());
            //config.Formatters.Add(new XmlMediaTypeFormatter()); 


        }
    }
}
