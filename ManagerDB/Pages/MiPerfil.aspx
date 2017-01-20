<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MiPerfil.aspx.cs" Inherits="ManagerDB.Pages.MiPerfilAspx" MasterPageFile="~/master/main.master" %>

<asp:Content ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>
                    <asp:ImageButton runat="server" ID="BtBack" 
                                     ImageUrl="~/images/webapp/back.png" OnClientClick="goBack();" 
                                     CssClass="image_button" Width="45px" 
                                     style="vertical-align:text-top;"/>
                    PERFIL
                </h1>
                <hr />
            </div>
        </div>
        <br />
        <asp:Image runat="server" ID="ImgUser" Width="150px"/>
        <br /><br />
        <div class="row">
            <h3>DATOS DE USUARIO</h3>
            <div class="div_box">
                <p class="row">
                    <asp:Label runat="server" ID="Label3" Text="Nombre"></asp:Label>
                    <asp:TextBox runat="server" ID="TxNombre" Width="25%"></asp:TextBox>
                </p>

                <p class="row">
                    <asp:Label runat="server" ID="Label4" Text="Apellidos"></asp:Label>
                    <asp:TextBox runat="server" ID="TxApellidos" Width="80%"></asp:TextBox>
                </p>

                <p class="row">
                    <asp:Label runat="server" ID="Label5" Text="Correo electrónico"></asp:Label>
                    <asp:TextBox runat="server" ID="TxEmail" Width="80%" ></asp:TextBox>
                </p>
                <div style="text-align:right">
                    <asp:Button CssClass="btn" id="BtDatosUsuario" runat="server" text="MODIFICAR" style="width:145px" OnClick="BtDatosUsuario_Click"></asp:Button>
                </div>
                
            </div>
        </div>
        <br /><br />
        <div class="row">
            <h3>ACCESO AL SISTEMA</h3>
            <div class="div_box">
                <p class="row">
                    <asp:Label runat="server" ID="Label6" Text="Usuario"></asp:Label>
                    <asp:TextBox runat="server" Enabled="false" ID="TxUserLogin" Text=""></asp:TextBox>
                </p>
                <p class="row">
                    <asp:Label runat="server" ID="Label2" Text="Contraseña actual"></asp:Label>
                    <asp:TextBox runat="server" ID="TxPasswdActual" TextMode="Password"></asp:TextBox>
                </p>

                <p class="row">
                    <asp:Label runat="server" ID="LbLogin" Text="Nueva contraseña"></asp:Label>
                    <asp:TextBox runat="server" ID="TxPasswd1" TextMode="Password"></asp:TextBox>
                </p>

                <p class="row">
                    <asp:Label runat="server" ID="Label1" Text="Repetir contraseña"></asp:Label>
                    <asp:TextBox runat="server" ID="TxPasswd2" TextMode="Password"></asp:TextBox>
                </p>
                <div style="text-align:right">
                    <asp:Button CssClass="btn" id="BtLoginUsuario" runat="server" text="MODIFICAR" style="width:145px" OnClick="BtLoginUsuario_Click"></asp:Button>
                </div>
                
            </div>
        </div>
        <br /><br />
    </div>

    <!-- Popup -->
    <asp:Button ID="btnShow" runat="server" Text="Show Modal Popup" style="display:none"/>
    <ajax:ModalPopupExtender ID="PopUpMensaje" runat="server" PopupControlID="PnlPopUp" TargetControlID="btnShow"
        CancelControlID="btnClose" BackgroundCssClass="modalBackground" OkControlID="">
    </ajax:ModalPopupExtender>
    <asp:Panel ID="PnlPopUp" runat="server" CssClass="PopUp" style="display:none; width:400px;">
        <div class="div_box" style="padding:10px; text-align:center">
            <asp:Label runat="server" ID="LbTitulo" CssClass="TitlePopUp" Text="MENSAJE DEL SISTEMA" ></asp:Label>
            <asp:Button runat="server" ID="btnClose" CssClass="ClosePopUp" Text="X" />
            <br />
            <asp:Label runat="server" id="LbPopMensaje" Text="" ForeColor="#e3e3e3"></asp:Label>
            <br /><br />
            <asp:Button CssClass="btn" id="BtAceptar" runat="server" text="ACEPTAR" style="width:145px"></asp:Button>
        </div>
    </asp:Panel>


</asp:Content>