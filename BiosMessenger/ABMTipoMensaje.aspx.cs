using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioBM;
using System.Web.Services.Protocols;

public partial class ABMTipoMensaje : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        try
        {
            TipoMensaje T = new ServicioBiosMessenger().BuscarTipoMensaje(txtCodigo.Text.Trim());
            if (T != null)
            {
                btnModificar.Enabled = true;
                btnEliminar.Enabled = true;
                btnAlta.Enabled = false;
                txtNombre.Enabled = true;
                txtCodigo.Enabled = false;
                txtCodigo.Text = T.CodigoTipo;
                txtNombre.Text = T.Nombre;
                Session["TipoBuscado"] = T;
                lblError.Text = "Tipo de mensaje encontrado 🔍🙈";
            }
            else
            {
                btnAlta.Enabled = true;
                btnEliminar.Enabled = false;
                btnModificar.Enabled = false;
                txtNombre.Enabled = true;
                lblError.Text = "Tipo no encontrado😢 - Puede agregarlo🤗";
            }
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

    protected void btnAlta_Click(object sender, EventArgs e)
    {
        TipoMensaje T = null;
        try
        {
            T = new TipoMensaje()
            {
                CodigoTipo = txtCodigo.Text.Trim(),
                Nombre = txtNombre.Text.Trim()
            };
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
        try
        {
            new ServicioBiosMessenger().AltaTipoMensaje(T);
            lblError.Text = "Alta Exitosa 👏";
            limpio();
        }
        catch (SoapException ex)
        {
            lblError.Text = ex.Detail.InnerText;
        }
        
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        try
        {
            TipoMensaje T = (TipoMensaje)Session["TipoBuscado"];
            T.Nombre = txtNombre.Text.Trim();
            new ServicioBiosMessenger().ModificarTipoMensaje(T);
            lblError.Text = "Tipo modificado con Exito!! 👏";
            limpio();
        }
        catch(SoapException ex)
        {
            lblError.Text = ex.Detail.InnerText;
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }

    private void limpio()
    {
        txtCodigo.Enabled = true;
        txtCodigo.Text = "";
        txtNombre.Text = "";
        btnAlta.Enabled = false;
        btnEliminar.Enabled = false;
        btnModificar.Enabled = false;
        txtNombre.Enabled = false;
        Session["TipoBuscado"] = null;
    }

    protected void btnLimpiar_Click(object sender, EventArgs e)
    {
        limpio();
        lblError.Text = "";
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        try
        {
            TipoMensaje T = (TipoMensaje)Session["TipoBuscado"];
            new ServicioBiosMessenger().EliminarTipoMensaje(T);
            limpio();
            lblError.Text = "Tipo eliminado con Exito!! 👏";
        }
        catch (SoapException ex)
        {
            lblError.Text = ex.Detail.InnerText;
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }


}