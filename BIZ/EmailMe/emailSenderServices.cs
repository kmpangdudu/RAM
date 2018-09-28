using DATA.EF;
using System.Net;
using System.Net.Mail;

namespace BIZ.EmailMe
{
    public class emailSenderServices
    {
        private RAMEntities db = new RAMEntities();
        public bool sendfromInternal(string host, int port, bool ssl, string loginname, string pwd, string sendfrom, string displayname,
            string receiver, string subject, string body)
        {
            try
            {
                System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();
                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtp.Host = host;
                smtp.Port = port;
                smtp.EnableSsl = ssl;
                smtp.Credentials = new NetworkCredential(loginname, pwd);
                MailMessage mm = new MailMessage();
                mm.Priority = MailPriority.High;
                mm.From = new MailAddress(sendfrom, displayname);
                mm.ReplyTo = new MailAddress(sendfrom);
                mm.To.Add(receiver);
                mm.Subject = subject;
                mm.IsBodyHtml = true;
                mm.Body = body;
                smtp.Send(mm);
                //db.Proc_apilog("POST", host, sendfrom, subject, "email", receiver + "/OK");

                return true;
            }
            catch
            {
                //db.Proc_apilog("POST", host, sendfrom, subject, "email", receiver + "/No");

                return false;
            }

        }

        public bool sendfromGmail(string Receiver, string subject, string body)
        {
            try
            {

            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtp.EnableSsl = true;
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.Credentials = new NetworkCredential("cnsdwang@gmail.com", "12629634abc");
            MailMessage mm = new MailMessage();
            mm.Priority = MailPriority.High;
            mm.From = new MailAddress("Ram.project@kidshelpphone.ca", "Resources Around Me/Ressources autour de moi");
            mm.ReplyTo = new MailAddress("william.chen@kidshelpphone.ca", "my box");
            mm.To.Add(Receiver);
            mm.Subject = subject;
            mm.IsBodyHtml = true;
            mm.Body = body;
            smtp.Send(mm);

                //db.Proc_apilog("POST", "gmail", string.Empty, subject, "email", Receiver + "/OK");

                return true;
                
            }
            catch
            {
                //db.Proc_apilog("POST", "gmail", string.Empty, subject, "email", Receiver + "/No");

                return false;
            }
        }
    }
}