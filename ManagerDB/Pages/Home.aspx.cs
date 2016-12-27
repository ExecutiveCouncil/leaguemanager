using Entidades;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagerDB.Pages
{
    public partial class Home : System.Web.UI.Page
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
                CargarLigas();
                CargarUltimosMensajes();
            }
        }

        private void CargarLigas()
        {
            var id_usuario = Convert.ToInt32(Session["idUsuario"]);

            var ligasUsuario = (from ul in ctx.t_user_leagues
                              join l in ctx.t_leagues on ul.id_league equals l.id
                              join g in ctx.t_games on l.id_game equals g.id
                              join gf in ctx.t_game_factions on ul.id_faction equals gf.id
                              where ul.id_user == id_usuario
                              select new
                              {
                                  user_id = ul.id_user,
                                  team_name = ul.team_name,
                                  team_avatar_url = ul.team_avatar_url,
                                  wins = ul.wins,
                                  losses = ul.losses,
                                  draws = ul.draws,
                                  score = ul.total_score,
                                  league_name = l.name,
                                  league_avatar_url = l.avatar_url,
                                  current_round = l.current_round,
                                  game_name = g.name,
                                  game_avatar_url = g.avatar_url,
                                  faction_name = gf.name,
                                  faction_avatar_url = gf.avatar_url
                              }).ToList();

            if (ligasUsuario.Count > 0)
            {
                //List<string> listaColumnas = new List<string>(new string[]{"Liga", "Juego", "Equipo", "Facción", "Ronda", "Victorias", "Empates", "Derrotas", "Puntuación total"});
                ////Building an HTML string.
                //StringBuilder html = new StringBuilder();

                ////Table start.
                //html.Append("<table class=''.table-hover''>");

                ////Building the Header row.
                //html.Append("<tr>");
                //foreach (var columna in listaColumnas)
                //{
                //    html.Append("<th>");
                //    html.Append(columna);
                //    html.Append("</th>");
                //}
                //html.Append("</tr>");

                //foreach (var ligaUsuario in ligasUsuario)
                //{
                //    html.Append("<tr>");
                //    html.Append("<td>" + ligaUsuario.league_name + "</td>"); //meter tb imagen de la liga
                //    html.Append("<td>" + ligaUsuario.game_name + "</td>"); //meter tb imagen del juego
                //    html.Append("<td>" + ligaUsuario.team_name + "</td>"); //meter tb imagen del equipo
                //    html.Append("<td>" + ligaUsuario.faction_name + "</td>"); //meter tb imagen de la facción
                //    html.Append("<td>" + ligaUsuario.current_round + "</td>");
                //    html.Append("<td>" + ligaUsuario.wins + "</td>");
                //    html.Append("<td>" + ligaUsuario.losses + "</td>");
                //    html.Append("<td>" + ligaUsuario.draws + "</td>");
                //    html.Append("<td>" + ligaUsuario.total_score + "</td>");
                //    html.Append("</tr>");
                //}

                ////Table end.
                //html.Append("</table>");

                ////Append the HTML string to Placeholder.
                //Ligas.Controls.Add(new Literal { Text = html.ToString() });

                this.GrLigas.DataSource = ligasUsuario;
                this.GrLigas.DataBind();

            }
        }

        private void CargarUltimosMensajes()
        {
            var usuario = Convert.ToInt32(Session["idUsuario"]);

            var mensajesUsuario = (from m in ctx.t_messages
                                join l in ctx.t_leagues on m.id_league equals l.id
                                join u in ctx.t_users on m.id_user_from equals u.id
                                where m.id_user_to == usuario 
                                select new
                                {
                                    league_avatar_url = l.avatar_url,
                                    league_name = l.name,
                                    user_name_from = u.name,
                                    user_avatar_url = u.avatar_url,
                                    subject = m.subject,
                                    message = m.message,
                                    sent_date = m.sent_date
                                }).OrderByDescending(a=> a.sent_date).Take(5).ToList();

            if (mensajesUsuario.Count > 0)
            {
                //List<string> listaColumnas = new List<string>(new string[] { "Liga", "De", "Asunto", "Mensaje", "Fecha de envío" });
                ////Building an HTML string.
                //StringBuilder html = new StringBuilder();

                ////Table start.
                //html.Append("<table class=''.table-hover''>");

                ////Building the Header row.
                //html.Append("<tr>");
                //foreach (var columna in listaColumnas)
                //{
                //    html.Append("<th>");
                //    html.Append(columna);
                //    html.Append("</th>");
                //}
                //html.Append("</tr>");

                //foreach (var mensajeUsuario in mensajesUsuario)
                //{
                //    html.Append("<tr>");
                //    html.Append("<td>" + mensajeUsuario.league_name + "</td>"); //meter tb imagen de la liga
                //    html.Append("<td>" + mensajeUsuario.user_name_from + "</td>"); //meter tb imagen del usuario
                //    html.Append("<td>" + mensajeUsuario.subject + "</td>");
                //    html.Append("<td>" + mensajeUsuario.message + "</td>");
                //    html.Append("<td>" + mensajeUsuario.sent_date + "</td>");
                //    html.Append("</tr>");
                //}

                ////Table end.
                //html.Append("</table>");

                ////Append the HTML string to Placeholder.
                //UltimosMensajes.Controls.Add(new Literal { Text = html.ToString() });

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

                        int _iduser = Convert.ToInt32(e.Item.Cells[0].Text);

                        //aqui cruzo los dedos

                        this.Response.Redirect("http://www.google.es", true);
                        break;
                    }
            }
        }
    }
}