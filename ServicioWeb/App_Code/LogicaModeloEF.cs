using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ModeloEF;
using System.Data.SqlClient;
using System.Data.Entity;


public class LogicaModeloEF
{
    private static Obligatorio2Entities _OBcontext = null;
    public static Obligatorio2Entities OBcontext
    {
        get
        {
            if(_OBcontext == null)
            {
                _OBcontext = new Obligatorio2Entities();
                _OBcontext.Configuration.ProxyCreationEnabled = false;
            }
            return _OBcontext;
        }
    }

    //operaciones TipoMensaje
    public static void AltaTipoMensaje(TipoMensaje unT)
    {
        try
        {
            Validar.ValidarTipoMensaje(unT);
        }
        catch(Exception ex)
        {
            throw ex;
        }
        try
        {
            OBcontext.TipoMensaje.Add(unT);
            OBcontext.SaveChanges();
        }
        catch (Exception ex)
        {
            OBcontext.Entry(unT).State = System.Data.Entity.EntityState.Detached;
            throw ex;
        }
    }
    public static void ModificarTipoMensaje(TipoMensaje unT)
    {
        try
        {
            TipoMensaje T = OBcontext.TipoMensaje.Where(t => t.CodigoTipo == unT.CodigoTipo).FirstOrDefault();
            T.Nombre = unT.Nombre;

            Validar.ValidarTipoMensaje(T);
            OBcontext.SaveChanges();
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
    public static void EliminarTipoMensaje(TipoMensaje unT)
    {
        try
        {
            TipoMensaje T = OBcontext.TipoMensaje.Where(t => t.CodigoTipo == unT.CodigoTipo).FirstOrDefault();

            //verificar que no haya mensajes con el tipo de mensaje
            bool encontre = (from unM in OBcontext.Mensajes
                             where unM.TipoMensaje.CodigoTipo == unT.CodigoTipo
                             select unM).Any();

            if (encontre)
                throw new Exception("No se puede eliminar - Hay mensajes asociados");

            OBcontext.TipoMensaje.Remove(T);
            OBcontext.SaveChanges();
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
    public static List<TipoMensaje> ListarTipoMensajes()
    {
        return (OBcontext.TipoMensaje.ToList());
    }
    public static TipoMensaje BuscarTipoMensaje(string codTipo)
    {
        return OBcontext.TipoMensaje.Where(t => t.CodigoTipo == codTipo).FirstOrDefault();
    }

    //operaciones Usuarios
    public static Usuarios LogueoUsuario(string usu, string contra)
    {
        return (OBcontext.Usuarios.Where(u => u.NombreUsuario == usu.Trim() && u.Contraseña == contra.Trim()).FirstOrDefault());
    }
    public static Usuarios BuscarUsuario(string nomUsu)
    {
        return (OBcontext.Usuarios.Where(u => u.NombreUsuario == nomUsu.Trim()).FirstOrDefault());
    }
    public static void AltaUsuario(Usuarios unUsu)
    {
        try
        {
            Validar.ValidarUsuario(unUsu);
        }
        catch(Exception ex)
        {
            throw ex;
        }
        try
        {
            OBcontext.Usuarios.Add(unUsu);
            OBcontext.SaveChanges();
        }
        catch(Exception ex)
        {
            OBcontext.Entry(unUsu).State = System.Data.Entity.EntityState.Detached;
            throw ex;
        }
    }
    public static void ModificarUsuario(Usuarios unUsu)
    {
        try
        {
            Usuarios U = OBcontext.Usuarios.Where(u => u.NombreUsuario == unUsu.NombreUsuario).FirstOrDefault();

            U.NombreCompleto = unUsu.NombreCompleto;
            U.Mail = unUsu.Mail;
            U.Contraseña = unUsu.Contraseña;

            Validar.ValidarUsuario(U);
            OBcontext.SaveChanges();
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    public static void BajaUsuario(Usuarios unUsu)
    {
        try
        {
            SqlParameter _nomUsu = new SqlParameter("@nomUsu", unUsu.NombreUsuario);
            SqlParameter _ret = new SqlParameter("@ret", System.Data.SqlDbType.Int);
            _ret.Direction = System.Data.ParameterDirection.Output;

            OBcontext.Database.ExecuteSqlCommand("exec BajaUsuario @nomUsu, @ret output", _nomUsu, _ret);

            if ((int)_ret.Value == -1)
                throw new Exception("Nombre de Usuario inexistente");
            if ((int)_ret.Value == -2)
                throw new Exception("El Usuario tiene mensajes asociados");
            if ((int)_ret.Value == -3)
                throw new Exception("Error de BD");

            OBcontext.SaveChanges();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //operaciones de Mensajes
    public static void AltaMensaje(Mensajes unM)
    {
        try
        {
            HashSet<Usuarios> lista = new HashSet<Usuarios>();
            for(int i = 0; i<unM.UsuariosReciben.Count; i++)
            {
                string nomUsu = unM.UsuariosReciben.ElementAt(i).NombreUsuario;

                Usuarios unUsu = OBcontext.Usuarios.Where(u => u.NombreUsuario == nomUsu).FirstOrDefault();

                lista.Add(unUsu);
            }
            unM.UsuariosReciben = lista;

            string codTipo = unM.TipoMensaje.CodigoTipo;
            TipoMensaje unT = OBcontext.TipoMensaje.Where(t => t.CodigoTipo == codTipo).FirstOrDefault();
            unM.TipoMensaje = unT;

            string nomUsuEnv = unM.UsuariosEnv.NombreUsuario;
            Usuarios usuEnv = OBcontext.Usuarios.Where(u => u.NombreUsuario == nomUsuEnv).FirstOrDefault();
            unM.UsuariosEnv = usuEnv;

            Validar.ValidarMensaje(unM);
        }
        catch(Exception ex)
        {
            throw ex;
        }
        try
        {
            OBcontext.Mensajes.Add(unM);
            OBcontext.SaveChanges();
        }
        catch(Exception ex)
        {
            OBcontext.Entry(unM).State = System.Data.Entity.EntityState.Detached;
            throw ex;
        }
    }
    public static List<Mensajes> ListarMensajesEnviados(Usuarios unUsu)
    {
        OBcontext.Usuarios.ToList();
        OBcontext.TipoMensaje.ToList();
        List<Mensajes> lista = (from unM in OBcontext.Mensajes
                                    where unM.UsuariosEnv.NombreUsuario == unUsu.NombreUsuario
                                    orderby unM.Fecha descending
                                    select unM).ToList();
        return lista;
    }
    public static List<Mensajes> ListarMensajesEnviados(Usuarios unUsu, TipoMensaje unT = null, DateTime unaF = new DateTime())
    {
        List<Mensajes> lista = new List<Mensajes>();
        OBcontext.Usuarios.ToList();
        OBcontext.TipoMensaje.ToList();
        if (unT == null && unaF != new DateTime())
        {
            lista = (from unM in OBcontext.Mensajes
                     where unM.UsuariosEnv.NombreUsuario == unUsu.NombreUsuario && DbFunctions.TruncateTime(unM.Fecha) == DbFunctions.TruncateTime(unaF)
                     orderby unM.Fecha descending
                     select unM).ToList();
        }

        if (unaF == new DateTime() && unT != null)
        {
            lista = (from unM in OBcontext.Mensajes
                     where unM.UsuariosEnv.NombreUsuario == unUsu.NombreUsuario && unM.TipoMensaje.CodigoTipo == unT.CodigoTipo
                     orderby unM.Fecha descending
                     select unM).ToList();
        }

        if (unaF != new DateTime() && unT != null)
        {
            lista = (from unM in OBcontext.Mensajes
                     where unM.UsuariosEnv.NombreUsuario == unUsu.NombreUsuario && unM.TipoMensaje.CodigoTipo == unT.CodigoTipo && DbFunctions.TruncateTime(unM.Fecha) == DbFunctions.TruncateTime(unaF)
                     orderby unM.Fecha descending
                     select unM).ToList();
        }
        return lista;
    }
    public static List<Usuarios> ListarUsuariosDeMensaje(Mensajes M)
    {
        List<Usuarios> lista = (from unM in OBcontext.Mensajes
                                     where unM.Codigo == M.Codigo
                                     from unUsu in unM.UsuariosReciben
                                     select unUsu).ToList();
        return lista;
    }
    public static List<Mensajes> ListarMensajesRecibidos(Usuarios unUsu)
    {
        OBcontext.Usuarios.ToList();
        OBcontext.TipoMensaje.ToList();
        List<Mensajes> lista = (from unM in OBcontext.Mensajes
                                where unM.Caducidad > DateTime.Now
                                from unR in unM.UsuariosReciben
                                where unR.NombreUsuario == unUsu.NombreUsuario
                                orderby unM.Fecha descending
                                select unM).ToList();
        return lista;
    }
    public static List<Mensajes> ListarMensajesRecibidos(Usuarios unUsu, TipoMensaje unT = null, DateTime unaF = new DateTime())
    {
        List<Mensajes> lista = new List<Mensajes>();
        OBcontext.Usuarios.ToList();
        OBcontext.TipoMensaje.ToList();
        if (unT == null && unaF != new DateTime())
        {
            lista = (from unM in OBcontext.Mensajes
                     where DbFunctions.TruncateTime(unM.Fecha) == DbFunctions.TruncateTime(unaF) && unM.Caducidad > DateTime.Now //como no podemos comparar Date porque linQ to entities no es compatible, usamos funciones del entity
                     from unR in unM.UsuariosReciben                                            //con TruncateTime para quitarle la hora de el DateTime para comparar solo las fechas.
                     where unR.NombreUsuario == unUsu.NombreUsuario
                     orderby unM.Fecha descending
                     select unM).ToList();
        }

        if(unaF == new DateTime() && unT != null)
        {
            lista = (from unM in OBcontext.Mensajes
                     where unM.TipoMensaje.CodigoTipo == unT.CodigoTipo && unM.Caducidad > DateTime.Now
                     from unR in unM.UsuariosReciben
                     where unR.NombreUsuario == unUsu.NombreUsuario
                     orderby unM.Fecha descending
                     select unM).ToList();
        }

        if(unaF != new DateTime() && unT != null)
        {
            lista = (from unM in OBcontext.Mensajes
                     where unM.TipoMensaje.CodigoTipo == unT.CodigoTipo && DbFunctions.TruncateTime(unM.Fecha) == DbFunctions.TruncateTime(unaF) && unM.Caducidad > DateTime.Now
                     from unR in unM.UsuariosReciben
                     where unR.NombreUsuario == unUsu.NombreUsuario
                     orderby unM.Fecha descending
                     select unM).ToList();
        }

        return lista;
    }

    public static int Estadisticas1()
    {
        int res = 0;
        res = OBcontext.Usuarios.Count();
        return res;
    }
    public static int Estadisticas2()
    {
        int res = 0;
        res = OBcontext.Mensajes.Count();
        return res;
    }
    public static List<string> Estadisticas3()
    {
        List<string> res = (from unM in OBcontext.Mensajes
                            group unM by unM.TipoMensaje.CodigoTipo into Grupo
                            select (Grupo.Key.ToString() + ":  " + Grupo.Count())).ToList();
        return res;
    }
}