using Entidades;
using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace ManagerDB.Pages
{
    public partial class LigaDetAspx : BasicPage
    {

        private int idKey
        {
            get
            {
                try
                {
                    return Convert.ToInt32(Request.QueryString["idKey"]);
                }
                catch
                {
                    return -1;
                }
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                if (this.ValidateSession() == false)
                {
                    FormsAuthentication.RedirectToLoginPage();
                }
                else
                {
                    this.RellenarLigas();                    
                    if (this.idKey >= 0)
                    {
                        t_leagues _liga = this.manager.t_leagues.Where(p => p.id == this.idKey).FirstOrDefault();
                        this.DrpLigas.SelectedValue = _liga.id.ToString();
                        this.CargarJugadores();
                        this.CargarBadges();
                    }
                }
            }
        }

        private void RellenarLigas()
        {
            this.DrpLigas.Items.Clear();
            this.DrpLigas.Items.Add(new ListItem("seleccione una liga", "-1"));
            var _ligas = this.manager.t_leagues.Where(p=>p.active == "Y").ToList();
            foreach (t_leagues _liga in _ligas)
            {
                this.DrpLigas.Items.Add(new ListItem(_liga.name, _liga.id.ToString()));
            }
        }

        private EnvironmentVariableTarget _jugador;

        private void CargarJugadores()
        {

            int _idLiga = Convert.ToInt32(this.DrpLigas.SelectedValue);
            this._LbNoJugadores.Visible = false;
            var ligasUsuario = (from ul in this.manager.t_user_leagues
                                join l in this.manager.t_leagues on ul.id_league equals l.id
                                join g in this.manager.t_games on l.id_game equals g.id
                                join u in this.manager.t_users on ul.id_user equals u.id
                                join gf in this.manager.t_game_factions on ul.id_faction equals gf.id
                                where ul.id_league == _idLiga
                                select new JugadorLiga
                                {
                                    league_id = l.id,
                                    user_id = ul.id_user,
                                    user_name = u.name,
                                    user_avatar = u.avatar_url,
                                    team_name = ul.team_name,
                                    team_avatar_url = ul.team_avatar_url,
                                    wins = ul.wins,
                                    losses = ul.losses,
                                    draws = ul.draws,
                                    score = ul.total_score,
                                    league_name = l.name,
                                    league_avatar_url = l.avatar_url,
                                    game_name = g.name,
                                    game_avatar_url = g.avatar_url,
                                    faction_name = gf.name,
                                    faction_avatar_url = gf.avatar_url
                                }).OrderBy(o=>o.score).ThenBy(t=>t.wins).ToList();

            if (ligasUsuario.Count > 0)
            {
                this.GrJugadores.DataSource = ligasUsuario;
                this.GrJugadores.DataBind();
            }
            else
            {
                this.GrJugadores.DataSource = null;
                this.GrJugadores.DataBind();
                this._LbNoJugadores.Visible = true;
            }
        }

        private void CargarBadges()
        {
            int _idLiga = Convert.ToInt32(this.DrpLigas.SelectedValue);

            var _listaBadges = (from lt in this.manager.t_league_titles
                                join b in this.manager.t_badges on lt.id_badge equals b.id
                                where lt.id_league == _idLiga
                                select new
                                {
                                    title_id = lt.id,
                                    badge_id = b.id,
                                    badge_name = b.name,
                                    badge_url = "../images" + b.avatar_url,
                                    title_info = lt.info,
                                    title_name = lt.name
                                }).ToList();

            if (_listaBadges.Count > 0)
            {
                this.GrBadges.DataSource = _listaBadges;
                this.GrBadges.DataBind();
            }
            else
            {
                this.GrBadges.DataSource = null;
                this.GrBadges.DataBind();
                this._LbNoBadges.Visible = true;
            }

        }

        protected void GrClasificacion_ItemCommand(object source, DataGridCommandEventArgs e)
        {

        }

        protected void DrpLigas_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.CargarJugadores();
            this.CargarBadges();
        }

        protected void GrJugadores_ItemDataBound(object sender, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item)
            {
                JugadorLiga _jugadorLiga = (JugadorLiga)e.Item.DataItem;
                if (this.usuario != null &&
                    _jugadorLiga.user_id == this.usuario.id)
                {
                    //pintamos diferente la fila que representa al usuario conectado.
                    e.Item.Style.Add("color", "#ffffff");
                }
            }





        }
    }
}