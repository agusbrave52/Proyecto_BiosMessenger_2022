using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioBM;
using System.Web.Services.Protocols;

public partial class AltaMensaje : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                List<TipoMensaje> listaTipo = new ServicioBiosMessenger().ListarTipoMensajes().ToList();
                Session["ListaTipo"] = listaTipo;
                List<Usuarios> ListaUsuario = new List<Usuarios>();
                Session["ListaUsuario"] = ListaUsuario;
                lbReceptores.DataTextField = "NombreUsuario";
                ddlCodigoTipo.DataSource = listaTipo;
                ddlCodigoTipo.DataTextField = "Nombre";
                ddlCodigoTipo.DataValueField = "CodigoTipo";
                ddlCodigoTipo.DataBind();
            }
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

    protected void btnAgregar_Click(object sender, EventArgs e)
    {
        try
        {
            Usuarios receptor = new ServicioBiosMessenger().BuscarUsuario(txtPara.Text.Trim());
            if (receptor != null)
            {
                List<Usuarios> Lista = (List<Usuarios>)Session["ListaUsuario"];
                bool encontro = (from unR in Lista where unR.NombreUsuario == receptor.NombreUsuario select unR).Any();
                if (!encontro)
                {
                    Lista.Add(receptor);
                    lbReceptores.DataSource = Lista;
                    lbReceptores.DataBind();
                    lblError.Text = "";
                }
                else
                    lblError.Text = "Usuario ya esta como destinatario";
            }
            else
                lblError.Text = "Usuario inexistente";
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

    protected void btnQuitar_Click(object sender, EventArgs e)
    {
        try
        {
            lblError.Text = "";
            List<Usuarios> Lista = (List<Usuarios>)Session["ListaUsuario"];
            Lista.RemoveAt(lbReceptores.SelectedIndex);
            lbReceptores.Items.RemoveAt(lbReceptores.SelectedIndex);
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }

    protected void btnEnviar_Click(object sender, EventArgs e)
    {
        Mensajes M = null;
        try
        {
            List<TipoMensaje> ListaTipo = (List<TipoMensaje>)Session["ListaTipo"];
            M = new Mensajes()
            {
                TipoMensaje = ListaTipo[ddlCodigoTipo.SelectedIndex],
                UsuariosEnv = (Usuarios)Session["Usuario"],
                UsuariosReciben = ((List<Usuarios>)Session["ListaUsuario"]).ToArray(),
                Asunto = txtAsunto.Text,
                Texto = txtMensaje.Text,
                Fecha = DateTime.Now,
                Caducidad = Convert.ToDateTime(txtCaducidad.Text)
            };
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
            return;
        }
        try
        {
            new ServicioBiosMessenger().AltaMensaje(M);
            lbReceptores.Items.Clear();
            txtAsunto.Text = "";
            txtMensaje.Text = "";
            txtPara.Text = "";
            ddlCodigoTipo.SelectedIndex = -1;
            lblError.Text = "Mensaje enviado correctamente!!";
            Session["ListaUsuario"] = new List<Usuarios>();
        }
        catch(SoapException ex)
        {
            lblError.Text = ex.Detail.InnerText;
        }
    }
}