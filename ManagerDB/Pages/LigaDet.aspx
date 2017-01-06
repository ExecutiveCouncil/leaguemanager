<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LigaDet.aspx.cs"
    Inherits="ManagerDB.Pages.LigaDetAspx" MasterPageFile="~/master/main.master" %>

<asp:Content ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
            </div>
        </div>
        <br /><br />
        <h3>
        <asp:DropDownList runat="server" ID="DrpLigas" AutoPostBack="true" CssClass="dropdown"
            style="min-width:350px"
            OnSelectedIndexChanged="DrpLigas_SelectedIndexChanged"></asp:DropDownList>
        </h3>
        <br />
        <h3><asp:Label runat="server" ID="LbClasif" Text="CLASIFICACION"></asp:Label></h3>
        <br />
        <asp:DataGrid ID="GrJugadores" runat="server" AutoGenerateColumns="false" Width="100%" OnItemCommand="GrClasificacion_ItemCommand" 
                    ShowHeader="true" 
                    CssClass="grid"
                    HeaderStyle-CssClass="grid_header" 
                    ItemStyle-CssClass="grid_row" 
                    AlternatingItemStyle-CssClass="grid_alternate_row"
                    >
            <Columns>
                <asp:BoundColumn DataField="user_id" HeaderText="user_id" Visible="false"></asp:BoundColumn>
                <asp:BoundColumn DataField="league_id" HeaderText="league_id" Visible="false"></asp:BoundColumn>
                <asp:BoundColumn DataField="user_name" HeaderText="Jugador"></asp:BoundColumn>
                <asp:BoundColumn DataField="team_name" HeaderText="Equipo"></asp:BoundColumn>
                <asp:BoundColumn DataField="faction_name" HeaderText="Facción"></asp:BoundColumn>
                <asp:BoundColumn DataField="wins" HeaderText="Victorias"></asp:BoundColumn>
                <asp:BoundColumn DataField="losses" HeaderText="Derrotas"></asp:BoundColumn>
                <asp:BoundColumn DataField="draws" HeaderText="Empates"></asp:BoundColumn>
                <asp:BoundColumn DataField="score" HeaderText="Puntos"></asp:BoundColumn>
            </Columns>
        </asp:DataGrid>
        <asp:Label runat="server" style="color:#ffd800;" Text="No hay jugadores" ID="_LbNoJugadores" Visible="false"></asp:Label>

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