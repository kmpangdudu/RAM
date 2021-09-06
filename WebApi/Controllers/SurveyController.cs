using BIZ.Log;
using BIZ.Survey;
using DATA.EF;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Http.Description;

namespace WebApi.Controllers
{
    /// <summary>
    /// Retrieving survey information and collecting user's Survey answer.
    /// </summary>
    public class SurveyController : ApiController
    {
        HttpResponseMessage response = new HttpResponseMessage();
        HttpRequest request = HttpContext.Current.Request;
        LogServices logservices = new LogServices();
        suveryServices ss = new suveryServices();

        // v2
        #region Version 2
        /// <summary>
        /// Version 2: collecting Per/Post Survey answer 
        /// </summary>
        /// <param name="_survey">Collection of answers</param>
        /// <param name="_surveyQuestion_ID">_surveyQuestion_ID</param>
        /// <param name="_surveyAnswer">survey Answer(s)</param>
        /// <param name="_chatID">ChatID:from ChatApp</param>
        /// <param name="language">survey language, English, French</param>
        /// <param name="surveyAnswer_Device">Answer device, useragent or short in Mobile, laptop etc </param>
        /// <param name="token">Access Token</param>
        /// <returns></returns>
        [ResponseType(typeof(answer))]
        [Route("api/v2/survey/answer")]
        [HttpPost]
        [EnableCors(origins: "*", headers: "*", methods: "post")]
        public HttpResponseMessage answer([FromBody]ChatSurvey _survey)
        {
            bool result = false;

            int _chatid = 0;
            string _language = "";
            string _surveyAnswer_Device = "";
            string _token = "";

            List<answer> _answer = _survey.chatsurvey;
            int _surveyQuestion_ID = 0;
            string _surveyAnswer = "";

            try
            {
                _chatid = _survey.chatID;
                _language = _survey.language;
                _surveyAnswer_Device = _survey.surveyAnswer_Device;
                _token = _survey.token;

                foreach (answer _a in _answer)
                {
                    _surveyQuestion_ID = _a.surveyQuestion_ID;
                    _surveyAnswer = _a.surveyAnswer;

                    ss.insertSurvey(_token,  _surveyQuestion_ID, _chatid, _surveyAnswer, _language, _surveyAnswer_Device);

                    result = true;
                }

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

                //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
                 logservices.logservices(request, response, "survey", "json", "path", _language, _token, "answer", "survey_2", _chatid+"");


                return response;
            }
            else
            {
                var response = this.Request.CreateResponse(HttpStatusCode.NotFound);
                response.Content = new StringContent("\"status\":\"Failed\"", Encoding.UTF8);
                response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");


                logservices.logservices(request, response, "survey", "json", "path", _language, _token, "answer", "survey_2", _chatid + "");

                return response;
            }

        }
        #endregion Version 2




        // V3
        #region Version_3
        #region post_answer
        /// <summary>
        /// Version 3: collecting Ver.3 Per/Post Survey answer 
        /// </summary>
        /// <param name="_survey">Collection of answers</param>
        /// <param name="_surveyQuestion_ID">surveyQuestion_ID</param>
        /// <param name="_surveyAnswer">survey Answer(s)</param>
        /// <param name="_chatID">ChatID:from ChatApp</param>
        /// <param name="language">survey language, English, French</param>
        /// <param name="surveyAnswer_Device">Answer device, useragent or short in Mobile, laptop etc </param>
        /// <param name="token">Access Token</param>
        /// <returns></returns>
        [ResponseType(typeof(answer))]
        [Route("api/v3/survey/answer")]
        [HttpPost]
        [EnableCors(origins: "*", headers: "*", methods: "post")]
        public HttpResponseMessage answerv3([FromBody]ChatSurvey _survey)
        {
            bool result = false;

            int _chatid = 0;
            string _language = "";
            string _surveyAnswer_Device = "";
            string _token = "";

            List<answer> _answer = _survey.chatsurvey;
            int _surveyQuestion_ID = 0;
            string _surveyAnswer = "";

            try
            {
                _chatid = _survey.chatID;
                _language = _survey.language;
                _surveyAnswer_Device = _survey.surveyAnswer_Device;
                _token = _survey.token;

                foreach (answer _a in _answer)
                {
                    _surveyQuestion_ID = _a.surveyQuestion_ID;
                    _surveyAnswer = _a.surveyAnswer;

                    ss.insertSurvey(_token, _surveyQuestion_ID, _chatid, _surveyAnswer, _language, _surveyAnswer_Device);

                    result = true;
                }

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

                //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
                logservices.logservices(request, response, "survey", "json", "path", _language, _token, "answer", "survey_3", _chatid + "");


                return response;
            }
            else
            {
                var response = this.Request.CreateResponse(HttpStatusCode.NotFound);
                response.Content = new StringContent("\"status\":\"Failed\"", Encoding.UTF8);
                response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");


                logservices.logservices(request, response, "survey", "json", "path", _language, _token, "answer", "survey_3", _chatid + "");

                return response;
            }

        }
        #endregion post_answer


        #region survey_type
        // Path
        /// <summary>
        /// Path: Gets a list of survey types SurveyTypeID=0, or type information specifying the survey type ID.
        /// </summary>
        /// <param name="TypeID">Survey type id, Per-Survey, Post-Suvey etc.</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return a survey type list, or return a survey type by specific survey-type-ID. Format in JSON </returns>
        [ActionName("json")]
        [Route("api/v3/survey/type/json/{TypeID}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyTypeByID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyType(int TypeID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyType(token, TypeID, lang);
            response = toJson(r,lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "survey type", "survey_3", TypeID + "");
            return response;
        }
        // Query
        /// <summary>
        /// Query: Gets a list of survey types SurveyTypeID=0, or type information specifying the survey type ID.
        /// </summary>
        /// <param name="TypeID">Survey type id, Per-Survey, Post-Suvey etc.</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return a survey type list, or return a survey type by specific survey-type-ID. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v3/survey/type/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyTypeByID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyType_QS(int TypeID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyType(token, TypeID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "query", lang, token, "survey type", "survey_3", TypeID + "");
            return response;
        }
        #endregion survey_type


        #region question_list
        // Path
        /// <summary>
        /// Path: retrieving a list of survey questions when QuestionID=0, or a specify information about the questions.
        /// </summary>
        /// <param name="QID">servey question ID</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return a survey question list, or return a specific survey question information by its survey-question-ID. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v3/survey/question/json/{QID}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionByQuestionID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestion(int QID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestion(token, QID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "survey question", "survey_3", QID + "");
            return response;
        }

        // Query
        /// <summary>
        /// Query: retrieving a list of survey questions when QuestionID=0, or a specify information about the questions.
        /// </summary>
        /// <param name="QID">servey question ID</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return a survey question list, or return a specific survey question information by its survey-question-ID. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v3/survey/question/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionByQuestionID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestion_QS(int QID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestion(token, QID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "query", lang, token, "survey question", "survey_3", QID + "");
            return response;
        }
        #endregion question_list


        #region question_optional
        // Path
        /// <summary>
        /// Path: Get optional answers to specified survey questions, and when QuestionID=0, gets the full list of options.
        /// </summary>
        /// <param name="QID">servey question ID</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a specific survey question optional answers list, or all of V3 question optional answers list if no question specified. JSON format.</returns>
        [ActionName("json")]
        [Route("api/v3/survey/question/answer/option/json/{QID}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionOptsByQuestionID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionOpt(int QID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionOpts(token, QID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "answer options", "survey_3", QID + "");
            return response;
        }

        // Query
        /// <summary>
        /// Query: Get optional answers to specified survey questions, and when QuestionID=0, gets the full list of options.
        /// </summary>
        /// <param name="QID">servey question ID</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a specific survey question optional answers list, or all of V3 question optional answers list if no question specified. JSON format.</returns>
        [ActionName("json")]
        [Route("api/v3/survey/question/answer/option/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionOptsByQuestionID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionOpt_QS(int QID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionOpts(token, QID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "answer options", "survery_3", QID + "");
            return response;
        }
        #endregion question_optional


        #region question_List_By_Version
        /// <summary>
        /// Path: Gets a list of questions for the specified survey version
        /// </summary>
        /// <param name="ver">servey version number. E.g.: v2,v3 </param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return all version survey question list, or return a specific version survey question information list. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v3/survey/question/version/json/{ver}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionByVersion_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionByVer(string ver, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionByVersion(token, ver, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "survey question by Version", "survey_3", ver + "");
            return response;
        }

        /// <summary>
        /// Query: Gets a list of questions for the specified survey version
        /// </summary>
        /// <param name="ver">servey version number. E.g.: v2,v3 </param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return all version survey question list, or return a specific version survey question information list. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v3/survey/question/version/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionByVersion_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionByVer_QS(string ver, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionByVersion(token, ver, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "query", lang, token, "survey question by Version", "survey_3", ver + "");
            return response;
        }
        #endregion question_List_By_Version


        #region question_optional_By_Version
        /// <summary>
        /// Path: Get survey question optional answers list by specified version.
        /// </summary>
        /// <param name="ver">servey version. E.g. v2, v3</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a specific survey question optional answers list, or all of V3 question optional answers list if no question specified. JSON format.</returns>
        [ActionName("json")]
        [Route("api/v3/survey/version/question/answer/option/json/{ver}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionOptsByVersion_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionOptByVer(string ver, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionOptsByVersion(token, ver, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "version answer options", "survery_3", ver + "");
            return response;
        }

        /// <summary>
        /// Query: Get survey question optional answers list by specified version.
        /// </summary>
        /// <param name="ver">servey version. E.g. v2, v3</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a specific survey question optional answers list, or all of V3 question optional answers list if no question specified. JSON format.</returns>
        [ActionName("json")]
        [Route("api/v3/survey/version/question/answer/option/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionOptsByVersion_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionOptByVer_QS(string ver, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionOptsByVersion(token, ver, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "version answer options", "survey_3", ver + "");
            return response;
        }
        #endregion question_optional_By_Version

        #endregion Version_3




        // V5 --2021-03-13
        #region Version_5
        #region post_answer
        /// <summary>
        /// Version 5: collecting Ver.5 Per/Post Survey answer 
        /// </summary>
        /// <param name="_survey">Collection of answers</param>
        /// <param name="_surveyQuestion_ID">surveyQuestion_ID</param>
        /// <param name="_surveyAnswer">survey Answer(s)</param>
        /// <param name="_chatID">ChatID:from ChatApp</param>
        /// <param name="language">survey language, English, French</param>
        /// <param name="surveyAnswer_Device">Answer device, useragent or short in Mobile, laptop etc </param>
        /// <param name="token">Access Token</param>
        /// <returns></returns>
        [ResponseType(typeof(answer))]
        [Route("api/v5/survey/answer")]
        [HttpPost]
        [EnableCors(origins: "*", headers: "*", methods: "post")]
        public HttpResponseMessage answerv5([FromBody] ChatSurvey _survey)
        {
            bool result = false;

            int _chatid = 0;
            string _language = "";
            string _surveyAnswer_Device = "";
            string _token = "";

            List<answer> _answer = _survey.chatsurvey;
            int _surveyQuestion_ID = 0;
            string _surveyAnswer = "";

            try
            {
                _chatid = _survey.chatID;
                _language = _survey.language;
                _surveyAnswer_Device = _survey.surveyAnswer_Device;
                _token = _survey.token;

                foreach (answer _a in _answer)
                {
                    _surveyQuestion_ID = _a.surveyQuestion_ID;
                    _surveyAnswer = _a.surveyAnswer;

                    ss.insertSurvey(_token, _surveyQuestion_ID, _chatid, _surveyAnswer, _language, _surveyAnswer_Device);

                    result = true;
                }

            }
            catch (Exception e)
            {
                e.Message.ToString();
            }

            if (result)
            {
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent("\"status\":\"OK\"", Encoding.UTF8);
                response.Content.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
                logservices.logservices(request, response, "survey", "json", "path", _language, _token, "answer", "survey_5", _chatid + "");


                return response;
            }
            else
            {
                var response = this.Request.CreateResponse(HttpStatusCode.NotFound);
                response.Content = new StringContent("\"status\":\"Failed\"", Encoding.UTF8);
                response.Content.Headers.ContentType = new MediaTypeHeaderValue("application/json");


                logservices.logservices(request, response, "survey", "json", "path", _language, _token, "answer", "survey_5", _chatid + "");

                return response;
            }

        }
        #endregion post_answer


        #region survey_type
        // Path
        /// <summary>
        /// Path: Gets a list of survey types SurveyTypeID=0, or type information specifying the survey type ID.
        /// </summary>
        /// <param name="TypeID">Survey type id, Per-Survey, Post-Suvey etc.</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return a survey type list, or return a survey type by specific survey-type-ID. Format in JSON </returns>
        [ActionName("json")]
        [Route("api/v5/survey/type/json/{TypeID}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyTypeByID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyType5(int TypeID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyType(token, TypeID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "survey type", "survey_5", TypeID + "");
            return response;
        }
        // Query
        /// <summary>
        /// Query: Gets a list of survey types SurveyTypeID=0, or type information specifying the survey type ID.
        /// </summary>
        /// <param name="TypeID">Survey type id, Per-Survey, Post-Suvey etc.</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return a survey type list, or return a survey type by specific survey-type-ID. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v5/survey/type/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyTypeByID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyType_QS5(int TypeID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyType(token, TypeID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "query", lang, token, "survey type", "survey_5", TypeID + "");
            return response;
        }
        #endregion survey_type


        #region question_list
        // Path
        /// <summary>
        /// Path: retrieving a list of survey questions when QuestionID=0, or a specify information about the questions.
        /// </summary>
        /// <param name="QID">servey question ID</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return a survey question list, or return a specific survey question information by its survey-question-ID. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v5/survey/question/json/{QID}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionByQuestionID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestion5(int QID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestion(token, QID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "survey question", "survey_5", QID + "");
            return response;
        }

        // Query
        /// <summary>
        /// Query: retrieving a list of survey questions when QuestionID=0, or a specify information about the questions.
        /// </summary>
        /// <param name="QID">servey question ID</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return a survey question list, or return a specific survey question information by its survey-question-ID. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v5/survey/question/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionByQuestionID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestion_QS5(int QID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestion(token, QID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "query", lang, token, "survey question", "survey_5", QID + "");
            return response;
        }
        #endregion question_list


        #region question_optional
        // Path
        /// <summary>
        /// Path: Get optional answers to specified survey questions, and when QuestionID=0, gets the full list of options.
        /// </summary>
        /// <param name="QID">servey question ID</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a specific survey question optional answers list, or all of V3 question optional answers list if no question specified. JSON format.</returns>
        [ActionName("json")]
        [Route("api/v5/survey/question/answer/option/json/{QID}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionOptsByQuestionID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionOpt5(int QID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionOpts(token, QID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "answer options", "survey_5", QID + "");
            return response;
        }

        // Query
        /// <summary>
        /// Query: Get optional answers to specified survey questions, and when QuestionID=0, gets the full list of options.
        /// </summary>
        /// <param name="QID">servey question ID</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a specific survey question optional answers list, or all of V3 question optional answers list if no question specified. JSON format.</returns>
        [ActionName("json")]
        [Route("api/v5/survey/question/answer/option/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionOptsByQuestionID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionOpt_QS5(int QID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionOpts(token, QID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "answer options", "survey_5", QID + "");
            return response;
        }
        #endregion question_optional


        #region question_List_By_Version
        /// <summary>
        /// Path: Gets a list of questions for the specified survey version
        /// </summary>
        /// <param name="ver">servey version number. E.g.: v2,v3 </param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return all version survey question list, or return a specific version survey question information list. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v5/survey/question/version/json/{ver}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionByVersion_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionByVer5(string ver, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionByVersion(token, ver, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "survey question by Version", "survey_5", ver + "");
            return response;
        }

        /// <summary>
        /// Query: Gets a list of questions for the specified survey version
        /// </summary>
        /// <param name="ver">servey version number. E.g.: v2, v3, v5</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return all version survey question list, or return a specific version survey question information list. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v5/survey/question/version/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionByVersion_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionByVer_QS5(string ver, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionByVersion(token, ver, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "query", lang, token, "survey question by Version", "survey_5", ver + "");
            return response;
        }
        #endregion question_List_By_Version


        #region question_optional_By_Version
        /// <summary>
        /// Path: Get survey question optional answers list by specified version.
        /// </summary>
        /// <param name="ver">servey version. E.g. v2, v3, v5</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a specific survey question optional answers list, or all of V3 question optional answers list if no question specified. JSON format.</returns>
        [ActionName("json")]
        [Route("api/v5/survey/version/question/answer/option/json/{ver}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionOptsByVersion_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionOptByVer5(string ver, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionOptsByVersion(token, ver, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "version answer options", "survey_5", ver + "");
            return response;
        }

        /// <summary>
        /// Query: Get survey question optional answers list by specified version.
        /// </summary>
        /// <param name="ver">servey version. E.g. v2, v3, v5</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a specific survey question optional answers list, or all of V3 question optional answers list if no question specified. JSON format.</returns>
        [ActionName("json")]
        [Route("api/v5/survey/version/question/answer/option/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionOptsByVersion_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionOptByVer_QS5(string ver, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionOptsByVersion(token, ver, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "version answer options", "survey_5", ver + "");
            return response;
        }
        #endregion question_optional_By_Version

        #endregion Version_5




        // Version_6  -- 2021-08-27
        #region Version_6
        #region post_answer
        /// <summary>
        /// Version 6: collecting Ver.6 Per/Post Survey answer 
        /// </summary>
        /// <param name="_survey">Collection of answers</param>
        /// <param name="_surveyQuestion_ID">surveyQuestion_ID</param>
        /// <param name="_surveyAnswer">survey Answer(s)</param>
        /// <param name="_chatID">ChatID:from ChatApp</param>
        /// <param name="language">survey language, English, French</param>
        /// <param name="surveyAnswer_Device">Answer device, useragent or short in Mobile, laptop etc </param>
        /// <param name="token">Access Token</param>
        /// <returns></returns>
        [ResponseType(typeof(answer))]
        [Route("api/v6/survey/answer")]
        [HttpPost]
        [EnableCors(origins: "*", headers: "*", methods: "post")]
        public HttpResponseMessage answerv6([FromBody] ChatSurvey _survey)
        {
            bool result = false;

            int _chatid = 0;
            string _language = "";
            string _surveyAnswer_Device = "";
            string _token = "";

            List<answer> _answer = _survey.chatsurvey;
            int _surveyQuestion_ID = 0;
            string _surveyAnswer = "";

            try
            {
                _chatid = _survey.chatID;
                _language = _survey.language;
                _surveyAnswer_Device = _survey.surveyAnswer_Device;
                _token = _survey.token;

                foreach (answer _a in _answer)
                {
                    _surveyQuestion_ID = _a.surveyQuestion_ID;
                    _surveyAnswer = _a.surveyAnswer;

                    ss.insertSurvey(_token, _surveyQuestion_ID, _chatid, _surveyAnswer, _language, _surveyAnswer_Device);

                    result = true;
                }

            }
            catch (Exception e)
            {
                e.Message.ToString();
            }

            if (result)
            {
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent("\"status\":\"OK\"", Encoding.UTF8);
                response.Content.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
                logservices.logservices(request, response, "survey", "json", "path", _language, _token, "answer", "survey_6", _chatid + "");


                return response;
            }
            else
            {
                var response = this.Request.CreateResponse(HttpStatusCode.NotFound);
                response.Content = new StringContent("\"status\":\"Failed\"", Encoding.UTF8);
                response.Content.Headers.ContentType = new MediaTypeHeaderValue("application/json");


                logservices.logservices(request, response, "survey", "json", "path", _language, _token, "answer", "survey_6", _chatid + "");

                return response;
            }

        }
        #endregion post_answer


        #region survey_type
        // Path
        /// <summary>
        /// Path: Gets a list of survey types SurveyTypeID=0, or type information specifying the survey type ID.
        /// </summary>
        /// <param name="TypeID">Survey type id, Per-Survey, Post-Suvey etc.</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return a survey type list, or return a survey type by specific survey-type-ID. Format in JSON </returns>
        [ActionName("json")]
        [Route("api/v6/survey/type/json/{TypeID}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyTypeByID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyType6(int TypeID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyType(token, TypeID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "survey type", "survey_6", TypeID + "");
            return response;
        }
        // Query
        /// <summary>
        /// Query: Gets a list of survey types SurveyTypeID=0, or type information specifying the survey type ID.
        /// </summary>
        /// <param name="TypeID">Survey type id, Per-Survey, Post-Suvey etc.</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return a survey type list, or return a survey type by specific survey-type-ID. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v6/survey/type/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyTypeByID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyType_QS6(int TypeID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyType(token, TypeID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "query", lang, token, "survey type", "survey_6", TypeID + "");
            return response;
        }
        #endregion survey_type


        #region question_list
        // Path
        /// <summary>
        /// Path: retrieving a list of survey questions when QuestionID=0, or a specify information about the questions.
        /// </summary>
        /// <param name="QID">servey question ID</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return a survey question list, or return a specific survey question information by its survey-question-ID. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v6/survey/question/json/{QID}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionByQuestionID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestion6(int QID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestion(token, QID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "survey question", "survey_6", QID + "");
            return response;
        }

        // Query
        /// <summary>
        /// Query: retrieving a list of survey questions when QuestionID=0, or a specify information about the questions.
        /// </summary>
        /// <param name="QID">servey question ID</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return a survey question list, or return a specific survey question information by its survey-question-ID. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v6/survey/question/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionByQuestionID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestion_QS6(int QID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestion(token, QID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "query", lang, token, "survey question", "survey_6", QID + "");
            return response;
        }
        #endregion question_list


        #region question_optional
        // Path
        /// <summary>
        /// Path: Get optional answers to specified survey questions, and when QuestionID=0, gets the full list of options.
        /// </summary>
        /// <param name="QID">servey question ID</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a specific survey question optional answers list, or all of V3 question optional answers list if no question specified. JSON format.</returns>
        [ActionName("json")]
        [Route("api/v6/survey/question/answer/option/json/{QID}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionOptsByQuestionID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionOpt6(int QID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionOpts(token, QID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "answer options", "survey_6", QID + "");
            return response;
        }

        // Query
        /// <summary>
        /// Query: Get optional answers to specified survey questions, and when QuestionID=0, gets the full list of options.
        /// </summary>
        /// <param name="QID">servey question ID</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a specific survey question optional answers list, or all of V3 question optional answers list if no question specified. JSON format.</returns>
        [ActionName("json")]
        [Route("api/v6/survey/question/answer/option/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionOptsByQuestionID_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionOpt_QS6(int QID, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionOpts(token, QID, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "answer options", "survey_6", QID + "");
            return response;
        }
        #endregion question_optional


        #region question_List_By_Version
        /// <summary>
        /// Path: Gets a list of questions for the specified survey version
        /// </summary>
        /// <param name="ver">servey version number. E.g.: v2,v3 </param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return all version survey question list, or return a specific version survey question information list. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v6/survey/question/version/json/{ver}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionByVersion_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionByVer6(string ver, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionByVersion(token, ver, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "survey question by Version", "survey_6", ver + "");
            return response;
        }

        /// <summary>
        /// Query: Gets a list of questions for the specified survey version
        /// </summary>
        /// <param name="ver">servey version number. E.g.: v2, v3, v5</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Default return all version survey question list, or return a specific version survey question information list. Format in JSON. </returns>
        [ActionName("json")]
        [Route("api/v6/survey/question/version/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionByVersion_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionByVer_QS6(string ver, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionByVersion(token, ver, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "query", lang, token, "survey question by Version", "survey_6", ver + "");
            return response;
        }
        #endregion question_List_By_Version


        #region question_optional_By_Version
        /// <summary>
        /// Path: Get survey question optional answers list by specified version.
        /// </summary>
        /// <param name="ver">servey version. E.g. v2, v3, v5</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a specific survey question optional answers list, or all of V3 question optional answers list if no question specified. JSON format.</returns>
        [ActionName("json")]
        [Route("api/v6/survey/version/question/answer/option/json/{ver}/{lang}/{token}")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionOptsByVersion_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionOptByVer6(string ver, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionOptsByVersion(token, ver, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "version answer options", "survey_6", ver + "");
            return response;
        }

        /// <summary>
        /// Query: Get survey question optional answers list by specified version.
        /// </summary>
        /// <param name="ver">servey version. E.g. v2, v3, v5</param>
        /// <param name="lang">Language, English = en, French = fr</param>
        /// <param name="token">Access token</param>
        /// <returns>Return a specific survey question optional answers list, or all of V3 question optional answers list if no question specified. JSON format.</returns>
        [ActionName("json")]
        [Route("api/v6/survey/version/question/answer/option/json")]
        [HttpGet]
        [ResponseType(typeof(Proc_GetSurveyQuestionOptsByVersion_Result))]
        [EnableCors(origins: "*", headers: "*", methods: "get")]
        public HttpResponseMessage SurveyQuestionOptByVer_QS6(string ver, string lang, string token)
        {
            HttpContext.Current.Response.Cache.VaryByHeaders["accept-enconding"] = true;
            var r = ss.GetSurveyQuestionOptsByVersion(token, ver, lang);
            response = toJson(r, lang);
            //( request,  response,  dbschema, format,  para,  lang, token, string cscontent,  csendpoint, keywords)
            logservices.logservices(request, response, "survey", "json", "path", lang, token, "version answer options", "survey_6", ver + "");
            return response;
        }
        #endregion question_optional_By_Version

        #endregion Version_6

        private HttpResponseMessage toJson(Object r, string lang)
        {
            lang = lang.ToLower();
            if ((lang == "en") || (lang == "fr"))
            {
                string thisJson = null;
                thisJson = JsonConvert.SerializeObject(r, Formatting.None);

                if (thisJson.Length < 5)
                {
                    var response = this.Request.CreateResponse(HttpStatusCode.NoContent);
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
