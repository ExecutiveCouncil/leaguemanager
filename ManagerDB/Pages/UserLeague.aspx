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
        <div class="row">
            <div class="col-md-12">
                <h3>DATOS DEL JUGADOR</h3>
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
                        <asp:Label runat="server" ID="Label7" Text="Nombre del jugador"></asp:Label>
                        <asp:TextBox runat="server" Enabled="false" ID="TxJugador" Text="XXXXXX" Width="100%"></asp:TextBox>
                    </p>
                    <p class="row">
                        <asp:Label runat="server" ID="Label4" Text="Nombre del equipo"></asp:Label>
                        <asp:TextBox runat="server" Enabled="false" ID="TxNombreEquipo" Text="XXXXXX" Width="100%"></asp:TextBox>
                    </p>
                    <p class="row">
                        <asp:Label runat="server" ID="Label5" Text="Facción utilizada"></asp:Label>
                        <asp:TextBox runat="server" Enabled="false" ID="TxNombreFaccion" Text="XXXXXX" Width="100%"></asp:TextBox>
                    </p>
                    <table style="width:100%; margin-top: 20px">
                        <tr>
                            <td style="padding-left: 5px; color: #a47c05; width:145px;">
                                <asp:Label runat="server" ID="Label8" Text="Insignias"></asp:Label>
                            </td>
                            <td style="padding-left: 10px">
                                <asp:Panel runat="server" Visible="false" ID="PnlInsignias">
                                    <asp:Repeater runat="server" ID="RptInsignias">
                                        <ItemTemplate>
                                            <asp:Image runat="server" ID="ImgInsignia" Width="32px"
                                                    ImageUrl= '<%# Eval("title_avatar_url").ToString().Trim() %>'
                                                    ToolTip='<%# Eval("title_name").ToString().Trim() %>' />
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <asp:LinkButton runat="server" id="LnkVerInsignias" Text="Ver todas" style="margin-left: 10px"></asp:LinkButton>
                                </asp:Panel>
                                <asp:Label runat="server" style="color:#ffd800;" Text="Ninguna" ID="_LbNoInsignias" Visible="false"></asp:Label>
                            </td>
                        </tr>
                    </table>
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
            <asp:Button CssClass="btn" id="BtAdminMERCS" runat="server" OnClick="BtAdminMERCS_Click" text="ADMINISTRAR LIGA" Width="200px"></asp:Button>
            <asp:Button CssClass="btn" id="BtInformePartida" runat="server" OnClick="BtRecursosMERCS_Click" text="INFORMAR PARTIDA" Width="200px"></asp:Button>
            <asp:Button CssClass="btn" id="BtRecursosMERCS" runat="server" OnClick="BtRecursosMERCS_Click" text="PANEL DE CONTROL" Width="200px"></asp:Button>
        </asp:Panel>
        <br />

        <asp:Panel runat="server" id="PnlMejoras">
            <div class="row">
                <div class="col-md-12">
                    <h3>MEJORAS ACTIVAS</h3>
                </div>
            </div>
            <br />
            <div class="row">
            <div class="col-md-12">
                <asp:DataGrid ID="GrMejoras" runat="server" AutoGenerateColumns="false" Width="100%"
                            ShowHeader="true" 
                            CssClass="grid"
                            HeaderStyle-CssClass="grid_header" 
                            ItemStyle-CssClass="grid_row" 
                            AlternatingItemStyle-CssClass="grid_alternate_row"
                            OnItemCommand="GrMensajes_ItemCommand">
                    <Columns>
                        <asp:BoundColumn DataField="upgrade_id1" HeaderText="ID" Visible="false"></asp:BoundColumn>
                        <asp:BoundColumn DataField="upgrade_name" HeaderText="Mejora" ItemStyle-Width="150px"></asp:BoundColumn>
                        <asp:BoundColumn DataField="upgrade_rules" HeaderText="Reglas especiales"></asp:BoundColumn>
                    </Columns>
                </asp:DataGrid>
                <asp:Label runat="server" style="color:#ffd800;" Text="No se han realizado mejoras" ID="_LbNoMejoras" Visible="false"></asp:Label>
            </div>
        </div>
        </asp:Panel>

        <br /><br />

        <asp:Panel runat="server" id="PnlTropas">
            <div class="row">
                <div class="col-md-12">
                    <h3>TROPAS RECLUTADAS</h3>
                </div>
            </div>
            <br />
            <div class="row">
            <div class="col-md-12">
                <asp:DataGrid ID="GrTropas" runat="server" AutoGenerateColumns="false" Width="100%"
                            ShowHeader="true" 
                            CssClass="grid"
                            HeaderStyle-CssClass="grid_header" 
                            ItemStyle-CssClass="grid_row" 
                            AlternatingItemStyle-CssClass="grid_alternate_row"
                            OnItemCommand="GrMensajes_ItemCommand">
                    <Columns>
                        <asp:BoundColumn DataField="troop_id" HeaderText="ID" Visible="false"></asp:BoundColumn>
                        <asp:BoundColumn DataField="troop_name" HeaderText="Tropa" ItemStyle-Width="150px"></asp:BoundColumn>
                        <asp:BoundColumn DataField="troop_rules" HeaderText="Reglas especiales"></asp:BoundColumn>
                    </Columns>
                </asp:DataGrid>
                <asp:Label runat="server" style="color:#ffd800;" Text="No hay tropas disponibles" ID="_LbNoTroops" Visible="false"></asp:Label>
            </div>
        </div>
        </asp:Panel>

        <br /><br />

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
        </asp:Panel>
        <br /><br />
    </div>

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

    <!-- Popup -->
    <ajax:ModalPopupExtender ID="PopUpInsignias" runat="server" PopupControlID="PnlPopUpInsignias" TargetControlID="LnkVerInsignias"
        CancelControlID="btnClose" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>
    <asp:Panel ID="PnlPopUpInsignias" runat="server" CssClass="PopUp" style="display:none; max-width:600px; width:80%; overflow:hidden">
        <div style="overflow-y:auto; max-height: 300px; padding:10px" class="div_box">
            <asp:Label runat="server" ID="LbTitulo" CssClass="TitlePopUp" Text="INSIGNIAS" ></asp:Label>
            <asp:Button ID="btnCloseInsignias" CssClass="ClosePopUp" runat="server" Text="X" />
            <table style="width:100%">
            <asp:Repeater runat="server" ID="RptInsigniasAll">
                <ItemTemplate>
                    <tr>
                        <td style="width:40px; height:50px; vertical-align:top;">
                            <asp:Image runat="server" ID="ImgInsignia" Width="32px"
                                    ImageUrl= '<%# Eval("title_avatar_url").ToString().Trim() %>'
                                    ToolTip='<%# Eval("title_name").ToString().Trim() %>' />
                        </td>
                        <td style="vertical-align:top;">
                            <asp:Label runat="server" Text='<%# Eval("title_name").ToString().Trim() %>' Font-Bold="true" ForeColor="#a47c05"></asp:Label>
                            <br />
                            <asp:Label runat="server" Text='<%# Eval("title_info").ToString().Trim() %>'></asp:Label>
                        </td>
                        <td style="width:80px; text-align:right">
                            <asp:Label runat="server" Text='<%# Convert.ToDateTime(Eval("title_date").ToString()).ToShortDateString() %>' Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
            </table>
        </div>
    </asp:Panel>

</asp:Content>