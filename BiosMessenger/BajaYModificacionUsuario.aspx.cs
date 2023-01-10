using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioBM;
using System.Web.Services.Protocols;

public partial class BajaYModUsuario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                txtMail.Text = ((Usuarios)Session["Usuario"]).Mail;
                txtNomCompleto.Text = ((Usuarios)Session["Usuario"]).NombreCompleto;
            }
            catch(Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        try
        {
            Usuarios usuLogueado = (Usuarios)Session["Usuario"];
            usuLogueado.NombreCompleto = txtNomCompleto.Text.Trim();
            usuLogueado.Contraseña = txtContraseña.Text.Trim();
            usuLogueado.Mail = txtMail.Text.Trim();

            new ServicioBiosMessenger().ModificarUsuario(usuLogueado);

            Session["Usuario"] = usuLogueado;
            lblError.Text = "Usuario modificado con exito!";
        }
        catch (SoapException ex)
        {
            lblError.Text = ex.Detail.InnerText;
        }
        catch(Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        try
        {
            new ServicioBiosMessenger().BajaUsuario((Usuarios)Session["Usuario"]);
            Session["Usuario"] = null;
            Response.Redirect("./Default.aspx");
        }
        catch (SoapException ex)
        {
            lblError.Text = ex.Detail.InnerText;
        }
        catch(Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }
}