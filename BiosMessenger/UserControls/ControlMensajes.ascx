<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlMensajes.ascx.cs" Inherits="UserControls_ControlMensajes" %>
<table >
    <tr>
        <td >
            <asp:Label ID="Label1" runat="server" Text="Remitente: "></asp:Label>
            <asp:Label ID="lblNombreRemitente" runat="server"></asp:Label>
            <br />
            <asp:Label ID="label" runat="server" Text="Asunto: "></asp:Label>
            <asp:Label ID="lblAsunto" runat="server"></asp:Label>
            <br />
            <asp:Label ID="Label3" runat="server" Font-Underline="True" Text="Mensaje: "></asp:Label>
        </td>
        <td>
            <asp:Label ID="Label4" runat="server" Text="Fecha de Envío: "></asp:Label>
            <asp:Label ID="lblFechaEnvio" runat="server"></asp:Label>
            <br />
            <asp:Label ID="lblInfo" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td rowspan="2" >
<asp:TextBox ID="txtMsj" runat="server" Height="176px" ReadOnly="True" TextMode="MultiLine" Width="335px"></asp:TextBox>
        </td>
        <td>
            <asp:Label ID="Label2" runat="server" Font-Underline="True" Text="Enviados a: "></asp:Label>

        </td>
    </tr>
    <tr>
        <td>
<asp:ListBox ID="lbDest" runat="server" Enabled="False" Height="143px" Width="110px"></asp:ListBox>

        </td>
    </tr>
    </table>


