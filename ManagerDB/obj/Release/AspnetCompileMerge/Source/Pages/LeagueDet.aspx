<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LeagueDet.aspx.cs"
    Inherits="ManagerDB.Pages.LeagueDetAspx" MasterPageFile="~/master/main.master" %>

<asp:Content ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>
                    <asp:ImageButton runat="server" ID="BtBack" 
                                     ImageUrl="~/images/webapp/back.png" OnClientClick="goBack();" 
                                     CssClass="image_button" Width="45px" 
                                     style="vertical-align:text-top;"/>
                    <asp:Label runat="server" ID="_LbTitle"></asp:Label>
                </h1>
                <hr />
            </div>
        </div>
        <h3>
        <asp:DropDownList runat="server" ID="DrpLigas" AutoPostBack="true" CssClass="dropdown"
            style="min-width:350px"
            OnSelectedIndexChanged="DrpLigas_SelectedIndexChanged"></asp:DropDownList>
        </h3>
        <br />

        <asp:Table runat="server" Width="100%">
            <asp:TableRow>
                <asp:TableCell Width="200px">
                    <asp:Image runat="server" ID="ImgLiga" Width="200px" />
                </asp:TableCell>
                <asp:TableCell Width="10px"></asp:TableCell>
                <asp:TableCell VerticalAlign="Top">
                    <p class="row">
                        <asp:Label runat="server" ID="Label6" Text="Fecha inicio de liga"></asp:Label>
                        <asp:TextBox runat="server" Enabled="false" ID="TxFechaInicio" Text="XXXXXX" Width="100%"></asp:TextBox>
                    </p>
                    <p class="row">
                        <asp:Label runat="server" ID="Label2" Text="Fecha fin de liga"></asp:Label>
                        <asp:TextBox runat="server" Enabled="false" ID="TxFechaFin" Text="XXXXXX" Width="100%"></asp:TextBox>
                    </p>
                    <p class="row">
                        <asp:Label runat="server" ID="Label3" Text="Información adicional"></asp:Label>
                        <asp:TextBox runat="server" Enabled="false" ID="TxInfo" Text="XXXXXX" Width="100%"></asp:TextBox>
                    </p>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>

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
                <asp:ButtonColumn CommandName="VerJugador" DataTextField="user_name" HeaderText="Jugador"></asp:ButtonColumn>
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
        <asp:Panel runat="server" ID="PnlUsuarioLiga" Visible="false" CssClass="div_box" style="text-align:right">            
            <asp:Button CssClass="btn" id="BtAdministrar" runat="server" OnClick="BtAdministrar_Click" Visible="false" text="ADMINISTRAR" Width="150px"></asp:Button>
            <asp:Button CssClass="btn" id="BtLiga" runat="server" OnClick="BtLiga_Click" text="ACCEDER" Width="150px"></asp:Button>
        </asp:Panel>

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
                    <asp:TemplateColumn HeaderText="Insignia" ItemStyle-Width="50px">
                        <ItemTemplate>
                            <asp:Image runat="server" ImageUrl='<%# Eval("badge_url") %>' Width="50px" ToolTip='<%# Eval("badge_name") %>' CssClass="imagenDados" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Título" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <strong>
                            <asp:Label runat="server" ID="_LbNombreTitulo" Text='<%# Eval("title_name") %>' ForeColor="#ffffff"></asp:Label>
                            </strong>
                            <br />
                            <asp:Label runat="server" ID="_LbInfo" Text='<%# Eval("title_info") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>

            <asp:Label runat="server" style="color:#ffd800;" Text="No hay insignias" ID="_LbNoBadges" Visible="false"></asp:Label>
        </asp:Panel>

        <br /><br />

    </div>
</asp:Content>