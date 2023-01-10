<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageUsuario.master" AutoEventWireup="true" CodeFile="BajaYModificacionUsuario.aspx.cs" Inherits="BajaYModUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .labels {
            text-align: right;
        }

        .ayuda {
            visibility: hidden;
        }

        #ContentPlaceHolder1_txtContraseña:focus ~ #ContentPlaceHolder1_lblContra {
            visibility: visible;
        }

        #ContentPlaceHolder1_txtNomCompleto:focus ~ #ContentPlaceHolder1_lblNom {
            visibility: visible;
        }

        #ContentPlaceHolder1_txtMail:focus ~ #ContentPlaceHolder1_lblMail {
            visibility: visible;
        }

        .auto-style4 {
            width: 145px;
        }

        .auto-style6 {
            text-align: right;
            width: 145px;
        }
        .auto-style7 {
            text-align: right;
            width: 145px;
            height: 30px;
        }
        .auto-style8 {
            height: 30px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



    <asp:Label ID="Label5" runat="server" Font-Names="Cabin Sketch" Font-Size="XX-Large" Text="Modificar Usuario"></asp:Label>
    <br />
    <br />
    <table style="width: 100%;">
        <tr>
            <td class="auto-style7">
                <asp:Label ID="Label6" runat="server" Text="Contraseña:"></asp:Label>
            </td>
            <td class="auto-style8">
                <asp:TextBox ID="txtContraseña" runat="server" MaxLength="6" TextMode="Password"></asp:TextBox>
                <asp:Label CssClass="ayuda" ID="lblContra" runat="server" Text="Debe contener 5 letras y 1 numero" ForeColor="#666666"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style7">
                <asp:Label ID="Label7" runat="server" Text="Nombre Completo:"></asp:Label>
            </td>
            <td class="auto-style8">
                <asp:TextBox ID="txtNomCompleto" runat="server" MaxLength="50"></asp:TextBox>
                <asp:Label CssClass="ayuda" ID="lblNom" runat="server" Text="Ej: Rodolfo Perez" ForeColor="#666666"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style6">
                <asp:Label ID="Label8" runat="server" Text="Mail: "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtMail" runat="server" MaxLength="35"></asp:TextBox>
                <asp:Label CssClass="ayuda" ID="lblMail" runat="server" Text="Ej: maria@gmail.com" ForeColor="#666666"></asp:Label>

            </td>
        </tr>
        <tr>
            <td class="auto-style4">&nbsp;</td>
            <td>
                <asp:Button ID="btnModificar" runat="server" Text="Modificar" OnClick="btnModificar_Click" />
                &nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" OnClick="btnEliminar_Click" />
            </td>
        </tr>
        <tr>
            <td class="auto-style4">&nbsp;</td>
            <td>
                <asp:Label ID="lblError" runat="server"></asp:Label>

            </td>
        </tr>
    </table>
</asp:Content>

