<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Factions.aspx.cs"
    Inherits="ManagerDB.Pages.FactionsAspx" MasterPageFile="~/master/main.master" %>

<asp:Content ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
            </div>
        </div>
        <br /><br />
        <h3>
        Facciones
        <asp:DropDownList runat="server" ID="DrpGames" AutoPostBack="true" CssClass="dropdown"
            OnSelectedIndexChanged="DrpGames_SelectedIndexChanged"></asp:DropDownList>

        </h3>
        <br /><br />
        <asp:Repeater runat="server" ID="RptFactions" OnItemCommand="RptFactions_ItemCommand">
            <ItemTemplate>
                <div style="float:left; margin:5px">
                    <asp:ImageButton runat="server" ID="ImgFaction" CssClass="img_button"
                        Width="100px"
                        ToolTip='<%# Eval("name") %>'
                        AlternateText='<%# Eval("name") %>'
                        ImageUrl= '<%# "../images/" + Eval("avatar_url").ToString().Trim() %>'
                        CommandName="ViewFaction"
                        CommandArgument='<%# Eval("id") %>' >
                    </asp:ImageButton>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- Popup -->
    <asp:Button ID="btnShow" runat="server" Text="Show Modal Popup" style="display:none"/>
    <ajax:ModalPopupExtender ID="PopUpFaction" runat="server" PopupControlID="PnlPopUp" TargetControlID="btnShow"
        CancelControlID="btnClose" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>
    <asp:Panel ID="PnlPopUp" runat="server" CssClass="PopUp" style="display:none">
        <asp:Button ID="btnClose" CssClass="ClosePopUp" runat="server" Text="X" />
        <div class="col-md-4">
            <h2>
                <img src="../images/t_game_factions/mercs/ccc.jpg" style="width:40px" />
                <asp:Label runat="server" ID="LbFactionName"></asp:Label>
            </h2>
            <asp:Label runat="server" ID="LbFactionInfo"></asp:Label>
        </div>
    </asp:Panel>

</asp:Content>