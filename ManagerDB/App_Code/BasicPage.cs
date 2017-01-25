using Entidades;
using ManagerDB.Clases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using ManagerDB.master;


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
                    if (this.Session["Manager"] != null)
                    {
                        _mng = (MANAGERDBEntities)this.Session["Manager"];
                        if (_mng.Database.Connection.State != System.Data.ConnectionState.Open)
                        {
                            _mng.Database.Connection.Open();
                        }
                    }
                    else
                    {
                        _mng = new MANAGERDBEntities();
                        this.Session["Manager"] = _mng;
                    }
                }
                catch 
                {
                    //ups
                }
                return _mng;
            }
            set
            {
                this.Session["Manager"] = value;
            }
        }

        /// <summary>
        /// Directorio paadre del que cuelgan las imágenes de la web
        /// </summary>
        public string PATH_IMAGES = "../images/";

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

        protected t_leagues liga
        {
            get
            {
                return (t_leagues)this.Session["liga"];
            }
            set
            {
                this.Session["liga"] = value;
            }
        }

        protected mercs_user_dice dadoSeleccionado
        {
            get
            {
                return (mercs_user_dice)this.Session["dadoSeleccionado"];
            }
            set
            {
                this.Session["dadoSeleccionado"] = value;
            }
        }

        protected int? idUsuarioLigaSeleccionado
        {
            get
            {
                return (int?)this.Session["idUsuarioLigaSeleccionado"];
            }
            set
            {
                this.Session["idUsuarioLigaSeleccionado"] = value;
            }
        }
 
        /// <summary>
        /// Valida si los datos del entorno estan correctamente definidos o no.
        /// </summary>
        /// <param name="SecurityLevel">Nivel de seguridad minimo necesario</param>
        /// <returns>
        /// True si se permite el acceso a páginas, false en caso contrario.
        /// </returns>
        public bool ValidateSession(int? SecurityLevel = null)
        {
            if (this.Session != null &&
                //this.Page.User.Identity.IsAuthenticated == true &&
                this.manager != null &&
                this.usuario != null )
            {
                ((ManagerDB.master.main)this.Master).LoggedUser = this.usuario.login;
                ((ManagerDB.master.main)this.Master).ImgUser = this.PATH_IMAGES + this.usuario.avatar_url;

                if (SecurityLevel.HasValue)
                {
                    if (SecurityLevel >= this.usuario.security_level)
                    {
                        return false;
                    }
                }
                return true;
            }
            return false;
        }

        /// <summary>
        /// Obtiene el segundo numerador de una tabla
        /// </summary>
        /// <param name="Manager"></param>
        /// <param name="NombreTabla"></param>
        /// <returns></returns>
        public int GetNextTableId(string NombreTabla)
        {
            int _newValue = 1;
            t_systables _tabla = this.manager.t_systables.Where(w => w.table_name == NombreTabla).FirstOrDefault();
            if (_tabla != null)
            {
                if (_tabla.step.HasValue == false)
                {
                    _tabla.step = 1;
                }

                if (_tabla.next_id.HasValue == false)
                {
                    _tabla.next_id = 1;
                }
                _newValue = _tabla.next_id.Value;
                _tabla.next_id = _tabla.next_id.Value + _tabla.step;
                this.manager.SaveChanges();
            }
            else
            {
                //NO esta dada de alta en numeradores
                _tabla = new t_systables();
                _tabla.next_id = 1;
                _tabla.step = 1;
                _tabla.table_name = NombreTabla;
                this.manager.t_systables.Add(_tabla);
                this.manager.SaveChanges();

                _newValue = 1;
            }

            return _newValue;
        }
        /// <summary>
        /// Obtiene el segundo numerador de una tabla
        /// </summary>
        /// <param name="Manager"></param>
        /// <param name="NombreTabla"></param>
        /// <returns></returns>
        public static int GetNextTableId(MANAGERDBEntities Manager, string NombreTabla)
        {
            int _newValue = 1;
            t_systables _tabla = Manager.t_systables.Where(w => w.table_name == NombreTabla).FirstOrDefault();
            if (_tabla != null)
            {
                if (_tabla.step.HasValue == false)
                {
                    _tabla.step = 1;
                }
                
                if (_tabla.next_id.HasValue == false)
                {
                    _tabla.next_id = 1;
                }
                _newValue = _tabla.next_id.Value;
                _tabla.next_id = _tabla.next_id.Value + _tabla.step;
                Manager.SaveChanges();
            }
            else
            {
                //NO esta dada de alta en numeradores
                _tabla = new t_systables();
                _tabla.next_id = 1;
                _tabla.step = 1;
                _tabla.table_name = NombreTabla;
                Manager.t_systables.Add(_tabla);
                Manager.SaveChanges();
                _newValue = 1;
            }

            return _newValue;
        }


    }
}