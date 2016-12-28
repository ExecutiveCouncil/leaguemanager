using Entidades;
using ManagerDB.Clases;
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

            List<UserDice> dadosUsuario = (from ul in ctx.t_user_leagues
                                    join l in ctx.t_leagues on ul.id_league equals l.id
                                    join ud in ctx.mercs_user_dice on ul.id equals ud.id_user_league
                                    join dt in ctx.mercs_die_types on ud.id_die_type equals dt.id
                                    join df in ctx.mercs_die_faces on ud.id_die_face equals df.id
                                    where ul.id_user == idUsuario //hay q identificar liga y ronda
                                        //&& l.current_round == ud.round
                                    select new UserDice
                                    {
                                        id_die_type = ud.id_die_type,
                                        spent_date = ud.spent_date,
                                        resources_gained = ud.resources_gained,
                                        rolled_date = ud.rolled_date,
                                        die_type_name = dt.name,
                                        total_faces = dt.total_faces,
                                        info_die = dt.info,
                                        die_face = df.die_face,
                                        action = df.action,
                                        info_face = df.info,
                                        cost_credits = df.cost_credits,
                                        sell_materials = df.sell_materials,
                                        sell_credits = df.sell_credits,
                                        img_Dice = ""
                                    }).ToList();

            if (dadosUsuario.Count > 0)
            {
                var divHtml = new System.Text.StringBuilder();
                var contador = 1;
                foreach (var dado in dadosUsuario)
                {
                    using(HtmlGenericControl div = new System.Web.UI.HtmlControls.HtmlGenericControl("div"))
                    {
                        var imagen = CalcularImagenDado(dado.die_type_name, dado.die_face, dado.rolled_date, dado.spent_date, dado.resources_gained);
                        dado.img_Dice = imagen;
                    }
                    contador++;
                }

                this.RptDices.DataSource = dadosUsuario;
                this.RptDices.DataBind();
            }
        }
        
        private string CalcularImagenDado(string nombreDado, int? cara, DateTime? fechaTirada, DateTime? fechaUso, int? recursosGanados)
        {
            var imagen = string.Empty;
            //miramos que tipo de imagen corresponde (a,c,g,v)
            switch(nombreDado)
            {
                case "Recurso":
                    imagen = "a";
                    break;
                case "Economía":
                    imagen = "c";
                    break;
                case "Política":
                    imagen = "g";
                    break;
                case "Espionaje":
                    imagen = "v";
                    break;
            }

            if (fechaTirada != null)
            {
                //añadimos al nombre la cara de la tirada
                imagen += cara;

                if (fechaUso != null)
                {
                    if (recursosGanados != null)
                    {
                        imagen += "s";
                    }
                    else
                    {
                        imagen += "u";
                    }
                }
            }

            return imagen + ".png";
        }

        protected void RptDices_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "RollDice":
                    {
                        int _idDice = Convert.ToInt32(e.CommandArgument);

                        break;
                    }
                default:
                    {
                        break;
                    }
            }
        }
    }
}