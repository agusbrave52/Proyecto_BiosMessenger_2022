using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioBM;
using System.Web.Services.Protocols;

public partial class BandejaEntrada : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                Usuarios usu = (Usuarios)Session["Usuario"];// cuando cargo la pagina traigo al usuario de logueo
                List<Mensajes> listMsjTodos = new ServicioBiosMessenger().ListarMensajesRecibidos(usu).ToList();// solo en la primer entrada a la pagina cargo la lista de Mensajes completa y la guardo en la session
                Session["ListaMsjRecTodos"] = listMsjTodos;
                gvEntrada.DataSource = listMsjTodos;// cargo en la grilla todos los mensajes
                gvEntrada.DataBind();
                Session["MsjFilter"] = listMsjTodos;

                List<TipoMensaje> listaTipo = new ServicioBiosMessenger().ListarTipoMensajes().ToList();// solo en la primer entrada a la pagina traigo la lista de tipos de mensaje
                Session["ListaTipo"] = listaTipo;
                ddlFiltro.DataSource = listaTipo;
                ddlFiltro.DataTextField = "Nombre";
                ddlFiltro.DataValueField = "CodigoTipo";
                ddlFiltro.DataBind();
                ddlFiltro.Items.Insert(0,"-");
                lblError.Text = "";
            }
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

    protected void gvEntrada_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            List<Mensajes> listaMSJ = (List<Mensajes>)Session["MsjFilter"];// cargo la lista filtrada o no, para poder seleccionar bien en la grilla
            (listaMSJ[gvEntrada.SelectedIndex]).UsuariosReciben = new ServicioBiosMessenger().ListarUsuariosDeMensaje(listaMSJ[gvEntrada.SelectedIndex]);
            ControlMensajes1.CargoMsj(listaMSJ[gvEntrada.SelectedIndex]);
            lblError.Text = "";
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }

    protected void ddlFiltro_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            List<Mensajes> listMsj = (List<Mensajes>)Session["ListaMsjRecTodos"];// cargo la lista completa
            TipoMensaje T = null;
            if (ddlFiltro.SelectedIndex != 0)
            {
                T = ((List<TipoMensaje>)Session["ListaTipo"]).ElementAt(ddlFiltro.SelectedIndex - 1);
                List<Mensajes> listaFiltrada = new ServicioBiosMessenger().ListarMensajesRecibidosFiltrados((Usuarios)Session["Usuario"], T, new DateTime()).ToList();
                gvEntrada.DataSource = listaFiltrada;
                gvEntrada.DataBind();
                Session["MsjFilter"] = listaFiltrada;
                if (gvEntrada.Rows.Count == 0)
                    ControlMensajes1.Limpio();
                lblError.Text = "";
                txtFechaRecepcion.Text = "";
            }
            else
            {
                gvEntrada.DataSource = listMsj;
                gvEntrada.DataBind();
                if (gvEntrada.Rows.Count == 0)
                    ControlMensajes1.Limpio();
                lblError.Text = "";
                txtFechaRecepcion.Text = "";
                Session["MsjFilter"] = listMsj;
            }
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

    protected void imgSearch_Click(object sender, ImageClickEventArgs e)//metodo para filtrar por fecha al clickear en la lupa
    {
        try
        {
            ControlMensajes1.Limpio();
            DateTime fecha = Convert.ToDateTime(txtFechaRecepcion.Text);
            List<Mensajes> listaFecha = new List<Mensajes>();
            if (ddlFiltro.SelectedIndex != 0)
            {
                listaFecha = new ServicioBiosMessenger().ListarMensajesRecibidosFiltrados((Usuarios)Session["Usuario"], ((List<TipoMensaje>)Session["ListaTipo"]).ElementAt(ddlFiltro.SelectedIndex - 1), fecha).ToList();
                gvEntrada.DataSource = listaFecha;// cargo la grilla con la lista filtrada
                gvEntrada.DataBind();
                Session["MsjFilter"] = listaFecha;// guardo en session la lista para despues poder seleccionar bien en la grilla 
                if (gvEntrada.Rows.Count == 0)
                    ControlMensajes1.Limpio();
                lblError.Text = "";
            }
            else
            {
                listaFecha = new ServicioBiosMessenger().ListarMensajesRecibidosFiltrados((Usuarios)Session["Usuario"], null, fecha).ToList();
                gvEntrada.DataSource = listaFecha;// cargo la grilla con la lista filtrada
                gvEntrada.DataBind();
                Session["MsjFilter"] = listaFecha;// guardo en session la lista para despues poder seleccionar bien en la grilla 
                if (gvEntrada.Rows.Count == 0)
                    ControlMensajes1.Limpio();
                lblError.Text = "";
            }
            //limpio todo al cambiar de filtro
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

    protected void btnLimpiar_Click(object sender, EventArgs e)//metodo del boton para limpiar todo
    {
        try
        {
            lblError.Text = "";
            List<Mensajes> listMsjTodos = (List<Mensajes>)Session["ListaMsjRecTodos"];
            Session["MsjFilter"] = listMsjTodos;
            gvEntrada.DataSource = listMsjTodos;
            gvEntrada.DataBind();
            gvEntrada.SelectedIndex = -1;
            ControlMensajes1.Limpio();
            txtFechaRecepcion.Text = "";
            ddlFiltro.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }

    }
}