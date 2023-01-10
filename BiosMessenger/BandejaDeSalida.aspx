<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageUsuario.master" AutoEventWireup="true" CodeFile="BandejaDeSalida.aspx.cs" Inherits="BandejaSalida" %>

<%@ Register src="UserControls/ControlMensajes.ascx" tagname="ControlMensajes" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style4 {
            width: 1424px;
        }
        .auto-style5 {
            width: 1418px;
        }
        .auto-style6 {
            width: 468px;
        }
        .estilo1{
            vertical-align:baseline;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr>
            <td class="auto-style4" colspan="2">
    
    <asp:Label ID="Label5" runat="server" Font-Names="Cabin Sketch" Font-Size="XX-Large" Text="Bandeja de Entrada"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style4" colspan="2">
    <asp:Label ID="Label6" runat="server" Text="Filtrar:"></asp:Label>
    <asp:DropDownList ID="ddlFiltro" runat="server" Height="17px" Width="114px" OnSelectedIndexChanged="ddlFiltro_SelectedIndexChanged" AutoPostBack="True">
        <asp:ListItem>-</asp:ListItem>
        <asp:ListItem>Privado</asp:ListItem>
        <asp:ListItem Value="Comun">Común</asp:ListItem>
    </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style6">

            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar Filtros" />
            </td>
        </tr>
        <tr>
            <td class="auto-style4" colspan="2">
    <asp:Label ID="Label7" runat="server" Text="Seleccionar Fecha:"></asp:Label>
                <asp:TextBox ID="txtFechaRecepcion" runat="server" TextMode="Date"></asp:TextBox>
        <asp:ImageButton ID="imgSearch" runat="server" Height="16px" ImageUrl="https://media.discordapp.net/attachments/747233260093833238/1007368971676303450/icons8-search-32.png" OnClick="imgSearch_Click" style="width: 16px" />
            </td>
        </tr>
        <tr>
            <td class="estilo1">
    <asp:GridView ID="gvEntrada" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvEntrada_SelectedIndexChanged" Width="455px">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField HeaderText="Fecha" DataField="Fecha" />
            <asp:BoundField HeaderText="Asunto" DataField="Asunto" />
            <asp:CommandField ButtonType="Button" CancelText="" CausesValidation="False" DeleteText="" EditText="" InsertText="" InsertVisible="False" NewText="" SelectText="Ver" ShowCancelButton="False" ShowSelectButton="True" UpdateText="" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    
            </td>
            <td style="vertical-align:baseline;">
                <uc1:ControlMensajes ID="ControlMensajes1" runat="server" />
    
            </td>
        </tr>
        <tr>
            <td colspan="2">

        <asp:Label ID="lblError" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
        </asp:Content>

