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
                }
            }
        }

        private void CargarDatosLiga()
        {
            var _ligaSeleccionada = (from l in this.manager.t_leagues where l.id == this.idLiga select l).FirstOrDefault();
            this.TxFechaInicio.Text = "---";
            this.TxFechaFin.Text = "---";
            this.TxInfo.Text = "---";
            this.ImgLiga.ImageUrl = null;
            if (_ligaSeleccionada != null)
            {
                this.liga = _ligaSeleccionada;
                this.LbTituloLiga.Text = _ligaSeleccionada.name;
                this.ImgLiga.ImageUrl = this.PATH_IMAGES + _ligaSeleccionada.avatar_url;
                if (_ligaSeleccionada.start_date.HasValue == true)
                {
                    this.TxFechaInicio.Text = _ligaSeleccionada.start_date.Value.ToLongDateString();
                }
                if (_ligaSeleccionada.end_date.HasValue == true)
                {
                    this.TxFechaFin.Text = _ligaSeleccionada.end_date.Value.ToLongDateString();
                }
                this.TxInfo.Text = _ligaSeleccionada.info;

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
                        _ligaActual.user_id == this.usuario.id)
                    {
                        this.PnlUsuarioLigaMERCS.Visible = true;
                    }

                    if (_ligaActual.user_id == this.usuario.id)
                    {
                        this.PnlMensajes.Visible = true;
                    }

                    this.TxJugador.Text = _ligaActual.user_name;
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

    }
}