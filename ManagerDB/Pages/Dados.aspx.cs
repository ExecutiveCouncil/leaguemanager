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
    public partial class Dados : BasicPage
    {

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
                    this.MostrarDados();
                }
            }
        }

        private void MostrarDados()
        {
            List<UserDice> dadosUsuario = (from ul in this.manager.t_user_leagues
                                           join l in this.manager.t_leagues on ul.id_league equals l.id
                                           join ud in this.manager.mercs_user_dice on ul.id equals ud.id_user_league
                                           join dt in this.manager.mercs_die_types on ud.id_die_type equals dt.id
                                    where ul.id_user == this.usuario.id
                                            && l.current_round == ud.round
                                            && l.id == this.idLiga
                                    select new UserDice
                                    {
                                        id = ud.id,
                                        id_die_type = ud.id_die_type,
                                        spent_date = ud.spent_date,
                                        resources_gained = ud.resources_gained,
                                        rolled_date = ud.rolled_date,
                                        die_type_name = dt.name,
                                        total_faces = dt.total_faces,
                                        info_die = dt.info,
                                        id_die_face = ud.id_die_face,                                        
                                        img_Dice = ""
                                    }).ToList();

            if (dadosUsuario.Count > 0)
            {
                var caras = (from df in this.manager.mercs_die_faces select df).ToList();

                foreach (var dado in dadosUsuario)
                {                    
                    //Elegimos que info mostramos en el dado (si no se ha tirado mostramos la general y si se ha tirado la específica de la cara)
                    dado.info = (dado.rolled_date == null) ? dado.info_die : dado.info_face;

                    if (dado.id_die_face != null)
                    {
                        var cara = caras.Where(a => a.id == dado.id_die_face).FirstOrDefault();
                        dado.action = cara.action;
                        dado.info = cara.info;
                        dado.cost_credits = cara.cost_credits;
                        dado.sell_materials = cara.sell_materials;
                        dado.sell_credits = cara.sell_credits;
                        dado.die_face = cara.die_face;
                    }

                    //Calculamos que imagen debe ir en el dado
                    var imagen = CalcularImagenDado(dado.die_type_name, dado.die_face, dado.rolled_date, dado.spent_date, dado.resources_gained);
                    dado.img_Dice = imagen;
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

        private void RollDice(int idDice)
        {
            var dado = this.manager.mercs_user_dice.Where(a => a.id == idDice).FirstOrDefault();
            if (dado != null)
            {
                if (dado.rolled_date == null)
                {
                    //Hacemos la tirada
                    dado.rolled_date = DateTime.UtcNow;
                    var tirada = RandomGenerator.RandomNumber(1, 6);
                    var cara = this.manager.mercs_die_faces.Where(a => a.die_face == tirada && a.id_die_type == dado.id_die_type).FirstOrDefault();
                    dado.id_die_face = cara.id;
                }
            }
        }

        protected void RptDices_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "RollDice":
                    {
                        int idDice = Convert.ToInt32(e.CommandArgument);
                        //Tiramos el dado
                        RollDice(idDice);
                        //Guardamos la tirada
                        this.manager.SaveChanges();
                        //recalculamos los dados a mostrar
                        MostrarDados();
                        break;
                    }
                default:
                    {
                        break;
                    }
            }
        }

        protected void rollButton_Command(object sender, CommandEventArgs e)
        {
            var dadosPendientesTirar = (from ul in this.manager.t_user_leagues
                                           join l in this.manager.t_leagues on ul.id_league equals l.id
                                           join ud in this.manager.mercs_user_dice on ul.id equals ud.id_user_league
                                           where ul.id_user == this.usuario.id
                                                   && l.current_round == ud.round
                                                   && l.id == this.idLiga
                                                   && ud.rolled_date == null
                                           select ud.id
                                           ).ToList();

            foreach (var idDado in dadosPendientesTirar)
            {
                //Tiramos el dado
                RollDice(idDado);
            }
            
            //Guardamos la tirada
            this.manager.SaveChanges();
            //recalculamos los dados a mostrar
            MostrarDados();
        }
    }
}