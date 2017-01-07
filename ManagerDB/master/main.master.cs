using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagerDB.master
{
    public partial class main : System.Web.UI.MasterPage
    {

        public string LoggedUser
        {
            get
            {
                return this._LbUser.Text;
            }
            set
            {
                this._LbUser.Text = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}