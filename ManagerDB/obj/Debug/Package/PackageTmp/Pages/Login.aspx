<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ManagerDB.Pages.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title></title>    
        <link id="Link1" rel="stylesheet" runat="server" media="screen" href="~/css/style.css" />
        <link href="css/bootstrap.min.css" rel="stylesheet"/>
    </head>
    <body> 
        <script src="js/bootstrap.min.js"></script>
        <div class="container">
            <form id="login" runat="server">
                <div class="row">
                    <div class="center">
                        <asp:Login ID = "Login1" runat = "server" OnAuthenticate= "ValidateUser"></asp:Login>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
