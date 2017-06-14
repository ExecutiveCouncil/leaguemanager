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

        public int RondaActiva
        {
            get
            {
                return Convert.ToInt32(this.DrpRondaActual.SelectedValue);
            }
        }
        
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
                    else
                    {
                        if (this.usuario.security_level == 1)
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
                    this.lblRonda.Text = "RONDA ACTUAL:";                    
                    this.lblLiga.Text += this.liga.name;

                    this.DrpRondaActual.Items.Clear();
                    for (int i=1; i <= this.RondaActiva; i++)
                    {
                        this.DrpRondaActual.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    }
                    this.DrpRondaActual.SelectedValue = this.liga.current_round.ToString();

                    this.MostrarDadosUsuarios();
                    this.CargarPartidasRonda();
                    this.CargarJugadoresLiga();
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
            if (this.liga.type == 0)
            {
                this._LbNoCampaña.Visible = true;
                this.btnAddTurno.Visible = false;
                this.RptDatosUsuarios.DataSource = null;
                this.RptDatosUsuarios.DataBind();
                return;
            }
            
            List<UserDice> usuarios = (from ul in this.manager.t_user_leagues
                        join l in this.manager.t_leagues on ul.id_league equals l.id
                        join ud in this.manager.mercs_user_dice on ul.id equals ud.id_user_league
                        join dt in this.manager.mercs_die_types on ud.id_die_type equals dt.id
                        join u in this.manager.t_users on ul.id_user equals u.id
                        where l.current_round == this.RondaActiva
                                 && l.id == this.liga.id
                        select new UserDice
                        {
                            user_name = u.login,
                            id_user_league = ul.id,
                            user_avatar = u.avatar_url,
                            id_user = u.id,
                            wins = ul.wins,
                            draws =ul.draws,
                            losses = ul.losses,
                            total_score = ul.total_score
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
                usuario.textoCreditos = "Recursos: " + creditos;
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
                                               id_user_league = ul.id,
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
                    imagen = "g";
                    break;
                case 3:
                    imagen = "v";
                    break;
                case 4:
                    imagen = "c";
                    break;
                case 5:
                    imagen = "b";
                    break;
                case 6:
                    imagen = "m";
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
                    GuardarMensaje("Coste aumentado de dado", "Un dado de '" + nombreDado + "' aumenta su coste en " + txtAumentarCoste.Text + " recursos (ahora cuesta " + costeTotal + ")", this.usuario.id, this.usuario.id);
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

        private int ObtenerIdMatch()
        {
            var _ultimoID = (from m in this.manager.t_league_matchs
                              select m).OrderByDescending(a => a.id).FirstOrDefault();
            var _id = 0;
            if (_ultimoID == null)
            {
                _id = 1;
            }
            else
            {
                _id = _ultimoID.id + 1;
            }
            return _id;
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
            msg.round = this.RondaActiva;
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
            this.idUsuarioLigaSeleccionado = Convert.ToInt32(e.CommandArgument);
            this.PopUpAddDados.Show();
        }

        protected void btnAddTurno_Command(object sender, CommandEventArgs e)
        {
            var nuevoTurno = this.liga.current_round + 1;
            //Actualizamos el turno en la liga            
            this.lblRonda.Text = "RONDA ACTUAL:";                    
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

        protected void btnActivarTurno_Command(object sender, CommandEventArgs e)
        {
            //Actualizamos el turno en la liga
            var ligaActualizar = this.manager.t_leagues.Where(a => a.id == this.liga.id).FirstOrDefault();
            if (ligaActualizar != null)
            {
                ligaActualizar.current_round = ligaActualizar.current_round + 1;
                this.lblRonda.Text = "RONDA ACTUAL:";
                this.DrpRondaActual.SelectedValue = ligaActualizar.current_round.ToString();

                var ligasUsuario = (from ul in this.manager.t_user_leagues
                                    join l in this.manager.t_leagues on ul.id_league equals l.id
                                    join g in this.manager.t_games on l.id_game equals g.id
                                    join u in this.manager.t_users on ul.id_user equals u.id
                                    join gf in this.manager.t_game_factions on ul.id_faction equals gf.id
                                    where ul.id_league == this.liga.id
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
                                        kills = ul.total_kills,
                                        vp = ul.total_vp,
                                        league_name = l.name,
                                        league_avatar_url = l.avatar_url,
                                        game_name = g.name,
                                        game_avatar_url = g.avatar_url,
                                        faction_name = gf.name,
                                        faction_avatar_url = gf.avatar_url
                                    }).OrderByDescending(o => o.score)
                                        .ThenByDescending(t => t.vp)
                                        .ThenByDescending(tt => tt.kills).ToList();

                List<JugadorLiga> _listaJ1 = new List<JugadorLiga>(0);
                List<JugadorLiga> _listaJ2 = new List<JugadorLiga>(0);

                int _mitad = ligasUsuario.Count / 2;
                int i = 0;
                foreach (JugadorLiga _jl in ligasUsuario)
                {
                    _listaJ2.Add(_jl);
                    _listaJ1.Add(_jl);
                }

                int _lastID = this.ObtenerIdMatch();
                foreach (JugadorLiga _jl in _listaJ1)
                {
                    i++;
                    if (i <= _mitad) { continue; }
                    t_league_matchs _newMatch = new t_league_matchs();
                    _newMatch.id = _lastID;
                    _newMatch.id_league = this.liga.id;
                    _newMatch.p1_id_user = _jl.user_id;
                    _newMatch.p2_id_user = 0;
                    _newMatch.round = this.RondaActiva;

                    foreach (JugadorLiga _op in _listaJ2)
                    {
                        //VERIFICA: jugador contra si mismo
                        if (_op.user_id == _jl.user_id) { continue; } 

                        //VERIFICA: ya han jugado antes
                        var _validar = this.manager.t_league_matchs
                            .Where(a => 
                                   (a.id_league == _newMatch.id_league) &&
                                   ((a.p1_id_user == _jl.user_id && a.p2_id_user == _op.user_id) ||
                                   (a.p1_id_user == _op.user_id && a.p2_id_user == _jl.user_id))
                                   ).FirstOrDefault();
                        if (_validar == null)
                        {
                            _newMatch.p2_id_user = _op.user_id;
                            _listaJ2.RemoveAll(p=>p.user_id == _op.user_id);
                            _listaJ2.RemoveAll(p=>p.user_id == _jl.user_id);
                            break;
                        }
                    }

                    //Emparejamiento forzado (REPETIDO)
                    if (_newMatch.p2_id_user == 0)
                    {
                        foreach (JugadorLiga _op in _listaJ2)
                        {
                            _newMatch.p2_id_user = _op.user_id;
                            _listaJ2.RemoveAll(p => p.user_id == _op.user_id);
                            _listaJ2.RemoveAll(p => p.user_id == _jl.user_id);
                            _newMatch.match_notes = "REPITEN";
                            break;
                        }
                    }

                    //Guardamos
                    if (_newMatch.p1_id_user > 0 && _newMatch.p2_id_user > 0)
                    {
                        this.manager.t_league_matchs.Add(_newMatch);
                        this.manager.SaveChanges();
                    }
                    _lastID++;
                }




                this.manager.SaveChanges();
                this.CargarPartidasRonda();
                this.MostrarDadosUsuarios();
            }
        }

        protected void AddVictorias_Command(object sender, CommandEventArgs e)
        {
            int _idUser = Convert.ToInt32( e.CommandArgument);
            var usuarioLiga = this.manager.t_user_leagues.Where(a => a.id == _idUser).FirstOrDefault();
            usuarioLiga.wins = usuarioLiga.wins+1;
            usuarioLiga.total_score = usuarioLiga.total_score+25;
            this.manager.SaveChanges();
            this.MostrarDadosUsuarios();
        }

        protected void AddEmpates_Command(object sender, CommandEventArgs e)
        {
            int _idUser = Convert.ToInt32(e.CommandArgument);
            var usuarioLiga = this.manager.t_user_leagues.Where(a => a.id == _idUser).FirstOrDefault();
            usuarioLiga.draws = usuarioLiga.draws+1;
            usuarioLiga.total_score = usuarioLiga.total_score + 10;
            this.manager.SaveChanges();
            this.MostrarDadosUsuarios();
        }

        protected void AddPerdidas_Command(object sender, CommandEventArgs e)
        {
            int _idUser = Convert.ToInt32(e.CommandArgument);
            var usuarioLiga = this.manager.t_user_leagues.Where(a => a.id == _idUser).FirstOrDefault();
            usuarioLiga.losses = usuarioLiga.losses+1;
            this.manager.SaveChanges();
            this.MostrarDadosUsuarios();
        }

        protected void ImgAddDados_Command(object sender, CommandEventArgs e)
        {
            mercs_user_dice dado = new mercs_user_dice();
            var nombreDado = string.Empty;

            //datos genéricos del nuevo dado
            dado.id = ObtenerIdNuevoDado();
            dado.status = 0;
            dado.id_user_league = this.idUsuarioLigaSeleccionado;
            dado.round = this.RondaActiva;

            switch (e.CommandName)
            {
                case "AddDado":
                    {
                        int tipoDado = Convert.ToInt32(e.CommandArgument);
                        nombreDado = this.manager.mercs_die_types.Where(a => a.id == tipoDado).FirstOrDefault().name;  
                        dado.id_die_type = tipoDado;
                        break;
                    }
                case "AddRecursos":
                    {
                        nombreDado = this.manager.mercs_die_types.Where(a => a.id == 5).FirstOrDefault().name;
                        dado.id_die_type = 5;
                        dado.id_die_face = Convert.ToInt32(e.CommandArgument);
                        dado.rolled_date = DateTime.Now;
                        break;
                    }
                case "AddMateriales":
                    {
                        nombreDado = this.manager.mercs_die_types.Where(a => a.id == 6).FirstOrDefault().name;
                        dado.id_die_type = 6;
                        dado.id_die_face = Convert.ToInt32(e.CommandArgument);
                        dado.rolled_date = DateTime.Now;
                        break;
                    }
                case "AddDadoRecursos":
                    {
                        int cara = Convert.ToInt32(e.CommandArgument);
                        nombreDado = this.manager.mercs_die_types.Where(a => a.id == 1).FirstOrDefault().name;
                        dado.id_die_type = 1;
                        dado.id_die_face = cara;
                        dado.rolled_date = DateTime.Now;
                        dado.cost = this.manager.mercs_die_faces.Where(a => a.id_die_type == 1 && a.die_face == cara).FirstOrDefault().cost_credits;
                        break;
                    }
                case "AddDadoEconomia":
                    {
                        int cara = Convert.ToInt32(e.CommandArgument);
                        nombreDado = this.manager.mercs_die_types.Where(a => a.id == 2).FirstOrDefault().name;
                        dado.id_die_type = 2;
                        dado.id_die_face = cara;
                        dado.rolled_date = DateTime.Now;
                        dado.cost = this.manager.mercs_die_faces.Where(a => a.id_die_type == 2 && a.die_face == cara).FirstOrDefault().cost_credits;
                        break;
                    }
                case "AddDadoPolitica":
                    {
                        int cara = Convert.ToInt32(e.CommandArgument);
                        nombreDado = this.manager.mercs_die_types.Where(a => a.id == 3).FirstOrDefault().name;
                        dado.id_die_type = 3;
                        dado.id_die_face = cara;
                        dado.rolled_date = DateTime.Now;
                        dado.cost = this.manager.mercs_die_faces.Where(a => a.id_die_type == 3 && a.die_face == cara).FirstOrDefault().cost_credits;
                        break;
                    }
                case "AddDadoEspionaje":
                    {
                        int cara = Convert.ToInt32(e.CommandArgument);
                        nombreDado = this.manager.mercs_die_types.Where(a => a.id == 4).FirstOrDefault().name;
                        dado.id_die_type = 4;
                        dado.id_die_face = cara;
                        dado.rolled_date = DateTime.Now;
                        dado.cost = this.manager.mercs_die_faces.Where(a => a.id_die_type == 4 && a.die_face == cara).FirstOrDefault().cost_credits;
                        break;
                    }
            }

            GuardarMensaje("Añadido dado", "Se ha añadido un dado de '" + nombreDado + "'", this.usuario.id, idUsuarioLigaSeleccionado);
            //Añadir el dado y guardar los cambios
            this.manager.mercs_user_dice.Add(dado);
            this.manager.SaveChanges();

            this.MostrarDadosUsuarios();
        }

        private void CargarPartidasRonda()
        {
            var _rondas = (from lm in this.manager.t_league_matchs
                           join u1 in this.manager.t_users on lm.p1_id_user equals u1.id into tmpu1
                           join u2 in this.manager.t_users on lm.p2_id_user equals u2.id into tmpu2
                           join wnr in this.manager.t_users on lm.winner_id_user equals wnr.id into tmpwnr
                           where lm.round == this.RondaActiva && lm.id_league == this.liga.id
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
                               match_notes = lm.match_notes,
                           }).OrderByDescending(a => a.id).ToList();

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

        private void CargarJugadoresLiga()
{
            var ligasUsuario = (from ul in this.manager.t_user_leagues
                                join l in this.manager.t_leagues on ul.id_league equals l.id
                                join g in this.manager.t_games on l.id_game equals g.id
                                join u in this.manager.t_users on ul.id_user equals u.id
                                join gf in this.manager.t_game_factions on ul.id_faction equals gf.id
                                where ul.id_league == this.liga.id
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
                                    kills = ul.total_kills,
                                    vp = ul.total_vp,
                                    league_name = l.name,
                                    league_avatar_url = l.avatar_url,
                                    game_name = g.name,
                                    game_avatar_url = g.avatar_url,
                                    faction_name = gf.name,
                                    faction_avatar_url = gf.avatar_url
                                }).OrderByDescending(o => o.score)
                                        .ThenByDescending(t => t.vp)
                                        .ThenByDescending(tt => tt.kills).ToList();


            if (ligasUsuario.Count > 0)
            {
                this.GrJugadores.DataSource = ligasUsuario;
                this._LbNoJugadores.Visible = false;
            }
            else
            {
                this.GrJugadores.DataSource = null;
                this._LbNoJugadores.Visible = true;
            }
            this.GrJugadores.DataBind();
        }

    }
}