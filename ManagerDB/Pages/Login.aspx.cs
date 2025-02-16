﻿using Entidades;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;
using System.Data.Linq;

namespace ManagerDB.Pages
{
    public partial class Login : BasicPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void ValidateUser(object sender, EventArgs e)
        {
            this.Session.RemoveAll();
            this._LbErrorLogin.Text = null;
            this.PnlErrorLogin.Visible = true;

            var usuarioRegistrado = this.manager.t_users
                .Where(a => a.login == UserName.Text && 
                       a.active == "Y").FirstOrDefault();
            if (usuarioRegistrado != null)
            {

                if (usuarioRegistrado.pass == Password.Text)
                {
                    usuarioRegistrado.login_errors = 0;
                    this.manager.SaveChanges();

                    base.usuario = usuarioRegistrado;

                    //FormsAuthentication.RedirectFromLoginPage(Login1.UserName, false);
                    Response.Redirect("home.aspx", true);
                }
                else
                {
                    usuarioRegistrado.login_errors++;
                    if (usuarioRegistrado.login_errors >= 5)
                    {
                        usuarioRegistrado.active = "N";
                    }
                    
                    this.manager.SaveChanges();

                    this._LbErrorLogin.Text = "Usuario / Contraseña incorrectos";
                    this.PnlErrorLogin.Visible = true;

                }
            }      
            else
            {
                base.usuario = null;
                var _usuarioError = this.manager.t_users
                    .Where(a => a.login == UserName.Text &&
                           a.active == "Y").FirstOrDefault();
                if (_usuarioError != null)
                {
                    _usuarioError.login_errors++;
                    if (_usuarioError.login_errors >= 5)
                    {
                        _usuarioError.active = "N";
                    }
                    this.manager.SaveChanges();
                }

                this._LbErrorLogin.Text = "Usuario / Contraseña incorrectos";
                this.PnlErrorLogin.Visible = true;
            }

        }

        protected void LoginButton_Command(object sender, CommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "Login":
                    ValidateUser(sender, e);
                    break;
            }
        }
    }
}