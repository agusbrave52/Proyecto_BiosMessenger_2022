using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioBM;


public partial class UserControls_ControlMensajes : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void CargoMsj(Mensajes msj)
    {
        try
        {
            txtMsj.Text = msj.Texto;
            lblNombreRemitente.Text = msj.UsuariosEnv.NombreCompleto;
            lblAsunto.Text = msj.Asunto;
            lblFechaEnvio.Text = msj.Fecha.ToString();
            lblInfo.Text = "Fecha de Caducidad " + msj.Caducidad.ToString() + "\nTipo de Mensaje: " + msj.TipoMensaje.CodigoTipo + " (" + msj.TipoMensaje.Nombre + ")";
            lbDest.DataSource = msj.UsuariosReciben;
            lbDest.DataTextField = "NombreUsuario";
            lbDest.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public void Limpio()
    {
        try
        {
            txtMsj.Text = "";
            lblInfo.Text = "";
            lblNombreRemitente.Text = "";
            lblAsunto.Text = "";
            lblFechaEnvio.Text = "";
            lbDest.Items.Clear();
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
}