<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ManagerDB.Pages.Home" MasterPageFile="~/master/main.master" %>

<asp:Content ContentPlaceHolderID="ContentProgram" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>
                    INICIO
                </h1>
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h3>MIS LIGAS (ACTIVAS)</h3>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                <asp:DataGrid ID="GrLigas" runat="server" AutoGenerateColumns="false" Width="100%" OnItemCommand="GrLigas_ItemCommand" 
                            ShowHeader="true" 
                            CssClass="grid"
                            HeaderStyle-CssClass="grid_header" 
                            ItemStyle-CssClass="grid_row" 
                            AlternatingItemStyle-CssClass="grid_alternate_row"
                            >
                    <Columns>
                        <asp:BoundColumn DataField="user_id" HeaderText="user_id" Visible="false"></asp:BoundColumn>
                        <asp:BoundColumn DataField="league_id" HeaderText="league_id" Visible="false"></asp:BoundColumn>
                        <asp:ButtonColumn DataTextField="league_name" HeaderText="Liga" CommandName="VerLiga"></asp:ButtonColumn>
                        <asp:ButtonColumn DataTextField="team_name" HeaderText="Nombre equipo" CommandName="VerUsuarioLiga"></asp:ButtonColumn>
                        <asp:BoundColumn DataField="faction_name" HeaderText="Facción"></asp:BoundColumn>
                        <asp:BoundColumn DataField="kills" HeaderText="Asesinatos" ItemStyle-Width="70px"></asp:BoundColumn>
                        <asp:BoundColumn DataField="vp" HeaderText="P.Misión" ItemStyle-Width="70px"></asp:BoundColumn>
                        <asp:BoundColumn DataField="losses" HeaderText="Derrotas" ItemStyle-Width="70px"></asp:BoundColumn>
                        <asp:BoundColumn DataField="draws" HeaderText="Empates" ItemStyle-Width="70px"></asp:BoundColumn>
                        <asp:BoundColumn DataField="wins" HeaderText="Victorias" ItemStyle-Width="70px"></asp:BoundColumn>
                        <asp:BoundColumn DataField="score" HeaderText="Puntuación" ItemStyle-Width="70px"></asp:BoundColumn>
                    </Columns>
                </asp:DataGrid>
                <asp:Label runat="server" style="color:#ffd800;" Text="No participa en ninguna liga" ID="_LbNoLiga" Visible="false"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                <h3>ULTIMOS MENSAJES RECIBIDOS</h3>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                <asp:DataGrid ID="GrMensajes" runat="server" AutoGenerateColumns="false" Width="100%"
                            ShowHeader="true" 
                            CssClass="grid"
                            HeaderStyle-CssClass="grid_header" 
                            ItemStyle-CssClass="grid_row" 
                            AlternatingItemStyle-CssClass="grid_alternate_row"
                            OnItemCommand="GrMensajes_ItemCommand">
                    <Columns>
                        <asp:BoundColumn DataField="league_id" HeaderText="league_id" Visible="false"></asp:BoundColumn>
                        <asp:TemplateColumn HeaderText="Usuario" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="75px" ItemStyle-VerticalAlign="Top">
                            <ItemTemplate>
                                <asp:ImageButton runat="server" id="_imgUsuario" ImageUrl='<%# Eval("user_from_avatar_url") %>' Width="75px" 
                                                 CommandArgument='<%# Eval("message_id") %>'
                                                 CommandName="VerJugador" />
                                <br />
                                <strong><asp:Label runat="server" ID="_lbUsuarioNombre" Text='<%# Eval("user_from_name") %>' Font-Size="X-Small"></asp:Label></strong>
                                <br />
                                <asp:Label runat="server" ID="_LbFecha" Font-Italic="true" Font-Size="X-Small" Text='<%# Convert.ToDateTime(Eval("sent_date")).ToShortDateString() %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn ItemStyle-VerticalAlign="Top" HeaderText="Mensaje">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="Label1" Text='<%# Eval("league_name") %>' 
                                                CommandName="VerLiga" 
                                                CommandArgument='<%# Eval("league_id") %>'></asp:LinkButton>
                                -
                                <strong>
                                <asp:Label runat="server" ID="_LbTitulo" Text='<%# Eval("subject") %>' ForeColor="#ffffff"></asp:Label>
                                </strong>
                                <br />
                                <asp:Label runat="server" ID="_LbMessage" Text='<%# Eval("message") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
                <asp:Label runat="server" style="color:#ffd800;" Text="No hay mensajes" ID="_LbNoMensajes" Visible="false"></asp:Label>
            </div>
        </div>

    <!-- Modo manual (placeholder) -->
        <div class="row">
            <div class="col-md-8">
                <asp:PlaceHolder ID = "Ligas" runat="server" />
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-8">
                <asp:PlaceHolder ID = "UltimosMensajes" runat="server" />
            </div>
        </div>

        <br />
    </div>
</asp:Content>