using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using ManagerDB.Pages;

namespace ManagerDB
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {
            //Iniciamos el contexto
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

            Exception _err = Server.GetLastError();
            if (_err != null)
            {
                
                if (_err is System.Threading.ThreadAbortException)
                {
                    //Este tipo de error debe ser ignorado ya que se produce 
                    //de manera natural al realizar cambios de aplicación mediante el Code-Behind.
                    return;
                }

                try
                {
                    MANAGERDBEntities _mng = null;
                    if (this.Session["Manager"] != null)
                    {
                        _mng = (MANAGERDBEntities)this.Session["Manager"];
                        if (_mng.Database.Connection.State != System.Data.ConnectionState.Open)
                        {
                            _mng.Database.Connection.Open();
                        }
                    }
                    else
                    {
                        _mng = new MANAGERDBEntities();
                        this.Session["Manager"] = _mng;
                    }

                    //Escribimos en el log.
                    if (_mng != null)
                    {
                        t_syslog _log = new t_syslog();
                        int _newId = BasicPage.GetNextTableId(_mng, "t_syslog");
                        
                        //datos basicos.
                        _log.id = _newId;
                        _log.creation_date = DateTime.Now;
                        _log.message = _err.Message;

                        if (_err.InnerException != null)
                        {
                            _log.message = _err.Message + " [InnerException: '" + _err.InnerException.Message + "']";
                        }

                        _log.stack_trace = _err.StackTrace;

                        //login del usuario conectado
                        if (this.Session["User"] != null)
                        {
                            t_users _user = (t_users)this.Session["User"];
                            _log.logged_user = _user.login;
                        }

                        //IP
                        if (HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
                        {
                            _log.client_ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
                        }
                        else if (HttpContext.Current.Request.UserHostAddress.Length != 0)
                        {
                            _log.client_ip = HttpContext.Current.Request.UserHostAddress;
                        }

                        //Pagina que da el error
                        try
                        {
                            _log.url = ((HttpApplication)sender).Request.Url.OriginalString;
                        }
                        catch { }

                        _mng.t_syslog.Add(_log);
                        _mng.SaveChanges();
                    }
                }
                catch { }

                //Manejar aquí el resto de excepciones.
                Response.Clear();
                Response.Write("<head>");
                Response.Write("<link href='../css/style.css' rel='stylesheet' type='text/css' />");
                Response.Write("<link href='https://fonts.googleapis.com/css?family=Play' rel='stylesheet' />");
                Response.Write("<link href='https://fonts.googleapis.com/css?family=Audiowide' rel='stylesheet' />");
                Response.Write("<script src='../js/webapp.js' type='text/javascript' ></script>");
                        

                Response.Write("</head>");
                Response.Write("<body style='text-align:center'; background-image:url(../images/webapp/wallpaper.jpg); background-size:cover'>");
                Response.Write("<center>");

                Response.Write("<br/><br/><br/><img src='../images/webapp/error_black.png' alt='Oh, no!' width='75px' style='margin-bottom:10px'><br/><br/>");
                Response.Write("<div class='div_box' style='width:70%; max-width:600px; padding:20px'><div><div>");
                Response.Write("<h3>" + _err.GetType().ToString().ToUpper() + "</h3><br/>");
                Response.Write("<p>");
                Response.Write(_err.Message);
                Response.Write("</p>");

                if (_err.InnerException != null &&
                    _err.InnerException.GetType().ToString() != _err.GetType().ToString())
                {
                    Response.Write("<p>");
                    Response.Write(_err.InnerException.Message);
                    Response.Write("</p>");
                }

                Response.Write("<br/>");
                Response.Write("<i>Parece que se ha producido un error mientras tratábamos de realizar las operaciones solicitadas. <br/>" +
                               "Hemos tomado nota del problema y le pondremos solución lo antes posible. Disculpe las molestias.</i>");
                Response.Write("<br/><br/>");
                Response.Write("<input type='button' class='btn' onclick='GoHome()' style='width:250px' value='Página de inicio' />");
                Response.Write("</div></div></div>");
                Response.Write("</center>");
                Response.Write("</body>");
                Response.End();
                //        Response.Redirect("unexpectederror.htm");                    
            }

        }

        protected void Session_End(object sender, EventArgs e)
        {
            this.Session.RemoveAll();
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}