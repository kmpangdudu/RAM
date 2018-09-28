using BIZ.EmailMe;
using BIZ.Log;
using System;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.Http;
using System.Web.Http.Description;
using WebApi.Filters;
namespace WebApi.Controllers
{
    /// <summary>
    /// Sending user selected favourite’s resources list to an email account.
    /// </summary>
    [AuthorizeIPAddress]
    [FilterIP]
    public class EmailController : ApiController
    {
        emailSenderServices es = new emailSenderServices();
        HttpResponseMessage response = new HttpResponseMessage();
        HttpRequest request = HttpContext.Current.Request;
        LogServices logservices = new LogServices();


        /// <summary>
        /// Sending user selected favourite's  resources from KHP's public SMTP. the email receiver should do email account format validation before sending.
        /// </summary>
        /// <param name="_email">user's email account and his favourites resources list. Using "，" (comma) to separate each receivers if you have multiple receivers.
        /// JSON format. 
        /// {"lang":"en","receiver":"user1@example.com; user2@example.com;", "body":"my favourites resources list:<br/> 1. Kids help phone; 2. Ontario Mental Health services."}</param>
        /// <returns>successful sent return "OK", otherwise will say "Failed" </returns>
        [ResponseType(typeof(email))]
        [ActionName("Send")]
        [Route("api/v2/email/send")]
        [HttpPost]
        public HttpResponseMessage Send([FromBody]email _email)
        {
             
            string host = Properties.Settings.Default.host;
            int port = Properties.Settings.Default.port;
            bool ssl = Properties.Settings.Default.ssl;
            string loginName = Properties.Settings.Default.loginname;
            string pwd = Properties.Settings.Default.pwd;
            string sendfrom = Properties.Settings.Default.sendfrom;
            string displayName = Properties.Settings.Default.displayname;
            string subject = _email.lang == "fr" ? Properties.Settings.Default.subject_fr : Properties.Settings.Default.subject;
            //string subject =   Properties.Settings.Default.subject;
            bool result = false;



            //sendfromInternal(host, port, ssl, loginname, pwd, sendfrom, displayname, receiver, subject, body)

            try
            {
                result = es.sendfromInternal(host, port, ssl, loginName, pwd, sendfrom, 
                    displayName, _email.receiver, subject, _email.body);
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }

            if (result) 
            {
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent("\"status\":\"OK\"", Encoding.UTF8);
                response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
                logservices.logservices(request, response, string.Empty, string.Empty, "send", _email.lang, string.Empty, subject, "email", _email.receiver);

                return response;
            }
            else
            {
                var response = this.Request.CreateResponse(HttpStatusCode.NotFound);
                response.Content = new StringContent("\"status\":\"Failed\"", Encoding.UTF8);
                response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
                logservices.logservices(request, response, string.Empty, string.Empty, "send", _email.lang, string.Empty, subject, "email", _email.receiver);

                return response; 
            }

        }



        /// <summary>
        /// Sending KHP eCard, its property declares in eCare class.
        /// </summary>
        /// <param name="_eCard">user's email account. Using "，" (comma) to separate each receivers if you have multiple receivers.
        /// JSON format. 
        /// {"lang":"en",
        /// "receiver":"user1@example.com; user2@example.com;",
        /// "sendFrom":"KHP_eCard@kidshelpphone.ca",
        /// "displayName":"Kids Help Phone",
        /// "subject":"Happy Holiday!"
        /// "body":"Happy Holiday!<br/><div>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque </div>
        /// <ul><li> venenatis vitae, justo.</li> 
        /// <li> Nam quam nunc, blandit vel, luctus</li>
        /// <li>an vulputate eleifend</li>
        /// <li>massa quis enim. Donec pede justo</li>
        /// </ul> <br/>KHP"}
        /// </param>
        /// <returns>successful sent return "OK", otherwise will say "Failed" </returns>
        [ResponseType(typeof(eCard))]
        [ActionName("Send")]
        [Route("api/v2/eCard/send")]
        [HttpPost]
        public HttpResponseMessage send([FromBody] eCard _eCard)
        {
            string host = Properties.Settings.Default.host;
            int port = Properties.Settings.Default.port;
            bool ssl = Properties.Settings.Default.ssl;
            string loginName = Properties.Settings.Default.eCardloginname;
            string pwd = Properties.Settings.Default.eCardpwd;
            string lang = _eCard.lang;
            string receiver = _eCard.receiver;
            string sendfrom = _eCard.sendfrom; //***??
            string displayName = _eCard.displayName; //***
            string subject = _eCard.subject; // ***??
            string body = _eCard.body;   
            bool result = false;
            //sendfromInternal(host, port, ssl, loginname, pwd, sendfrom, displayname, receiver, subject, body)
            try
            {
                result = es.sendfromInternal(host, port, ssl, loginName, pwd, sendfrom,
                    displayName, receiver, subject, body);
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }

            if (result)
            {
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent("\"status\":\"OK\"", Encoding.UTF8);
                response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
                logservices.logservices(request, response, string.Empty, string.Empty, "send", lang, string.Empty, subject, "eCard", receiver);

                return response;
            }
            else
            {
                var response = this.Request.CreateResponse(HttpStatusCode.NotFound);
                response.Content = new StringContent("\"status\":\"Failed\"", Encoding.UTF8);
                response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
                logservices.logservices(request, response, string.Empty, string.Empty, "send", lang, string.Empty, subject, "eCard", receiver);

                return response;
            }
        }


        // below is for debugging only. It is a "GET"

        ///// <summary>
        ///// eCard sender, does not use eCard class
        ///// </summary>
        ///// <param name="lang">Language</param>
        ///// <param name="receiver">Receiver account</param>
        ///// <param name="sendfrom">Send from account</param>
        ///// <param name="displayName">display name on the mail head.</param>
        ///// <param name="subject">subject of mail.</param>
        ///// <param name="body">mail body.</param>
        ///// <returns></returns>
        //[ResponseType(typeof(eCard))]
        //[ActionName("Send")]
        //[Route("api/v2/eCard/submit")]
        //[HttpGet]
        //public HttpResponseMessage submit(string lang, string receiver, string sendfrom,
        //    string displayName, string subject, string body)
        //{
        //    string host = Properties.Settings.Default.host;
        //    int port = Properties.Settings.Default.port;
        //    bool ssl = Properties.Settings.Default.ssl;
        //    string loginName = Properties.Settings.Default.eCardloginname;
        //    string pwd = Properties.Settings.Default.eCardpwd;
        //string lang = _eCard.lang;
        //string receiver = _eCard.receiver;
        //string sendfrom = _eCard.sendfrom; //***??
        //string displayName = _eCard.displayName; //***
        //string subject = _eCard.subject; // ***??
        //string body = _eCard.body;
        //    bool result = false;

        //    try
        //    {
        //        result = es.sendfromInternal(host, port, ssl, loginName, pwd, sendfrom,
        //            displayName, receiver, subject, body);
        //    }
        //    catch (Exception e)
        //    {
        //        e.Message.ToString();
        //    }

        //    if (result)
        //    {
        //        var response = this.Request.CreateResponse(HttpStatusCode.OK);
        //        response.Content = new StringContent("\"status\":\"OK\"", Encoding.UTF8);
        //        response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
        //        logservices.logservices(request, response, string.Empty, string.Empty, "submit", lang, string.Empty, subject, "eCard", receiver);

        //        return response;
        //    }
        //    else
        //    {
        //        var response = this.Request.CreateResponse(HttpStatusCode.NotFound);
        //        response.Content = new StringContent("\"status\":\"Failed\"", Encoding.UTF8);
        //        response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
        //        logservices.logservices(request, response, string.Empty, string.Empty, "submit", lang, string.Empty, subject, "eCard", receiver);

        //        return response;
        //    }
        //}













        /// <summary>
        /// Sending email by using Gmail public SMTP for testing. the email receiver should do email account format validation before sending.
        /// </summary>
        /// <param name="_email">user's email account and his favourites resources list. Using ", " (comma) to separate each receivers if you have multiple receivers.
        /// JSON format. 
        /// {"receiver":"user1@example.com; user2@example.com;", "body":"my favourites resources list:<br/> 1. Kids help phone; 2. Ontario Mental Health services."}</param>
        /// <returns>successful sent return "OK", otherwise will say "Failed" </returns>
        [ResponseType(typeof(email))]
        [ActionName("Send")]
        [HttpPost]
        [Route("api/v2/email/gmail")]
        public HttpResponseMessage Gsender([FromBody] email _email)

        {
            string subject = Properties.Settings.Default.subject;
            bool result = false;



            string _account = _email.receiver;
            string _body = _email.body;


            try
            {
                result = es.sendfromGmail(_account, subject, _body);
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }

                

            if (result)
            {
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent("\"status\":\"OK\"", Encoding.UTF8);
                response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
                logservices.logservices(request, response, string.Empty, string.Empty, "gsender", _email.lang, string.Empty, subject, "gmail", _account);

                return response;
            }
            else
            {
                var response = this.Request.CreateResponse(HttpStatusCode.NotFound);
                response.Content = new StringContent("\"status\":\"Failed\"", Encoding.UTF8);
                response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
                logservices.logservices(request, response, string.Empty, string.Empty, "gsender", _email.lang, string.Empty, subject, "gmail", _account);

                return response;
            }
        }
    }
}
