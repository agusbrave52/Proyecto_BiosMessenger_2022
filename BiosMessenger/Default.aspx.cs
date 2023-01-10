using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;
using ServicioBM;
using System.Web.Services.Protocols;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                Session["Usuario"] = null;
                List<string> lista = new ServicioBiosMessenger().EstadisticasGet().ToList();//traigo la lista
                Dictionary<string, string> datosSeparados = new Dictionary<string, string>();
                for(int i = 2; i < lista.Count(); i++)
                {
                    datosSeparados.Add(lista[i].Substring(0, 3), lista[i].Substring(5, lista[i].Length - 5));
                }

                gvEstadisticas.DataSource = datosSeparados;
                gvEstadisticas.DataBind();
                lblUsuActivos.Text = lista[0];
                lblCantMsjEnv.Text = lista[1];
            }
        }
        catch (SoapException ex)
        {
            lblError.Text = ex.Detail.InnerText;
            txtUsuario.Text = "";
            txtContraseña.Text = "";
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
        
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        try
        {
            Usuarios usu = new ServicioBiosMessenger().LogueoUsuario(txtUsuario.Text.Trim(), txtContraseña.Text.Trim());
            if (usu != null)
            {
                Session["Usuario"] = usu;
                Response.Redirect("./BajaYModificacionUsuario.aspx");
            }
            else
            {
                throw new Exception("Usuario o Contraseña incorrecta...");
            }
        }
        catch(SoapException ex)
        {
            lblError.Text = ex.Detail.InnerText;
            txtUsuario.Text = "";
            txtContraseña.Text = "";
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
            txtUsuario.Text = "";
            txtContraseña.Text = "";
        }
    }
}