using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;


namespace ManagerDB.Pages
{
    public class BasicPage : System.Web.UI.Page
    {

        /// <summary>
        /// Conexión y contexto para el acceso a datos
        /// </summary>
        protected MANAGERDBEntities manager
        {
            get
            {
                MANAGERDBEntities _mng = null;
                try
                {
                    _mng = (MANAGERDBEntities)this.Session["Manager"];
                    if (_mng.Database.Connection.State != System.Data.ConnectionState.Open)
                    {
                        _mng.Database.Connection.Open();
                    }
                }
                catch 
                {
                    _mng = new MANAGERDBEntities();
                }
                return _mng;
            }
            set
            {
                this.Session["Manager"] = value;
            }
        }

        /// <summary>
        /// Datos del usuario
        /// </summary>
        protected t_users usuario
        {
            get
            {
                return (t_users)this.Session["User"];
            }
            set
            {
                this.Session["User"] = value;
            }
        }

        /// <summary>
        /// Valida si los datos del entorno estan correctamente definidos o no.
        /// </summary>
        /// <returns>
        /// True si se permite el acceso a páginas, false en caso contrario.
        /// </returns>
        public bool ValidateSession()
        {
            if (this.Session != null &&
                this.Page.User.Identity.IsAuthenticated == true &&
                this.manager != null ||
                this.usuario != null )
            {
                return true;
            }
            return false;
        }

    }
}