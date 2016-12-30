<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dados.aspx.cs" Inherits="ManagerDB.Pages.Dados"  MasterPageFile="~/master/main.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="Container">
        <br /><br />
        <div class="row">
            <div style="padding-left: 30px">
                <asp:Repeater runat="server" ID="RptDices" OnItemCommand="RptDices_ItemCommand">
                    <ItemTemplate>
                            <asp:ImageButton runat="server" ID="ImgDice"
                                Width="60px"
                                CssClass="dado"
                                ToolTip='<%# Eval("info") %>'
                                AlternateText='<%# Eval("info") %>'
                                ImageUrl= '<%# "../images/t_dices/mercs/" + Eval("img_Dice").ToString().Trim() %>'
                                CommandName="RollDice"
                                CommandArgument='<%# Eval("id") %>' >
                            </asp:ImageButton>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Button CssClass="btn" id="rollButton" runat="server" 
                            OnCommand="rollButton_Command" text="Tirar" 
                            style="vertical-align:text-bottom"
                            ToolTip="Tirada completa" Width="100px"></asp:Button>
            </div>
        </div>
    </div>
</asp:Content>
