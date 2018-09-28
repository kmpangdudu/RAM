using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Security.Principal;
using System.Web.Http.Controllers;
using BIZ.AccessControl;

namespace WebApi.Filters
{
    /// <summary>
    /// FilterIP Attribute
    /// </summary>
    public class FilterIPAttribute : AuthorizeAttribute
    {

        /// <summary>
        /// Determines whether access to the core framework is authorized.
        /// </summary>
        /// <param name="actionContext">The HTTP context, which encapsulates all HTTP-specific information about an individual HTTP request.</param>
        /// <returns>
        /// true if access is authorized; otherwise, false.
        /// </returns>
        /// <exception cref="T:System.ArgumentNullException">The <paramref name="httpContext"/> parameter is null.</exception>
        protected override bool IsAuthorized(HttpActionContext actionContext)
        {
            if (actionContext == null)
                throw new ArgumentNullException("actionContext");

            string userIpAddress = ((HttpContextWrapper)actionContext.Request.Properties["MS_HttpContext"]).Request.UserHostName;

            try
            {
                // Check that the IP is allowed to access
                bool ipAllowed = CheckAllowedIPs(userIpAddress);

                // Check that the IP is not denied to access
                bool ipDenied = CheckDeniedIPs(userIpAddress);

                // Only allowed if allowed and not denied
                //bool finallyAllowed = ipAllowed && !ipDenied;

                 bool finallyAllowed = ipAllowed;

                return finallyAllowed;
            }
            catch (Exception e)
            {
                // Log the exception, probably something wrong with the configuration
            }

            return true; // if there was an exception, then we return true
        }








        #region allow IP
            static AuthServices authservices = new AuthServices();
            /// <summary>
            /// get all of allowable ips 
            /// </summary>
            /// <returns></returns>
            public static List<string> GetAuthIPs()
            {
                List<string> ips = authservices.GetAllowIps();
                return ips;
            }




            /// <summary>
            /// Checks the allowed IPs.
            /// </summary>
            /// <param name="userIpAddress">The user ip address.</param>
            /// <returns></returns>
            private bool CheckAllowedIPs(string userIpAddress)
            {
                //Split the users IP address into it's 4 octets (Assumes IPv4) 
                string[] incomingOctets = userIpAddress.Trim().Split(new char[] { '.' });



                string[] validIpAddresses = GetAuthIPs().ToArray();

                //Iterate through each valid IP address 
                foreach (var validIpAddress in validIpAddresses)
                {
                    //Return true if valid IP address matches the users 
                    if (validIpAddress.Trim() == userIpAddress)
                    {
                        return true;
                    }

                    //Split the valid IP address into it's 4 octets 
                    string[] validOctets = validIpAddress.Trim().Split(new char[] { '.' });

                    bool matches = true;

                    //Iterate through each octet 
                    for (int index = 0; index < validOctets.Length; index++)
                    {
                        //Skip if octet is an asterisk indicating an entire 
                        //subnet range is valid 
                        if (validOctets[index] != "*")
                        {
                            if (validOctets[index] != incomingOctets[index])
                            {
                                matches = false;
                                break; //Break out of loop 
                            }
                        }
                    }

                    if (matches)
                    {
                        return true;
                    }
                } //foreach 

                //Found no matches 
                return false;
            }
        #endregion allow IP



        #region Blocked IP
            /// <summary>
            /// get all of Blocked ips 
            /// </summary>
            /// <returns></returns>
            public static List<string> GetBlockedIPs()
            {
                List<string> ips = authservices.GetBlockedIPs();
                return ips;
            }

            private bool CheckDeniedIPs(string userIpAddress)
            {
                //Split the users IP address into it's 4 octets (Assumes IPv4) 
                string[] incomingOctets = userIpAddress.Trim().Split(new char[] { '.' });


                string[] blockedIpAddresses = GetBlockedIPs().ToArray();

                //Iterate through each blocked IP address 
                foreach (var blockedIpAddress in blockedIpAddresses)
                {
                    //Return true if blocked IP address matches the users 
                    if (blockedIpAddress.Trim() == userIpAddress)
                    {
                        return true;
                    }

                    //Split the valid IP address into it's 4 octets 
                    string[] blockedOctets = blockedIpAddress.Trim().Split(new char[] { '.' });

                    bool matches = true;

                    //Iterate through each octet 
                    for (int index = 0; index < blockedOctets.Length; index++)
                    {
                        //Skip if octet is an asterisk indicating an entire 
                        //subnet range is blocked 
                        if (blockedOctets[index] != "*")
                        {
                            if (blockedOctets[index] != incomingOctets[index])
                            {
                                matches = false;
                                break; //Break out of loop 
                            }
                        }
                    }

                    if (matches)
                    {
                        return true;
                    }
                } //foreach 



                return false;
            }

        #endregion Blocked IP
    }
}