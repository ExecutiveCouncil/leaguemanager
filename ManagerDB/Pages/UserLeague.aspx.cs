using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace ManagerDB.Pages
{
    public partial class UserLeagueAspx : BasicPage
    {

        private int idLiga
        {
            get
            {
                try
                {
                    return Convert.ToInt32(Request.QueryString["idLeague"]);
                }
                catch
                {
                    return -1;
                }
            }
        }


        private int idUsuario
        {
            get
            {
                try
                {
                    return Convert.ToInt32(Request.QueryString["idUser"]);
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
                if (base.ValidateSession() == false)
                {
                    FormsAuthentication.RedirectToLoginPage();
                }
                else
                {
                    CargarDatosLiga();
                    CargarMensajes();
                    CargarInsignias();
                    CargarTropas();
                    CargarRondas();
                    CargarMejoras();
                }
            }
        }


        private void CargarRondas()
        {
            var _rondas = (from lm in this.manager.t_league_matchs
                           join u1 in this.manager.t_users on lm.p1_id_user equals u1.id into tmpu1
                           join u2 in this.manager.t_users on lm.p2_id_user equals u2.id into tmpu2
                           join wnr in this.manager.t_users on lm.winner_id_user equals wnr.id into tmpwnr
                           where ((lm.p1_id_user == this.idUsuario || lm.p2_id_user == this.idUsuario)
                                && lm.id_league == this.idLiga)
                           from u1 in tmpu1.DefaultIfEmpty()
                           from u2 in tmpu2.DefaultIfEmpty()
                           from wnr in tmpwnr.DefaultIfEmpty()
                           select new
                           {
                               id = lm.id,
                               id_league = lm.id_league,
                               round = lm.round,
                               p1_name = u1.name,
                               p1_score = lm.p1_score,
                               p1_kills = lm.p1_kills,
                               p2_name = u2.name,
                               p2_score = lm.p2_score,
                               p2_kills = lm.p2_kills,
                               match_date = lm.match_date,
                               winner_name = wnr.name,
                           }).OrderBy(a => a.round).ToList();

            if (_rondas.Count > 0)
            {
                this.GrRondas.DataSource = _rondas;
                this._LbNoRondas.Visible = false;
            }
            else
            {
                this.GrRondas.DataSource = null;
                this._LbNoRondas.Visible = true;
            }
            this.GrRondas.DataBind();
        }


        private void CargarTropas()
        {
            var _tropas = (from ut in this.manager.mercs_user_troops
                           join ul in this.manager.t_user_leagues on ut.id_user_league equals ul.id
                           join tr in this.manager.mercs_troops on ut.id_troop equals tr.id
                           where ul.id_user == this.idUsuario &&
                                 ul.id_league == this.idLiga
                           select new
                              {
                                  troop_id = ut.id,
                                  troop_name = tr.name,
                                  troop_rules = tr.conflict_rule,
                              }).OrderByDescending(a => a.troop_id).ToList();

            if (_tropas.Count > 0)
            {
                this.GrTropas.DataSource = _tropas;
                this._LbNoTroops.Visible = false;
            }
            else
            {
                this.GrTropas.DataSource = null;
                this._LbNoTroops.Visible = true;
            }
            this.GrTropas.DataBind();
        }

        private void CargarMejoras()
        {
            var _tropas = (from uu in this.manager.mercs_user_upgrades
                           join ul in this.manager.t_user_leagues on uu.id_user_league equals ul.id
                           join up in this.manager.mercs_upgrades on uu.id_upgrade equals up.id
                           where ul.id_user == this.idUsuario &&
                                 ul.id_league == this.idLiga
                           select new
                           {
                               upgrade_id = uu.id,
                               upgrade_name = up.name,
                               upgrade_rules = up.function_rule
                           }).OrderByDescending(a => a.upgrade_id).ToList();

            if (_tropas.Count > 0)
            {
                this.GrMejoras.DataSource = _tropas;
                this._LbNoMejoras.Visible = false;
            }
            else
            {
                this.GrMejoras.DataSource = null;
                this._LbNoMejoras.Visible = true;
            }
            this.GrMejoras.DataBind();
        }

        
        private void CargarInsignias()
        {
            var _insignias = (from ut in this.manager.t_user_titles
                                   join ul in this.manager.t_user_leagues on ut.id_user_league equals ul.id
                                   join lt in this.manager.t_league_titles on ut.id_league_title equals lt.id
                                   join b in this.manager.t_badges on lt.id_badge equals b.id
                                   join l in this.manager.t_leagues on lt.id_league equals l.id
                                   where ul.id_user == this.idUsuario &&
                                         ul.id_league == this.idLiga
                                   select new
                                   {
                                       title_avatar_url = this.PATH_IMAGES + b.avatar_url,
                                       title_name = lt.name,
                                       title_info = lt.info,
                                       title_date = ut.unlock_date,
                                       title_id = ut.id,
                                   }).OrderByDescending(a => a.title_date).ToList();

            if (_insignias.Count > 0)
            {
                this.RptInsigniasAll.DataSource = _insignias;
                this.RptInsignias.DataSource = _insignias.Take(10);
                this._LbNoInsignias.Visible = false;
                this.PnlInsignias.Visible = true;
            }
            else
            {
                this.RptInsigniasAll.DataSource = null;
                this.RptInsignias.DataSource = null;
                this._LbNoInsignias.Visible = true;
                this.PnlInsignias.Visible = false;
            }
            this.RptInsigniasAll.DataBind();
            this.RptInsignias.DataBind();
        }

        private void CargarDatosLiga()
        {
            var _ligaSeleccionada = (from l in this.manager.t_leagues where l.id == this.idLiga select l).FirstOrDefault();
            if (_ligaSeleccionada != null)
            {
                this.liga = _ligaSeleccionada;
                this.LbTituloLiga.Text = _ligaSeleccionada.name;

                var ligasUsuario = (from ul in this.manager.t_user_leagues
                                    join l in this.manager.t_leagues on ul.id_league equals l.id
                                    join g in this.manager.t_games on l.id_game equals g.id
                                    join u in this.manager.t_users on ul.id_user equals u.id
                                    join gf in this.manager.t_game_factions on ul.id_faction equals gf.id
                                    where ul.id_league == this.idLiga &&
                                          ul.id_user == this.idUsuario
                                    select new JugadorLiga
                                    {
                                        league_id = l.id,
                                        tipo_liga = l.type,
                                        userleague_sec_level = ul.security_level,
                                        user_id = ul.id_user,
                                        user_name = u.name,
                                        user_surname = u.surname,
                                        user_avatar = u.avatar_url,
                                        team_name = ul.team_name,
                                        team_avatar_url = ul.team_avatar_url,
                                        wins = ul.wins,
                                        losses = ul.losses,
                                        draws = ul.draws,
                                        score = ul.total_score,
                                        vp = ul.total_vp,
                                        kills = ul.total_kills,
                                        league_name = l.name,
                                        league_avatar_url = l.avatar_url,
                                        game_id = l.id_game,
                                        game_name = g.name,
                                        game_avatar_url = g.avatar_url,
                                        faction_id = gf.id,
                                        faction_name = gf.name,
                                        faction_info = gf.info,
                                        faction_avatar_url = gf.avatar_url
                                    }).OrderBy(o => o.score).ThenBy(t => t.wins).ToList();

                var _ligaActual = ligasUsuario.FirstOrDefault();
                if (ligasUsuario.Count > 0)
                {
                    this.GrJugadores.DataSource = ligasUsuario;
                }
                else
                {
                    this.GrJugadores.DataSource = null;
                }

                this.BtAdminMERCS.Visible = false;
                if (_ligaActual.userleague_sec_level == 1)
                {
                    this.BtAdminMERCS.Visible = true;
                }

                this.GrJugadores.DataBind();
                this.PnlMensajes.Visible = false;
                this.PnlUsuarioLigaMERCS.Visible = false;
                this.TxNombreEquipo.Text = "---";
                this.TxNombreFaccion.Text = "---";
                this.TxJugador.Text = "---";
                this.ImgEquipo.ImageUrl = null;
                this.ImgFaccion.ImageUrl = null;
                this.ImgFaccion.CommandArgument = "0";
                if (_ligaActual != null) //mercs
                {
                    if (_ligaActual.game_id == 1 &&
                        _ligaActual.user_id == this.usuario.id &&
                        _ligaActual.tipo_liga != 0)
                    {
                        this.PnlUsuarioLigaMERCS.Visible = true;
                    }

                    if (_ligaActual.user_id == this.usuario.id)
                    {
                        this.PnlMensajes.Visible = true;
                    }

                    this.TxJugador.Text = _ligaActual.user_name + " " + _ligaActual.user_surname;
                    this.TxNombreEquipo.Text = _ligaActual.team_name;
                    this.TxNombreFaccion.Text = _ligaActual.faction_name;
                    this.ImgEquipo.ImageUrl = this.PATH_IMAGES + _ligaActual.team_avatar_url;
                    this.ImgFaccion.ImageUrl = this.PATH_IMAGES + _ligaActual.faction_avatar_url;

                    //Popupp de facción
                    this.LbFactionInfo.Text = _ligaActual.faction_info;
                    this.LbFactionName.Text = _ligaActual.faction_name;
                    this.ImgFaction.ImageUrl = this.PATH_IMAGES + _ligaActual.faction_avatar_url;
                    this.ImgFaction.ToolTip = _ligaActual.faction_name;
                    this.ImgFaction.AlternateText = _ligaActual.faction_name;
                }
            }
        }

        private void CargarMensajes()
        {

            var mensajesUsuario = (from m in this.manager.t_messages
                                   join l in this.manager.t_leagues on m.id_league equals l.id
                                   join u in this.manager.t_users on m.id_user_from equals u.id
                                where m.id_user_to == this.usuario.id &&
                                      l.id == this.idLiga                                  
                                select new
                                {
                                    message_id = m.id,
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
                                }).OrderByDescending(a=> a.sent_date).ToList();

            if (mensajesUsuario.Count > 0)
            {
                this.GrMensajes.DataSource = mensajesUsuario;
                _LbNoMensajes.Visible = false;
            }
            else
            {
                _LbNoMensajes.Visible = true;
                this.GrMensajes.DataSource = null;
            }
            this.GrMensajes.DataBind();
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
                case "VerJugador":
                    {
                        int _idMessage = Convert.ToInt32(e.CommandArgument);
                        var _msg = (from l in this.manager.t_messages where l.id == _idMessage select l).FirstOrDefault();

                        this.Response.Redirect("UserLeague.aspx?idLeague=" + _msg.id_league + "&idUser=" + _msg.id_user_from, true);
                        break;
                    }
            }
        }

        protected void BtRecursosMERCS_Click(object sender, EventArgs e)
        {
            Response.Redirect("../pages/dados.aspx", true);
        }

        protected void ImgFaccion_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            this.PopUpFaction.Show();
        }

        protected void BtAdminMERCS_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDados.aspx", true);
        }

    }
}