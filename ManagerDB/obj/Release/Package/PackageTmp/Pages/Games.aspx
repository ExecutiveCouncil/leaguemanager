  <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Games.aspx.cs"
    Inherits="ManagerDB.Pages.GamesAspx" MasterPageFile="~/master/main.master" %>

<asp:Content ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>
                    JUEGOS
                </h1>
            </div>
        </div>
        <hr />
        <h3>
        <asp:DropDownList runat="server" ID="DrpGames" AutoPostBack="true" CssClass="dropdown"
            OnSelectedIndexChanged="DrpGames_SelectedIndexChanged"></asp:DropDownList>
        </h3>

        <asp:Table runat="server" Width="100%">
            <asp:TableRow>
                <asp:TableCell Width="200px">
                    <asp:Image runat="server" ID="ImgGame" Width="200px" />
                </asp:TableCell>
                <asp:TableCell Width="10px"></asp:TableCell>
                <asp:TableCell VerticalAlign="Top">
                    <asp:Label runat="server" ID="_LbInfoGame"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>


        <br /><br />
        <h3><asp:Label runat="server" ID="LbClasif" Text="FACCIONES DISPONIBLES"></asp:Label></h3>
        <br />
        <asp:Repeater runat="server" ID="RptFactions" OnItemCommand="RptFactions_ItemCommand">
            <ItemTemplate>
                <div style="float:left; margin:5px">
                    <asp:ImageButton runat="server" ID="ImgFaction" CssClass="img_button"
                        Width="100px"
                        ToolTip='<%# Eval("name") %>'
                        AlternateText='<%# Eval("name") %>'
                        ImageUrl= '<%# this.PATH_IMAGES + Eval("avatar_url").ToString().Trim() %>'
                        CommandName="ViewFaction"
                        CommandArgument='<%# Eval("id") %>' >
                    </asp:ImageButton>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Label runat="server" style="color:#ffd800;" Text="No hay facciones dadas de alta" ID="_LbNoFactions" Visible="false"></asp:Label>
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

</asp:Content>