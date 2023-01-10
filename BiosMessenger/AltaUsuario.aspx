<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AltaUsuario.aspx.cs" Inherits="AltaUsuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style>
        .ayuda{
            visibility:hidden;
        }
        #txtUsuario:focus ~ #lblNomUsu{
            visibility:visible;
        }
        #txtContraseña:focus ~ #lblContra{
            visibility:visible;
        }
        #txtNomCompleto:focus ~ #lblNom{
            visibility:visible;
        }
        #txtMail:focus ~ #lblMail{
            visibility:visible;
        }
        .auto-style1 {
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="auto-style1">
        <asp:Label ID="Label5" runat="server" Font-Names="Cabin Sketch" Font-Size="XX-Large" Text="Registro de usuario"></asp:Label>
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label1" runat="server" Text="Nombre de usuario: "></asp:Label>
        &nbsp;&nbsp;
        <asp:TextBox ID="txtUsuario" runat="server" MaxLength="8"></asp:TextBox>
        <asp:Label CssClass="ayuda" ID="lblNomUsu" runat="server" Text="Debe contener 8 caracteres exactamente" ForeColor="#666666" ></asp:Label>
        <br />
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label2" runat="server" Text="Contraseña: "></asp:Label>
        &nbsp;&nbsp;
        <asp:TextBox ID="txtContraseña" runat="server" MaxLength="6" TextMode="Password"></asp:TextBox>
        <asp:Label CssClass="ayuda" ID="lblContra" runat="server" Text="Debe contener 5 letras y 1 numero" ForeColor="#666666" ></asp:Label>
        <br />
        <br />
        &nbsp;
        <asp:Label ID="Label3" runat="server" Text="Nombre completo: "></asp:Label>
        &nbsp;
        <asp:TextBox ID="txtNomCompleto" runat="server" MaxLength="50"></asp:TextBox>
        <asp:Label CssClass="ayuda" ID="lblNom" runat="server" Text="Ej: Rodolfo Perez" ForeColor="#666666"></asp:Label>
        <br />
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label4" runat="server" Text="Mail de contacto: "></asp:Label>
        &nbsp;&nbsp;
        <asp:TextBox ID="txtMail" runat="server" MaxLength="35" TextMode="Email"></asp:TextBox>
    
        <asp:Label CssClass="ayuda" ID="lblMail" runat="server" Text="Ej: maria@gmail.com" ForeColor="#666666"></asp:Label>
    
        <br />
        <br />
        <asp:Label ID="lblError" runat="server"></asp:Label>
        <br />
        <asp:Button ID="btnRegistro" runat="server" Text="Registrarse" OnClick="btnRegistro_Click" />
        <br />
        <br />
        <asp:HyperLink ID="hlVolver" runat="server" NavigateUrl="~/Default.aspx">Volver</asp:HyperLink>
    
    </div>
    </form>
</body>
</html>
