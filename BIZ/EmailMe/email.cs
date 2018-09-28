using System.ComponentModel.DataAnnotations;

namespace BIZ.EmailMe
{
    public class email
    {
        /// <summary>
        /// user's Language. English:en; French: fr
        /// </summary>
        [Required(ErrorMessage = "Language field can't be empty.")]
        public string lang { get; set; }


        /// <summary>
        /// user's email account. Ex user@example.com
        /// </summary>
        [Required(ErrorMessage = "Field can't be empty")]
        [DataType(DataType.EmailAddress, ErrorMessage = "Email is not valid")]
        public string receiver { get; set; }

        /// <summary>
        /// user selected favourites
        /// </summary>
        [Required(ErrorMessage = "Favourites body can't be empty")]
        public string body { get; set; }
    }
}