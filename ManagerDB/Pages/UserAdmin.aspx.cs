using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagerDB.Pages
{
    public partial class UserAdmin : BasicPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                var admin = false;
                if (this.usuario != null)
                {
                    var _usuario = this.manager.t_users
                            .Where(a => a.id == this.usuario.id).FirstOrDefault();
                    if (_usuario != null)
                    {
                        if (_usuario.security_level == 1)
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
                    this.MostrarDatosUsuarios();
                }
            }
        }

        protected void MostrarDatosUsuarios()
        {
            var usuarios = this.manager.t_users.ToList();

            if (usuarios.Count > 0)
            {
                this.GrUsuarios.DataSource = usuarios;
                this._LbNoUsuarios.Visible = false;
            }
            else
            {
                this.GrUsuarios.DataSource = null;
                this._LbNoUsuarios.Visible = true;
            }
            this.GrUsuarios.DataBind();
        }

        protected void GrUsuarios_ItemCommand(object source, DataGridCommandEventArgs e)
        {
            int _idUser = Convert.ToInt32(e.Item.Cells[0].Text);
            switch (e.CommandName)
            {
                case "Editar":
                {
                    LimpiarPopUp();
                    this.lblId.Text = _idUser.ToString();
                    this.txtNSocio.Text = e.Item.Cells[1].Text;
                    this.PopUpUser.Show();
                    break;
                }
                case "Eliminar":
                {
                    var usuario = this.manager.t_users.Where(a=> a.id == _idUser).FirstOrDefault();
                    this.manager.t_users.Remove(usuario);
                    this.manager.SaveChanges();
                    break;
                }
            }
            this.GrUsuarios.DataBind();
        }

        protected void BtAddUser_Click(object sender, EventArgs e)
        {
            LimpiarPopUp();
            this.PopUpUser.Show();
        }

        private void LimpiarPopUp()
        {
            this.lblId.Text = string.Empty;
            this.txtNSocio.Text = string.Empty;
        }

        protected void btnGuardar_Command(object sender, CommandEventArgs e)
        {
            t_users nuevoUsuario= new t_users();
            
            if (this.lblId.Text == string.Empty)
            {
                //Calcular Id
                nuevoUsuario.id = ObtenerIdUsuario();
            }
            else
            {
                var id = Convert.ToInt32(this.lblId.Text);
                nuevoUsuario = this.manager.t_users.Where(a => a.id == id).FirstOrDefault();
            }

            nuevoUsuario.numero_socio = Convert.ToInt32(this.txtNSocio.Text);

            if (this.lblId.Text == string.Empty)
            {
                this.manager.t_users.Add(nuevoUsuario);
            }
            this.manager.SaveChanges();
        }

        private int ObtenerIdUsuario()
        {
            var ultimoUsuario = (from m in this.manager.t_users
                             select m).OrderByDescending(a => a.id).FirstOrDefault();
            var idUsuario = 0;
            if (ultimoUsuario == null)
            {
                idUsuario = 1;
            }
            else
            {
                idUsuario = ultimoUsuario.id + 1;
            }
            return idUsuario;
        }
    }
}