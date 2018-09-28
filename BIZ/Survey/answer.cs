using System.ComponentModel.DataAnnotations;

namespace BIZ.Survey
{
    public class answer
    {

        /// <summary>
        /// surveyQuestion_ID is a mandatory parameter which question is answered.
        /// </summary>
        [Required(ErrorMessage = "surveyQuestion_ID can't be empty")]
        public int surveyQuestion_ID { get; set; }



        /// <summary>
        /// surveyAnswer is mandatory field.
        /// </summary>
        [Required(ErrorMessage = "surveyAnswer is required.")]
        public string surveyAnswer { get; set; }



    }
}