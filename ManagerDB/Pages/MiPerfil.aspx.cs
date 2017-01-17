using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace ManagerDB.Pages
{
    public partial class MiPerfilAspx : BasicPage
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
                    this.ImgUser.ImageUrl = this.PATH_IMAGES + this.usuario.avatar_url;
                    this.TxNombre.Text = this.usuario.name;
                    this.TxApellidos.Text = this.usuario.surname;
                    this.TxEmail.Text = this.usuario.email;
                    this.TxUserLogin.Text = this.usuario.login;
                }
            }
        }

        protected void BtDatosUsuario_Click(object sender, EventArgs e)
        {

            try
            {
                this.usuario.name = this.TxNombre.Text;
                this.usuario.surname = this.TxApellidos.Text;
                this.usuario.email = this.TxEmail.Text;
                this.manager.SaveChanges();
                this.LbPopMensaje.Text = "Datos guardados correctamente.";
                this.PopUpMensaje.Show();
            }
            catch 
            {
                this.LbPopMensaje.Text = "Error al guardar los datos.";
                this.PopUpMensaje.Show();
            }

        }

        protected void BtLoginUsuario_Click(object sender, EventArgs e)
        {
            if (this.TxPasswdActual.Text.Equals(this.usuario.pass) == true)
            {
                if (string.IsNullOrEmpty(this.TxPasswdActual.Text) == true ||
                    string.IsNullOrEmpty(this.TxPasswd1.Text) == true ||
                    string.IsNullOrEmpty(this.TxPasswd2.Text) == true)
                {
                    this.LbPopMensaje.Text = "Debe rellenar correctamente todos los campos de contraseña.";
                    this.PopUpMensaje.Show();
                }
                else
                {
                    if (this.TxPasswd1.Text == this.TxPasswd2.Text)
                    {
                        this.usuario.pass = this.TxPasswd1.Text;
                        this.manager.SaveChanges();
                        this.LbPopMensaje.Text = "Contraseña modificada correctamente.";
                        this.PopUpMensaje.Show();
                    }
                    else
                    {
                        this.LbPopMensaje.Text = "El password de verificación no coincide con el nuevo password.";
                        this.PopUpMensaje.Show();
                    }
                }
            }
            else
            {
                this.TxPasswdActual.Text = null;
                this.TxPasswd1.Text = null;
                this.TxPasswd2.Text = null;
                this.LbPopMensaje.Text = "La contraseña actual no es correcta";
                this.PopUpMensaje.Show();
            }
        }
    }
}