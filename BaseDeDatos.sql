use master
go

--------------Creacion de base de datos--------------
if exists(select * from SysDataBases where name='Obligatorio2')
begin
	drop database Obligatorio2
end
go

create database Obligatorio2
go

use Obligatorio2
go

--------------Creacion de tablas--------------
create table Usuarios(
	NombreUsuario varchar(8) primary key check(len(NombreUsuario)=8),
	Contraseña varchar(6) not null check(Contraseña like'[a-Z][a-Z][a-Z][a-Z][a-Z][0-9]'),
	NombreCompleto varchar(50) not null,
	Mail varchar(35) not null check(Mail like'%___@___%.___%')
)
go

create table TipoMensaje(
	CodigoTipo varchar(3) primary key check(CodigoTipo like'[A-Z][A-Z][A-Z]'),
	Nombre varchar(15) not null
)
go

create table Mensajes(
	Codigo int identity primary key,
	Texto text not null,
	Fecha datetime not null default GETDATE(),
	Asunto varchar(70) not null,
	Caducidad datetime not null check(Caducidad > DATEADD(hour, 24, GETDATE())),
	CodigoTipo varchar(3) not null FOREIGN KEY references TipoMensaje(CodigoTipo),
	NombreUsuRemitente varchar(8) not null Foreign key references Usuarios(NombreUsuario)
)
go

create table Reciben(
	NombreUsuReceptor varchar(8) not null Foreign key references Usuarios(NombreUsuario),
	Codigo int not null Foreign key references Mensajes(Codigo)
	primary key (NombreUsuReceptor,Codigo)
)
go

--------- Determino un usuario para servidor web (IIS 7.0) --------------------------------------------------------------
USE MASTER
go

CREATE LOGIN [IIS APPPOOL\DefaultAppPool] FROM WINDOWS
go

USE Obligatorio2
go

CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool]
go

exec sys.sp_addrolemember 'db_owner', [IIS APPPOOL\DefaultAppPool]
go


----------------------------------CREACION DE SP----------------------------------------------------------------------------------

create proc BajaUsuario 
@nomUsu varchar (8), @ret int OUTPUT AS
begin	
	if not exists(select * from Usuarios where NombreUsuario = @nomUsu)
	begin
		set @ret = -1
		return
	end
	if exists (select * from Mensajes where NombreUsuRemitente = @nomUsu) or exists(select * from Reciben where NombreUsuReceptor = @nomUsu)
	begin
		set @ret = -2
		return
	end

	delete Usuarios where NombreUsuario = @nomUsu

	if(@@ERROR = 0)
	begin
		set @ret = 1
		return
	end
	else
	begin
		set @ret = -3
		return
	end
end
go

---- USUARIOS AGREGADOS

insert Usuarios values ('agustin1', 'agust5', 'Agustin', 'agustin15@gmail.com')
insert Usuarios values ('santiag2', 'santi1', 'Santiago', 'santiago32@gmail.com')
insert Usuarios values ('pedrooo1', 'pedro0', 'Pedro', 'pedrin00@gmail.com')
insert Usuarios values ('nicolas1', 'nicoo5', 'Nicolas', 'nicolas3@gmail.com')
insert Usuarios values ('batmann0', 'night1', 'Bruce Wayne', 'nosoybatman@gmail.com')
insert Usuarios values ('Leonard0', 'Leooo0', 'Leonardo DiCaprio', 'dicaprio@gmail.com')
insert Usuarios values ('Susanaa1', 'Susii0', 'Susana Gimenez', 'susanita@adinet.com')
insert Usuarios values ('joekker1', 'funny5', 'Jack Napier', 'wazonwashere@gmail.com')
insert Usuarios values ('Leonard2', 'Leooo2', 'Leonardo', 'dicaprio2@gmail.com')
insert Usuarios values ('SantaCl0', 'Santa2', 'Papa Noel', 'navidad@gmail.com')
go
insert Usuarios values ('yaqueli2', 'abcde2', 'Yaquelin', 'yaquelin22e@gmail.com')
insert Usuarios values ('navarro0', 'narro0', 'Vargas Navarro', 'varganavarro01@gmail.com')
insert Usuarios values ('ortizro1', 'ortiz1', 'Ortiz Rodriguez', 'ortizrodrguez2233@gmail.com')
insert Usuarios values ('rosales0', 'rosaa5', 'Rosales Gomez', 'rosaaagomez@gmail.com')
insert Usuarios values ('robinnn0', 'night1', 'Nicolas', 'nosoyrobin@gmail.com')
insert Usuarios values ('Logannn1', 'Logii0', 'Wolverine', 'lobezno@gmail.com')
insert Usuarios values ('Carlito0', 'Carlo0', 'Carlos Santana', 'carlitos@adinet.com')
insert Usuarios values ('Jhoness1', 'jhony5', 'Jhon Wayne', 'wayne@gmail.com')
insert Usuarios values ('Xaviero1', 'Calvo0', 'Xavier', 'calvito@gmail.com')
insert Usuarios values ('Peterpa4', 'Arana1', 'Peter Parker', 'litllespider@gmail.com')
go
insert Usuarios values ('chuchaa1', 'chuuu5', 'Chucha', 'chucha23423@gmail.com')
insert Usuarios values ('francis0', 'franc1', 'Francisco', 'franciscoo32@gmail.com')
insert Usuarios values ('Panchoo1', 'panch0', 'Pancho', 'panchopedro@gmail.com')
insert Usuarios values ('Rosaria1', 'rosii5', 'Rosaria', 'rosaria3@gmail.com')
insert Usuarios values ('Menchoo0', 'mench1', 'Mencho', 'menchoon@gmail.com')
insert Usuarios values ('Pacoooo0', 'pacoo0', 'Paco', 'paco234234@gmail.com')
insert Usuarios values ('Ismaell1', 'ismaa0', 'Isamel', 'ismael422@adinet.com')
insert Usuarios values ('pepeeee3', 'pepee1', 'Pepe', 'pepe2211344@gmail.com')
insert Usuarios values ('Marcooo0', 'marco2', 'Marcos', 'marquitos4354@gmail.com')
insert Usuarios values ('Manuell1', 'manuu2', 'Manuel', 'manuel2111@gmail.com')
go
insert Usuarios values ('manueal2', 'manue1', 'Manuela', 'manuelaaa221@gmail.com')
insert Usuarios values ('Eustaci0', 'eusta1', 'Eustacio', 'eustaciooo001@gmail.com')
insert Usuarios values ('Juancho0', 'juanc0', 'Juacho', 'Juancho0012@gmail.com')
insert Usuarios values ('Patrici0', 'patri2', 'Patricio', 'estrellademar@gmail.com')
insert Usuarios values ('Bobespo1', 'bobes1', 'Bob Esponja', 'pantalonescuadrados@gmail.com')
insert Usuarios values ('Mohamad4', 'moham0', 'Mohamad', 'mohamad121@gmail.com')
insert Usuarios values ('Marcelo0', 'marce0', 'Marcerlo', 'marcerlito@gmail.com')
insert Usuarios values ('Juanito0', 'juani5', 'Juan', 'juanito@gmail.com')
insert Usuarios values ('marthaa2', 'marth2', 'Martha', 'marthita221345@gmail.com')
insert Usuarios values ('Jirafal1', 'jiraf5', 'Jirafal', 'donjirafales@gmail.com')
go
insert Usuarios values ('karinaa7', 'karuu1', 'Karina', 'katarinaaa@gmail.com')
insert Usuarios values ('Krisste3', 'kirss1', 'Krister', 'krisssmpache@gmail.com')
insert Usuarios values ('Simbaaa7', 'simba6', 'Simba', 'nooooo@gmail.com')
insert Usuarios values ('Solecit0', 'soles5', 'Sol', 'soless33@gmail.com')
insert Usuarios values ('laaaara2', 'laura0', 'Laura', 'lauraaaaaaaaa01010@gmail.com')
insert Usuarios values ('Alfonos0', 'alfon0', 'Alfonso', 'alfonos14@gmail.com')
insert Usuarios values ('Felipee1', 'felip4', 'Felipe', 'felipe2132@gmail.com')
insert Usuarios values ('Limaaaa0', 'limon1', 'Lima Limon', 'limalimon131@gmail.com')
insert Usuarios values ('maximus1', 'maxxx2', 'Drunkenfix', 'drunkenmax@gmail.com')
insert Usuarios values ('Chumiii1', 'yumii2', 'ChumiYumi', 'yumichu@gmail.com')
go
insert TipoMensaje values('URG', 'Urgente')
insert TipoMensaje values('EVT', 'Eventos')
insert TipoMensaje values('IVT', 'Invitación')
insert TipoMensaje values('EME', 'Emergencia')
insert TipoMensaje values('SUS', 'Susurro')
go

-----Correos
insert Mensajes values('Mensaje 1', GETDATE(), 'Saludo1','20-12-2022', 'URG', 'agustin1')
insert Mensajes values('Mensaje 2', GETDATE(), 'Saludo2','20-12-2022', 'EVT', 'agustin1')
insert Mensajes values('Mensaje 3', GETDATE(), 'Saludo3','20-12-2022', 'EVT', 'santiag2')
insert Mensajes values('Mensaje 4', GETDATE(), 'Saludo4','20-12-2022', 'IVT', 'santiag2')
insert Mensajes values('Mensaje 5', GETDATE(), 'Saludo5','20-12-2022', 'IVT', 'pedrooo1')
insert Mensajes values('Mensaje 6', GETDATE(), 'Saludo6','20-12-2022', 'EVT', 'pedrooo1')
insert Mensajes values('Mensaje 7', GETDATE(), 'Saludo7','20-12-2022', 'EVT', 'Chumiii1')
insert Mensajes values('Mensaje 8', GETDATE(), 'Saludo8','20-12-2022', 'URG', 'maximus1')
insert Mensajes values('Mensaje 9', GETDATE(), 'Saludo9','20-12-2022', 'IVT', 'Limaaaa0')
insert Mensajes values('Mensaje 10', GETDATE(), 'Saludo10','20-12-2022', 'URG', 'Felipee1')
go

insert Mensajes values('Mensaje 11', GETDATE(), 'Saludo11','20-12-2022', 'EVT', 'Alfonos0')
insert Mensajes values('Mensaje 12', GETDATE(), 'Saludo12','20-12-2022', 'URG', 'laaaara2')
insert Mensajes values('Mensaje 13', GETDATE(), 'Saludo13','20-12-2022', 'EVT', 'Solecit0')
insert Mensajes values('Mensaje 14', GETDATE(), 'Saludo14','20-12-2022', 'IVT', 'Simbaaa7')
insert Mensajes values('Mensaje 15', GETDATE(), 'Saludo15','20-12-2022', 'URG', 'Krisste3')
insert Mensajes values('Mensaje 16', GETDATE(), 'Saludo16','20-12-2022', 'IVT', 'karinaa7')
insert Mensajes values('Mensaje 17', GETDATE(), 'Saludo17','20-12-2022', 'EVT', 'marthaa2')
insert Mensajes values('Mensaje 18', GETDATE(), 'Saludo18','20-12-2022', 'URG', 'Juanito0')
insert Mensajes values('Mensaje 19', GETDATE(), 'Saludo19','20-12-2022', 'IVT', 'Marcelo0')
insert Mensajes values('Mensaje 20', GETDATE(), 'Saludo20','20-12-2022', 'EVT', 'Mohamad4')
go

insert Mensajes values('Mensaje 21', GETDATE(), 'Saludo21','20-12-2022', 'IVT', 'Bobespo1')
insert Mensajes values('Mensaje 22', GETDATE(), 'Saludo22','20-12-2022', 'EVT', 'Patrici0')
insert Mensajes values('Mensaje 23', GETDATE(), 'Saludo23','20-12-2022', 'URG', 'Juancho0')
insert Mensajes values('Mensaje 24', GETDATE(), 'Saludo24','20-12-2022', 'EVT', 'Eustaci0')
insert Mensajes values('Mensaje 25', GETDATE(), 'Saludo25','20-12-2022', 'IVT', 'manueal2')
insert Mensajes values('Mensaje 26', GETDATE(), 'Saludo26','20-12-2022', 'EVT', 'santiag2')
insert Mensajes values('Mensaje 27', GETDATE(), 'Saludo27','20-12-2022', 'URG', 'Susanaa1')
insert Mensajes values('Mensaje 28', GETDATE(), 'Saludo28','20-12-2022', 'IVT', 'Susanaa1')
insert Mensajes values('Mensaje 29', GETDATE(), 'Saludo29','20-12-2022', 'EVT', 'agustin1')
insert Mensajes values('Mensaje 30', GETDATE(), 'Saludo30','20-12-2022', 'URG', 'pedrooo1')
go

insert Mensajes values('Mensaje 31', GETDATE(), 'Saludo31','20-12-2022', 'IVT', 'agustin1')
insert Mensajes values('Mensaje 32', GETDATE(), 'Saludo32','20-12-2022', 'EVT', 'Marcooo0')
insert Mensajes values('Mensaje 33', GETDATE(), 'Saludo33','20-12-2022', 'URG', 'pepeeee3')
insert Mensajes values('Mensaje 34', GETDATE(), 'Saludo34','20-12-2022', 'EVT', 'Ismaell1')
insert Mensajes values('Mensaje 35', GETDATE(), 'Saludo35','20-12-2022', 'IVT', 'Pacoooo0')
insert Mensajes values('Mensaje 36', GETDATE(), 'Saludo36','20-12-2022', 'EVT', 'Menchoo0')
insert Mensajes values('Mensaje 37', GETDATE(), 'Saludo37','20-12-2022', 'URG', 'Rosaria1')
insert Mensajes values('Mensaje 38', GETDATE(), 'Saludo38','20-12-2022', 'IVT', 'agustin1')
insert Mensajes values('Mensaje 39', GETDATE(), 'Saludo39','20-12-2022', 'EVT', 'francis0')
insert Mensajes values('Mensaje 40', GETDATE(), 'Saludo40','20-12-2022', 'URG', 'chuchaa1')
go

insert Mensajes values('Mensaje 41', GETDATE(), 'Saludo41','20-12-2022', 'IVT', 'Peterpa4')
insert Mensajes values('Mensaje 42', GETDATE(), 'Saludo42','20-12-2022', 'EVT', 'Xaviero1')
insert Mensajes values('Mensaje 43', GETDATE(), 'Saludo43','20-12-2022', 'URG', 'Jhoness1')
insert Mensajes values('Mensaje 44', GETDATE(), 'Saludo44','20-12-2022', 'EVT', 'agustin1')
insert Mensajes values('Mensaje 45', GETDATE(), 'Saludo45','20-12-2022', 'IVT', 'Logannn1')
insert Mensajes values('Mensaje 46', GETDATE(), 'Saludo46','20-12-2022', 'EVT', 'robinnn0')
insert Mensajes values('Mensaje 47', GETDATE(), 'Saludo47','20-12-2022', 'URG', 'rosales0')
insert Mensajes values('Mensaje 48', GETDATE(), 'Saludo48','20-12-2022', 'IVT', 'agustin1')
insert Mensajes values('Mensaje 49', GETDATE(), 'Saludo49','20-12-2022', 'EVT', 'navarro0')
insert Mensajes values('Mensaje 50', GETDATE(), 'Saludo50','20-12-2022', 'URG', 'yaqueli2')
go


go
insert Reciben values ('agustin1', '1')
insert Reciben values ('batmann0', '1')
insert Reciben values ('batmann0', '2')
insert Reciben values ('Leonard0', '2')
insert Reciben values ('Leonard0', '3')
insert Reciben values ('pedrooo1', '5')
insert Reciben values ('agustin1', '5')
insert Reciben values ('santiag2', '6')
insert Reciben values ('santiag2', '7')
insert Reciben values ('Susanaa1', '8')
insert Reciben values ('Susanaa1', '9')
insert Reciben values ('Leonard0', '10')
insert Reciben values ('Ismaell1', '10')
insert Reciben values ('Rosaria1', '10')
insert Reciben values ('Leonard0', '12')
insert Reciben values ('Leonard0', '11')
insert Reciben values ('Limaaaa0', '12')
insert Reciben values ('Limaaaa0', '13')
insert Reciben values ('yaqueli2', '14')
insert Reciben values ('rosales0', '14')
insert Reciben values ('Chumiii1', '15')
insert Reciben values ('rosales0', '16')
insert Reciben values ('Patrici0', '17')
insert Reciben values ('chuchaa1', '18')
insert Reciben values ('Chumiii1', '19')
insert Reciben values ('yaqueli2', '20')
insert Reciben values ('Juancho0', '20')
insert Reciben values ('Ismaell1', '21')
insert Reciben values ('Ismaell1', '22')
insert Reciben values ('rosales0', '23')
insert Reciben values ('Felipee1', '24')
insert Reciben values ('Felipee1', '25')
insert Reciben values ('ortizro1', '26')
insert Reciben values ('batmann0', '26')
insert Reciben values ('joekker1', '27')
insert Reciben values ('joekker1', '28')
insert Reciben values ('batmann0', '29')
insert Reciben values ('batmann0', '30')
insert Reciben values ('Peterpa4', '31')
insert Reciben values ('Rosaria1', '31')
insert Reciben values ('Patrici0', '32')
insert Reciben values ('Ismaell1', '32')
insert Reciben values ('Chumiii1', '33')
insert Reciben values ('Chumiii1', '34')
insert Reciben values ('pepeeee3', '35')
insert Reciben values ('Ismaell1', '35')
insert Reciben values ('Eustaci0', '36')
insert Reciben values ('laaaara2', '37')
insert Reciben values ('Mohamad4', '38')
insert Reciben values ('Leonard0', '39')
insert Reciben values ('Ismaell1', '40')
insert Reciben values ('Rosaria1', '41')
insert Reciben values ('Leonard0', '42')
insert Reciben values ('Leonard0', '43')
insert Reciben values ('Limaaaa0', '44')
insert Reciben values ('Limaaaa0', '45')
insert Reciben values ('Limaaaa0', '46')
insert Reciben values ('yaqueli2', '47')
insert Reciben values ('rosales0', '48')
insert Reciben values ('Chumiii1', '49')
insert Reciben values ('rosales0', '50')
go
--select * from TipoMensaje
--select * from Usuarios
--select * from Reciben order by Codigo
--select * from Mensajes

--declare @usu int, @msjC int, @msjP int, @cant varchar(50)
--exec Estadisticas @usu OUTPUT, @msjC OUTPUT, @msjP OUTPUT, @cant OUTPUT
--select @usu AS UsuariosActivos, @msjC AS MensajesComunes, @msjP AS MensajesPrivados, @cant AS CantidadMensajesXTipo

------------------------------PRACTICA OUTPUT------------------------------------------
--create proc devolverMail @nomUsu varchar(8), @contra varchar(6), @correo varchar(35) OUTPUT, @nomCom varchar(50) OUTPUT AS
--begin
--	SELECT @correo = Mail, @nomCom = NombreCompleto from Usuarios where NombreUsuario = @nomUsu AND Contraseña = @contra
--end
--go

--DECLARE @mail varchar(35), @nombre varchar(50)
--exec devolverMail 'agustin1', 'agust5', @mail OUTPUT, @nombre OUTPUT
--SELECT @mail AS MAIL, @nombre AS NOMBRE
-------------------------------------------------------------------------------------------
--	declare @VarSentencia varchar(200)
--	set @VarSentencia = 'create user [' + @nombre + '] from login [' + @nombre + ']'
--	exec(@VarSentencia)

--declare @retorno int
--exec BajaUsuario 'agustin1', @retorno OUTPUT
--select 'agustin1', @retorno AS RET
