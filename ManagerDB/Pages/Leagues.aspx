<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Leagues.aspx.cs" Inherits="ManagerDB.Pages.LeaguesAspx" MasterPageFile="~/master/main.master" %>

<asp:Content ContentPlaceHolderID="ContentProgram" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>
                        LIGAS
                </h1>
                <hr />
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <h3>LIGAS ACTIVAS</h3>
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
                        <asp:TemplateColumn HeaderText="Juego" ItemStyle-Width="150px">
                            <ItemTemplate>
                                <asp:Image runat="server" ImageUrl='<%# Eval("game_url") %>' Width="150px" ToolTip='<%# Eval("game_name") %>' />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Liga" ItemStyle-Width="150px" >
                            <ItemTemplate>
                                <asp:Image runat="server" ImageUrl='<%# Eval("league_url") %>' Width="150px" ToolTip='<%# Eval("league_name") %>' />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Datos" ItemStyle-VerticalAlign="Top">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" id="_LbName" 
                                                Text='<%# Eval("league_name") %>' 
                                                CommandArgument='<%# Eval("league_id") %>'
                                                CommandName="VerLiga"></asp:LinkButton>
                                <br />
                                <asp:Label runat="server" Text='<%# Eval("league_info") %>' Font-Italic="true"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </div>
        </div>
    </div>
</asp:Content>