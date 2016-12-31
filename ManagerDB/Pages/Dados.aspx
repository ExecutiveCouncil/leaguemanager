<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dados.aspx.cs" Inherits="ManagerDB.Pages.Dados"  MasterPageFile="~/master/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="Container">
        <br /><br />
        <div class="row">
            <div class="box" style="width:80%; max-width:100%; padding: 10px;">
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
            </div>
        </div>
        <br /> <br />
        <div class="row">
            <div style="padding-left: 30px">
                <label id="tituloUsuarios" class="">Dados del resto de participantes:</label>            
            </div>
        </div>
        
        <div class="row">
            <asp:Repeater runat="server" ID="RptDatosUsuarios" OnItemDataBound="RptDatosUsuarios_ItemDataBound">
                <ItemTemplate>
                    <div style="padding-left: 30px;width:60px">
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

    <!-- Popup -->
    <asp:Button ID="btnShow" runat="server" Text="Show Modal Popup" style="display:none"/>
    <ajax:ModalPopupExtender ID="PopUpDado" runat="server" PopupControlID="PnlPopUp" TargetControlID="btnShow"
        CancelControlID="btnClose" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="PnlPopUp" runat="server" CssClass="PopUp" style="display:none">
        <asp:Button ID="btnClose" CssClass="ClosePopUp" runat="server" Text="X" />
        <iframe src="./PopDadosBasic.aspx" style="border:none;width:100%"></iframe>
    </asp:Panel>

</asp:Content>
