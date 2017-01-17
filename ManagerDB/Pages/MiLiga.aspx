<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MiLiga.aspx.cs" Inherits="ManagerDB.Pages.MiLigaAspx" MasterPageFile="~/master/main.master" %>

<asp:Content ContentPlaceHolderID="ContentProgram" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>
                    <asp:ImageButton runat="server" ID="BtBack" 
                                     ImageUrl="~/images/webapp/back.png" OnClientClick="goBack();" 
                                     CssClass="image_button" Width="40px" 
                                     style="vertical-align:text-top;"/>
                    <asp:Label runat="server" ID="LbTituloLiga"></asp:Label>
                </h1>
                <hr />
            </div>
        </div>
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
        <div class="row">
            <div class="col-md-12">
                <h3>PANEL DE CONTROL</h3>
            </div>
        </div>
        <br />
        <asp:DataGrid ID="GrJugadores" runat="server" AutoGenerateColumns="false" Width="100%" 
                    ShowHeader="true" 
                    CssClass="grid"
                    HeaderStyle-CssClass="grid_header" 
                    ItemStyle-CssClass="grid_row" 
                    AlternatingItemStyle-CssClass="grid_alternate_row">
            <Columns>
                <asp:BoundColumn DataField="user_id" HeaderText="user_id" Visible="false"></asp:BoundColumn>
                <asp:BoundColumn DataField="league_id" HeaderText="league_id" Visible="false"></asp:BoundColumn>
                <asp:BoundColumn DataField="wins" HeaderText="Victorias"></asp:BoundColumn>
                <asp:BoundColumn DataField="losses" HeaderText="Derrotas"></asp:BoundColumn>
                <asp:BoundColumn DataField="draws" HeaderText="Empates"></asp:BoundColumn>
                <asp:BoundColumn DataField="score" HeaderText="Puntos"></asp:BoundColumn>
            </Columns>
        </asp:DataGrid>
        <br />
        <asp:Panel runat="server" ID="PnlUsuarioLigaMERCS" Visible="false" class="div_box" style="text-align:right">
            <asp:Button CssClass="btn" id="BtInformePartida" runat="server" OnClick="BtRecursosMERCS_Click" text="INFORMAR PARTIDA" Width="200px"></asp:Button>
            <asp:Button CssClass="btn" id="BtRecursosMERCS" runat="server" OnClick="BtRecursosMERCS_Click" text="USAR DADOS" Width="150px"></asp:Button>
        </asp:Panel>
        <div class="row">
            <div class="col-md-12">
                <h3>MENSAJES RECIBIDOS</h3>
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
                                                 CommandArgument='<%# Eval("user_from_id") %>'
                                                 CommandName="VerUsuario" />
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