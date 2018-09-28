using System.ComponentModel.DataAnnotations;
namespace BIZ.EmailMe
{
    public class eCard
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
        /// Send From Email Account 
        /// </summary>
        [Required(ErrorMessage = "Send From can't be empty")]
        [DataType(DataType.EmailAddress, ErrorMessage = "Send From Email is not valid")]
        public string sendfrom { get; set; }

        /// <summary>
        /// Display Name 
        /// </summary>
        [Required(ErrorMessage = "Display Name can't be empty")]
        public string displayName { get; set; }

        /// <summary>
        /// eCard subject 
        /// </summary>
        [Required(ErrorMessage = "subject can't be empty")]
        public string subject { get; set; }

        /// <summary>
        /// user selected favourites
        /// </summary>
        [Required(ErrorMessage = "eCard body can't be empty")]
        public string body { get; set; }
    }
}