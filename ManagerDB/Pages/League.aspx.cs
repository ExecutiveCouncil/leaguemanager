using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagerDB.Pages
{
    public partial class League : System.Web.UI.Page
    {
        MANAGERDBEntities ctx = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated || Session["idUsuario"] == null)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            else
            {
                ctx = new MANAGERDBEntities();
            }
        }
    }
}