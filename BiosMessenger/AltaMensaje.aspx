<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageUsuario.master" AutoEventWireup="true" CodeFile="AltaMensaje.aspx.cs" Inherits="AltaMensaje" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .labels {
            text-align: right;
        }

        .auto-style5 {
            margin-right: 4px;
        }

        .btnquitar {
            vertical-align: top;
        }

        .auto-style6 {
            width: 110px;
        }

        .auto-style8 {
            width: 263px;
        }
        .auto-style9 {
            text-align: right;
            width: 110px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="Label5" runat="server" Font-Names="Cabin Sketch" Font-Size="XX-Large" Text="Alta Mensaje"></asp:Label>
<br />
    <table style="width:100%;">
        <tr>
            <td class="auto-style9">
<asp:Label ID="Label6" runat="server" Text="Asunto:"></asp:Label>

            </td>
            <td colspan="2">

    <asp:TextBox ID="txtAsunto" runat="server" MaxLength="70"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">
    <asp:Label ID="lbl5" runat="server" Text="Mensaje:"></asp:Label>
            </td>
            <td class="auto-style1" colspan="2">
    <asp:TextBox ID="txtMensaje" runat="server" CssClass="auto-style5" Height="78px" TextMode="MultiLine" Width="236px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">
    <asp:Label ID="Label7" runat="server" Text="Para:"></asp:Label>
            </td>
            <td class="auto-style8">
    <asp:TextBox ID="txtPara" runat="server" MaxLength="8"></asp:TextBox>
    <asp:Button ID="btnAgregar" runat="server" Text="Agregar" OnClick="btnAgregar_Click" />
            </td>
            <td>
    <asp:ListBox ID="lbReceptores" runat="server" Height="101px" Width="139px"></asp:ListBox>
    <asp:Button ID="btnQuitar" runat="server" CssClass="btnquitar" Text="Quitar" OnClick="btnQuitar_Click" />
            </td>
        </tr>
        <tr>
            <td class="auto-style9">
    <asp:Label ID="Label8" runat="server" Text="Tipo de mensaje:"></asp:Label>
            </td>
            <td class="auto-style8">
    <asp:DropDownList ID="ddlCodigoTipo" runat="server">
    </asp:DropDownList>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style9">
        <asp:Label ID="Label1" runat="server" Text="Caducidad:"></asp:Label>
            </td>
            <td colspan="2">
        <asp:TextBox ID="txtCaducidad" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style6">&nbsp;</td>
            <td class="auto-style8">
    <asp:Button ID="btnEnviar" runat="server" Text="Enviar" OnClick="btnEnviar_Click" />
            </td>
            <td><asp:Label ID="lblError" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>

