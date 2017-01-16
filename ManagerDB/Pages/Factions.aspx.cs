using Entidades;
using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace ManagerDB.Pages
{
    public partial class FactionsAspx : BasicPage
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
                    this.CargarJuegos();
                }
            }
        }

        private void CargarJuegos()
        {

            var _listaJuegos = (from games in this.manager.t_games
                            select new
                              {
                                  game_name = games.name,
                                  game_id = games.id
                              }).ToList();

            this.DrpGames.Items.Clear();
            this.DrpGames.Items.Add(new ListItem("Seleccione un juego", "-1"));
            foreach (var _item in _listaJuegos)
            {
                this.DrpGames.Items.Add(new ListItem(_item.game_name, _item.game_id.ToString()));
            }
            if (this.DrpGames.Items.Count > 1)
            {
                this.DrpGames.SelectedIndex = 1;
                DrpGames_SelectedIndexChanged(null, null);
            }
        }

        protected void DrpGames_SelectedIndexChanged(object sender, EventArgs e)
        {
            //rellenar repeater
            int _id = Convert.ToInt32(this.DrpGames.SelectedValue);
            var _listaFacciones = this.manager.t_game_factions
                .Where(fc => fc.id_game == _id &&
                       fc.id != 0).ToList();

            if (_listaFacciones.Count > 0)
            {
                _LbNoFactions.Visible = false;
                this.RptFactions.DataSource = _listaFacciones;
            }
            else
            {
                _LbNoFactions.Visible = true;
                this.RptFactions.DataSource = null;
            }

            this.RptFactions.DataBind();

        }

        protected void RptFactions_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "ViewFaction":
                    {
                        int _idFaction = Convert.ToInt32(e.CommandArgument);

                        var _faction = this.manager.t_game_factions.Where(fc => fc.id == _idFaction).FirstOrDefault();
                        this.LbFactionInfo.Text = _faction.info;
                        this.LbFactionName.Text = _faction.name;
                        this.ImgFaction.ImageUrl = "../images/" + _faction.avatar_url;
                        this.ImgFaction.ToolTip = _faction.name;
                        this.ImgFaction.AlternateText = _faction.name;
                        this.PopUpFaction.Show();
                        break;
                    }
                default:
                    {
                        this.LbFactionName.Text = null;
                        this.LbFactionInfo.Text = null;
                        break;
                    }
            }
        }
    }
}