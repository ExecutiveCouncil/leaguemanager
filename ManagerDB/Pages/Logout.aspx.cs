using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagerDB.Pages
{
    public partial class Logout : BasicPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Session.RemoveAll();
            Response.Redirect("login.aspx", true);
        }
    }
}