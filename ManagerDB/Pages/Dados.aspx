<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dados.aspx.cs" Inherits="ManagerDB.Pages.Dados"  MasterPageFile="~/master/main.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="Container">
        <br /><br />
        <div class="row">
            <div class="col-md-11">
                <asp:Repeater runat="server" ID="RptDices" OnItemCommand="RptDices_ItemCommand">
                    <ItemTemplate>
                        <div style="float:left; margin:5px">
                            <asp:ImageButton runat="server" ID="ImgDice"
                                Width="50px"
                                ToolTip='<%# Eval("info") %>'
                                AlternateText='<%# Eval("info") %>'
                                ImageUrl= '<%# "../images/t_dices/mercs/" + Eval("img_Dice").ToString().Trim() %>'
                                CommandName="RollDice"
                                CommandArgument='<%# Eval("id") %>' >
                            </asp:ImageButton>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="col-md-1">
                    <asp:Button CssClass="btn" id="rollButton" runat="server" OnCommand="rollButton_Command" text="Tirar" ToolTip="Tirada completa" ></asp:Button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
