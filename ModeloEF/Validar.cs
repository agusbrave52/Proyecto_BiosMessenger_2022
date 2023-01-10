using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ModeloEF
{
    public class Validar
    {
        public static void ValidarTipoMensaje(TipoMensaje unTM)
        {
            if(!System.Text.RegularExpressions.Regex.IsMatch(unTM.CodigoTipo, "[A-Z]{3}"))
                throw new Exception("El codigo del tipo de mensaje no puede ser mas que 3 letras");
            if(string.IsNullOrEmpty(unTM.Nombre) || unTM.Nombre.Length > 15)
                throw new Exception("Tiene que tener un nombre y debe ser menor a 15 caracteres");
        }
        public static void ValidarUsuario(Usuarios unUsu)
        {
            if(unUsu.NombreUsuario.Trim().Length != 8)
                throw new Exception("El nombre de usuario no puede estar vacio y tiene que ser exactamente 8 caracteres");
            if(string.IsNullOrEmpty(unUsu.NombreCompleto) || unUsu.NombreCompleto.Length > 50)
                throw new Exception("El nombre completo no puede estar vacio y tiene que ser menor a 50 caracteres");
            if(!System.Text.RegularExpressions.Regex.IsMatch(unUsu.Contraseña, "[a-zA-Z]{5}[0-9]{1}"))
                throw new Exception("La contraseña no puede estar vacia, tiene que ser igual a 6 caracteres y debe contener 1 numero al final");
            if(!System.Text.RegularExpressions.Regex.IsMatch(unUsu.Mail, "[a-zA-Z0-9_]{3,}@[a-z]{3,}.[a-z]{3,}"))
                throw new Exception("El mail esta vacio o formato no valido");
        }
        public static void ValidarMensaje(Mensajes msj)
        {
            if(string.IsNullOrEmpty(msj.Texto))
                throw new Exception("El mensaje no puede estar vacío");
            if(string.IsNullOrEmpty(msj.Asunto) || msj.Asunto.Length > 70)
                throw new Exception("El asunto no puede estar vacío ni ser mayor a 70 caracteres");
            if(msj.UsuariosEnv == null)
                throw new Exception("El usuario no puede estar vacio");
            if(msj.UsuariosReciben == null || msj.UsuariosReciben.Count() == 0)
                throw new Exception("tiene que tener almenos un destinatario");
            if(msj.TipoMensaje == null)
                throw new Exception("Tiene que tener un tipo de mensaje");
            if (msj.Caducidad < (DateTime.Now).AddHours(24))
                throw new Exception("Tiene que tener una caducidad mayor a 24 hs");
        }
    }
}
