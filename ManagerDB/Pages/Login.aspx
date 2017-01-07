<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ManagerDB.Pages.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title></title>    
        <link href="~/css/bootstrap.min.css" rel="stylesheet"/>
        <link id="Link1" rel="stylesheet" runat="server" media="screen" href="~/css/style.css" />
    </head>
    <body> 
        <div class="container">
            <form id="login" runat="server">
                <div class="row">
                    <div class="center">
                        <asp:Panel ID="Login1" runat="server" style="width: 100%;">
                            <div class="box">
                                <div class="content">
                                    <h1>Autentificación requerida</h1>
                                    <asp:TextBox CssClass="field" placeholder="ID OPERATIVO" id="UserName" runat="server"></asp:TextBox>
                                    <br />
                                    <asp:TextBox CssClass="field" placeholder="CONTRASEÑA" id="Password" runat="server" textmode="Password"></asp:TextBox>
                                    <br />
                                    <asp:Panel runat="server" ID="PnlErrorLogin" Visible="false">
                                        <asp:Label runat="server" ID="_LbErrorLogin" style="color:#ffd800;"></asp:Label>
                                    </asp:Panel>
                                    <br />
                                    <asp:Button CssClass="btn" id="LoginButton" runat="server" OnClick="ValidateUser" text="Acceso"></asp:Button>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
