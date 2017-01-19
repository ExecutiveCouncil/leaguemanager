using Entidades;
using ManagerDB.Clases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagerDB.Pages
{
    public partial class AdminDadosAspx : BasicPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                var admin = false;
                if (this.usuario != null && this.liga != null)
                {
                    var _ligaUsuario = this.manager.t_user_leagues
                            .Where(a => a.id_user == this.usuario.id &&
                                        a.id_league == this.liga.id).FirstOrDefault();
                    if (_ligaUsuario != null)
                    {
                        if (_ligaUsuario.security_level == 1)
                        {
                            admin = true;
                        }
                    }
                }

                if (this.ValidateSession() == false || !admin)
                {
                    FormsAuthentication.RedirectToLoginPage();
                }
                else
                {
                    //Ponemos la ronda actual y el nombre de la liga
                    this.lblRonda.Text = "RONDA ACTUAL: <span style='color:#e3e3e3;'>" + this.liga.current_round.ToString() + "</span>";                    
                    this.lblLiga.Text += this.liga.name;

                    this.MostrarDadosUsuarios();
                }
            }
        }

        private int? CalcularCreditos(int? idUsuario)
        {
            int? creditos = 0;
            var creditosConseguidos = (from ul in this.manager.t_user_leagues
                                            join l in this.manager.t_leagues on ul.id_league equals l.id
                                            join ud in this.manager.mercs_user_dice on ul.id equals ud.id_user_league
                                            where ul.id_user == idUsuario
                                                   && l.current_round == ud.round
                                                   && l.id == this.liga.id
                                                   && ud.status == 1
                                           select ud.resources_gained).ToList();
            creditos = creditosConseguidos.DefaultIfEmpty(0).Sum();


            var creditosGastados = (from ul in this.manager.t_user_leagues
                                    join l in this.manager.t_leagues on ul.id_league equals l.id
                                    join ud in this.manager.mercs_user_dice on ul.id equals ud.id_user_league
                                    where ul.id_user == idUsuario
                                            && l.current_round == ud.round
                                            && l.id == this.liga.id
                                            && ud.status == 3
                                    select ud.cost).ToList();
            creditos -= creditosGastados.DefaultIfEmpty(0).Sum();
            return creditos;
        }

        private int? CalcularMateriales(int? idUsuario)
        {
            int? materiales = 0;

            var materialesConseguidos = (from ul in this.manager.t_user_leagues
                                        join l in this.manager.t_leagues on ul.id_league equals l.id
                                        join ud in this.manager.mercs_user_dice on ul.id equals ud.id_user_league
                                        where ul.id_user == idUsuario
                                               && l.current_round == ud.round
                                               && l.id == this.liga.id
                                               && ud.status == 2
                                       select ud.resources_gained).ToList();
            materiales = materialesConseguidos.DefaultIfEmpty(0).Sum();
            return materiales;
        }

        private void MostrarDadosUsuarios()
        {
            List<UserDice> usuarios = (from ul in this.manager.t_user_leagues
                                           join l in this.manager.t_leagues on ul.id_league equals l.id
                                           join ud in this.manager.mercs_user_dice on ul.id equals ud.id_user_league
                                           join dt in this.manager.mercs_die_types on ud.id_die_type equals dt.id
                                           join u in this.manager.t_users on ul.id_user equals u.id
                                           where l.current_round == ud.round
                                                    && l.id == this.liga.id
                                           select new UserDice
                                           {
                                               user_name = u.login,
                                               id_user_league = ul.id,
                                               user_avatar = u.avatar_url,
                                               id_user = u.id
                                           }).Distinct().ToList();
            foreach (var usuario in usuarios)
            {
                //Si no tiene foto de avatar ponemos la de por defecto
                if (string.IsNullOrEmpty(usuario.user_avatar))
                {
                    usuario.user_avatar = "webapp/user.png";
                }
                var creditos = CalcularCreditos(usuario.id_user);
                var materiales = CalcularMateriales(usuario.id_user);
                usuario.textoCreditos = "Créditos: " + creditos;
                usuario.textoMateriales = "Materiales: " + materiales;
                usuario.creditos = creditos;
                usuario.materiales = materiales;
            }

            if (usuarios.Count > 0)
            {
                this.RptDatosUsuarios.DataSource = usuarios;
                this.RptDatosUsuarios.DataBind();
            }
        }

        protected void RptDatosUsuarios_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var _usuarioActual = (UserDice)e.Item.DataItem;

                List<UserDice> datosUsuario = (from ul in this.manager.t_user_leagues
                                           join l in this.manager.t_leagues on ul.id_league equals l.id
                                           join ud in this.manager.mercs_user_dice on ul.id equals ud.id_user_league
                                           join dt in this.manager.mercs_die_types on ud.id_die_type equals dt.id
                                           join u in this.manager.t_users on ul.id_user equals u.id
                                           where  l.current_round == ud.round
                                                   && l.id == this.liga.id
                                                   && ul.id == _usuarioActual.id_user_league
                                           select new UserDice
                                           {
                                               user_name = u.login,
                                               id = ud.id,
                                               id_die_type = ud.id_die_type,
                                               spent_date = ud.spent_date,
                                               resources_gained = ud.resources_gained,
                                               rolled_date = ud.rolled_date,
                                               die_type_name = dt.name,
                                               total_faces = dt.total_faces,
                                               info_die = dt.info,
                                               id_die_face = ud.id_die_face,
                                               img_Dice = "",
                                               cost = ud.cost,
                                               status = ud.status,
                                               admin_date = ud.admin_date
                                           }).ToList();

                if (datosUsuario.Count > 0)
                {
                    var caras = (from df in this.manager.mercs_die_faces select df).ToList();

                    foreach (var dado in datosUsuario)
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

                        //Calculamos que imagen debe ir en el dadodie_typedie_type
                        var imagen = CalcularImagenDado(dado.id_die_type, dado.die_face, dado.rolled_date, dado.spent_date, dado.status);
                        dado.img_Dice = imagen;
                    }
                    Repeater childRepeater = (Repeater)e.Item.FindControl("RptDadosUsuarios");
                    childRepeater.DataSource = datosUsuario.OrderByDescending(o=>o.spent_date).ThenByDescending(t=>t.rolled_date).ThenBy(t2=>t2.id_die_type).ThenBy(i=>i.id_die_face);
                    childRepeater.DataBind();
                }
            }
        }
        
        private string CalcularImagenDado(int? tipoDado, int? cara, DateTime? fechaTirada, DateTime? fechaUso, int? status)
        {
            var imagen = string.Empty;
            //miramos que tipo de imagen corresponde (a,c,g,v)
            switch (tipoDado)
            {
                case 1:
                    imagen = "a";
                    break;
                case 2:
                    imagen = "v";
                    break;
                case 3:
                    imagen = "g";
                    break;
                case 4:
                    imagen = "c";
                    break;
            }

            if (fechaTirada != null)
            {
                //añadimos al nombre la cara de la tirada
                imagen += cara;

                if (fechaUso != null)
                {
                    if (status == 1)
                    {
                        imagen += "s";
                    }
                    else if (status == 2)
                    {
                        imagen += "m";
                    }
                    else                    
                    {
                        imagen += "u";
                    }
                }
            }

            return imagen + ".png";
        }
        protected void btnAdminDado_Command(object sender, CommandEventArgs e)
        {
            if (!optReroll.Checked && !optAumentarCoste.Checked && !optEliminar.Checked)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "error", "alert('Debes seleccionar una opción')", true);
                //lblError.Text = "Debes seleccionar una opción";
                //lblError.Visible = true;
            }
            else if (optAumentarCoste.Checked && string.IsNullOrEmpty(txtAumentarCoste.Text))
            {
                //Obligamos a meter texto si está marcado aumentar coste
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "error", "alert('Si se va a aumentar el coste de la acción, debe especificarse cuánto')", true);
            }
            else
            {                
                var dado = this.manager.mercs_user_dice.Where(a => a.id == dadoSeleccionado.id).FirstOrDefault();
                var nombreDado = this.manager.mercs_die_types.Where(a => a.id == dado.id_die_type).FirstOrDefault().name;
                var cara = this.manager.mercs_die_faces.Where(a => a.id == dado.id_die_face).FirstOrDefault();
                //Guardamos la fecha de administracion del dado
                dado.admin_date = DateTime.Now;

                if (optReroll.Checked)
                {
                    //marcar el dado como no tirado/gastado
                    dado.status = 0; 
                    dado.rolled_date = null;
                    dado.spent_date = null;
                    GuardarMensaje("Reroll dado", "Debes volver a tirar el dado de '" + nombreDado + "'", this.usuario.id, this.usuario.id);
                }
                else if (optAumentarCoste.Checked)
                {
                    var costeTotal = dado.cost + Convert.ToInt32(txtAumentarCoste.Text);
                    dado.cost = costeTotal;
                    GuardarMensaje("Coste aumentado de dado", "Un dado de '" + nombreDado + "' aumenta su coste en " + txtAumentarCoste.Text + " créditos (ahora cuesta " + costeTotal + ")", this.usuario.id, this.usuario.id);
                }
                else if (optEliminar.Checked)
                {
                    //También guardamos un mensaje
                    GuardarMensaje("Dado eliminado", "Se elimina un dado de '" + nombreDado + "'", this.usuario.id, this.usuario.id);
                    this.manager.mercs_user_dice.Remove(dado);
                }                

                this.manager.SaveChanges();
                this.MostrarDadosUsuarios();
            }
        }

        private int ObtenerIdMensaje()
        {
            var ultimoMsg = (from m in this.manager.t_messages
                             select m).OrderByDescending(a => a.id).FirstOrDefault();
            var idMsg = 0;
            if (ultimoMsg == null)
            {
                idMsg = 1;
            }
            else
            {
                idMsg = ultimoMsg.id + 1;
            }
            return idMsg;
        }

        private int GuardarMensaje(string asunto, string mensaje, int? from, int? to)
        {
            //Guardamos el mensaje
            var idMsg = ObtenerIdMensaje();
            t_messages msg = new t_messages();
            msg.id = idMsg;
            msg.id_league = this.liga.id;
            msg.id_user_from = from;
            msg.id_user_to = to;
            msg.message = mensaje;
            msg.round = this.liga.current_round;
            msg.sent_date = DateTime.Now;
            msg.subject = asunto;

            //añadimos el mensaje
            this.manager.t_messages.Add(msg);
            //Guardamos aquí para que no se pisen los Ids de los mensajes
            this.manager.SaveChanges();

            return idMsg;
        }

        private int ObtenerIdRelacionMensajeDado()
        {
            var ultimoMsg = (from m in this.manager.mercs_user_dice_msg
                             select m).OrderByDescending(a => a.id).FirstOrDefault();
            var idMsg = 0;
            if (ultimoMsg == null)
            {
                idMsg = 1;
            }
            else
            {
                idMsg = ultimoMsg.id + 1;
            }
            return idMsg;
        }

        private int GuardarRelacionMensajeDado(string mensaje, int? from)
        {
            //Guardamos el mensaje
            var idMsg = ObtenerIdRelacionMensajeDado();
            mercs_user_dice_msg msg = new mercs_user_dice_msg();
            msg.id = idMsg;
            msg.id_user_dice = this.dadoSeleccionado.id;
            msg.id_user_from = from;
            msg.message = mensaje;
            msg.message_date = DateTime.Now;

            //añadimos el mensaje
            this.manager.mercs_user_dice_msg.Add(msg);
            //Guardamos aquí para que no se pisen los Ids de los mensajes
            this.manager.SaveChanges();

            return idMsg;
        }

        protected void btnAddDado_Command(object sender, CommandEventArgs e)
        {
            
        }

        protected void btnAddTurno_Command(object sender, CommandEventArgs e)
        {
            //Actualizamos el turno en la liga
            var nuevoTurno = this.liga.current_round + 1;
            var ligaActualizar = this.manager.t_leagues.Where(a => a.id == this.liga.id).FirstOrDefault();
            ligaActualizar.current_round = nuevoTurno;
            this.lblRonda.Text = "RONDA ACTUAL: <span style='color:#e3e3e3;'>" + nuevoTurno + "</span>";                    
            this.liga.current_round = nuevoTurno;

            //Insertamos los dados por usuario y facción
            var dadosFacciones = (from ul in this.manager.t_user_leagues
                                            join fd in this.manager.mercs_faction_dice on ul.id_faction equals fd.id_game_faction
                                            where ul.id_league == this.liga.id
                                            select new 
                                            {
                                                id_user_league = ul.id,
                                                id_die_type = fd.id_die_type
                                           }).ToList();

            var idDado = ObtenerIdNuevoDado();
            foreach(var dado in dadosFacciones)
            {
                var dadoNuevo = new mercs_user_dice();
                dadoNuevo.id = idDado;
                dadoNuevo.id_user_league = dado.id_user_league;
                dadoNuevo.id_die_type = dado.id_die_type;
                dadoNuevo.round = nuevoTurno;
                dadoNuevo.status = 0;
                this.manager.mercs_user_dice.Add(dadoNuevo);
                idDado++;
            }

            this.manager.SaveChanges();
            this.MostrarDadosUsuarios();
        }

        private int ObtenerIdNuevoDado()
        {
            var ultimoDado = (from m in this.manager.mercs_user_dice
                             select m).OrderByDescending(a => a.id).FirstOrDefault();
            var idDado = 0;
            if (ultimoDado == null)
            {
                idDado = 1;
            }
            else
            {
                idDado = ultimoDado.id + 1;
            }
            return idDado;
        }

        protected void RptDadosUsuarios_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "AdministrarDado":
                    {
                        int _idDado = Convert.ToInt32( e.CommandArgument);
                        var dado = this.manager.mercs_user_dice.Where(a => a.id == _idDado).FirstOrDefault();
                        dadoSeleccionado = dado;

                        //Vaciamos el popup
                        txtMensaje.Text = string.Empty;
                        txtAumentarCoste.Text = string.Empty;
                        optReroll.Checked = false;
                        optAumentarCoste.Checked = false;
                        optEliminar.Checked = false;

                        PopUpDado.Show();
                        break;
                    }
            }
        }
    }
}