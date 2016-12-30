﻿using Entidades;
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

        protected int idLiga
        {
            get
            {
                return (int)this.Session["idLiga"];
            }
            set
            {
                this.Session["idLiga"] = value;
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

    }
}