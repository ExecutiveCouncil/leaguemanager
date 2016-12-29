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
                        <asp:login id="Login1" runat="server" style="width: 100%;">
                            <layouttemplate>
                                <div class="box">
                                    <div class="content">
                                        <h1>Autentificación requerida</h1>
                                        <asp:TextBox CssClass="field" placeholder="ID Operativo" id="UserName" runat="server"></asp:TextBox>
                                        <asp:requiredfieldvalidator id="UserNameRequired" runat="server" controltovalidate="UserName" errormessage="ID Operativo requerido." tooltip="ID Operativo requerido." validationgroup="Login1">*</asp:requiredfieldvalidator>
                                        <br>
                                        <asp:TextBox CssClass="field" placeholder="Contraseña" id="Password" runat="server" textmode="Password"></asp:TextBox>
                                        <asp:requiredfieldvalidator id="PasswordRequired" runat="server" controltovalidate="Password" errormessage="Contraseña requerida." tooltip="Contraseña requerida." validationgroup="Login1">*</asp:requiredfieldvalidator>
                                        <br>
                                        <asp:Button CssClass="btn" id="LoginButton" runat="server" commandname="Login" OnCommand="ValidateUser" text="Acceso" validationgroup="Login1"></asp:Button>
                                        <br>
                                        <asp:literal id="FailureText" runat="server" enableviewstate="False"></asp:literal></div>
                                </div>
                            </layouttemplate>
                        </asp:login>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
