<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Factions.aspx.cs"
    Inherits="ManagerDB.Pages.FactionsAspx" MasterPageFile="~/master/main.master" %>

<asp:Content ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>Facciones</h1>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                Selecciona un juego
                <asp:DropDownList runat="server" ID="DrpGames" AutoPostBack="true" CssClass="dropdown"
                    OnSelectedIndexChanged="DrpGames_SelectedIndexChanged"></asp:DropDownList>
            </div>
        </div>
        <br /><br />
        <div class="row">
            <div class="col-md-8">
                <asp:Repeater runat="server" ID="RptFactions" OnItemCommand="RptFactions_ItemCommand">
                    <ItemTemplate>
                        <div style="float:left; margin:5px">
                            <asp:ImageButton runat="server" ID="ImgFaction"
                                Width="240px"
                                ToolTip='<%# Eval("name") %>'
                                AlternateText='<%# Eval("name") %>'
                                ImageUrl= '<%# "../images/" + Eval("avatar_url").ToString().Trim() %>'
                                CommandName="ViewFaction"
                                CommandArgument='<%# Eval("id") %>' >
                            </asp:ImageButton>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="col-md-4">
                <h2>
                    <asp:Label runat="server" ID="LbFactionName"></asp:Label>
                </h2>
                <asp:Label runat="server" ID="LbFactionInfo"></asp:Label>
            </div>
        </div>
        <br /><br />
    </div>
</asp:Content>