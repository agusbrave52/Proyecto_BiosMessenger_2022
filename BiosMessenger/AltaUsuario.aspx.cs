using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioBM;
using System.Web.Services.Protocols;

public partial class AltaUsuario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnRegistro_Click(object sender, EventArgs e)
    {
        Usuarios U = null;
        try
        {
            U = new Usuarios()
            {
                NombreUsuario = txtUsuario.Text.Trim(),
                NombreCompleto = txtNomCompleto.Text.Trim(),
                Contraseña = txtContraseña.Text.Trim(),
                Mail = txtMail.Text.Trim()
            };
        }
        catch(Exception ex)
        {
            lblError.Text = ex.Message;
            return;
        }
        try
        {
            new ServicioBiosMessenger().AltaUsuario(U);
            lblError.Text = "Registro exitoso";
            txtContraseña.Text = "";
            txtMail.Text = "";
            txtNomCompleto.Text = "";
            txtUsuario.Text = "";
        }
        catch(SoapException ex)
        {
            lblError.Text = ex.Detail.InnerText;
        }
    }
    //void limpio()
    //{
    //    txtContraseña.Text = "";
    //    txtMail.Text = "";
    //    txtNomCompleto.Text = "";
    //    txtUsuario.Text = "";
    //}
}