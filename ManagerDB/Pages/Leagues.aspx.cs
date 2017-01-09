using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace ManagerDB.Pages
{
    public partial class LeaguesAspx : BasicPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                if (base.ValidateSession() == false)
                {
                    FormsAuthentication.RedirectToLoginPage();
                }
                else
                {
                    CargarLigas();
                }
            }
        }

        private void CargarLigas()
        {
            var ligasUsuario = (from l in this.manager.t_leagues
                                join g in this.manager.t_games on l.id_game equals g.id
                              where l.active == "Y"
                              select new
                              {
                                  league_id = l.id,
                                  game_id = g.id,
                                  league_url = this.PATH_IMAGES + l.avatar_url,
                                  league_name = l.name,
                                  league_info = l.info,
                                  game_name = g.name,
                                  game_url = this.PATH_IMAGES + g.avatar_url,
                                  game_info = g.info,
                                  league_start = l.start_date,
                                  league_end = l.start_date
                             }).OrderBy(p=>p.game_id).ToList();

            if (ligasUsuario.Count > 0)
            {
                this.GrLigas.DataSource = ligasUsuario;
                this.GrLigas.DataBind();
            }
        }
        
        protected void GrLigas_ItemCommand(object source, DataGridCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "VerLiga":
                    {
                        var idLiga = Convert.ToInt32(e.Item.Cells[0].Text);
                        this.Response.Redirect("LeagueDet.aspx?idKey=" + idLiga, true);
                        break;
                    }
            }
        }

    }
}