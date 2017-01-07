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
    <asp:Panel ID="PnlPopUp" runat="server" CssClass="PopUp" style="display:none; max-width:600px; width:80%; height: 400px; overflow:hidden">
        <h2 style="background-color:#a47c05; color:#35322C; margin-top:0">
            <asp:Image runat="server" id="ImgFaction" style="width:40px" />
            <asp:Label runat="server" ID="LbFactionName" style="vertical-align:text-bottom"></asp:Label>
        </h2>
        <div style="overflow-y:scroll; height: 300px; padding:10px">
            <asp:Button ID="btnClose" CssClass="ClosePopUp" runat="server" Text="X" />
            <asp:Label runat="server" ID="LbFactionInfo"></asp:Label>
        </div>
    </asp:Panel>

</asp:Content>