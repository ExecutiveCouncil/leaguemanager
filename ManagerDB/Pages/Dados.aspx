<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dados.aspx.cs" Inherits="ManagerDB.Pages.Dados"  MasterPageFile="~/master/main.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="Container">
        <div class="row">
            <div class="col-md-12">
                <asp:Repeater runat="server" ID="RptDices" OnItemCommand="RptDices_ItemCommand">
                    <ItemTemplate>
                        <div style="float:left; margin:5px">
                            <asp:ImageButton runat="server" ID="ImgDice"
                                Width="240px"
                                ToolTip='<%# Eval("name") %>'
                                AlternateText='<%# Eval("name") %>'
                                ImageUrl= '<%# "../images/t_dices/mercs/" + Eval("img_Dice").ToString().Trim() %>'
                                CommandName="RollDice"
                                CommandArgument='<%# Eval("id") %>' >
                            </asp:ImageButton>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
