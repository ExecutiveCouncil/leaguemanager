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
    public partial class Login : System.Web.UI.Page
    {
        MANAGERDBEntities ctx = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            ctx = new MANAGERDBEntities();
        }

        protected void ValidateUser(object sender, EventArgs e)
        {
            var usuarioRegistrado = ctx.t_users.Where(a => a.login == Login1.UserName && a.pass == Login1.Password && a.active == "Y").FirstOrDefault();

            if (usuarioRegistrado != null)
            {
                Session["idUsuario"] = usuarioRegistrado.id;
                FormsAuthentication.RedirectFromLoginPage(Login1.UserName, Login1.RememberMeSet);
            }                
        }
    }
}