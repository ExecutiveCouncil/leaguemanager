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
                                    AlternateText='<%# Eval("info") %>'
                                    ImageUrl= '<%# "../images/t_dices/mercs/" + Eval("img_Dice").ToString().Trim() %>'
                                    CommandName="RollDice"
                                    CommandArgument='<%# Eval("id") %>'>
                                </asp:ImageButton>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Button CssClass="btn" id="rollButton" runat="server" 
                                OnCommand="rollButton_Command" text="Tirar" 
                                style="vertical-align:text-bottom; margin-left:30px;"
                                ToolTip="Tirada completa" Width="100px"></asp:Button>
                    <asp:Button CssClass="btn" id="btnVerHistorial" runat="server"
                                onCommand="btnVerHistorial_Command" text="Ver Historial" 
                                style="vertical-align:text-bottom; margin-left:30px; float:right"
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
                                                        ImageUrl= '<%# "../images/" + Eval("user_avatar").ToString().Trim() %>'>
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
                                                        AlternateText='<%# Eval("info") %>'
                                                        ImageUrl= '<%# "../images/t_dices/mercs/" + Eval("img_Dice").ToString().Trim() %>'>
                                                    </asp:Image>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </ItemTemplate>
                    </asp:Repeater>
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
                <div style="margin-left:25px">
                        <asp:RadioButton id="optCreditos" GroupName="UsarDado" Text="" runat="server"/>
                    </div>
                <div class="row" style="margin-left:25px">
                    <asp:RadioButton id="optMateriales" GroupName="UsarDado" Text="" runat="server"/>
                </div>
                <div style="margin-left:25px">
                    <asp:RadioButton id="optUsar" GroupName="UsarDado" Text="" runat="server"/>
                </div>
                <div style="margin-left:25px">
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
    <asp:Panel ID="PnlHistorico" runat="server" CssClass="PopUp" style="display:none">
        <asp:Button ID="btnCloseHistorico" CssClass="ClosePopUp" runat="server" Text="X" />
        <div>
            <asp:label id="LblHistorial" CssClass="titulo" runat="server">Historial de tiradas en </asp:label>            
        </div>
        <div class="row">
            <asp:Repeater runat="server" ID="RptHistorialUsuarios" OnItemDataBound="RptHistorialUsuarios_ItemDataBound">
                <ItemTemplate>
                    <div style="padding-left: 30px;width:90%;padding-top:10px;">
                        <asp:Label id="user" Text='<%# Eval("user_name") + " ronda " + Eval("round") + ":" %>' runat="server"></asp:Label>  
                        <div>                     
                            <asp:Repeater runat="server" ID="RptHistorialDadosUsuarios">
                                <ItemTemplate>                                    
                                        <asp:Image runat="server" ID="ImgUserDice"
                                            Width="25px"
                                            ToolTip='<%# Eval("info") %>'
                                            AlternateText='<%# Eval("info") %>'
                                            ImageUrl= '<%# "../images/t_dices/mercs/" + Eval("img_Dice").ToString().Trim() %>'>
                                        </asp:Image>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div> 
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </asp:Panel>
 
</asp:Content>
