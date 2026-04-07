# 💬 BiosMessenger
 
Proyecto de mensajería desarrollado como **obligatorio final** del curso de **Programación .NET** en el [Instituto BIOS](https://www.bios.edu.uy/) — edición 2022.
 
Aplicación de escritorio construida con **C# / Windows Forms**, una arquitectura de **tres capas** y comunicación vía **Web Service (ASMX)** sobre una base de datos **SQL Server**.
 
---
 
## 📋 Descripción
 
BiosMessenger es un sistema de mensajería interno que permite a usuarios registrados enviarse mensajes con distintos tipos (Urgente, Eventos, Invitación, Emergencia, Susurro), con soporte para múltiples destinatarios y mensajes con fecha de caducidad. La lógica de negocio está completamente separada en capas independientes y el acceso a datos se realiza a través de un servicio web.
 
---
 
## 🏗️ Arquitectura
 
El proyecto está dividido en tres proyectos dentro de la solución `ObligatorioProyecto.sln`:
 
```
ObligatorioProyecto.sln
├── BiosMessenger/     ← Capa de presentación (Windows Forms)
├── ModeloEF/          ← Capa de datos (Entity Framework + SQL Server)
└── ServicioWeb/       ← Capa de servicios (Web Service ASMX / ASP.NET)
```
 
**Flujo de comunicación:**
 
```
[BiosMessenger UI]  →  [ServicioWeb ASMX]  →  [ModeloEF / SQL Server]
   Windows Forms          Web Service             Entity Framework
```
 
---
 
## ✨ Funcionalidades
 
- 🔐 **Login** de usuario con validación de credenciales en base de datos
- 📤 **Envío de mensajes** con asunto, texto, tipo, fecha de caducidad y múltiples destinatarios
- 📥 **Recepción de mensajes** por usuario autenticado
- 🗂️ **Tipos de mensaje:** Urgente (URG), Eventos (EVT), Invitación (IVT), Emergencia (EME), Susurro (SUS)
- 🗑️ **Baja de usuario** con validación (no se puede eliminar si tiene mensajes asociados)
- ⏰ **Caducidad de mensajes** — deben vencer al menos 24 horas después de su creación
 
---
 
## 🗄️ Base de datos
 
**Motor:** SQL Server | **Nombre:** `Obligatorio2`
 
### Tablas
 
| Tabla | Descripción |
|---|---|
| `Usuarios` | Usuarios del sistema (NombreUsuario 8 chars, contraseña 6 chars) |
| `TipoMensaje` | Tipos de mensaje (código 3 letras mayúsculas) |
| `Mensajes` | Mensajes enviados con texto, asunto, fecha y caducidad |
| `Reciben` | Relación N:N entre mensajes y usuarios receptores |
 
### Constraints destacados
 
- `NombreUsuario`: exactamente 8 caracteres
- `Contraseña`: 5 letras + 1 número (`[a-Z][a-Z][a-Z][a-Z][a-Z][0-9]`)
- `Mail`: formato válido con `@` y dominio
- `Caducidad`: debe ser al menos 24 horas posterior a `GETDATE()`
- `CodigoTipo`: exactamente 3 letras mayúsculas
 
### Stored Procedures
 
- `BajaUsuario` — elimina un usuario con validación de integridad; retorna códigos de salida: `1` (éxito), `-1` (no existe), `-2` (tiene mensajes asociados), `-3` (error SQL)
 
---
 
## 🛠️ Tecnologías utilizadas
 
| Tecnología | Uso |
|---|---|
| C# (.NET Framework) | Lenguaje principal |
| Windows Forms | Interfaz de usuario de escritorio |
| ASP.NET Web Services (ASMX) | Capa de servicios / comunicación entre capas |
| Entity Framework 6.1.3 | ORM para acceso a datos |
| SQL Server | Motor de base de datos |
| T-SQL | Definición de tablas, constraints y stored procedures |
| IIS (Internet Information Services) | Hosting del Web Service en local |
| draw.io | Diagramas DER y modelo conceptual |
 
---
 
## 📁 Estructura del proyecto
 
```
Proyecto_BiosMessenger_2022/
├── ObligatorioProyecto.sln      ← Solución principal de Visual Studio
├── BaseDeDatos.sql              ← Script de creación y carga de datos
├── BiosMessenger/               ← Proyecto Windows Forms (UI)
├── ModeloEF/                    ← Proyecto Entity Framework (DAL)
├── ServicioWeb/                 ← Proyecto Web Service ASMX
├── packages/
│   └── EntityFramework.6.1.3/  ← Paquete NuGet local
├── DER.pdf                      ← Diagrama de Entidad-Relación
├── DER +RNE.pdf                 ← DER con Reglas de Negocio
├── DER +RNE.drawio              ← Fuente editable draw.io
├── DER +RNE + MC.drawio         ← DER + RNE + Modelo Conceptual
└── Obligatorio_2022.pdf         ← Enunciado original del proyecto
```
 
---
 
## 🚀 Requisitos para ejecutar
 
- **Visual Studio 2019 o superior**
- **SQL Server** (Express o superior)
- **IIS** habilitado en Windows (para el Web Service)
- **.NET Framework 4.x**
 
### Pasos de instalación
 
1. Cloná el repositorio:
   ```bash
   git clone https://github.com/agusbrave52/Proyecto_BiosMessenger_2022.git
   ```
 
2. Creá la base de datos ejecutando el script en SQL Server Management Studio:
   ```
   BaseDeDatos.sql
   ```
 
3. Abrí `ObligatorioProyecto.sln` en Visual Studio.
 
4. Configurá la cadena de conexión en `ModeloEF` apuntando a tu instancia de SQL Server.
 
5. Publicá `ServicioWeb` en IIS local (el script SQL ya incluye la configuración del usuario para `IIS APPPOOL\DefaultAppPool`).
 
6. Ejecutá el proyecto `BiosMessenger`.
 
---
 
## 👥 Usuarios de prueba
 
El script `BaseDeDatos.sql` incluye 50 usuarios precargados. Algunos ejemplos:
 
| NombreUsuario | Contraseña |
|---|---|
| `agustin1` | `agust5` |
| `santiag2` | `santi1` |
| `pedrooo1` | `pedro0` |
| `batmann0` | `night1` |
 
---
 
## 📄 Documentación incluida
 
El repositorio incluye los diagramas y el enunciado original del proyecto:
 
- `DER.pdf` — Diagrama de Entidad-Relación básico
- `DER +RNE.pdf` — DER con Reglas de Negocio Estructurales
- `DER +RNE + MC.drawio` — Versión completa con Modelo Conceptual (editable en draw.io)
- `Obligatorio_2022.pdf` — Enunciado original entregado por BIOS
 
---
 
## 📌 Estado del proyecto
 
✅ **Completado** — entrega final académica del curso .NET en Instituto BIOS, 2022. Proyecto archivado como referencia del aprendizaje en desarrollo de aplicaciones de escritorio con arquitectura en capas.
 
---
 
## 👤 Autor
 
**Agustín Brave**
- GitHub: [@agusbrave52](https://github.com/agusbrave52)
