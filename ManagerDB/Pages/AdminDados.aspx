<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDados.aspx.cs" Inherits="ManagerDB.Pages.AdminDadosAspx"  MasterPageFile="~/master/main.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="container">

        <div class="row">
            <div class="col-md-12">
                <h1>
                    <asp:ImageButton runat="server" ID="BtBack" 
                                     ImageUrl="~/images/webapp/back.png" OnClientClick="goBack();" 
                                     CssClass="image_button" Width="45px" 
                                     style="vertical-align:text-top;"/>
                    <asp:Label runat="server" ID="_LbTitle" Text="ADMINISTRAR RONDA DE JUEGO MERCS"></asp:Label>
                </h1>
                <hr />
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                <h3>
                    <asp:Label ID="lblLiga" runat="server" ></asp:Label>
                    -
                    <asp:Label ID="lblRonda" runat="server"></asp:Label>
                </h3>
                <br />
                <div style="text-align:right" class="div_box">
                    <asp:Button CssClass="btn" id="btnAddTurno" runat="server" 
                                            OnCommand="btnAddTurno_Command" text="Nueva ronda" 
                                            style="width:150px;"
                                            ToolTip="Pasa la liga al siguiente turno" Width="150px"></asp:Button> 
                </div>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                <h3>
                    <label id="tituloUsuarios">PARTICIPANTES</label>            
                </h3>
                <asp:Repeater runat="server" ID="RptDatosUsuarios" OnItemDataBound="RptDatosUsuarios_ItemDataBound">
                    <ItemTemplate>
                        <div class="div_box">
                            <asp:Table runat="server" Width="100%">
                            <asp:TableRow>
                                <asp:TableCell RowSpan="2" Width="60px" HorizontalAlign="Center">
                                    <asp:Image runat="server" ID="ImgUser"
                                                Width="45px"
                                                ToolTip='<%# Eval("user_name") %>'
                                                AlternateText='<%# Eval("user_name") %>'
                                                ImageUrl= '<%# this.PATH_IMAGES + Eval("user_avatar").ToString().Trim() %>'>
                                    </asp:Image>
                                    <br />
                                    <asp:Label id="user" Text='<%# Eval("user_name") %>' runat="server"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell style="padding-left:5px" VerticalAlign="Middle" Width="100px">
                                    <asp:Label id="creditos" Text='<%# Eval("textoCreditos") %>' runat="server" ForeColor="#a47c05"></asp:Label>
                                    <br />
                                    <asp:Label id="materiales" Text='<%# Eval("textoMateriales") %>' runat="server" ForeColor="#a47c05"></asp:Label>                           
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Repeater runat="server" ID="RptDadosUsuarios" OnItemCommand="RptDadosUsuarios_ItemCommand">
                                        <ItemTemplate>                                    
                                            <asp:ImageButton runat="server" ID="ImgDice"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='<%# Eval("info") %>'
                                                AlternateText='<%# Eval("info") %>'
                                                ImageUrl= '<%# "../images/t_dices/mercs/" + Eval("img_Dice").ToString().Trim() %>'
                                                CommandName="AdministrarDado"
                                                CommandArgument='<%# Eval("id") %>'>
                                            </asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <asp:ImageButton CssClass="dado" id="btnAddDado" runat="server" 
                                        OnCommand="btnAddDado_Command"  ImageUrl="../images/t_dices/mercs/add.png" 
                                        ToolTip="Añadir un dado" Width="60px"></asp:ImageButton> 
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        </div>
                        <br />
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
    <br /><br />

    <!-- Popup -->
    <asp:Button ID="btnShow" runat="server" Text="Show Modal Popup" style="display:none"/>
    <ajax:ModalPopupExtender ID="PopUpDado" runat="server" PopupControlID="PnlPopUp" TargetControlID="btnShow"
        CancelControlID="btnClose" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>
    <asp:Panel ID="PnlPopUp" runat="server" CssClass="PopUp" style="display:none">
        <asp:Button ID="btnClose" CssClass="ClosePopUp" runat="server" Text="X" />
        <div class="box" style="width:80%; max-width:100%; padding: 10px; margin-top:25px;">            
            <div style="padding-left: 30px">
                <div class="row">                    
                    <asp:RadioButton id="optReroll" GroupName="AdminDado" Text="Reroll" runat="server"/>
                </div>
                <div class="row">
                    <asp:RadioButton id="optAumentarCoste" GroupName="AdminDado" Text="Aumentar coste" runat="server"/>
                    <asp:TextBox ID="txtAumentarCoste" runat="server" Height="23px" Width="30px"  style="margin-left:25px;"></asp:TextBox>
                </div>
                <div class="row">                    
                    <asp:RadioButton id="optEliminar" GroupName="AdminDado" Text="Eliminar dado" runat="server"/>
                </div>
                <div class="row">
                    <asp:TextBox ID="txtMensaje" runat="server" Height="100px" TextMode="MultiLine" Width="90%"></asp:TextBox>
                </div>
                <div class="row" style="text-align:center">
                    <asp:Button CssClass="btn" id="btnUsarDado" runat="server" 
                                oncommand="btnAdminDado_Command" text="Aceptar" 
                                style="vertical-align:text-bottom; margin-left:30px"
                                ToolTip="Usar dado" Width="100px"></asp:Button>
                </div>
            </div>
        </div>
    </asp:Panel>

</asp:Content>
