<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ManagerDB.Pages.Home" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title></title>
        <link id="Link1" rel="stylesheet" runat="server" media="screen" href="~/css/style.css" />
        <link href="css/bootstrap.min.css" rel="stylesheet"/>
    </head> 
    <body>
        <form id="home_form" runat="server">
            <script src="js/bootstrap.min.js"></script>
            <div class="container">
                <div class="row">
                    Usuario: <asp:LoginName ID="LoginName1" runat="server" Font-Bold = "true" />
                </div>
                <br />
                <div class="row">
                    <div class="col-md-12">
                        <asp:DataGrid ID="GrLigas" runat="server" AutoGenerateColumns="false" Width="100%" OnItemCommand="GrLigas_ItemCommand">
                            <Columns>
                                <asp:BoundColumn DataField="user_id" HeaderText="user_id" Visible="false"></asp:BoundColumn>
                                <asp:ButtonColumn DataTextField="league_name" HeaderText="Liga" CommandName="VerLiga"></asp:ButtonColumn>
                                <asp:BoundColumn DataField="faction_name" HeaderText="Facción"></asp:BoundColumn>
                                <asp:BoundColumn DataField="team_name" HeaderText="Equipo"></asp:BoundColumn>
                                <asp:BoundColumn DataField="wins" HeaderText="Victorias"></asp:BoundColumn>
                                <asp:BoundColumn DataField="losses" HeaderText="Derrotas"></asp:BoundColumn>
                                <asp:BoundColumn DataField="draws" HeaderText="Empates"></asp:BoundColumn>
                                <asp:BoundColumn DataField="score" HeaderText="Puntos"></asp:BoundColumn>
                            </Columns>
                        </asp:DataGrid>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-12">
                        <asp:DataGrid ID="GrMensajes" runat="server" AutoGenerateColumns="false" Width="100%">
                            <Columns>
                                <asp:BoundColumn DataField="sent_date" HeaderText="Fecha"></asp:BoundColumn>
                                <asp:BoundColumn DataField="league_name" HeaderText="Liga"></asp:BoundColumn>
                                <asp:BoundColumn DataField="user_name_from" HeaderText="Emisor"></asp:BoundColumn>
                                <asp:BoundColumn DataField="subject" HeaderText="Asunto"></asp:BoundColumn>
                                <asp:BoundColumn DataField="message" HeaderText="Mensaje"></asp:BoundColumn>
                            </Columns>
                        </asp:DataGrid>
                    </div>
                </div>

            <!-- Modo manual (placeholder) -->
                <div class="row">
                    <div class="col-md-8">
                        <asp:PlaceHolder ID = "Ligas" runat="server" />
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-8">
                        <asp:PlaceHolder ID = "UltimosMensajes" runat="server" />
                    </div>
                </div>

                <br />
            </div>
        </form>
    </body>
</html>
