<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserLeague.aspx.cs" Inherits="ManagerDB.Pages.UserLeagueAspx" MasterPageFile="~/master/main.master" %>

<asp:Content ContentPlaceHolderID="ContentProgram" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>
                    <asp:ImageButton runat="server" ID="BtBack" 
                                     ImageUrl="~/images/webapp/back.png" OnClientClick="goBack();" 
                                     CssClass="image_button" Width="45px" 
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
        <asp:Table runat="server" Width="100%">
            <asp:TableRow>
                <asp:TableCell Width="200px" style="position:relative">
                    <asp:Image runat="server" ID="ImgEquipo" Width="200px" AlternateText="Imagen equipo"/>
                    <asp:ImageButton runat="server" ID="ImgFaccion" class="image_button" 
                                     Width="50px" style="position:absolute; bottom:0; right:0;" 
                                     AlternateText="Faccion" OnClick="ImgFaccion_Click"/>
                </asp:TableCell>
                <asp:TableCell Width="10px"></asp:TableCell>
                <asp:TableCell VerticalAlign="Top">
                    <p class="row">
                        <asp:Label runat="server" ID="Label4" Text="Nombre del equipo"></asp:Label>
                        <asp:TextBox runat="server" Enabled="false" ID="TxNombreEquipo" Text="XXXXXX" Width="100%"></asp:TextBox>
                    </p>
                    <p class="row">
                        <asp:Label runat="server" ID="Label7" Text="Jugador"></asp:Label>
                        <asp:TextBox runat="server" Enabled="false" ID="TxJugador" Text="XXXXXX" Width="100%"></asp:TextBox>
                    </p>
                    <p class="row">
                        <asp:Label runat="server" ID="Label5" Text="Facción utilizada"></asp:Label>
                        <asp:TextBox runat="server" Enabled="false" ID="TxNombreFaccion" Text="XXXXXX" Width="100%"></asp:TextBox>
                    </p>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
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
        <asp:Panel runat="server" id="PnlMensajes" Visible="false">
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
        </asp:Panel>
        <br /><br />

        <!-- Popup -->
        <asp:Button ID="btnShow" runat="server" Text="Show Modal Popup" style="display:none"/>
        <ajax:ModalPopupExtender ID="PopUpFaction" runat="server" PopupControlID="PnlPopUp" TargetControlID="btnShow"
            CancelControlID="btnClose" BackgroundCssClass="modalBackground">
        </ajax:ModalPopupExtender>
        <asp:Panel ID="PnlPopUp" runat="server" CssClass="PopUp" style="display:none; max-width:600px; width:80%; height: 400px; overflow:hidden">
            <h2 style="padding-left:10px; background-color:transparent; color:#ffffff; margin-top:0">
                <asp:Image runat="server" id="ImgFaction" style="width:40px" />
                <asp:Label runat="server" ID="LbFactionName" style="vertical-align:text-bottom"></asp:Label>
            </h2>
            <div style="overflow-y:auto; height: 300px; padding:10px" class="div_box">
                <asp:Button ID="btnClose" CssClass="ClosePopUp" runat="server" Text="X" />
                <asp:Label runat="server" ID="LbFactionInfo"></asp:Label>
            </div>
        </asp:Panel>
    </div>

</asp:Content>