<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        .auto-style2 {
            width: 1830px;
        }
        .auto-style3 {
            height: 34px;
        }
        .nuevoEstilo1 {
            width: auto;
        }
        .auto-style4 {
            width: 761px;
        }
        .auto-style6 {
            width: 608px;
        }
        .auto-style7 {
            width: 347px;
        }
        .nuevoEstilo2 {
            margin-bottom: 5px;
        }
        .separacion {
            margin-bottom: 5px;
        }
        .separacion {
            margin-bottom: 12px;
        }
        .auto-style8 {
            width: 608px;
            height: 25px;
        }
        .auto-style9 {
            width: 761px;
            height: 25px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="auto-style1">

        <table style="width:100%;">
            <tr>
                <td>&nbsp;</td>
                <td colspan="4">
        <asp:Label ID="Label3" runat="server" Font-Names="Cabin Sketch" Font-Size="XX-Large" Text="BIOS MESSENGER"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td rowspan="4">&nbsp;</td>
                <td class="auto-style2" rowspan="4" style="text-align: right;">
        <asp:Label ID="Label1" runat="server" Text="Usuario: "></asp:Label>
                    <br />
                    <br />
        <asp:Label ID="Label2" runat="server" Text="Contraseña: "></asp:Label>
                    <br />
                </td>
                <td class="auto-style7" rowspan="4" style="text-align: left;">
        <asp:TextBox ID="txtUsuario" runat="server" MaxLength="8"></asp:TextBox>
                    <br />
                    <br />
        <asp:TextBox ID="txtContraseña" runat="server" TextMode="Password" MaxLength="6"></asp:TextBox>
                </td>
                <td class="auto-style6" style="text-align: right;">
                    &nbsp;</td>
                <td class="auto-style4" style="text-align: left;">
                    <asp:Label ID="Label4" runat="server" Text="Usuarios Activos:  "></asp:Label>
                    <asp:Label ID="lblUsuActivos" runat="server"></asp:Label>
                    <br />
                    <asp:Label ID="Label6" runat="server" Text="Cantidad Mensajes Enviados:  "></asp:Label>
                    <asp:Label ID="lblCantMsjEnv" runat="server"></asp:Label>
                    <br />
                    <asp:GridView ID="gvEstadisticas" runat="server" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="Key" HeaderText="Tipo de Mensaje" />
                            <asp:BoundField DataField="Value" HeaderText="Cantidad enviados" />
                        </Columns>
                    </asp:GridView>
                </td>
                <td rowspan="4">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style8" style="text-align: right;">
                    </td>
                <td class="auto-style9" style="text-align: left;">
                    </td>
            </tr>
            <tr>
                <td class="auto-style6" style="text-align: right;">
                    &nbsp;</td>
                <td class="auto-style4" style="text-align: left;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style6" style="text-align: right;">
                    &nbsp;</td>
                <td class="auto-style4" style="text-align: left;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3"></td>
                <td class="auto-style3" colspan="4">
        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
        &nbsp;
        <asp:HyperLink ID="hlRegistro" runat="server" NavigateUrl="~/AltaUsuario.aspx">Registrarse</asp:HyperLink>
                </td>
                <td class="auto-style3"></td>
            </tr>
        </table>
        <asp:Label ID="lblError" runat="server"></asp:Label>
    </div>
    </form>
</body>
</html>
