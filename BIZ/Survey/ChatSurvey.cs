using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BIZ.Survey
{
    public class ChatSurvey
    {
        /// <summary>
        /// 
        /// </summary>
        [Required(ErrorMessage = "answer can't be empty")]
        public List<answer> chatsurvey { get; set; }


        /// <summary>
        /// chatID is a mandatory paramter which comes from ChatApp
        /// </summary>
        [Required(ErrorMessage = "chatID can't be empty")]
        public int chatID { get; set; }

        /// <summary>
        /// language is a mandatory paramter which indicates Site or App's Language.
        /// </summary>
        [Required(ErrorMessage = "language is requried")]
        public string language { get; set; }


        /// <summary>
        /// surveyAnswer_Device is a mandatory field which indicates user's type of device.
        /// </summary>
        [Required(ErrorMessage = "surveyAnswer_Device can't be empty")]
        public string surveyAnswer_Device { get; set; }


        /// <summary>
        /// App access token
        /// </summary>
        [Required(ErrorMessage = "Access token required.")]
        public string token { get; set; }
    }
}