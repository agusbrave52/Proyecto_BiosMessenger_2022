using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioBM;

public partial class MasterPageUsuario : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Session["Usuario"] is Usuarios))
            Response.Redirect("./Default.aspx");
        else
            lblNomUsuario.Text = ((Usuarios)Session["Usuario"]).NombreCompleto;
    }
}
