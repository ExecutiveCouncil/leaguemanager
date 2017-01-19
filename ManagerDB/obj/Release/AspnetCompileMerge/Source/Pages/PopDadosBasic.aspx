<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PopDadosBasic.aspx.cs" Inherits="ManagerDB.Pages.PopDadosBasic" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link id="StyleBootstrap" rel="stylesheet" runat="server" media="screen" href="~/css/bootstrap.min.css" />
    <link id="StyleCustom" rel="stylesheet" runat="server" media="screen" href="~/css/style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="ScriptManager"></asp:ScriptManager>
        <script type="text/javascript">
            function CloseMe()
            {
                parent.window.document.getElementById("ContentProgram_btnClose").click();
                return false;
            }
        </script>

        <div style="text-align:center">
            hello world!
            <br />
            <asp:Button id="BtConfirmar" runat="server" Text="Confirmar" CssClass="btn" Width="200px" OnClick="BtConfirmar_Click"/>
        </div>
    </form>
</body>
</html>
