using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagerDB.Pages
{
    public partial class PopDadosBasic : BasicPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtConfirmar_Click(object sender, EventArgs e)
        {
            //Operaciones en BD
            //....
            
            //Cerrado del popup mediante javascript.
            Page.ClientScript.RegisterStartupScript(this.GetType(),"Confirmar", "CloseMe()", true);
        }
    }
}