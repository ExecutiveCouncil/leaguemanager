<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dados.aspx.cs" Inherits="ManagerDB.Pages.Dados"  MasterPageFile="~/master/main.master" %>

<asp:Content ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="container">
        
        <div class="row">
            <div class="col-md-12">
                <h1>
                    <asp:ImageButton runat="server" ID="BtBack" 
                                     ImageUrl="~/images/webapp/back.png" OnClientClick="goBack();" 
                                     CssClass="image_button" Width="45px" 
                                     style="vertical-align:text-top;"/>
                    <asp:Label runat="server" ID="_LbTitle" Text="DADOS DE INFLUENCIA"></asp:Label>
                </h1>
                <hr />
            </div>
        </div>
        <br />

        <div class="row">
            <div class="col-md-12">
                <h3>
                    <asp:Label ID="lblLiga" runat="server" >Liga: </asp:Label>
                </h3>
                <br />

                <div class="div_box" style="margin-right: 10px; width: 200px; float:left">
                    <asp:Label ID="lblRonda" runat="server" CssClass="cabecera"></asp:Label>
                </div>

                <div class="div_box" style="margin-right: 10px; width: 200px; float:left">
                    <asp:Label ID="lblCreditos" runat="server" CssClass="cabecera"></asp:Label>
                </div>

                <div class="div_box" style="margin-right: 10px; width: 200px; float:left">
                    <asp:Label ID="lblMateriales" runat="server" CssClass="cabecera"></asp:Label>
                </div>

            </div>
        </div>

        <br /><br />
        <h3>MIS DADOS</h3>
        <div class="row">
            <div class="col-md-12">
                <asp:Panel runat="server" ID="PnlDados" CssClass="div_box">
                    <asp:Repeater runat="server" ID="RptDices" OnItemCommand="RptDices_ItemCommand">
                        <ItemTemplate>
                                <asp:ImageButton runat="server" ID="ImgDice"
                                    Width="60px"
                                    CssClass="dado"
                                    ToolTip='<%# Eval("info") %>'
                                    AlternateText='<%# Eval("die_type_name") %>'
                                    ImageUrl= '<%# Eval("img_Dice").ToString().Trim() %>'
                                    CommandName="RollDice"
                                    CommandArgument='<%# Eval("id") %>'>
                                </asp:ImageButton>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Button CssClass="btn" id="rollButton" runat="server" 
                                OnCommand="rollButton_Command" text="Tirar dados" 
                                style="vertical-align:text-bottom; float:right; margin-left:15px"
                                ToolTip="Tirada completa" Width="150px"></asp:Button>

                    <asp:Button CssClass="btn" id="btnVerMiHistorial" runat="server"
                                text="Historial" 
                                style="vertical-align:text-bottom; float:right; margin-left:15px"
                                OnCommand="btnVerHistorial_Command"
                                ToolTip="Ver historial de las tiradas de dados" Width="150px"></asp:Button>                


                </asp:Panel>
                <asp:Label runat="server" style="color:#ffd800;" Text="Sin dados asignados" ID="_LbNoDadosAsignados" Visible="false"></asp:Label>
            </div>
        </div>   
        <br /><br />
        <h3>DADOS DEL RESTO DE PARTICIPANTES</h3>
        <div class="row">
            <div class="col-md-12">
                <asp:Panel runat="server" id="PnlDadosUsuarios" CssClass="div_box" Visible="false" >
                    <asp:Repeater runat="server" ID="RptDatosUsuarios" OnItemDataBound="RptDatosUsuarios_ItemDataBound" OnItemCommand="RptDatosUsuarios_ItemCommand">
                        <ItemTemplate>
                            <asp:Table runat="server" Width="100%">
                                <asp:TableRow>
                                    <asp:TableCell Width="45px" Height="60px" HorizontalAlign="Center">
                                        <asp:ImageButton runat="server" ID="ImgUser"
                                                        CommandName="VerUsuarioLiga" 
                                                        CommandArgument='<%# Eval("id_user_league") %>'
                                                        Width="45px"
                                                        ToolTip='<%# Eval("user_name") %>'
                                                        AlternateText='<%# Eval("user_name") %>'
                                                        ImageUrl= '<%# this.PATH_IMAGES + Eval("user_avatar").ToString().Trim() %>'>
                                                    </asp:ImageButton>
                                    </asp:TableCell>
                                    <asp:TableCell VerticalAlign="Middle" Width="75px">
                                        <asp:LinkButton id="user" Text='<%# Eval("user_name") %>' runat="server" CommandName="VerUsuarioLiga" CommandArgument='<%# Eval("id_user_league") %>'></asp:LinkButton>
                                    </asp:TableCell>
                                    <asp:TableCell VerticalAlign="Middle">
                                        <asp:Repeater runat="server" ID="RptDadosUsuarios">
                                            <ItemTemplate>                                    
                                                    <asp:Image runat="server" ID="ImgUserDice"
                                                        Width="45px"
                                                        ToolTip='<%# Eval("info") %>'
                                                        AlternateText='<%# Eval("die_type_name") %>'
                                                        ImageUrl= '<%# Eval("img_Dice").ToString().Trim() %>'>
                                                    </asp:Image>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right" Width="160px">
                                        <asp:Button CssClass="btn" id="btnVerHistorial" runat="server"
                                                    text="Historial" 
                                                    CommandName="VerHistorialUsuario" CommandArgument='<%# Eval("id_user_league") %>'
                                                    ToolTip="Ver historial de las tiradas de dados" Width="150px"></asp:Button>                
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div style="text-align:right">
                    </div>
                </asp:Panel>
                <asp:Label runat="server" style="color:#ffd800;" Text="No hay datos de otros usuarios" ID="_LbNoDadosUsuarios" Visible="false"></asp:Label>
            </div>
        </div>

    </div>

    <!-- Popup -->
    <asp:Button ID="btnShow" runat="server" Text="Show Modal Popup" style="display:none"/>
    <ajax:ModalPopupExtender ID="PopUpDado" runat="server" PopupControlID="PnlPopUp" TargetControlID="btnShow"
        CancelControlID="btnClose" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>
    <asp:Panel ID="PnlPopUp" runat="server" CssClass="PopUp" style="display:none">
        <asp:Button ID="btnClose" CssClass="ClosePopUp" runat="server" Text="X" />
        <asp:Label runat="server" ID="LbTitulo" CssClass="TitlePopUp" Text="UTILIZAR DADO DE RECURSOS" ></asp:Label>

        <%--<iframe src="./PopDadosBasic.aspx" style="border:none;width:100%"></iframe>--%>
        <div class="div_box">            
            <div>
                <br />
                <table style="width:100%">
                    <tr>
                        <td style="width:55px; vertical-align:top; text-align:left">
                            <asp:Image runat="server" ID="ImgDadoUsar" Width="45px" />
                        </td>
                        <td>
                            <asp:Label runat="server" ID="LbNombreDado" Font-Bold="true" ForeColor="#e3e3e3"></asp:Label><br />
                            <asp:Label runat="server" ID="LbInfoDado"></asp:Label>
                        </td>
                    </tr>
                </table>                        
                <br />
                <div class="row" style="margin-left:25px">
                    <asp:RadioButton id="optMateriales" GroupName="UsarDado" Text="" runat="server"/>
                </div>
                <div style="margin-left:25px">
                    <asp:RadioButton id="optCreditos" GroupName="UsarDado" Text="" runat="server"/>
                </div>
                <div style="margin-left:25px">
                    <asp:RadioButton id="optUsar" GroupName="UsarDado" Text="" runat="server"/>
                </div>
                <div style="margin-left:25px">
                    <asp:Label runat="server" ID="LbObservaciones" Text="Notas para el admin (P.ej: jugador objetivo)"></asp:Label>
                    <br />
                    <asp:TextBox ID="txtUsar" runat="server" Height="100px" TextMode="MultiLine" Width="90%"></asp:TextBox>
                </div>
                <br />
                <div style="text-align:center">
                    <asp:Button CssClass="btn" id="btnUsarDado" runat="server" 
                                oncommand="btnUsarDado_Command" text="Aceptar" 
                                Width="150px"></asp:Button>
                    <asp:Button CssClass="btn" id="BtCancelar" runat="server" 
                                text="Cancelar" style="margin-left:15px"
                                Width="150px"></asp:Button>
                </div>
            </div>
        </div>
    </asp:Panel>
    
    <asp:Button ID="btnOculto" runat="server" Text="" style="display:none"/>
    <ajax:ModalPopupExtender ID="PopUpHistorial" runat="server" PopupControlID="PnlHistorico" TargetControlID="btnOculto"
        CancelControlID="btnCloseHistorico" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>
    <asp:Panel ID="PnlHistorico" runat="server" CssClass="PopUp" style="display:none; height:50vh; width:70vw">
        <asp:Button ID="btnCloseHistorico" CssClass="ClosePopUp" runat="server" Text="X" />
        <asp:Label runat="server" ID="LblHistorial" CssClass="TitlePopUp" Text="---" ></asp:Label>
        <div class="div_box" style="height:100%; width:100%; overflow:auto">            
            <table style="width:100%">
            <tr>
                <th style="height:2em; font-weight:bold; color:#e3e3e3">JUGADOR</th>
                <th style="height:2em; font-weight:bold; color:#e3e3e3">RONDA</th>
                <th style="height:2em; font-weight:bold; color:#e3e3e3">DADOS</th>
            </tr>
                <asp:Repeater runat="server" ID="RptHistorialUsuarios" OnItemDataBound="RptHistorialUsuarios_ItemDataBound">
                    <ItemTemplate>
                        <tr>
                            <td style="width:80px; height:30px;">
                                <asp:Label id="user" Text='<%# Eval("user_name") %>' runat="server"></asp:Label>  
                            </td>
                            <td style="width:60px; text-align:center">
                                <asp:Label id="Label1" Text='<%# Eval("round") %>' runat="server"></asp:Label>  
                            </td>
                            <td>
                                <asp:Repeater runat="server" ID="RptHistorialDadosUsuarios">
                                    <ItemTemplate>                                    
                                            <asp:Image runat="server" ID="ImgUserDice"
                                                Width="25px"
                                                style="margin-right:5px; float:left"
                                                ToolTip='<%# Eval("info") %>'
                                                AlternateText='<%# Eval("info") %>'
                                                ImageUrl= '<%# Eval("img_Dice").ToString().Trim() %>'>
                                            </asp:Image>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div style="clear:both"></div>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>
    </asp:Panel>
 
</asp:Content>
