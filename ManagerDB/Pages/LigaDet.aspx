<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LigaDet.aspx.cs"
    Inherits="ManagerDB.Pages.LigaDetAspx" MasterPageFile="~/master/main.master" %>

<asp:Content ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
            </div>
        </div>
        <br /><br />
        <h3>
        <asp:DropDownList runat="server" ID="DrpLigas" AutoPostBack="true" CssClass="dropdown"
            style="min-width:350px"
            OnSelectedIndexChanged="DrpLigas_SelectedIndexChanged"></asp:DropDownList>
        </h3>
        <br />
        <h3><asp:Label runat="server" ID="LbClasif" Text="CLASIFICACION"></asp:Label></h3>
        <br />
        <asp:DataGrid ID="GrJugadores" runat="server" AutoGenerateColumns="false" Width="100%" 
                    OnItemCommand="GrClasificacion_ItemCommand" 
                    OnItemDataBound="GrJugadores_ItemDataBound"
                    ShowHeader="true" 
                    CssClass="grid"
                    HeaderStyle-CssClass="grid_header" 
                    ItemStyle-CssClass="grid_row" 
                    AlternatingItemStyle-CssClass="grid_alternate_row"
                    >
            <Columns>
                <asp:BoundColumn DataField="user_id" HeaderText="user_id" Visible="false"></asp:BoundColumn>
                <asp:BoundColumn DataField="league_id" HeaderText="league_id" Visible="false"></asp:BoundColumn>
                <asp:BoundColumn DataField="user_name" HeaderText="Jugador"></asp:BoundColumn>
                <asp:BoundColumn DataField="team_name" HeaderText="Equipo"></asp:BoundColumn>
                <asp:BoundColumn DataField="faction_name" HeaderText="Facción"></asp:BoundColumn>
                <asp:BoundColumn DataField="wins" HeaderText="Victorias"></asp:BoundColumn>
                <asp:BoundColumn DataField="losses" HeaderText="Derrotas"></asp:BoundColumn>
                <asp:BoundColumn DataField="draws" HeaderText="Empates"></asp:BoundColumn>
                <asp:BoundColumn DataField="score" HeaderText="Puntos"></asp:BoundColumn>
            </Columns>
        </asp:DataGrid>
        <asp:Label runat="server" style="color:#ffd800;" Text="No hay jugadores" ID="_LbNoJugadores" Visible="false"></asp:Label>
        <br />
        <asp:Panel runat="server" ID="PnlBadges">
            <br />
            <h3><asp:Label runat="server" ID="Label1" Text="INSIGNIAS DISPONIBLES"></asp:Label></h3>
            <br />
            <asp:DataGrid ID="GrBadges" runat="server" AutoGenerateColumns="false" Width="100%" 
                        ShowHeader="true" 
                        CssClass="grid"
                        HeaderStyle-CssClass="grid_header" 
                        ItemStyle-CssClass="grid_row" 
                        AlternatingItemStyle-CssClass="grid_alternate_row"
                        >
                <Columns>
                    <asp:BoundColumn DataField="title_id" Visible="false"></asp:BoundColumn>
                    <asp:BoundColumn DataField="badge_id" Visible="false"></asp:BoundColumn>
                    <asp:TemplateColumn HeaderText="">
                        <ItemTemplate>
                            <asp:Image runat="server" ImageUrl='<%# Eval("badge_url") %>' Width="45px" ToolTip='<%# Eval("badge_name") %>' CssClass="imagenDados" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:BoundColumn DataField="title_name" HeaderText="Título" HeaderStyle-Font-Bold="true" ItemStyle-Width="220px"></asp:BoundColumn>
                    <asp:BoundColumn DataField="title_info" HeaderText="Reglas" ></asp:BoundColumn>
                </Columns>
            </asp:DataGrid>

            <asp:Label runat="server" style="color:#ffd800;" Text="No hay insignias" ID="_LbNoBadges" Visible="false"></asp:Label>
        </asp:Panel>

        <br /><br />

    </div>
</asp:Content>