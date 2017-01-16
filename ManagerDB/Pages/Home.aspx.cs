using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace ManagerDB.Pages
{
    public partial class Home : BasicPage
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
                    CargarUltimosMensajes();
                }
            }
        }

        private void CargarLigas()
        {
            var ligasUsuario = (from ul in this.manager.t_user_leagues
                                join l in this.manager.t_leagues on ul.id_league equals l.id
                                join g in this.manager.t_games on l.id_game equals g.id
                                join gf in this.manager.t_game_factions on ul.id_faction equals gf.id
                              where ul.id_user == this.usuario.id
                                    && l.active == "Y"
                              select new
                              {
                                  league_id = l.id,
                                  user_id = ul.id_user,
                                  team_name = ul.team_name,
                                  team_avatar_url = this.PATH_IMAGES + ul.team_avatar_url,
                                  wins = ul.wins,
                                  losses = ul.losses,
                                  draws = ul.draws,
                                  score = ul.total_score,
                                  league_name = l.name,
                                  league_avatar_url = this.PATH_IMAGES + l.avatar_url,
                                  current_round = l.current_round,
                                  game_name = g.name,
                                  game_avatar_url = this.PATH_IMAGES + g.avatar_url,
                                  faction_name = gf.name,
                                  faction_avatar_url = this.PATH_IMAGES + gf.avatar_url
                              }).ToList();

            if (ligasUsuario.Count > 0)
            {
                this.GrLigas.DataSource = ligasUsuario;
                this.GrLigas.DataBind();
            }
        }

        private void CargarUltimosMensajes()
        {

            var mensajesUsuario = (from m in this.manager.t_messages
                                   join l in this.manager.t_leagues on m.id_league equals l.id
                                   join u in this.manager.t_users on m.id_user_from equals u.id
                                where m.id_user_to == this.usuario.id
                                select new
                                {
                                    league_id = l.id,
                                    league_avatar_url = this.PATH_IMAGES + l.avatar_url,
                                    league_name = l.name,
                                    user_from_id = u.id,
                                    user_from_name = u.name,
                                    user_from_avatar_url = this.PATH_IMAGES + u.avatar_url,
                                    subject = m.subject,
                                    message = m.message,
                                    sent_date = m.sent_date.Value,
                                    current_round = l.current_round,
                                }).OrderByDescending(a=> a.sent_date).Take(10).ToList();

            if (mensajesUsuario.Count > 0)
            {
                this.GrMensajes.DataSource = mensajesUsuario;
                this.GrMensajes.DataBind();

            }
        }

        protected void GrLigas_ItemCommand(object source, DataGridCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "VerLiga":
                    {
                        var _miItem = e.Item;

                        var _idLiga = Convert.ToInt32(e.Item.Cells[1].Text);

                        var _ligaSeleccionada = (from l in this.manager.t_leagues where l.id == _idLiga select l).FirstOrDefault();
                        base.liga = _ligaSeleccionada;

                        this.Response.Redirect("LeagueDet.aspx?idKey=" + _ligaSeleccionada.id, true);
                        break;
                    }
            }
        }

        protected void GrMensajes_ItemCommand(object source, DataGridCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "VerLiga":
                    {
                        int _idLiga = Convert.ToInt32(e.CommandArgument);

                        var _ligaSeleccionada = (from l in this.manager.t_leagues where l.id == _idLiga select l).FirstOrDefault();
                        base.liga = _ligaSeleccionada;

                        this.Response.Redirect("LeagueDet.aspx?idKey=" + _ligaSeleccionada.id, true);
                        break;
                    }
            }
        }

    }
}