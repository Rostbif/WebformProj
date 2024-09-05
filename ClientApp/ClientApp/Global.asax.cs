using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace ClientApp
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        /// <summary>
        /// catches all unhandled exceptions in the application, log them, and redirect the user to an error page.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Application_Error(object sender, EventArgs e)
        {
            Exception exception = Server.GetLastError();
            // here we should log this error
            Logger.LogExceptionToDatabase(exception);

            Server.ClearError();

            // redirect to the custom error page for unhandeled bad exceptions
            Response.Redirect("~/ErrorPage.aspx");
        }
    }
}