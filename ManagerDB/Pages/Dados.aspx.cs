using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ManagerDB.Pages
{
    public partial class Dados : System.Web.UI.Page
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
                MostrarDados();
            }
        }

        private void MostrarDados()
        {
            var idUsuario = Convert.ToInt32(Session["idUsuario"]);

            var dadosUsuario = (from m in ctx.t_messages
                                   join l in ctx.t_leagues on m.id_league equals l.id
                                   join u in ctx.t_users on m.id_user_from equals u.id
                                   where m.id_user_to == idUsuario
                                   select new
                                   {
                                       league_avatar_url = l.avatar_url,
                                       league_name = l.name,
                                       user_name_from = u.name,
                                       user_avatar_url = u.avatar_url,
                                       subject = m.subject,
                                       message = m.message,
                                       sent_date = m.sent_date
                                   }).OrderByDescending(a => a.sent_date).Take(5).ToList();

            if (dadosUsuario.Count > 0)
            {
                var divHtml = new System.Text.StringBuilder();
                var contador = 1;
                foreach (var dado in dadosUsuario)
                    using(HtmlGenericControl div = new System.Web.UI.HtmlControls.HtmlGenericControl("div"))
                    {
                        div.ID = "Dado"+ contador ;
                        Image img = new Image();
                        img.ImageUrl = "~/images/" + dado.imagen;
                        img.AlternateText = dado.texto;
                        div.Controls.Add(img);
                        Dados.Controls.Add(div);
                    }
                    contador++;
                }
                Dados.InnerHtml = divHtml.ToString();
            }

        }
    }
}