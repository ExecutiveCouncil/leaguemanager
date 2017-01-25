<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserAdmin.aspx.cs" Inherits="ManagerDB.Pages.UserAdmin"  MasterPageFile="~/master/main.master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>
                    <asp:ImageButton runat="server" ID="BtBack" 
                                     ImageUrl="~/images/webapp/back.png" OnClientClick="goBack();" 
                                     CssClass="image_button" Width="45px" 
                                     style="vertical-align:text-top;"/>
                    <asp:Label runat="server" ID="_LbTitle">ADMINISTRACIÓN USUARIOS</asp:Label>
                </h1>
                <hr />
            </div>
        </div>
        <br />
        <h3><asp:Label runat="server" ID="LbUsers" Text="USUARIOS"></asp:Label></h3>
        <br />
        <asp:DataGrid ID="GrUsuarios" runat="server" AutoGenerateColumns="false" Width="100%" 
                    OnItemCommand="GrUsuarios_ItemCommand"
                    ShowHeader="true" 
                    CssClass="grid"
                    HeaderStyle-CssClass="grid_header" 
                    ItemStyle-CssClass="grid_row" 
                    AlternatingItemStyle-CssClass="grid_alternate_row"
                    >
            <Columns>
                <asp:BoundColumn DataField="id" HeaderText="id" Visible="false"></asp:BoundColumn>
                <asp:BoundColumn DataField="numero_socio" HeaderText="Socio"></asp:BoundColumn>
                <asp:ButtonColumn CommandName="Editar" DataTextField="login" HeaderText="Login"></asp:ButtonColumn>
                <asp:BoundColumn DataField="pass" HeaderText="Password"></asp:BoundColumn>
                <asp:BoundColumn DataField="name" HeaderText="Nombre"></asp:BoundColumn>
                <asp:BoundColumn DataField="surname" HeaderText="Apellidos"></asp:BoundColumn>
                <asp:BoundColumn DataField="email" HeaderText="Email"></asp:BoundColumn>
                <asp:BoundColumn DataField="avatar_url" HeaderText="Avatar"></asp:BoundColumn>
                <asp:BoundColumn DataField="info" HeaderText="Info"></asp:BoundColumn>
                <asp:BoundColumn DataField="security_level" HeaderText="Nivel seguridad"></asp:BoundColumn>
                <asp:BoundColumn DataField="active" HeaderText="Activo"></asp:BoundColumn>
                <asp:ButtonColumn CommandName="Eliminar" Text="Eliminar" DataTextField="id" HeaderText="Eliminar"></asp:ButtonColumn>
            </Columns>
        </asp:DataGrid>
        <asp:Label runat="server" style="color:#ffd800;" Text="No hay usuarios" ID="_LbNoUsuarios" Visible="false"></asp:Label>
        <br />
        <asp:Panel runat="server" ID="PnlUsuario" CssClass="div_box" style="text-align:right">            
            <asp:Button CssClass="btn" id="BtAddUser" runat="server" OnClick="BtAddUser_Click" text="NUEVO USUARIO" Width="150px"></asp:Button>
        </asp:Panel>
    </div>

    <!-- Popup -->
    <asp:Button ID="btnShow" runat="server" Text="Show Modal Popup" style="display:none"/>
    <ajax:ModalPopupExtender ID="PopUpUser" runat="server" PopupControlID="PnlPopUp" TargetControlID="btnShow"
        CancelControlID="btnClose" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>
    <asp:Panel ID="PnlPopUp" runat="server" CssClass="PopUp" style="display:none">
        <asp:Button ID="btnClose" CssClass="ClosePopUp" runat="server" Text="X" />
        <div class="box" style="width:80%; max-width:100%; padding: 10px; margin-top:25px;">     
            <asp:Label ID="lblId" runat="server" Visible ="false"></asp:Label>       
            <div style="padding-left: 30px">
                <div class="row"> 
                    <label>Numero de socio: </label>
                    <asp:TextBox ID="txtNSocio" runat="server" Height="23px" Width="30px"  style="margin-left:25px;"></asp:TextBox>
                </div>
                <div class="row" style="text-align:center">
                    <asp:Button CssClass="btn" id="btnGuardar" runat="server" 
                                oncommand="btnGuardar_Command" text="Guardar" 
                                style="vertical-align:text-bottom; margin-left:30px"
                                ToolTip="Guardar usuario" Width="100px"></asp:Button>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>