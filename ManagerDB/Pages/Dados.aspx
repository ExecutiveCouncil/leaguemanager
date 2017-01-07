<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dados.aspx.cs" Inherits="ManagerDB.Pages.Dados"  MasterPageFile="~/master/main.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="Container">
        <br />
        <div class="row">
            <div class="col-md-1 col-sm-1"></div>
            <div class="col-md-3 col-sm-11" style="padding: 30px;">
                <asp:Label ID="lblLiga" runat="server" CssClass="cabecera">Liga: </asp:Label>
            </div>
            <div class="col-md-3 col-sm-11" style="padding: 30px;">
                <asp:Label ID="lblRonda" runat="server" CssClass="cabecera">Ronda: </asp:Label>
            </div>    
            <div class="col-md-5 col-sm-11">
                <div class="col-md-3 col-sm-12"></div>
                <div class="col-md-4 col-sm-12" style="padding: 30px;">
                    <asp:Label ID="lblCreditos" runat="server" CssClass="cabecera"></asp:Label>
                </div>   
                <div class="col-md-4 col-sm-12" style="padding: 30px;">
                    <asp:Label ID="lblMateriales" runat="server" CssClass="cabecera"></asp:Label>
                </div>   
            </div>
        </div>
        <div class="row">
            <div class="box" style="width:80%; max-width:100%; padding: 10px; margin-top:25px;">
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
            </div>
        </div>   
        <div class="row">
            <div class="box" style="width:80%; max-width:100%; padding: 10px; margin-top:25px;">
                <div class="row">
                    <div style="padding-left: 30px">
                        <label id="tituloUsuarios" class="titulo">Dados del resto de participantes:</label>            
                    </div>
                </div>
                <br />
                <asp:Repeater runat="server" ID="RptDatosUsuarios" OnItemDataBound="RptDatosUsuarios_ItemDataBound">
                    <ItemTemplate>
                        <div style="padding-left: 30px;width:60px">
                            <%--<asp:Image runat="server" ID="ImgUser"
                                            Width="45px"
                                            ToolTip='<%# Eval("user_name") %>'
                                            AlternateText='<%# Eval("user_name") %>'
                                            ImageUrl= '<%# "../images/t_dices/mercs/" + Eval("img_Dice").ToString().Trim() %>'>
                                        </asp:Image>--%>
                            <asp:Label id="user" Text='<%# Eval("user_name") %>' runat="server"></asp:Label>
                        </div>
                        <div style="padding-left: 30px">
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
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
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
        <%--<iframe src="./PopDadosBasic.aspx" style="border:none;width:100%"></iframe>--%>
        <div class="box" style="width:80%; max-width:100%; padding: 10px; margin-top:25px;">            
            <div style="padding-left: 30px">
                <div class="row">
                        <asp:RadioButton id="optCreditos" GroupName="UsarDado" Text="" runat="server"/>
                    </div>
                <div class="row">
                    <asp:RadioButton id="optMateriales" GroupName="UsarDado" Text="" runat="server"/>
                </div>
                <div class="row">
                    <asp:RadioButton id="optUsar" GroupName="UsarDado" Text="Usar" runat="server"/>
                </div>
                <div class="row">
                    <asp:TextBox ID="txtUsar" runat="server" Height="100px" TextMode="MultiLine" Width="90%"></asp:TextBox>
                </div>
                <div class="row" style="text-align:center">
                    <asp:Button CssClass="btn" id="btnUsarDado" runat="server" 
                                oncommand="btnUsarDado_Command" text="Usar" 
                                style="vertical-align:text-bottom; margin-left:30px"
                                ToolTip="Usar dado" Width="100px"></asp:Button>
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
