using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using System.Web.Services.Protocols;
using System.Xml;
using ModeloEF;

/// <summary>
/// Descripción breve de ServicioBiosMessenger
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
// [System.Web.Script.Services.ScriptService]
public class ServicioBiosMessenger : System.Web.Services.WebService
{
    private void GeneroSoapException(Exception ex)
    {
        ////generacion manual de excepcion SOAP - para poder obtener 
        ////solo el mensaje enviado por alguna de las capas

        ////1.- se debe crear un nodo xml (NodoError) el cual sera utilizado 
        ////para cargar el atributo Details de la exception SOAP
        XmlDocument _undoc = new System.Xml.XmlDocument();
        XmlNode _NodoError = _undoc.CreateNode(XmlNodeType.Element, SoapException.DetailElementName.Name, SoapException.DetailElementName.Namespace);

        ////2.- Se crea un nodo xml (NodoDetalle) q contendra el texto del error
        XmlNode _NodoDetalle = _undoc.CreateNode(XmlNodeType.Element, "Error", "");
        _NodoDetalle.InnerText = ex.Message;

        ////3.- Se agrega el nodo de detalle al nodo de error
        _NodoError.AppendChild(_NodoDetalle);

        //4. Creacion manual de la exception SOAP
        //parametro 1 --> mensaje basico de la excepcion
        //parametro 2 --> determina codigo de error para la exception 
        //parametro 3 --> se obtiene la URL de la solicitud actual
        //parametro 4 --> informacion especifica sobre la exception generada - carga automaticamente la propiedad details
        SoapException _MiEx = new SoapException(ex.Message, SoapException.ClientFaultCode, Context.Request.Url.AbsoluteUri, _NodoError);

        //se lanza la exception creada (no una automatica del WS)
        throw _MiEx;
    }

    [WebMethod]
    public void AltaTipoMensaje(TipoMensaje unT)
    {
        try
        {
            LogicaModeloEF.AltaTipoMensaje(unT);
        }
        catch(Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }

    [WebMethod]
    public void ModificarTipoMensaje(TipoMensaje unT)
    {
        try
        {
            LogicaModeloEF.ModificarTipoMensaje(unT);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }

    [WebMethod]
    public void EliminarTipoMensaje(TipoMensaje unT)
    {
        try
        {
            LogicaModeloEF.EliminarTipoMensaje(unT);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }

    [WebMethod]
    public List<TipoMensaje> ListarTipoMensajes()
    {
        List<TipoMensaje> lista = null;
        try
        {
            lista = LogicaModeloEF.ListarTipoMensajes();
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return lista;
    }

    [WebMethod]
    public TipoMensaje BuscarTipoMensaje(string codTipo)
    {
        TipoMensaje unT = null;
        try
        {
            unT = LogicaModeloEF.BuscarTipoMensaje(codTipo);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return unT;
    }


    //operaciones Usuarios
    [WebMethod]
    public Usuarios LogueoUsuario(string usu, string contra)
    {
        Usuarios _usu = null;
        try
        {
            _usu = LogicaModeloEF.LogueoUsuario(usu, contra);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return _usu;
    }

    [WebMethod]
    public Usuarios BuscarUsuario(string nomUsu)
    {
        Usuarios _usu = null;
        try
        {
            _usu = LogicaModeloEF.BuscarUsuario(nomUsu);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return _usu;
    }

    [WebMethod]
    public void AltaUsuario(Usuarios unUsu)
    {
        try
        {
            LogicaModeloEF.AltaUsuario(unUsu);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }

    [WebMethod]
    public void ModificarUsuario(Usuarios unUsu)
    {
        try
        {
            LogicaModeloEF.ModificarUsuario(unUsu);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }

    [WebMethod]
    public void BajaUsuario(Usuarios unUsu)
    {
        try
        {
            LogicaModeloEF.BajaUsuario(unUsu);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }

    //operaciones de Mensajes
    [WebMethod]
    public void AltaMensaje(Mensajes unM)
    {
        try
        {
            LogicaModeloEF.AltaMensaje(unM);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }

    [WebMethod]
    public List<Mensajes> ListarMensajesEnviados(Usuarios unUsu)
    {
        List<Mensajes> lista = new List<Mensajes>();
        try
        {
            lista = LogicaModeloEF.ListarMensajesEnviados(unUsu);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return lista;
    }

    [WebMethod]
    public List<Mensajes> ListarMensajesEnviadosFiltrados(Usuarios unUsu, TipoMensaje unT, DateTime unaFecha)
    {
        List<Mensajes> lista = new List<Mensajes>();
        try
        {
            
            if (unT == null && unaFecha != new DateTime())
            {
                lista = LogicaModeloEF.ListarMensajesEnviados(unUsu, unaF : unaFecha);
            }

            if (unaFecha == new DateTime() && unT != null)
            {
                lista = LogicaModeloEF.ListarMensajesEnviados(unUsu, unT);
            }

            if (unaFecha != new DateTime() && unT != null)
            {
                lista = LogicaModeloEF.ListarMensajesEnviados(unUsu, unT, unaFecha);
            }
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return lista;
    }

    [WebMethod]
    public List<Usuarios> ListarUsuariosDeMensaje(Mensajes M)
    {
        List<Usuarios> lista = null;
        try
        {
            lista = LogicaModeloEF.ListarUsuariosDeMensaje(M);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return lista;
    }

    [WebMethod]
    public List<Mensajes> ListarMensajesRecibidos(Usuarios unUsu)
    {
        List<Mensajes> lista = null;
        try
        {
            lista = LogicaModeloEF.ListarMensajesRecibidos(unUsu);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return lista;
    }

    [WebMethod]
    public List<Mensajes> ListarMensajesRecibidosFiltrados(Usuarios unUsu, TipoMensaje unT, DateTime unaFecha)
    {
        List<Mensajes> lista = new List<Mensajes>();
        try
        {

            if (unT == null && unaFecha != new DateTime())
            {
                lista = LogicaModeloEF.ListarMensajesRecibidos(unUsu, unaF: unaFecha);
            }

            if (unaFecha == new DateTime() && unT != null)
            {
                lista = LogicaModeloEF.ListarMensajesRecibidos(unUsu, unT);
            }

            if (unaFecha != new DateTime() && unT != null)
            {
                lista = LogicaModeloEF.ListarMensajesRecibidos(unUsu, unT, unaFecha);
            }
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return lista;
    }

    [WebMethod]
    public List<string> EstadisticasGet()
    {
        List<string> estadisticas = new List<string>();
        try
        {
            estadisticas.Add(LogicaModeloEF.Estadisticas1().ToString());
            estadisticas.Add(LogicaModeloEF.Estadisticas2().ToString());
            estadisticas.AddRange(LogicaModeloEF.Estadisticas3());
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return estadisticas;
    }
}
