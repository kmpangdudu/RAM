using DATA.EF;
using System.Linq;
using System.Collections.Generic;

namespace BIZ.Survey
{
    public class suveryServices
    {
        private RAMEntities db = new RAMEntities();

        public void insertSurvey(string token, int? surveryQuestionID, int? chatid, string surveyAnswer, string language, string surveyAnswer_Device)
        {
            try
            {
             db.Proc_Insert_Answer(token,  surveryQuestionID, chatid, surveyAnswer,language,surveyAnswer_Device );
            }
            catch
            {

            }


        }


        public List<Proc_GetSurveyTypeByID_Result> GetSurveyType(string token, int sid, string lang)
        {
            var response = db.Proc_GetSurveyTypeByID(token, sid, lang).ToList();
            return response;
        }

        public List<Proc_GetSurveyQuestionByQuestionID_Result> GetSurveyQuestion(string token, int qid, string lang)
        {
            var response = db.Proc_GetSurveyQuestionByQuestionID(token,qid,lang).ToList();
            return response;
        }

        public List<Proc_GetSurveyQuestionOptsByQuestionID_Result> GetSurveyQuestionOpts(string token, int qid, string lang)
        {
            var response = db.Proc_GetSurveyQuestionOptsByQuestionID(token, qid, lang).ToList();
            return response;
        }

        public List<Proc_GetSurveyQuestionByVersion_Result> GetSurveyQuestionByVersion(string token, string ver, string lang)
        {
            var response = db.Proc_GetSurveyQuestionByVersion(token, ver, lang).ToList();
            return response;
        }

        public List<Proc_GetSurveyQuestionOptsByVersion_Result> GetSurveyQuestionOptsByVersion(string token, string ver, string lang)
        {
            var response = db.Proc_GetSurveyQuestionOptsByVersion(token, ver, lang).ToList();
            return response;
        }

    }
}