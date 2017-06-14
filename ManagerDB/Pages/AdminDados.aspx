<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDados.aspx.cs" Inherits="ManagerDB.Pages.AdminDadosAspx"  MasterPageFile="~/master/main.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentProgram" runat="server">
    <div class="container">

        <div class="row">
            <div class="col-md-12">
                <h1>
                    <asp:ImageButton runat="server" ID="BtBack" 
                                     ImageUrl="~/images/webapp/back.png" OnClientClick="goBack();" 
                                     CssClass="image_button" Width="45px" 
                                     style="vertical-align:text-top;"/>
                    <asp:Label runat="server" ID="_LbTitle" Text="ADMINISTRAR RONDA DE JUEGO MERCS"></asp:Label>                    
                </h1>
                <hr />
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                <h3>
                    <asp:Label ID="lblLiga" runat="server" ></asp:Label>
                    -
                    <asp:Label ID="lblRonda" runat="server"></asp:Label>
                    <asp:DropDownList runat="server" ID="DrpRondaActual"></asp:DropDownList>
                </h3>
                <br />
                <div style="text-align:right" class="div_box">
                    <asp:Button CssClass="btn" id="btnAddTurno" runat="server" 
                                            OnCommand="btnAddTurno_Command" text="Asignar dados" 
                                            style="width:150px;"
                                            ToolTip="Asigna los dados a los equipos para la siguiente ronda" Width="150px"></asp:Button> 
                    <asp:Button CssClass="btn" id="btnActivarTurno" runat="server" 
                                            OnCommand="btnActivarTurno_Command" text="Nueva ronda" 
                                            style="width:150px;"
                                            ToolTip="Pasa la liga a la siguiente ronda" Width="150px"></asp:Button> 
                </div>
            </div>
        </div>
        <br />

        <asp:Panel runat="server" id="Panel1">
            <div class="row">
                <div class="col-md-12">
                    <h3>RONDA ACTUAL (RESULTADOS)</h3>
                </div>
            </div>
            <br />
            <asp:DataGrid ID="GrRondas" runat="server" AutoGenerateColumns="false" Width="100%" 
                        ShowHeader="true" 
                        CssClass="grid"
                        HeaderStyle-CssClass="grid_header" 
                        ItemStyle-CssClass="grid_row" 
                        AlternatingItemStyle-CssClass="grid_alternate_row">
                <Columns>
                    <asp:BoundColumn DataField="id" HeaderText="id" Visible="false"></asp:BoundColumn>
                    <asp:BoundColumn DataField="id_league" HeaderText="id_league" Visible="false"></asp:BoundColumn>
                    <asp:BoundColumn DataField="p1_name" HeaderText="Jugador 1"></asp:BoundColumn>
                    <asp:BoundColumn DataField="p1_score" HeaderText="Puntos"></asp:BoundColumn>
                    <asp:BoundColumn DataField="p1_kills" HeaderText="Kills"></asp:BoundColumn>
                    <asp:BoundColumn DataField="p2_name" HeaderText="Jugador 2"></asp:BoundColumn>
                    <asp:BoundColumn DataField="p2_score" HeaderText="Puntos"></asp:BoundColumn>
                    <asp:BoundColumn DataField="p2_kills" HeaderText="Kills"></asp:BoundColumn>
                    <asp:BoundColumn DataField="match_date" HeaderText="Fecha"></asp:BoundColumn>
                    <asp:BoundColumn DataField="winner_name" HeaderText="Ganador"></asp:BoundColumn>
                    <asp:BoundColumn DataField="match_notes" HeaderText="Notas"></asp:BoundColumn>
                </Columns>
            </asp:DataGrid>
            <asp:Label runat="server" style="color:#ffd800;" Text="No hay datos de rondas" ID="_LbNoRondas" Visible="false"></asp:Label>
        </asp:Panel>

        <br />
        <h3><asp:Label runat="server" ID="LbClasif" Text="CLASIFICACION GENERAL"></asp:Label></h3>
        <br />
        <asp:DataGrid ID="GrJugadores" runat="server" AutoGenerateColumns="false" Width="100%" 
                    ShowHeader="true" 
                    CssClass="grid"
                    HeaderStyle-CssClass="grid_header" 
                    ItemStyle-CssClass="grid_row" 
                    AlternatingItemStyle-CssClass="grid_alternate_row"
                    >
            <Columns>
                <asp:BoundColumn DataField="user_id" HeaderText="user_id" Visible="false"></asp:BoundColumn>
                <asp:BoundColumn DataField="league_id" HeaderText="league_id" Visible="false"></asp:BoundColumn>
                <asp:BoundColumn DataField="user_name" HeaderText="Jugador"></asp:BoundColumn>
                <asp:BoundColumn DataField="team_name" HeaderText="Equipo"></asp:BoundColumn>
                <asp:BoundColumn DataField="faction_name" HeaderText="Facción"></asp:BoundColumn>
                <asp:BoundColumn DataField="kills" HeaderText="Asesinatos" ItemStyle-Width="70px"></asp:BoundColumn>
                <asp:BoundColumn DataField="vp" HeaderText="P.Misión" ItemStyle-Width="70px"></asp:BoundColumn>
                <asp:BoundColumn DataField="losses" HeaderText="Derrotas" ItemStyle-Width="70px"></asp:BoundColumn>
                <asp:BoundColumn DataField="draws" HeaderText="Empates" ItemStyle-Width="70px"></asp:BoundColumn>
                <asp:BoundColumn DataField="wins" HeaderText="Victorias" ItemStyle-Width="70px"></asp:BoundColumn>
                <asp:BoundColumn DataField="score" HeaderText="Puntuación" ItemStyle-Width="70px"></asp:BoundColumn>
            </Columns>
        </asp:DataGrid>
        <asp:Label runat="server" style="color:#ffd800;" Text="No hay jugadores" ID="_LbNoJugadores" Visible="false"></asp:Label>
        <br />

        <div class="row">
            <div class="col-md-12">
                <h3>
                    <label id="tituloUsuarios">DATOS DE CAMPAÑA</label>            
                </h3>
                <asp:Label runat="server" style="color:#ffd800;" Text="No hay datos de campaña adicionales" ID="_LbNoCampaña" Visible="false"></asp:Label>
                <asp:Repeater runat="server" ID="RptDatosUsuarios" OnItemDataBound="RptDatosUsuarios_ItemDataBound">
                    <ItemTemplate>
                        <div class="div_box">
                            <asp:Table runat="server" Width="100%">
                            <asp:TableRow>
                                <asp:TableCell RowSpan="2" Width="60px" HorizontalAlign="Center">
                                    <asp:Image runat="server" ID="ImgUser"
                                                Width="45px"
                                                ToolTip='<%# Eval("user_name") %>'
                                                AlternateText='<%# Eval("user_name") %>'
                                                ImageUrl= '<%# this.PATH_IMAGES + Eval("user_avatar").ToString().Trim() %>'>
                                    </asp:Image>
                                    <br />
                                    <asp:Label id="user" Text='<%# Eval("user_name") %>' runat="server"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell style="padding-left:5px" VerticalAlign="Middle" Width="100px">
                                    <asp:Label id="creditos" Text='<%# Eval("textoCreditos") %>' runat="server" ForeColor="#a47c05"></asp:Label>
                                    <br />
                                    <asp:Label id="materiales" Text='<%# Eval("textoMateriales") %>' runat="server" ForeColor="#a47c05"></asp:Label>                           
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Repeater runat="server" ID="RptDadosUsuarios" OnItemCommand="RptDadosUsuarios_ItemCommand">
                                        <ItemTemplate>                                    
                                            <asp:ImageButton runat="server" ID="ImgDice"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='<%# Eval("info") %>'
                                                AlternateText='<%# Eval("info") %>'
                                                ImageUrl= '<%# "../images/t_dices/mercs/" + Eval("img_Dice").ToString().Trim() %>'
                                                CommandName="AdministrarDado"
                                                CommandArgument='<%# Eval("id") %>'>
                                            </asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <asp:ImageButton CssClass="dado" id="btnAddDado" runat="server" 
                                        OnCommand="btnAddDado_Command"  ImageUrl="../images/t_dices/mercs/add.png" 
                                        ToolTip="Añadir un dado" Width="60px" CommandArgument='<%# Eval("id_user_league") %>'></asp:ImageButton> 
                                </asp:TableCell>                                
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell style="padding-left:5px" VerticalAlign="Middle" Width="100px">
                                    <asp:Label id="Label1" Text='Victorias: ' runat="server" ForeColor="#a47c05"></asp:Label>
                                    <asp:Label id="lblVictorias" Text='<%# Eval("wins") %>' runat="server" ForeColor="#a47c05"></asp:Label>
                                    <asp:Label id="Label2" Text='Empates: ' runat="server" ForeColor="#a47c05"></asp:Label>
                                    <asp:Label id="lblEmpates" Text='<%# Eval("draws") %>' runat="server" ForeColor="#a47c05"></asp:Label>    
                                    <asp:Label id="Label3" Text='Derrotas: ' runat="server" ForeColor="#a47c05"></asp:Label>
                                    <asp:Label id="lblDerrotas" Text='<%# Eval("losses") %>' runat="server" ForeColor="#a47c05"></asp:Label> 
                                    <asp:Label id="Label4" Text='Puntos: ' runat="server" ForeColor="#a47c05"></asp:Label>
                                    <asp:Label id="lblPuntos" Text='<%# Eval("total_score") %>' runat="server" ForeColor="#a47c05"></asp:Label> 
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        </div>
                        <br />
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
    <br /><br />

    <!-- Popup -->
    <asp:Button ID="btnShow" runat="server" Text="Show Modal Popup" style="display:none"/>
    <ajax:ModalPopupExtender ID="PopUpDado" runat="server" PopupControlID="PnlPopUp" TargetControlID="btnShow"
        CancelControlID="btnClose" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>
    <asp:Panel ID="PnlPopUp" runat="server" CssClass="PopUp" style="display:none">
        <asp:Button ID="btnClose" CssClass="ClosePopUp" runat="server" Text="X" />
        <div class="box" style="width:80%; max-width:100%; padding: 10px; margin-top:25px;">            
            <div style="padding-left: 30px">
                <div class="row">                    
                    <asp:RadioButton id="optReroll" GroupName="AdminDado" Text="Reroll" runat="server"/>
                </div>
                <div class="row">
                    <asp:RadioButton id="optAumentarCoste" GroupName="AdminDado" Text="Aumentar coste" runat="server"/>
                    <asp:TextBox ID="txtAumentarCoste" runat="server" Height="23px" Width="30px"  style="margin-left:25px;"></asp:TextBox>
                </div>
                <div class="row">                    
                    <asp:RadioButton id="optEliminar" GroupName="AdminDado" Text="Eliminar dado" runat="server"/>
                </div>
                <div class="row">
                    <asp:TextBox ID="txtMensaje" runat="server" Height="100px" TextMode="MultiLine" Width="90%"></asp:TextBox>
                </div>
                <div class="row" style="text-align:center">
                    <asp:Button CssClass="btn" id="btnUsarDado" runat="server" 
                                oncommand="btnAdminDado_Command" text="Aceptar" 
                                style="vertical-align:text-bottom; margin-left:30px"
                                ToolTip="Usar dado" Width="100px"></asp:Button>
                </div>
            </div>
        </div>
    </asp:Panel>
    <asp:Button ID="btnShowAddDados" runat="server" Text="Show Modal Popup" style="display:none"/>
    <ajax:ModalPopupExtender ID="PopUpAddDados" runat="server" PopupControlID="PnlPopUpAddDados" TargetControlID="btnShowAddDados"
        CancelControlID="btnClose2" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>
    <asp:Panel ID="PnlPopUpAddDados" runat="server" CssClass="PopUp" style="width:600px;max-width:600px;">
        <asp:Button ID="btnClose2" CssClass="ClosePopUp" runat="server" Text="X" />
        <div class="box" style="width:80%; max-width:100%; padding: 10px; margin-top:25px;">            
            <div style="padding-left: 30px">
                <div class="row">Añadir dados:</div>
                <div class="row">                    
                    <asp:ImageButton runat="server" ID="ImgDice1"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Resursos'
                                                AlternateText='Resursos'
                                                ImageUrl= "../images/t_dices/mercs/a.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDado"
                                                CommandArgument='1' />
                    <asp:ImageButton runat="server" ID="ImgDice2"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Economía'
                                                AlternateText='Economía'
                                                ImageUrl= "../images/t_dices/mercs/g.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDado"
                                                CommandArgument='2'/>
                    <asp:ImageButton runat="server" ID="ImgDice3"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Política'
                                                AlternateText='Política'
                                                ImageUrl= "../images/t_dices/mercs/v.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDado"
                                                CommandArgument='3'/>
                    <asp:ImageButton runat="server" ID="ImgDice4"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Espionaje'
                                                AlternateText='Espionaje'
                                                ImageUrl= "../images/t_dices/mercs/c.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDado"
                                                CommandArgument='4'/>
                </div>
                <div class="row">Añadir recursos:</div>
                <div class="row">                    
                    <asp:ImageButton runat="server" ID="ImgDice5"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='+1 recurso'
                                                AlternateText='+1 recurso'
                                                ImageUrl= "../images/t_dices/mercs/b1.png"                        
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddRecursos"
                                                CommandArgument='1'/>
                    <asp:ImageButton runat="server" ID="ImgDice6"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='+2 recursos'
                                                AlternateText='+2 recursos'
                                                ImageUrl= "../images/t_dices/mercs/b2.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AdministrarDado"
                                                CommandArgument='2'/>
                    <asp:ImageButton runat="server" ID="ImgDice7"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='+3 recursos'
                                                AlternateText='+3 recursos'
                                                ImageUrl= "../images/t_dices/mercs/b3.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddRecursos"
                                                CommandArgument='3'/>                   
                    <asp:ImageButton runat="server" ID="ImgDice8"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='-1 recurso'
                                                AlternateText='-1 recurso'
                                                ImageUrl= "../images/t_dices/mercs/b4.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddRecursos"
                                                CommandArgument='4'/>
                    <asp:ImageButton runat="server" ID="ImgDice9"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='-2 recursos'
                                                AlternateText='-2 recursos'
                                                ImageUrl= "../images/t_dices/mercs/b5.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddRecursos"
                                                CommandArgument='5'/>
                    <asp:ImageButton runat="server" ID="ImgDice10"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='-3 recursos'
                                                AlternateText='-3 recursos'
                                                ImageUrl= "../images/t_dices/mercs/b6.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddRecursos"
                                                CommandArgument='6'/>
                </div>
                <div class="row">Añadir materiales:</div>
                <div class="row">                    
                    <asp:ImageButton runat="server" ID="ImgDice11"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='+1 material'
                                                AlternateText='+1 material'
                                                ImageUrl= "../images/t_dices/mercs/m1.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddMateriales"
                                                CommandArgument='1'/>
                    <asp:ImageButton runat="server" ID="ImgDice12"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='+2 materiales'
                                                AlternateText='+2 materiales'
                                                ImageUrl= "../images/t_dices/mercs/m2.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddMateriales"
                                                CommandArgument='2'/>
                    <asp:ImageButton runat="server" ID="ImgDice13"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='+3 materiales'
                                                AlternateText='+3 materiales'
                                                ImageUrl= "../images/t_dices/mercs/m3.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddMateriales"
                                                CommandArgument='3'/>                   
                    <asp:ImageButton runat="server" ID="ImgDice14"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='-1 material'
                                                AlternateText='-1 material'
                                                ImageUrl= "../images/t_dices/mercs/m4.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddMateriales"
                                                CommandArgument='4'/>
                    <asp:ImageButton runat="server" ID="ImgDice15"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='-2 materiales'
                                                AlternateText='-2 materiales'
                                                ImageUrl= "../images/t_dices/mercs/m5.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddMateriales"
                                                CommandArgument='5'/>
                    <asp:ImageButton runat="server" ID="ImgDice16"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='-3 materiales'
                                                AlternateText='-3 materiales'
                                                ImageUrl= "../images/t_dices/mercs/m6.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddMateriales"
                                                CommandArgument='6'/>
                </div>
                <div class="row">Añadir dado de recursos:</div>
                <div class="row">                    
                    <asp:ImageButton runat="server" ID="ImageButton1"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='créditos'
                                                AlternateText='créditos'
                                                ImageUrl= "../images/t_dices/mercs/a1.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoRecursos"
                                                CommandArgument='1'/>
                    <asp:ImageButton runat="server" ID="ImageButton2"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='créditos'
                                                AlternateText='créditos'
                                                ImageUrl= "../images/t_dices/mercs/a2.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoRecursos"
                                                CommandArgument='2'/>
                    <asp:ImageButton runat="server" ID="ImageButton3"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='créditos'
                                                AlternateText='créditos'
                                                ImageUrl= "../images/t_dices/mercs/a3.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoRecursos"
                                                CommandArgument='3'/>                   
                    <asp:ImageButton runat="server" ID="ImageButton4"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='créditos'
                                                AlternateText='créditos'
                                                ImageUrl= "../images/t_dices/mercs/a4.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoRecursos"
                                                CommandArgument='4'/>
                    <asp:ImageButton runat="server" ID="ImageButton5"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='créditos'
                                                AlternateText='créditos'
                                                ImageUrl= "../images/t_dices/mercs/a5.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoRecursos"
                                                CommandArgument='5'/>
                    <asp:ImageButton runat="server" ID="ImageButton6"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='créditos'
                                                AlternateText='créditos'
                                                ImageUrl= "../images/t_dices/mercs/a6.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoRecursos"
                                                CommandArgument='6'/>
                </div>
                <div class="row">Añadir dado de economía:</div>
                <div class="row">                    
                    <asp:ImageButton runat="server" ID="ImageButton7"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Buyout (Compra)'
                                                AlternateText='Buyout (Compra)'
                                                ImageUrl= "../images/t_dices/mercs/g1.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoEconomia"
                                                CommandArgument='1'/>
                    <asp:ImageButton runat="server" ID="ImageButton8"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Blackmail (Chantaje)'
                                                AlternateText='Blackmail (Chantaje)'
                                                ImageUrl= "../images/t_dices/mercs/g2.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoEconomia"
                                                CommandArgument='2'/>
                    <asp:ImageButton runat="server" ID="ImageButton9"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Leverage (Apalancamiento)'
                                                AlternateText='Leverage (Apalancamiento)'
                                                ImageUrl= "../images/t_dices/mercs/g3.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoEconomia"
                                                CommandArgument='3'/>                   
                    <asp:ImageButton runat="server" ID="ImageButton10"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='créditos'
                                                AlternateText='créditos'
                                                ImageUrl= "../images/t_dices/mercs/g4.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoEconomia"
                                                CommandArgument='4'/>
                    <asp:ImageButton runat="server" ID="ImageButton11"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='créditos'
                                                AlternateText='créditos'
                                                ImageUrl= "../images/t_dices/mercs/g5.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoEconomia"
                                                CommandArgument='5'/>
                    <asp:ImageButton runat="server" ID="ImageButton12"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='créditos'
                                                AlternateText='créditos'
                                                ImageUrl= "../images/t_dices/mercs/g6.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoEconomia"
                                                CommandArgument='6'/>
                </div>
                <div class="row">Añadir dado de política:</div>
                <div class="row">                    
                    <asp:ImageButton runat="server" ID="ImageButton13"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Reparations (Indemnización)'
                                                AlternateText='Reparations (Indemnización)'
                                                ImageUrl= "../images/t_dices/mercs/v1.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoPolitica"
                                                CommandArgument='1'/>
                    <asp:ImageButton runat="server" ID="ImageButton14"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Legislation (Legislación)'
                                                AlternateText='Legislation (Legislación)'
                                                ImageUrl= "../images/t_dices/mercs/v2.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoPolitica"
                                                CommandArgument='2'/>
                    <asp:ImageButton runat="server" ID="ImageButton15"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Influence (Influenciar)'
                                                AlternateText='Influence (Influenciar)'
                                                ImageUrl= "../images/t_dices/mercs/v3.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoPolitica"
                                                CommandArgument='3'/>                   
                    <asp:ImageButton runat="server" ID="ImageButton16"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Red Tape (formalidades burocráticas)'
                                                AlternateText='Red Tape (formalidades burocráticas)'
                                                ImageUrl= "../images/t_dices/mercs/v4.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoPolitica"
                                                CommandArgument='4'/>
                    <asp:ImageButton runat="server" ID="ImageButton17"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Reparations (Indemnización)'
                                                AlternateText='Reparations (Indemnización)'
                                                ImageUrl= "../images/t_dices/mercs/v5.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoPolitica"
                                                CommandArgument='5'/>
                    <asp:ImageButton runat="server" ID="ImageButton18"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='créditos'
                                                AlternateText='créditos'
                                                ImageUrl= "../images/t_dices/mercs/v6.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoPolitica"
                                                CommandArgument='6'/>
                </div>
                <div class="row">Añadir dado de espionaje:</div>
                <div class="row">                    
                    <asp:ImageButton runat="server" ID="ImageButton19"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Subvert (Subvertir)'
                                                AlternateText='Subvert (Subvertir)'
                                                ImageUrl= "../images/t_dices/mercs/c1.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoEspionaje"
                                                CommandArgument='1'/>
                    <asp:ImageButton runat="server" ID="ImageButton20"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Subterfuge (Subterfugio)'
                                                AlternateText='Subterfuge (Subterfugio)'
                                                ImageUrl= "../images/t_dices/mercs/c2.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoEspionaje"
                                                CommandArgument='2'/>
                    <asp:ImageButton runat="server" ID="ImageButton21"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Assassinate (asesinato)'
                                                AlternateText='Assassinate (asesinato)'
                                                ImageUrl= "../images/t_dices/mercs/c3.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoEspionaje"
                                                CommandArgument='3'/>                   
                    <asp:ImageButton runat="server" ID="ImageButton22"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Incite (Incitar)'
                                                AlternateText='Incite (Incitar)'
                                                ImageUrl= "../images/t_dices/mercs/c4.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoEspionaje"
                                                CommandArgument='4'/>
                    <asp:ImageButton runat="server" ID="ImageButton23"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='Subvert (Subvertir)'
                                                AlternateText='Subvert (Subvertir)'
                                                ImageUrl= "../images/t_dices/mercs/c5.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoEspionaje"
                                                CommandArgument='5'/>
                    <asp:ImageButton runat="server" ID="ImageButton24"
                                                Width="60px"
                                                CssClass="dado"
                                                ToolTip='créditos'
                                                AlternateText='créditos'
                                                ImageUrl= "../images/t_dices/mercs/c6.png"
                                                OnCommand="ImgAddDados_Command"
                                                CommandName="AddDadoEspionaje"
                                                CommandArgument='6'/>
                </div>
            </div>
        </div>
    </asp:Panel>

</asp:Content>
