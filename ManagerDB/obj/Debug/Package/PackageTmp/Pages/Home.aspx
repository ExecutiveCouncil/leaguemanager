<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ManagerDB.Pages.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>    
    <div>
        Welcome
        <asp:LoginName ID="LoginName1" runat="server" Font-Bold = "true" />
        <br />
        <br />
        <asp:LoginStatus ID="LoginStatus1" runat="server" />
    </div>
</body>
</html>
