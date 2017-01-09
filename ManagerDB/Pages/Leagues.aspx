<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Leagues.aspx.cs" Inherits="ManagerDB.Pages.LeaguesAspx" MasterPageFile="~/master/main.master" %>

<asp:Content ContentPlaceHolderID="ContentProgram" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h3>LIGAS</h3>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                <asp:DataGrid ID="GrLigas" runat="server" AutoGenerateColumns="false" Width="100%" OnItemCommand="GrLigas_ItemCommand" 
                            ShowHeader="true" 
                            CssClass="grid"
                            HeaderStyle-CssClass="grid_header" 
                            ItemStyle-CssClass="grid_row" 
                            AlternatingItemStyle-CssClass="grid_alternate_row"
                            >
                    <Columns>
                        <asp:BoundColumn DataField="league_id" HeaderText="league_id" Visible="false"></asp:BoundColumn>
                        <asp:TemplateColumn HeaderText="" ItemStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Image runat="server" ImageUrl='<%# Eval("game_url") %>' Height="60px" ToolTip='<%# Eval("game_name") %>' />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="" ItemStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Image runat="server" ImageUrl='<%# Eval("league_url") %>' Height="60px" ToolTip='<%# Eval("league_name") %>' />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:ButtonColumn DataTextField="league_name" HeaderText="Liga" CommandName="VerLiga"></asp:ButtonColumn>
                        <asp:BoundColumn DataField="league_start" HeaderText="F.Inicio"></asp:BoundColumn>
                        <asp:BoundColumn DataField="league_end" HeaderText="F.Fin"></asp:BoundColumn>
                    </Columns>
                </asp:DataGrid>
            </div>
        </div>
    </div>
</asp:Content>