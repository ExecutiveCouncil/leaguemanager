using Entidades;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;
using System.Data.Linq;

namespace ManagerDB.Pages
{
    public partial class Login : BasicPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void ValidateUser(object sender, EventArgs e)
        {

            var usuarioRegistrado = this.manager.t_users
                .Where(a => a.login == Login1.UserName && 
                       a.pass == Login1.Password && 
                       a.active == "Y").FirstOrDefault();
            if (usuarioRegistrado != null)
            {
                usuarioRegistrado.login_errors = 0;
                this.manager.SaveChanges();

                base.usuario = usuarioRegistrado;
                FormsAuthentication.RedirectFromLoginPage(Login1.UserName, Login1.RememberMeSet);
            }      
            else
            {
                base.usuario = null;
                var _usuarioError = this.manager.t_users
                    .Where(a => a.login == Login1.UserName &&
                           a.active == "Y").FirstOrDefault();
                if (_usuarioError != null)
                {
                    _usuarioError.login_errors++;
                    if (_usuarioError.login_errors >= 5)
                    {
                        _usuarioError.active = "N";
                    }
                    this.manager.SaveChanges();
                }

            }
        }

        protected void LoginButton_Command(object sender, CommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "Login":
                    ValidateUser(sender, e);
                    break;
            }
        }
    }
}