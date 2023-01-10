<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageUsuario.master" AutoEventWireup="true" CodeFile="ABMTipoMensaje.aspx.cs" Inherits="ABMTipoMensaje" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .labels {
            text-align: right;
        }

        .btnquitar {
            vertical-align: top;
        }

        .auto-style6 {
            width: 110px;
        }

        .auto-style9 {
            text-align: right;
            width: 110px;
        }
        .auto-style10 {
            width: 149px;
            text-align: center;
        }
        .codigo{
            text-transform: uppercase;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="Label5" runat="server" Font-Names="Cabin Sketch" Font-Size="XX-Large" Text="Agregar, Eliminar o Modificar Tipo de Mensajes"></asp:Label>
<br />
    <table style="width:100%;">
        <tr>
            <td class="auto-style9">
<asp:Label ID="Label6" runat="server" Text="Codigo:"></asp:Label>

            </td>
            <td colspan="2">

    <asp:TextBox ID="txtCodigo" runat="server" MaxLength="3" CssClass="codigo"></asp:TextBox>
    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click"  />
    <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" OnClick="btnLimpiar_Click"  />
            </td>
        </tr>
        <tr>
            <td class="auto-style9">
    <asp:Label ID="lbl5" runat="server" Text="Nombre:"></asp:Label>
            </td>
            <td class="auto-style1" colspan="2">

    <asp:TextBox ID="txtNombre" runat="server" MaxLength="70" Enabled="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">
                &nbsp;</td>
            <td class="auto-style10">
                &nbsp;</td>
            <td>
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">
    <asp:Button ID="btnAlta" runat="server" Text="Alta" Enabled="False" OnClick="btnAlta_Click" />
            </td>
            <td class="auto-style10">
    <asp:Button ID="btnModificar" runat="server" Text="Modificar" Enabled="False" OnClick="btnModificar_Click"  />
            </td>
            <td>
    <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" Enabled="False" OnClick="btnEliminar_Click"  />
            </td>
        </tr>
    </table>
</asp:Content>

