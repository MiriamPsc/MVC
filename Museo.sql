USE master
GO

IF DB_ID (N'Museo') IS NOT NULL
DROP DATABASE Museo;
GO
CREATE DATABASE Museo
ON 
(NAME = Museo_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Museo.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = Museo_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Museo.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE Museo
GO

--TABLAS

CREATE TABLE Articulo
(
    idArticulo int IDENTITY (1, 1),
    codigo char (5) not null,
    nombreArticulo varchar (50) not null,
    descripcion varchar (50) not null,
    precio numeric (10, 2) not null,
    idCategoria int not null,
    idTipoArticulo int not null,
    idProveedor int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKArticulo PRIMARY KEY(idArticulo)
)

CREATE TABLE Artista
(
    idArtista int IDENTITY (1, 1),
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    ciudad varchar (50) not null,
    pais varchar (50) not null,
    añoNacimiento varchar (6) not null,
    añoMuerte varchar (6) not null,
    idTipoArtista int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKArtista PRIMARY KEY(idArtista)
)

CREATE TABLE Audioguia
(
    idAudioguia int IDENTITY (1,1),
    codigo char (5) not null,
    idioma char (1) not null,
    estatus bit default 1,
    idEmpleado int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKAudioguia PRIMARY KEY(idAudioguia)
)

CREATE TABLE Boleto
(
    idBoleto int IDENTITY (1,1),
    codigo char (5) not null,
    precio numeric (10, 2) not null,
    fechaCompra datetime not null,
    idTipoBoleto int not null,
    idRegalo int default null,
    idAudioguia int default null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKBoleto PRIMARY KEY(idBoleto)
)

CREATE TABLE Categoria
(
    idCategoria int IDENTITY (1, 1),
    codigo char (5) not null,
    nombre varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCategoria PRIMARY KEY(idCategoria)
)

CREATE TABLE Clasificacion
(
    idClasificacion int IDENTITY (1, 1),
    nombre varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKClasificacion PRIMARY KEY(idClasificacion)
)

CREATE TABLE CorrienteArtistica
(
    idCorrienteArtistica int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (250) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCorrienteArtistica PRIMARY KEY(idCorrienteArtistica)
)

CREATE TABLE DirectorDeExhibicionExterno
(
    idDirectorDeExhibicionExterno int IDENTITY (1, 1),
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) default null,
    ciudad varchar (50) not null,
    pais varchar (50) not null,
    fechaNacimiento datetime not null,
    rfc char (13),
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKDirectorDeExhibicionExterno PRIMARY KEY(idDirectorDeExhibicionExterno)
)

CREATE TABLE Distribuidora
(
    idDistribuidora int IDENTITY (1, 1),
    nombre varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKDistribuidora PRIMARY KEY(idDistribuidora)
)

CREATE TABLE Editorial
(
    idEditorial int IDENTITY (1, 1),
    nombre varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKEditorial PRIMARY KEY(idEditorial)
)

CREATE TABLE Escuela
(
    idEscuela int IDENTITY (1, 1),
    nombre varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKEscuela PRIMARY KEY(idEscuela)
)

CREATE TABLE Empleado
(
    idEmpleado int IDENTITY (1, 1),
    numero char (5) not null,
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) default null,
    genero char (5) not null,
    ciudad varchar (50) not null,
    pais varchar (50) not null,
    fechaNacimiento datetime not null,
    rfc char (13),
    idTipoEmpleado int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKEmpleado PRIMARY KEY(idEmpleado)
)


CREATE TABLE Escultura
(
    idEscultura int IDENTITY (1, 1),
    nombre varchar (50) not null,
    idArtista int not null,
    idCorrienteArtistica int not null,
    idTecnicaEscultura int not null,
    idPais int not null,
    idPeriodo int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKEscultura PRIMARY KEY(idEscultura)
)

CREATE TABLE Evento
(
    idEvento int IDENTITY (1, 1),
    codigo char (5) not null,
    nombre varchar (50) not null,
    descripcion varchar (200) not null,
    fechaInicio datetime not null,
    fechaFinal datetime not null,
    idTipoEvento int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKEvento PRIMARY KEY(idEvento)
)

CREATE TABLE Exhibicion
(
    idExhibicion int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (250) not null,
    fechaInicio datetime not null,
    fechaFinal datetime not null,
    idTipoExhibicion int not null,
    idDirectorDeExhibicion int default null,
    idDirectorDeExhibicionExterno int default null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKExhibicion PRIMARY KEY(idExhibicion)
)

CREATE TABLE FormatoDeCamara
(
    idFormatoDeCamara int IDENTITY (1, 1),
    nombre varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKFormatoDeCamara PRIMARY KEY(idFormatoDeCamara)
)

CREATE TABLE Fotografia
(
    idFotografia int IDENTITY (1, 1),
    nombre varchar (50) not null,
    idFotografo int not null,
    idFormatoDeCamara int not null,
    idClasificacion int not null,
    idPais int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKFotografia PRIMARY KEY(idFotografia)
)

CREATE TABLE Grupo
(
    idGrupo int IDENTITY (1, 1),
    codigo char (5) not null,
    numeroIntegrantes int not null,
    estatus bit default 1,
    idTipoGrupo int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKGrupo PRIMARY KEY(idGrupo)
)

CREATE TABLE Idioma
(
    idIdioma int IDENTITY (1, 1),
    nombre varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKIdioma PRIMARY KEY(idIdioma)
)

CREATE TABLE Libro
(
    idLibro int IDENTITY (1, 1),
    nombre varchar (50) not null,
    año varchar (6),
    idAutor int not null,
    idTipoEdicion int not null,
    idEditorial int not null,
    idClasificacion int not null,
    idIdioma int not null,
    idPais int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKLibro PRIMARY KEY(idLibro)
)

CREATE TABLE Objeto
(
    idObjeto int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (250) not null,
    idTipoObjeto int not null,
    idPeriodo int not null,
    idPais int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKObjeto PRIMARY KEY(idObjeto)
)

CREATE TABLE Pais
(
    idPais int IDENTITY (1, 1),
    nombre varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPais PRIMARY KEY(idPais)
)

CREATE TABLE Pelicula
(
    idPelicula int IDENTITY (1, 1),
    nombre varchar (50) not null,
    año varchar (6) not null,
    duracion int not null,
    tipo char (1) not null,
    idDirector int not null,
    idFormatoDeCamara int not null,
    idClasificacion int not null,
    idIdioma int not null,
    idPais int not null,
    idDistribuidora int not null,
    idProductora int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPelicula PRIMARY KEY(idPelicula)
)

CREATE TABLE Periodo
(
    idPeriodo int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (250) not null,
    añoInicio varchar (6),
    añoFinal varchar (6),
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPeriodo PRIMARY KEY(idPeriodo)
)

CREATE TABLE Pintura
(
    idPintura int IDENTITY (1, 1),
    nombre varchar (50) not null,
    idArtista int not null,
    idClasificacion int not null,
    idTecnicaPintura int not null,
    idCorrienteArtistica int not null,
    idPais int not null,
    idPeriodo int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPintura PRIMARY KEY(idPintura)
)

CREATE TABLE Productora
(
    idProductora int IDENTITY (1, 1),
    nombre varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKProductora PRIMARY KEY(idProductora)
)

CREATE TABLE Proveedor
(
    idProveedor int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (100) not null,
    rfc varchar (13) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKProveedor PRIMARY KEY(idProveedor)
)

CREATE TABLE Regalo
(
    idRegalo int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (150) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKRegalo PRIMARY KEY(idRegalo)
)

CREATE TABLE Sala
(
    idSala int IDENTITY (1, 1),
    nombre varchar (50) not null,
    codigo char (5) not null,
    idUbicacion int not null,
    idTipoSala int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKSala PRIMARY KEY(idSala)
)

CREATE TABLE Taller
(
    idTaller int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (50) not null,
    fechaInicio datetime not null,
    fechaFinal datetime not null,
    idTipoTaller int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTaller PRIMARY KEY(idTaller)
)

CREATE TABLE TecnicaEscultura
(
    idTecnicaEscultura int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (150) not null,
    material varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTecnicaEscultura PRIMARY KEY(idTecnicaEscultura)
)

CREATE TABLE TecnicaPintura
(
    idTecnicaPintura int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (150) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTecnicaPintura PRIMARY KEY(idTecnicaPintura)
)

CREATE TABLE Tienda
(
    idTienda int IDENTITY (1, 1),
    codigo char (5) not null,
    nombre varchar (50) not null,
    idUbicacion int not null,
    idTipoTienda int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTienda PRIMARY KEY(idTienda)
)

CREATE TABLE TipoArticulo
(
    idTipoArticulo int IDENTITY (1, 1),
    nombre varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoArticulo PRIMARY KEY(idTipoArticulo)
)

CREATE TABLE TipoArtista
(
    idTipoArtista int IDENTITY (1, 1),
    nombre varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoArtista PRIMARY KEY(idTipoArtista)
)


CREATE TABLE TipoBoleto
(
    idTipoBoleto int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (150) not null,
    vigencia varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoBoleto PRIMARY KEY(idTipoBoleto)
)

CREATE TABLE TipoEdicion
(
    idTipoEdicion int IDENTITY (1, 1),
    nombre varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoEdicion PRIMARY KEY(idTipoEdicion)
)

CREATE TABLE TipoEmpleado
(
    idTipoEmpleado int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (200) not null,
    sueldoBase numeric (10, 2) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoEmpleado PRIMARY KEY(idTipoEmpleado)
)

CREATE TABLE TipoEvento
(
    idTipoEvento int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (150) not null,
    organizador char (1) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoEvento PRIMARY KEY(idTipoEvento)
)

CREATE TABLE TipoExhibicion
(
    idTipoExhibicion int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (150) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoExhibicion PRIMARY KEY(idTipoExhibicion)
)

CREATE TABLE TipoGrupo
(
    idTipoGrupo int IDENTITY (1, 1),
    nombre varchar (50) not null,
    numeroMaximo int not null,
    numeroMinimo int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoGrupo PRIMARY KEY(idTipoGrupo)
)

CREATE TABLE TipoObjeto
(
    idTipoObjeto int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (150) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoObjeto PRIMARY KEY(idTipoObjeto)
)

CREATE TABLE TipoSala
(
    idTipoSala int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (150) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoSala PRIMARY KEY(idTipoSala)
)

CREATE TABLE TipoTaller
(
    idTipoTaller int IDENTITY (1, 1),
    nombre varchar (50) not null,
    modalidad char (1) not null,
    numeroMaximo int not null,
    numeroMinimo int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoTaller PRIMARY KEY(idTipoTaller)
)

CREATE TABLE TipoTienda
(
    idTipoTienda int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (150) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoTienda PRIMARY KEY(idTipoTienda)
)

CREATE TABLE TipoVisita
(
    idTipoVisita int IDENTITY (1, 1),
    nombre varchar (50) not null,
    descripcion varchar (150) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoVisita PRIMARY KEY(idTipoVisita)
)

CREATE TABLE Ubicacion
(
    idUbicacion int IDENTITY (1, 1),
    nombre varchar (50) not null,
    ubicacion varchar (50),
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKUbicacion PRIMARY KEY(idUbicacion)
)

CREATE TABLE Usuario
(
    idUsuario int IDENTITY,
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    correo varchar (50) UNIQUE not null,
    clave varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKUsuario PRIMARY KEY(idUsuario)
)

CREATE TABLE Visita
(
    idVisita int IDENTITY (1, 1),
    codigo char (5) not null,
    fecha datetime not null,
    idTipoVisita int not null,
    idVisitante int not null,
    idBoleto int not null,
    idGrupo int not null,
    idGuia int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKVisita PRIMARY KEY(idVisita)
)

CREATE TABLE Visitante
(
    idVisitante int IDENTITY,
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    correo varchar (50) UNIQUE not null,
    telefono char (10) not null,
    fechaNacimiento datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKVisitante PRIMARY KEY(idVisitante)
)

CREATE TABLE ArticuloTienda
(
    idArticuloTienda int IDENTITY,
    idArticulo int not null,
    idTienda int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKArticuloTienda PRIMARY KEY(idArticuloTienda)
)

CREATE TABLE ArtistaEscuela
(
    idArtistaEscuela int IDENTITY,
    idArtista int not null,
    idEscuela int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKArtistaEscuela PRIMARY KEY(idArtistaEscuela)
)

CREATE TABLE BoletoExhibicion
(
    idBoletoExhibicion int IDENTITY,
    idBoleto int not null,
    idExhibicion int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKBoletoExhibicion PRIMARY KEY(idBoletoExhibicion)
)

CREATE TABLE EmpleadoExhibicion
(
    idEmpleadoExhibicion int IDENTITY,
    idEmpleado int not null,
    idExhibicion int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKEmpleadoExhibicion PRIMARY KEY(idEmpleadoExhibicion)
)

CREATE TABLE EmpleadoTaller
(
    idEmpleadoTaller int IDENTITY,
    idEmpleado int not null,
    idTaller int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKEmpleadoTaller PRIMARY KEY(idEmpleadoTaller)
)

CREATE TABLE EmpleadoTienda
(
    idEmpleadoTienda int IDENTITY,
    idEmpleado int not null,
    idTienda int not null,
    fechaHoraEntrada datetime not null,
    fechaHoraSalida datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKEmpleadoTienda PRIMARY KEY(idEmpleadoTienda)
)

CREATE TABLE EsculturaExhibicion
(
    idEsculturaExhibicion int IDENTITY,
    idEscultura int not null,
    idExhibicion int not null,
    fechaInicio datetime not null,
    fechaFinal datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKEsculturaExibicion PRIMARY KEY(idEsculturaExhibicion)
)

CREATE TABLE EventoSala
(
    idEventoSala int IDENTITY,
    idEvento int not null,
    idSala int not null,
    fechaHoraInicio datetime not null,
    fechaHoraFinal datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKEventoSala PRIMARY KEY(idEventoSala)
)

CREATE TABLE ExhibicionFotografia
(
    idExhibicionFotografia int IDENTITY,
    idExhibicion int not null,
    idFotografia int not null,
    fechaInicio datetime not null,
    fechaFinal datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKExhibicionFotografia PRIMARY KEY(idExhibicionFotografia)
)

CREATE TABLE ExhibicionLibro
(
    idExhibicionLibro int IDENTITY,
    idExhibicion int not null,
    idLibro int not null,
    fechaInicio datetime not null,
    fechaFinal datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKExhibicionLibro PRIMARY KEY(idExhibicionLibro)
)

CREATE TABLE ExhibicionObjeto
(
    idExhibicionObjeto int IDENTITY,
    idExhibicion int not null,
    idObjeto int not null,
    fechaInicio datetime not null,
    fechaFinal datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKExhibicionObjeto PRIMARY KEY(idExhibicionObjeto)
)

CREATE TABLE ExhibicionPelicula
(
    idExhibicionPelicula int IDENTITY,
    idExhibicion int not null,
    idPelicula int not null,
    fechaInicio datetime not null,
    fechaFinal datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKExhibicionPelicula PRIMARY KEY(idExhibicionPelicula)
)

CREATE TABLE ExhibicionPintura
(
    idExhibicionPintura int IDENTITY,
    idExhibicion int not null,
    idPintura int not null,
    fechaInicio datetime not null,
    fechaFinal datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKExhibicionPintura PRIMARY KEY(idExhibicionPintura)
)

CREATE TABLE ExhibicionSala
(
    idExhibicionSala int IDENTITY,
    idExhibicion int not null,
    idSala int not null,
    fechaInicio datetime not null,
    fechaFinal datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKExhibicionSala PRIMARY KEY(idExhibicionSala)
)

CREATE TABLE SalaTaller
(
    idSalaTaller int IDENTITY,
    idSala int not null,
    idTaller int not null,
    fechaInicio datetime not null,
    fechaFinal datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKSalaTaller PRIMARY KEY(idSalaTaller)
)

--INDEX

CREATE INDEX IXArtista ON Artista(idArtista)
GO
CREATE INDEX IXAudioguia ON Audioguia(idAudioguia)
GO
CREATE INDEX IXBoleto ON Boleto(idBoleto)
GO
CREATE INDEX IXCategoria ON Categoria(idCategoria)
GO
CREATE INDEX IXClasificacion ON Clasificacion(idClasificacion)
GO
CREATE INDEX IXCorrienteArtistica ON CorrienteArtistica(idCorrienteArtistica)
GO
CREATE INDEX IXDirectorDeExhibicionExterno ON DirectorDeExhibicionExterno(idDirectorDeExhibicionExterno)
GO
CREATE INDEX IXDistribuidora ON Distribuidora(idDistribuidora)
GO
CREATE INDEX IXEditorial ON Editorial(idEditorial)
GO
CREATE INDEX IXEscuela ON Escuela(idEscuela)
GO
CREATE INDEX IXEmpleado ON Empleado(idEmpleado)
GO
CREATE INDEX IXEscultura ON Escultura(idEscultura)
GO
CREATE INDEX IXEvento ON Evento(idEvento)
GO
CREATE INDEX IXExhibicion ON Exhibicion(idExhibicion)
GO
CREATE INDEX IXFormatoDeCamara ON FormatoDeCamara(idFormatoDeCamara)
GO
CREATE INDEX IXFotografia ON Fotografia(idFotografia)
GO
CREATE INDEX IXGrupo ON Grupo(idGrupo)
GO
CREATE INDEX IXIdioma ON Idioma(idIdioma)
GO
CREATE INDEX IXLibro ON Libro(idLibro)
GO
CREATE INDEX IXObjeto ON Objeto(idObjeto)
GO
CREATE INDEX IXPais ON Pais(idPais)
GO
CREATE INDEX IXPelicula ON Pelicula(idPelicula)
GO
CREATE INDEX IXPeriodo ON Periodo(idPeriodo)
GO
CREATE INDEX IXPintura ON Pintura(idPintura)
GO
CREATE INDEX IXProductora ON Productora(idProductora)
GO
CREATE INDEX IXProveedor ON Proveedor(idProveedor)
GO
CREATE INDEX IXRegalo ON Regalo(idRegalo)
GO
CREATE INDEX IXSala ON Sala(idSala)
GO
CREATE INDEX IXTaller ON Taller(idTaller)
GO
CREATE INDEX IXTecnicaEscultura ON TecnicaEscultura(idTecnicaEscultura)
GO
CREATE INDEX IXTecnicaPintura ON TecnicaPintura(idTecnicaPintura)
GO
CREATE INDEX IXTienda ON Tienda(idTienda)
GO
CREATE INDEX IXTipoArticulo ON TipoArticulo(idTipoArticulo)
GO
CREATE INDEX IXTipoArtista ON TipoArtista(idTipoArtista)
GO
CREATE INDEX IXTipoBoleto ON TipoBoleto(idTipoBoleto)
GO
CREATE INDEX IXTipoEdicion ON TipoEdicion(idTipoEdicion)
GO
CREATE INDEX IXTipoExhibicion ON TipoExhibicion(idTipoExhibicion)
GO
CREATE INDEX IXTipoGrupo ON TipoGrupo(idTipoGrupo)
GO
CREATE INDEX IXTipoObjeto ON TipoObjeto(idTipoObjeto)
GO
CREATE INDEX IXTipoSala ON TipoSala(idTipoSala)
GO
CREATE INDEX IXTipoTaller ON TipoTaller(idTipoTaller)
GO
CREATE INDEX IXTipoTienda ON TipoTienda(idTipoTienda)
GO
CREATE INDEX IXTipoVisita ON TipoVisita(idTipoVisita)
GO
CREATE INDEX IXUbicacion ON Ubicacion(idUbicacion)
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario)
GO
CREATE INDEX IXVisita ON Visita(idVisita)
GO
CREATE INDEX IXVisitante ON Visitante(idVisitante)
GO
CREATE INDEX IXArticuloTienda ON ArticuloTienda(idArticuloTienda)
GO
CREATE INDEX IXArtistaEscuela ON ArtistaEscuela(idArtistaEscuela)
GO
CREATE INDEX IXBoletoExhibicion ON BoletoExhibicion(idBoletoExhibicion)
GO
CREATE INDEX IXEmpleadoExhibicion ON EmpleadoExhibicion(idEmpleadoExhibicion)
GO
CREATE INDEX IXEmpleadoTaller ON EmpleadoTaller(idEmpleadoTaller)
GO
CREATE INDEX IXEmpleadoTienda ON EmpleadoTienda(idEmpleadoTienda)
GO
CREATE INDEX IXEsculturaExhibicion ON EsculturaExhibicion(idEsculturaExhibicion)
GO
CREATE INDEX IXEventoSala ON EventoSala(idEventoSala)
GO
CREATE INDEX IXExhibicionFotografia ON ExhibicionFotografia(idExhibicionFotografia)
GO
CREATE INDEX IXExhibicionLibro ON ExhibicionLibro(idExhibicionLibro)
GO
CREATE INDEX IXExhibicionObjeto ON ExhibicionObjeto(idExhibicionObjeto)
GO
CREATE INDEX IXExhibicionPelicula ON ExhibicionPelicula(idExhibicionPelicula)
GO
CREATE INDEX IXExhibicionPintura ON ExhibicionPintura(idExhibicionPintura)
GO
CREATE INDEX IXExhibicionSala ON ExhibicionSala(idExhibicionSala)
GO
CREATE INDEX IXSalaTaller ON SalaTaller(idSalaTaller)
GO

--RELACIONES

ALTER TABLE Articulo
ADD CONSTRAINT FKArticuloUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Articulo
ADD CONSTRAINT FKArticuloUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Artista
ADD CONSTRAINT FKArtistaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Artista
ADD CONSTRAINT FKArtistaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Audioguia
ADD CONSTRAINT FKAudioguiaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Audioguia
ADD CONSTRAINT FKAudioguiaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Boleto
ADD CONSTRAINT FKBoletoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Boleto
ADD CONSTRAINT FKBoletoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Categoria
ADD CONSTRAINT FKCategoriaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Categoria
ADD CONSTRAINT FKCategoriaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Clasificacion
ADD CONSTRAINT FKClasificacionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Clasificacion
ADD CONSTRAINT FKClasificacionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE CorrienteArtistica
ADD CONSTRAINT FKCorrienteArtisticaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE CorrienteArtistica
ADD CONSTRAINT FKCorrienteArtisticaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE DirectorDeExhibicionExterno
ADD CONSTRAINT FKDirectorDeExhibicionExternoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE DirectorDeExhibicionExterno
ADD CONSTRAINT FKDirectorDeExhibicionExternoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Distribuidora
ADD CONSTRAINT FKDistribuidoraUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Distribuidora
ADD CONSTRAINT FKDistribuidoraUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Editorial
ADD CONSTRAINT FKEditorialUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Editorial
ADD CONSTRAINT FKEditorialUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Escuela
ADD CONSTRAINT FKEscuelaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Escuela
ADD CONSTRAINT FKEscuelaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Empleado
ADD CONSTRAINT FKEmpleadoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Empleado
ADD CONSTRAINT FKEmpleadoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Escultura
ADD CONSTRAINT FKEsculturaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Escultura
ADD CONSTRAINT FKEsculturaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Evento
ADD CONSTRAINT FKEventoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Evento
ADD CONSTRAINT FKEventoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Exhibicion
ADD CONSTRAINT FKExhibicionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Exhibicion
ADD CONSTRAINT FKExhibicionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE FormatoDeCamara
ADD CONSTRAINT FKFormatoDeCamaraUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE FormatoDeCamara
ADD CONSTRAINT FKFormatoDeCamaraUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Fotografia
ADD CONSTRAINT FKFotografiaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Fotografia
ADD CONSTRAINT FKFotografiaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Grupo
ADD CONSTRAINT FKGrupoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Grupo
ADD CONSTRAINT FKGrupoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Idioma
ADD CONSTRAINT FKIdiomaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Idioma
ADD CONSTRAINT FKIdiomaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Libro
ADD CONSTRAINT FKLibroUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Libro
ADD CONSTRAINT FKLibroUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Objeto
ADD CONSTRAINT FKObjetoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Objeto
ADD CONSTRAINT FKObjetoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Pais
ADD CONSTRAINT FKPaisUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Pais
ADD CONSTRAINT FKPaisUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Pelicula
ADD CONSTRAINT FKPeliculaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Pelicula
ADD CONSTRAINT FKPeliculaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Periodo
ADD CONSTRAINT FKPeriodoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Periodo
ADD CONSTRAINT FKPeriodoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Pintura
ADD CONSTRAINT FKPinturaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Pintura
ADD CONSTRAINT FKPinturaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Productora
ADD CONSTRAINT FKProductoraUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Productora
ADD CONSTRAINT FKProductoraUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Proveedor
ADD CONSTRAINT FKProveedorUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Proveedor
ADD CONSTRAINT FKProveedorUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Regalo
ADD CONSTRAINT FKRegaloUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Regalo
ADD CONSTRAINT FKRegaloUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Sala
ADD CONSTRAINT FKSalaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Sala
ADD CONSTRAINT FKSalaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Taller
ADD CONSTRAINT FKTallerUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Taller
ADD CONSTRAINT FKTallerUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TecnicaEscultura
ADD CONSTRAINT FKTecnicaEsculturaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TecnicaEscultura
ADD CONSTRAINT FKTecnicaEsculturaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TecnicaPintura
ADD CONSTRAINT FKTecnicaPinturaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TecnicaPintura
ADD CONSTRAINT FKTecnicaPinturaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Tienda
ADD CONSTRAINT FKTiendaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Tienda
ADD CONSTRAINT FKTiendaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoArticulo
ADD CONSTRAINT FKTipoArticuloUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoArticulo
ADD CONSTRAINT FKTipoArticuloUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoArtista
ADD CONSTRAINT FKTipoArtistaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoArtista
ADD CONSTRAINT FKTipoArtistaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoBoleto
ADD CONSTRAINT FKTipoBoletoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoBoleto
ADD CONSTRAINT FKTipoBoletoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoEdicion
ADD CONSTRAINT FKTipoEdicionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoEdicion
ADD CONSTRAINT FKTipoEdicionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoEmpleado
ADD CONSTRAINT FKTipoEmpleadoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoEmpleado
ADD CONSTRAINT FKTipoEmpleadoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoEvento
ADD CONSTRAINT FKTipoEventoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoEvento
ADD CONSTRAINT FKTipoEventoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoExhibicion
ADD CONSTRAINT FKTipoExhibicionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoExhibicion
ADD CONSTRAINT FKTipoExhibicionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoObjeto
ADD CONSTRAINT FKTipoObjetoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoObjeto
ADD CONSTRAINT FKTipoObjetoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoSala
ADD CONSTRAINT FKTipoSalaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoSala
ADD CONSTRAINT FKTipoSalaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoTaller
ADD CONSTRAINT FKTipoTallerUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoTaller
ADD CONSTRAINT FKTipoTallerUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoTienda
ADD CONSTRAINT FKTipoTiendaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoTienda
ADD CONSTRAINT FKTipoTiendaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoVisita
ADD CONSTRAINT FKTipoVisitaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoVisita
ADD CONSTRAINT FKTipoVisitaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Ubicacion
ADD CONSTRAINT FKUbicacionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Ubicacion
ADD CONSTRAINT FKUbicacionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Visita
ADD CONSTRAINT FKVisitaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Visita
ADD CONSTRAINT FKVisitaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Visitante
ADD CONSTRAINT FKVisitanteUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Visitante
ADD CONSTRAINT FKVisitanteUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ArticuloTienda
ADD CONSTRAINT FKArticuloTiendaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ArticuloTienda
ADD CONSTRAINT FKArticuloTiendaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Audioguia
ADD CONSTRAINT FKAudioguiaEmpleado FOREIGN KEY (idEmpleado)
REFERENCES Empleado(idEmpleado)

ALTER TABLE BoletoExhibicion
ADD CONSTRAINT FKBoletoExhibicionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE BoletoExhibicion
ADD CONSTRAINT FKBoletoExhibicionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE EmpleadoExhibicion
ADD CONSTRAINT FKEmpleadoExhibicionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE EmpleadoExhibicion
ADD CONSTRAINT FKEmpleadoExhibicionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE EmpleadoTaller
ADD CONSTRAINT FKEmpleadoTallerUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE EmpleadoTaller
ADD CONSTRAINT FKEmpleadoTallerUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE EmpleadoTienda
ADD CONSTRAINT FKEmpleadoTiendaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE EmpleadoTienda
ADD CONSTRAINT FKEmpleadoTiendaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE EsculturaExhibicion
ADD CONSTRAINT FKEsculturaExhibicionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE EsculturaExhibicion
ADD CONSTRAINT FKEsculturaExhibicionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE EventoSala
ADD CONSTRAINT FKEventoSalaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE EventoSala
ADD CONSTRAINT FKEventoSalaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ExhibicionFotografia
ADD CONSTRAINT FKExhibicionFotografiaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ExhibicionFotografia
ADD CONSTRAINT FKExhibicionFotografiaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ExhibicionLibro
ADD CONSTRAINT FKExhibicionLibroUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ExhibicionLibro
ADD CONSTRAINT FKExhibicionLibroUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ExhibicionObjeto
ADD CONSTRAINT FKExhibicionObjetoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ExhibicionObjeto
ADD CONSTRAINT FKExhibicionObjetoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ExhibicionPelicula
ADD CONSTRAINT FKExhibicionPeliculaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ExhibicionPelicula
ADD CONSTRAINT FKExhibicionPeliculaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ExhibicionPintura
ADD CONSTRAINT FKExhibicionPinturaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ExhibicionPintura
ADD CONSTRAINT FKExhibicionPinturaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ExhibicionSala
ADD CONSTRAINT FKExhibicionSalaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ExhibicionSala
ADD CONSTRAINT FKExhibicionSalaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE SalaTaller
ADD CONSTRAINT FKSalaTallerUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE SalaTaller
ADD CONSTRAINT FKSalaTallerUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Articulo
ADD CONSTRAINT FKArticuloCategoria FOREIGN KEY (idCategoria)
REFERENCES Categoria(idCategoria)

ALTER TABLE Articulo
ADD CONSTRAINT FKArticuloTipoArticulo FOREIGN KEY (idTipoArticulo)
REFERENCES TipoArticulo(idTipoArticulo)

ALTER TABLE Articulo
ADD CONSTRAINT FKArticuloProveedor FOREIGN KEY (idProveedor)
REFERENCES Proveedor(idProveedor)

ALTER TABLE Artista
ADD CONSTRAINT FKArtistaTipoArtista FOREIGN KEY (idTipoArtista)
REFERENCES TipoArtista(idTipoArtista)

ALTER TABLE Boleto
ADD CONSTRAINT FKBoletoTipoBoleto FOREIGN KEY (idTipoBoleto)
REFERENCES TipoBoleto(idTipoBoleto)

ALTER TABLE Boleto
ADD CONSTRAINT FKBoletoRegalo FOREIGN KEY (idRegalo)
REFERENCES Regalo(idRegalo)

ALTER TABLE Boleto
ADD CONSTRAINT FKBoletoAudioguia FOREIGN KEY (idAudioguia)
REFERENCES Audioguia(idAudioguia)

ALTER TABLE Empleado
ADD CONSTRAINT FKEmpleadoTipoEmpleado FOREIGN KEY (idTipoEmpleado)
REFERENCES TipoEmpleado(idTipoEmpleado)

ALTER TABLE Escultura
ADD CONSTRAINT FKEsculturaArtista FOREIGN KEY (idArtista)
REFERENCES Artista(idArtista)

ALTER TABLE Escultura
ADD CONSTRAINT FKEsculturaCorrienteArtistica FOREIGN KEY (idCorrienteArtistica)
REFERENCES CorrienteArtistica(idCorrienteArtistica)

ALTER TABLE Escultura
ADD CONSTRAINT FKEsculturaTecnicaEscultura FOREIGN KEY (idTecnicaEscultura)
REFERENCES TecnicaEscultura(idTecnicaEscultura)

ALTER TABLE Escultura
ADD CONSTRAINT FKEsculturaPais FOREIGN KEY (idPais)
REFERENCES Pais(idPais)

ALTER TABLE Escultura
ADD CONSTRAINT FKEsculturaPeriodo FOREIGN KEY (idPeriodo)
REFERENCES Periodo(idPeriodo)

ALTER TABLE Evento
ADD CONSTRAINT FKEventoTipoEvento FOREIGN KEY (idTipoEvento)
REFERENCES TipoEvento(idTipoEvento)

ALTER TABLE Exhibicion
ADD CONSTRAINT FKExhibicionDirectorDeExhibicion FOREIGN KEY (idDirectorDeExhibicion)
REFERENCES Empleado(idEmpleado)

ALTER TABLE Exhibicion
ADD CONSTRAINT FKExhibicionDirectorDeExhibicionExterno FOREIGN KEY (idDirectorDeExhibicionExterno)
REFERENCES DirectorDeExhibicionExterno(idDirectorDeExhibicionExterno)

ALTER TABLE Exhibicion
ADD CONSTRAINT FKExhibicionTipoExhibicion FOREIGN KEY (idTipoExhibicion)
REFERENCES TipoExhibicion(idTipoExhibicion)

ALTER TABLE Fotografia
ADD CONSTRAINT FKFotografiaFotografo FOREIGN KEY (idFotografo)
REFERENCES Artista(idArtista)

ALTER TABLE Fotografia
ADD CONSTRAINT FKFotografiaFormatoDeCamara FOREIGN KEY (idFormatoDeCamara)
REFERENCES FormatoDeCamara(idFormatoDeCamara)

ALTER TABLE Fotografia
ADD CONSTRAINT FKFotografiaClasificacion FOREIGN KEY (idClasificacion)
REFERENCES Clasificacion(idClasificacion)

ALTER TABLE Fotografia
ADD CONSTRAINT FKFotografiaPais FOREIGN KEY (idPais)
REFERENCES Pais(idPais)

ALTER TABLE Grupo
ADD CONSTRAINT FKGrupoTipoGrupo FOREIGN KEY (idTipoGrupo)
REFERENCES TipoGrupo(idTipoGrupo)

ALTER TABLE Libro
ADD CONSTRAINT FKLibroAutor FOREIGN KEY (idAutor)
REFERENCES Artista(idArtista)

ALTER TABLE Libro
ADD CONSTRAINT FKLibroTipoEdicion FOREIGN KEY (idTipoEdicion)
REFERENCES TipoEdicion(idTipoEdicion)

ALTER TABLE Libro
ADD CONSTRAINT FKLibroEditorial FOREIGN KEY (idEditorial)
REFERENCES Editorial(idEditorial)

ALTER TABLE Libro
ADD CONSTRAINT FKLibroClasificacion FOREIGN KEY (idClasificacion)
REFERENCES Clasificacion(idClasificacion)

ALTER TABLE Libro
ADD CONSTRAINT FKLibroIdioma FOREIGN KEY (idIdioma)
REFERENCES Idioma(idIdioma)

ALTER TABLE Libro
ADD CONSTRAINT FKLibroPais FOREIGN KEY (idPais)
REFERENCES Pais(idPais)

ALTER TABLE Objeto
ADD CONSTRAINT FKObjetoTipoObjeto FOREIGN KEY (idTipoObjeto)
REFERENCES TipoObjeto(idTipoObjeto)

ALTER TABLE Objeto
ADD CONSTRAINT FKObjetoPeriodo FOREIGN KEY (idPeriodo)
REFERENCES Periodo(idPeriodo)

ALTER TABLE Objeto
ADD CONSTRAINT FKObjetoPais FOREIGN KEY (idPais)
REFERENCES Pais(idPais)

ALTER TABLE Pelicula
ADD CONSTRAINT FKPeliculaDirector FOREIGN KEY (idDirector)
REFERENCES Artista(idArtista)

ALTER TABLE Pelicula
ADD CONSTRAINT FKPeliculaFormatoDeCamara FOREIGN KEY (idFormatoDeCamara)
REFERENCES FormatoDeCamara(idFormatoDeCamara)

ALTER TABLE Pelicula
ADD CONSTRAINT FKPeliculaClasificacion FOREIGN KEY (idClasificacion)
REFERENCES Clasificacion(idClasificacion)

ALTER TABLE Pelicula
ADD CONSTRAINT FKPeliculaIdioma FOREIGN KEY (idIdioma)
REFERENCES Idioma(idIdioma)

ALTER TABLE Pelicula
ADD CONSTRAINT FKPeliculPais FOREIGN KEY (idPais)
REFERENCES Pais(idPais)

ALTER TABLE Pelicula
ADD CONSTRAINT FKPeliculaDistribuidora FOREIGN KEY (idDistribuidora)
REFERENCES Distribuidora(idDistribuidora)

ALTER TABLE Pelicula
ADD CONSTRAINT FKPeliculaProductora FOREIGN KEY (idProductora)
REFERENCES Productora(idProductora)

ALTER TABLE Pintura
ADD CONSTRAINT FKPinturaArtista FOREIGN KEY (idArtista)
REFERENCES Artista(idArtista)

ALTER TABLE Pintura
ADD CONSTRAINT FKPinturaClasificacion FOREIGN KEY (idClasificacion)
REFERENCES Clasificacion(idClasificacion)

ALTER TABLE Pintura
ADD CONSTRAINT FKEsculturaTecnicaPintura FOREIGN KEY (idTecnicaPintura)
REFERENCES TecnicaPintura(idTecnicaPintura)

ALTER TABLE Pintura
ADD CONSTRAINT FKPinturaCorrienteArtistica FOREIGN KEY (idCorrienteArtistica)
REFERENCES CorrienteArtistica(idCorrienteArtistica)

ALTER TABLE Pintura
ADD CONSTRAINT FKPinturaPais FOREIGN KEY (idPais)
REFERENCES Pais(idPais)

ALTER TABLE Pintura
ADD CONSTRAINT FKPinturaPeriodo FOREIGN KEY (idPeriodo)
REFERENCES Periodo(idPeriodo)

ALTER TABLE Sala
ADD CONSTRAINT FKSalaTipoSala FOREIGN KEY (idTipoSala)
REFERENCES TipoSala(idTipoSala)

ALTER TABLE Sala
ADD CONSTRAINT FKSalaUbicacion FOREIGN KEY (idUbicacion)
REFERENCES Ubicacion(idUbicacion)

ALTER TABLE Taller
ADD CONSTRAINT FKTallerTipoTaller FOREIGN KEY (idTipoTaller)
REFERENCES TipoTaller(idTipoTaller)

ALTER TABLE Tienda
ADD CONSTRAINT FKTiendaTipoTienda FOREIGN KEY (idTipoTienda)
REFERENCES TipoTienda(idTipoTienda)

ALTER TABLE Tienda
ADD CONSTRAINT FKTiendaUbicacion FOREIGN KEY (idUbicacion)
REFERENCES Ubicacion(idUbicacion)

ALTER TABLE Visita
ADD CONSTRAINT FKVisitaTipoVisita FOREIGN KEY (idTipoVisita)
REFERENCES Visita(idVisita)

ALTER TABLE Visita
ADD CONSTRAINT FKVisitaVisitante FOREIGN KEY (idVisitante)
REFERENCES Visitante(idVisitante)

ALTER TABLE Visita
ADD CONSTRAINT FKVisitaBoleto FOREIGN KEY (idBoleto)
REFERENCES Boleto(idBoleto)

ALTER TABLE Visita
ADD CONSTRAINT FKVisitaGrupo FOREIGN KEY (idGrupo)
REFERENCES Grupo(idGrupo)

ALTER TABLE Visita
ADD CONSTRAINT FKVisitaGuia FOREIGN KEY (idGuia)
REFERENCES Empleado(idEmpleado)

ALTER TABLE ArticuloTienda
ADD CONSTRAINT FKArticuloTiendaArticulo FOREIGN KEY (idArticulo)
REFERENCES Articulo(idArticulo)

ALTER TABLE ArticuloTienda
ADD CONSTRAINT FKArticuloTiendaTienda FOREIGN KEY (idTienda)
REFERENCES Tienda(idTienda)

ALTER TABLE ArtistaEscuela
ADD CONSTRAINT FKArtistaEscuelaArtista FOREIGN KEY (idArtista)
REFERENCES Artista(idArtista)

ALTER TABLE ArtistaEscuela
ADD CONSTRAINT FKArtistaEscuelaEscuela FOREIGN KEY (idEscuela)
REFERENCES Escuela(idEscuela)

ALTER TABLE BoletoExhibicion
ADD CONSTRAINT FKBoletoExhibicionBoleto FOREIGN KEY (idBoleto)
REFERENCES Boleto(idBoleto)

ALTER TABLE BoletoExhibicion
ADD CONSTRAINT FKBoletoExhibicionExhibcion FOREIGN KEY (idExhibicion)
REFERENCES Exhibicion(idExhibicion)

ALTER TABLE EmpleadoExhibicion
ADD CONSTRAINT FKEmpleadoExhibicionEmpleado FOREIGN KEY (idEmpleado)
REFERENCES Empleado(idEmpleado)

ALTER TABLE EmpleadoExhibicion
ADD CONSTRAINT FKEmpleadoExhibicionExhibicion FOREIGN KEY (idExhibicion)
REFERENCES Exhibicion(idExhibicion)

ALTER TABLE EmpleadoTaller
ADD CONSTRAINT FKEmpleadoTallerEmpleado FOREIGN KEY (idEmpleado)
REFERENCES Empleado(idEmpleado)

ALTER TABLE EmpleadoTaller
ADD CONSTRAINT FKEmpleadoTallerTaller FOREIGN KEY (idTaller)
REFERENCES Taller(idTaller)

ALTER TABLE EmpleadoTienda
ADD CONSTRAINT FKEmpleadoTiendaEmpleado FOREIGN KEY (idEmpleado)
REFERENCES Empleado(idEmpleado)

ALTER TABLE EmpleadoTienda
ADD CONSTRAINT FKEmpleadoTiendaTienda FOREIGN KEY (idTienda)
REFERENCES Tienda(idTienda)

ALTER TABLE EsculturaExhibicion
ADD CONSTRAINT FKEsculturaExhibicionEscultura FOREIGN KEY (idEscultura)
REFERENCES Escultura(idEscultura)

ALTER TABLE EsculturaExhibicion
ADD CONSTRAINT FKEsculturaExhibicionExhibicion FOREIGN KEY (idExhibicion)
REFERENCES Exhibicion(idExhibicion)

ALTER TABLE EventoSala
ADD CONSTRAINT FKEventoSalaEvento FOREIGN KEY (idEvento)
REFERENCES Evento(idEvento)

ALTER TABLE EventoSala
ADD CONSTRAINT FKEventoSalaSala FOREIGN KEY (idSala)
REFERENCES Sala(idSala)

ALTER TABLE ExhibicionFotografia
ADD CONSTRAINT FKExhibicionFotografiaExhibicion FOREIGN KEY (idExhibicion)
REFERENCES Exhibicion(idExhibicion)

ALTER TABLE ExhibicionFotografia
ADD CONSTRAINT FKExhibicionFotografiaFotografia FOREIGN KEY (idFotografia)
REFERENCES Fotografia(idFotografia)

ALTER TABLE ExhibicionLibro
ADD CONSTRAINT FKExhibicionLibroExhibicion FOREIGN KEY (idExhibicion)
REFERENCES Exhibicion(idExhibicion)

ALTER TABLE ExhibicionLibro
ADD CONSTRAINT FKExhibicionLibroLibro FOREIGN KEY (idLibro)
REFERENCES Libro(idLibro)

ALTER TABLE ExhibicionPelicula
ADD CONSTRAINT FKExhibicionPeliculaExhibicion FOREIGN KEY (idExhibicion)
REFERENCES Exhibicion(idExhibicion)

ALTER TABLE ExhibicionPelicula
ADD CONSTRAINT FKExhibicionPeliculaPelicula FOREIGN KEY (idPelicula)
REFERENCES Pelicula(idPelicula)

ALTER TABLE ExhibicionPintura
ADD CONSTRAINT FKExhibicionPinturaExhibicion FOREIGN KEY (idExhibicion)
REFERENCES Exhibicion(idExhibicion)

ALTER TABLE ExhibicionPintura
ADD CONSTRAINT FKExhibicionPinturaPintura FOREIGN KEY (idPintura)
REFERENCES Pintura(idPintura)

ALTER TABLE ExhibicionSala
ADD CONSTRAINT FKExhibicionSalaExhibicion FOREIGN KEY (idExhibicion)
REFERENCES Exhibicion(idExhibicion)

ALTER TABLE ExhibicionSala
ADD CONSTRAINT FKExhibicionSalaSala FOREIGN KEY (idSala)
REFERENCES Sala(idSala)

ALTER TABLE SalaTaller
ADD CONSTRAINT FKSalaTallerSala FOREIGN KEY (idSala)
REFERENCES Sala(idSala)

ALTER TABLE SalaTaller
ADD CONSTRAINT FKSalaTallerTaller FOREIGN KEY (idTaller)
REFERENCES Taller(idTaller)

--INSERT
INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Miriam Priscila', 'Moreno', 'Reyna', 'I19050460@monclova.tecnm.mx', 'Tec12345.', 1, GETDATE())
GO


INSERT INTO Categoria (codigo, nombre, idUsuarioCrea, fechaCrea)
    VALUES ('C-101', 'Colección Pintoras', 1, GETDATE()),
           ('C-102', 'Colección Escritoras', 1, GETDATE()),
           ('C-103', 'Ropa', 1, GETDATE()),
           ('C-104', 'Hogar y Decoraciones', 1, GETDATE()),
           ('C-105', 'Librería', 1, GETDATE()),
           ('C-106', 'Papelería', 1, GETDATE()),
           ('C-107', 'Niños', 1, GETDATE()),
           ('C-108', 'Ropa Niños', 1, GETDATE()),
           ('C-109', 'Accesorios', 1, GETDATE()),
           ('C-110', 'Snacks', 1, GETDATE())
GO

INSERT INTO Clasificacion (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Impresionismo', 1, GETDATE()),
           ('Retrato', 1, GETDATE()),
           ('Autorretrato', 1, GETDATE()),
           ('Poesía', 1, GETDATE()),
           ('Documental', 1, GETDATE()),
           ('Paisaje', 1, GETDATE()),
           ('Novela', 1, GETDATE()),
           ('Biográfico', 1, GETDATE()),
           ('Abstracto', 1, GETDATE()),
           ('Contemporaneo', 1, GETDATE()),
		   ('Drama', 1, GETDATE())
GO

INSERT INTO CorrienteArtistica (nombre, descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('Modernismo', 'Fue un arte novedoso, de características juveniles, símbolo de la libertad y de la etapa moderna.', 1, GETDATE()),
           ('Fauvismo', 'El fauvismo francés fue un movimiento artístico exclusivamente pictórico. El uso del color en su más puro estado es su característica principal', 1, GETDATE()),
           ('Cubismo', 'La corriente cubista rompe radicalmente con la pintura tradicional, materializada en el uso de la perspectiva.', 1, GETDATE()),
           ('Impresionismo', 'Se caracteriza por su persistente experimentación con la iluminación (similar al luminismo). El manejo de la luz se considera como un factor crucial para alcanzar belleza y balance en la pintura.', 1, GETDATE()),
           ('Expresionismo', 'Está considerada la primera de las vanguardias, por lo que no es un movimiento como tal, sino un modo de entender el arte.', 1, GETDATE()),
           ('Surrealismo', 'Es una corriente cargada de simbolismo, que ofrece una evidente dificultad de interpretación por haber perdido los referentes naturales.', 1, GETDATE()),
           ('Minimalismo', 'El arte minimalista se enfoca en la necesidad de reducir el contenido a la más pura esencia, deshaciéndose así de todo elemento restante que no aporte valor a la obra.', 1, GETDATE()),
           ('Hiperrealismo', 'Busca la representación de la realidad de un modo absolutamente fiel y objetivo. Con ello, se enfrenta directamente con la fotografía.', 1, GETDATE()),
           ('Barroco', 'Utilizaba la exageración como una forma de facilitar la expresión de las pasiones humanas internas, como el amor o la furia, pero también las formas de la espiritualidad, como la fe, la paz y la misericordia.', 1, GETDATE()),
           ('Renacimiento', 'Se destacó por su interés en el saber de la razón y en los valores clásicos de la antigua Grecia.', 1, GETDATE())
GO

INSERT INTO DirectorDeExhibicionExterno (nombre, apellidoPaterno, apellidoMaterno, ciudad, pais, fechaNacimiento, rfc, idUsuarioCrea, fechaCrea)
    VALUES ('Alfred', 'Garcia', 'Castillo', 'El Prat de Llobregat', 'España', '1997-04-14', 'GACA970414HCL', 1, GETDATE()),
           ('Juan Pablo', 'Villamil', 'Lorente','Bogotá', 'Colombia', '1994-09-01', 'VILJ940901LHS', 1, GETDATE()),
           ('Raoul', 'Vázquez', 'García', 'Montgat', 'España', '1997-03-19', 'VAGR970319JAD', 1, GETDATE()),
           ('Ricardo Luis', 'Urdiales', 'Merino', 'Palma de Mallorca', 'España', '1989-09-01', 'URMR890901FDE', 1, GETDATE()),
           ('Agoney', 'Hernandez', 'Morales', 'Adeje', 'España', '1995-10-18', 'HEAA951018REC', 1, GETDATE()),
           ('Mireya', 'Bravo', 'Alcalá', 'Alhaurín de la Torre', 'España', '1997-06-25', 'BRAM970625MKD', 1, GETDATE()),
           ('Melissa', 'Ferman', 'Reyna', 'Chihuahua', 'Chihuahua', '1998-08-25', 'FERM980825MSA', 1, GETDATE()),
           ('Paz', 'Amador', 'González', 'Oaxaca', 'Oaxaca', '1997-01-25', 'AMGP970125MJA', 1, GETDATE()),
           ('Fernanda', 'Melchor', 'Castillo', 'Puebla', 'Mexico', '1990-01-23', 'MECF900123MVD', 1, GETDATE()),
           ('Andrea', 'Santos', 'Reyes', 'Puebla', 'Puebla', '1999-05-14', 'SARA990514CED', 1, GETDATE())
GO

INSERT INTO Distribuidora (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Altitude Film Distribution', 1, GETDATE()),
           ('CBS Films', 1, GETDATE()),
           ('StudioCanal', 1, GETDATE()),
           ('Universal Pictures', 1, GETDATE()),
           ('Tōhō', 1, GETDATE()),
           ('Walt Disney Studios Motion Pictures', 1, GETDATE()),
           ('A Contracorriente Films', 1, GETDATE()),
           ('The Weinstein Company', 1, GETDATE()),
           ('Gaumont', 1, GETDATE()),
           ('UIP Duna', 1, GETDATE())
GO

INSERT INTO Editorial (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Steventon Books', 1, GETDATE()),
           ('Thomas Cautley Newby, Publisher', 1, GETDATE()),
           ('All the Year Round', 1, GETDATE()),
           ('El mensajero ruso', 1, GETDATE()),
           ('La Revue de Paris', 1, GETDATE()),
           ('Hetzel', 1, GETDATE()),
           ('Planeta', 1, GETDATE()),
           ('Séneca', 1, GETDATE()),
           ('Juan Régulo Pérez', 1, GETDATE()),
           ('*sin datos*', 1, GETDATE())
GO

INSERT INTO Escuela (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Liga de estudiantes de arte de Nueva York', 1, GETDATE()),
           ('Universidad de Ryerson', 1, GETDATE()),
           ('Universidad Estatal de San Francisco', 1, GETDATE()),
           ('Philadelphia High School for Girls', 1, GETDATE()),
           ('San Francisco Art Institute Northwood High School', 1, GETDATE()),
           ('Escuela Nacional de Artes Cinematográficas', 1, GETDATE()),
           ('Instituto de las Artes de California', 1, GETDATE()),
           ('Academia de Bellas Artes de Varsovia', 1, GETDATE()),
           ('Keble College', 1, GETDATE()),
           ('Universidad de Gakushuin', 1, GETDATE())
GO

INSERT INTO FormatoDeCamara (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('1/10"', 1, GETDATE()),
           ('1/8"', 1, GETDATE()),
           ('1/4"', 1, GETDATE()),
           ('Super 8mm film frame', 1, GETDATE()),
           ('Standard 16mm film frame', 1, GETDATE()),
           ('Super 35mm film 4 film', 1, GETDATE()),
           ('IMAX fil frame', 1, GETDATE()),
           ('Large Format Film 4x5', 1, GETDATE()),
           ('Large Format Film 5x7', 1, GETDATE()),
           ('Large Format Film 8x10', 1, GETDATE())
GO

INSERT INTO Idioma (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Español', 1, GETDATE()),
           ('Inglés Británico', 1, GETDATE()),
           ('Francés', 1, GETDATE()),
           ('Alemán', 1, GETDATE()),
           ('Ruso', 1, GETDATE()),
           ('Inglés estadounidense', 1, GETDATE()),
           ('Catalán', 1, GETDATE()),
           ('Italiano', 1, GETDATE()),
           ('Neerlandés', 1, GETDATE()),
           ('Ucraniano', 1, GETDATE())
GO

INSERT INTO Pais (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('México', 1, GETDATE()),
           ('España', 1, GETDATE()),
           ('Países bajos', 1, GETDATE()),
           ('Rusia', 1, GETDATE()),
           ('Ucrania', 1, GETDATE()),
           ('Inglaterra', 1, GETDATE()),
           ('Francia', 1, GETDATE()),
           ('Grecia', 1, GETDATE()),
           ('Italia', 1, GETDATE()),
           ('Alemania', 1, GETDATE()),
           ('Estados Unidos', 1, GETDATE()),
           ('Suiza', 1, GETDATE()),
           ('Sudáfrica', 1, GETDATE())
GO

INSERT INTO Periodo (nombre, descripcion, añoInicio, añoFinal, idUsuarioCrea, fechaCrea)
    VALUES ('Grecia', 'Caracterizado por el naturalismo y el uso de razón en medidas y proporciones.', '5 a.C.', '50', 1, GETDATE()),
           ('Gótico', 'Periodo en el que la iluminación en el arte era el elemento principal.', '800', '1000', 1, GETDATE()),
           ('Renacimiento', 'Estilo inspirado en la naturaleza, uso de la perspectiva.', '1400', '1500', 1, GETDATE()),
           ('Barroco', 'Periodo con arte refinado y ornamentado con formas más dinámicas y efectistas.', '1600', '1700', 1, GETDATE()),
           ('Edad Moderna', 'Supuso cambios radicales a nivel político, económico, social y cultural.', '1500', '1700', 1, GETDATE()),
           ('Romanticismo', 'Movimiento cultural que se originó en Alemania y en Reino Unido a finales del siglo XVIII', '1700', '1800', 1, GETDATE()),
           ('Siglo XX', 'El arte del siglo XX experimentó una transformación: el arte se dirige a los sentidos, no al intelecto.', '1900', '2000', 1, GETDATE()),
           ('Vanguardismo', 'Su concepto de realidad fue cuestionado por las nuevas teorías científicas', '1900', '1950', 1, GETDATE()),
           ('Nuevas tecnologías', 'El arte ha cambiado sus formas de expresión, y asi se ampliado los límites del arte.', '1965', 'Actual', 1, GETDATE()),
           ('Postmodernismo', 'El periodo en el que se está actualmente', '1975', 'Actual', 1, GETDATE())
GO

INSERT INTO Productora (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('BreakThru Productions', 1, GETDATE()),
           ('Iconoclast', 1, GETDATE()),
           ('Cartoon Saloon', 1, GETDATE()),
           ('Studio Ghibli', 1, GETDATE()),
           ('Walt Disney Pictures', 1, GETDATE()),
           ('Silverwood Films', 1, GETDATE()),
           ('Lionsgate', 1, GETDATE()),
           ('Columbia Pictures', 1, GETDATE()),
           ('20th Century-Fox', 1, GETDATE()),
           ('Paramount Pictures', 1, GETDATE())
GO

INSERT INTO Proveedor (nombre, descripcion, rfc, idUsuarioCrea, fechaCrea)
    VALUES ('Juguetes Didácticos Para Niños', 'Creación de juguetes didácticos.', 'JDPN980123JKL', 1, GETDATE()),
           ('Editorial Planeta', 'Editorial de libros y revistas', 'EDPL870503LAD', 1, GETDATE()),
           ('Personalizados Tijoux', 'Personalización de artículos de papelería', 'PRTJ890125JAB', 1, GETDATE()),
           ('M&M Publicidad', 'Personalización de playeras, tazas y publicidad', 'HDDA010714JED', 1, GETDATE()),
           ('JEDET', 'Fabricación de dulces artesanales', 'JUSD990830NBS', 1, GETDATE()),
           ('DISASE', 'Galletas y postres artesanales', 'JHOP930218VFE', 1, GETDATE()),
           ('SEESAW', 'Productos a base de resina epóxica', 'MYNG930309JHD', 1, GETDATE()),
           ('mono.', 'Imitación de pinturas', 'KNMJ940914LKD', 1, GETDATE()),
           ('VANTE', 'Imitación de pinturas', 'KTHG951230UYE', 1, GETDATE()),
           ('JKL', 'Imitación de pinturas en accesorios', 'JJKK970901JKL', 1, GETDATE())
GO

INSERT INTO Regalo (nombre, descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('Regalo 1', 'Tote bag', 1, GETDATE()),
           ('Regalo 2', 'Paquete de artículos de papelería', 1, GETDATE()),
           ('Regalo 3', '5 postcards random', 1, GETDATE()),
           ('Regalo 4', '5 photocards random', 1, GETDATE()),
           ('Regalo 5', 'Tote bag y 5 photocards', 1, GETDATE()),
           ('Regalo 6', 'Tote bag y 5 postcards random', 1, GETDATE()),
           ('Regalo 7', 'Tote bag, poster random y 5 photocards', 1, GETDATE()),
           ('Regalo 8', 'Tote bag, poster random y 5 postcards', 1, GETDATE()),
           ('Regalo 9', 'Tote bag y paquete de artículos de papelería', 1, GETDATE()),
           ('Regalo 10', 'Paquete de artículos de papelería y 5 photocards random', 1, GETDATE())
GO

INSERT INTO TecnicaEscultura (nombre, descripcion, material, idUsuarioCrea, fechaCrea)
    VALUES ('Esculpido', 'Es común en arquitectura, así como en la fabricación de figuras.', 'Piedra', 1, GETDATE()),
           ('Tallado', 'La técnica del tallado es un proceso mediante el cual el material se elimina desde el exterior hacia el interior.', 'Materia leñosa', 1, GETDATE()),
           ('Tallado de materia', 'La disponibilidad de los tipos de madera es el determinante clave para hacer diferentes tallados.', 'Madera', 1, GETDATE()),
           ('Fundición', 'Las esculturas que están fundidas están hechas de un material mezclado, que luego se vierte en un molde.', 'Metal', 1, GETDATE()),
           ('Modelado', 'La técnica del modelado consiste en darle forma a un material blando o maleable del que estará hecho la escultura.', 'Arcilla',  1, GETDATE()),
           ('Modelado en cera', 'La cera también es versátil y puede modelarse en cualquier forma de arte.', 'Cera', 1, GETDATE()),
           ('Pulido', 'El pulido es una de las técnicas escultóricas más conocidas. A esta operación también se la conoce como pulimento.', 'Metal', 1, GETDATE()),
           ('Cincelar', 'Arte que se trabaja con cincel y martillo en planchas de metal para convertirlas en alto o bajorrelieve de una figura.', 'Metal', 1, GETDATE()),
           ('Galvanoplastia', 'Es la aplicación tecnológica de la deposición de metales mediante electricidad, también llamada electrodeposición.', 'Metal', 1, GETDATE()),
           ('Repujado', 'Técnica artesanal que consiste en trabajar planchas de metal, cuero u otros materiales maleables, para obtener una figura ornamental en relieve.', 'Metal', 1, GETDATE())
GO

INSERT INTO TecnicaPintura (nombre, descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('Acuarela', 'Cuando el aglutinante es la goma arábiga y como vehículo el agua.', 1, GETDATE()),
           ('Témperas', 'Cuando el vehículo es agua y diferentes tipos de colas.', 1, GETDATE()),
           ('Collage', 'Técnica mixta, en donde se utilizan técnicas clásicas como el óleo, conjuntamente con el encolado de objetos diversos.', 1, GETDATE()),
           ('Cera', 'Cuando el vehículo son ceras, que normalmente se usan calientes o en formas de barritas que no necesitan calentarse.', 1, GETDATE()),
           ('Lápices de colores', 'Son un conjunto de lápices con mina de diversos colores. Cómo aglutinante se emplean colas y ceras.', 1, GETDATE()),
           ('Acrílicos', 'Cuando el vehículo usado son los diversos materiales sintéticos. El aglutinante es el alquil', 1, GETDATE()),
           ('Pastel', 'Cuando se pinta con tizas de colores. Lo que da cohesión a las barras es la goma tragacanto.', 1, GETDATE()),
           ('Temple', 'Cuando el aglutinante es una emulsión, generalmente huevo o caseína.', 1, GETDATE()),
           ('Óleos', 'Cuando el vehículo empleado son aceites.', 1, GETDATE()),
           ('Técnicas mixtas', 'Cuando se emplean diversas técnicas en una misma obra.', 1, GETDATE())
GO

INSERT INTO TecnicaPintura (nombre, descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('Acuarela', 'Cuando el aglutinante es la goma arábiga y como vehículo el agua.', 1, GETDATE()),
           ('Témperas', 'Cuando el vehículo es agua y diferentes tipos de colas.', 1, GETDATE()),
           ('Collage', 'Técnica mixta, en donde se utilizan técnicas clásicas como el óleo, conjuntamente con el encolado de objetos diversos.', 1, GETDATE()),
           ('Cera', 'Cuando el vehículo son ceras, que normalmente se usan calientes o en formas de barritas que no necesitan calentarse.', 1, GETDATE()),
           ('Lápices de colores', 'Son un conjunto de lápices con mina de diversos colores. Cómo aglutinante se emplean colas y ceras.', 1, GETDATE()),
           ('Acrílicos', 'Cuando el vehículo usado son los diversos materiales sintéticos. El aglutinante es el alquil', 1, GETDATE()),
           ('Pastel', 'Cuando se pinta con tizas de colores. Lo que da cohesión a las barras es la goma tragacanto.', 1, GETDATE()),
           ('Temple', 'Cuando el aglutinante es una emulsión, generalmente huevo o caseína.', 1, GETDATE()),
           ('Óleos', 'Cuando el vehículo empleado son aceites.', 1, GETDATE()),
           ('Técnicas mixtas', 'Cuando se emplean diversas técnicas en una misma obra.', 1, GETDATE())
GO

INSERT INTO TipoArticulo (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Jar', 1, GETDATE()),
           ('Comida', 1, GETDATE()),
           ('Playera niña', 1, GETDATE()),
           ('Playera niño', 1, GETDATE()),
           ('Playera adulto', 1, GETDATE()),
           ('Juguete', 1, GETDATE()),
           ('Libreta', 1, GETDATE()),
           ('Libro', 1, GETDATE()),
           ('Pintura imitación', 1, GETDATE()),
           ('Llavero', 1, GETDATE())
GO

INSERT INTO TipoArtista (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Plástico', 1, GETDATE()),
           ('Plástico y pintor', 1, GETDATE()),
           ('Cineasta', 1, GETDATE()),
           ('Novelista', 1, GETDATE()),
           ('Poeta', 1, GETDATE()),
           ('Pintor', 1, GETDATE()),
           ('Fotógrafo', 1, GETDATE()),
           ('Ilustrador', 1, GETDATE()),
           ('Conceptual', 1, GETDATE()),
           ('Digital', 1, GETDATE())
GO

INSERT INTO TipoBoleto (nombre, descripcion, vigencia, idUsuarioCrea, fechaCrea)
    VALUES ('T-Boleto 1', 'Boleto individual para 2 visitas al mes por un año.', '1 año', 1, GETDATE()),
           ('T-Boleto 2', 'Boleto de pareja para 2 visitas al mes por un año', '1 año', 1, GETDATE()),
           ('T-Boleto 3', 'Boleto estándar para una visita individual (niño)', '1 día', 1, GETDATE()),
           ('T-Boleto 4', 'Boleto estándar para una visita individual (adulto)', '1 día', 1, GETDATE()),
           ('T-Boleto 5', 'Boleto premium para una visita individual (niño)', '1 día', 1, GETDATE()),
           ('T-Boleto 6', 'Boleto estándar para una visita individual (adulto)', '1 día', 1, GETDATE()),
           ('T-Boleto 7', 'Boleto premium para exhibición y proyección', '1 día', 1, GETDATE()),
           ('T-Boleto 8', 'Boleto estándar para exhibición y proyección', '1 día', 1, GETDATE()),
           ('T-Boleto 9', 'Boleto estándar para proyección de película', '1 día', 1, GETDATE()),
           ('T-Boleto 10','Boleto premium para proyección de película', '1 día', 1, GETDATE())
GO

INSERT INTO TipoEdicion (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Primera edición', 1, GETDATE()),
           ('Primera reimpresión', 1, GETDATE()),
           ('Segunda reimpesión', 1, GETDATE()),
           ('Manuscrito', 1, GETDATE()),
           ('Diplomática', 1, GETDATE()),
           ('Facsimilar', 1, GETDATE()),
           ('Apócrifa', 1, GETDATE()),
           ('Acéfala', 1, GETDATE()),
           ('Múltiple', 1, GETDATE()),
           ('Paleográfica', 1, GETDATE())
GO

INSERT INTO TipoEmpleado (nombre, descripcion, sueldoBase, idUsuarioCrea, fechaCrea)
    VALUES ('Director', 'Dirección de museo', 25000, 1, GETDATE()),
           ('Vigilante de seguridad', 'Vigilancia de puertas, tiendas y exhibiciones', 8750, 1, GETDATE()),
           ('Intendente', 'Limpieza y mantenimiento del museo', 8000, 1, GETDATE()),
           ('Guía', 'Guía de exhibiciones permanentes y temporales', 10000, 1, GETDATE()),
           ('Documentalista', 'Documentación de las obras del museo', 25000, 1, GETDATE()),
           ('Vendedor', 'Ventas en las tiendas del museo', 8000, 1, GETDATE()),
           ('Restauradores', 'Restauración y conservación de las obras y objetos', 25000, 1, GETDATE()),
           ('Auxiliar de sala', 'Ayuda en el orden de sala y orientacion de visitantes', 10000, 1, GETDATE()),
           ('Recepcionista', 'Recibimiento de visitantes', 9000, 1, GETDATE()),
           ('Educador', 'Impartir talleres', 10000, 1, GETDATE()),
           ('Director de exhibición', 'Dirección de exhibición', 20000, 1, GETDATE())
GO

INSERT INTO TipoEvento (nombre, descripcion, organizador, idUsuarioCrea, fechaCrea)
    VALUES ('Conferencias', 'Conferencia o plática', 'I', 1, GETDATE()),
           ('Desayuno', 'Desayuno privado en el jardín del museo', 'I', 1, GETDATE()),
           ('Entrega de premios', 'Fiesta de entrega de premios', 'I', 1, GETDATE()),
           ('Seminario universitario', 'Junta para estudio de un tema', 'E', 1, GETDATE()),
           ('Graduación', 'Graduación de universidades', 'E', 1, GETDATE()),
           ('Recital de danza', 'Recital de danza por escuela independiente', 'E', 1, GETDATE()),
           ('Recital de canto', 'Recital de canto por escuela independiente', 'E', 1, GETDATE()),
           ('Obra de teatro', 'Obra teatral por grupos independiente', 'E', 1, GETDATE()),
           ('Concurso de ajedrez', 'Concurso anual de ajedrez para niños y adultos', 'I', 1, GETDATE()),
           ('Concurso de pinutra', 'Concurso de pintura para niños y jóvenes', 'I', 1, GETDATE())
GO

INSERT INTO TipoExhibicion (nombre, descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('E-Interna-Permanente', 'Exhibición permanente coordinada por el museo', 1, GETDATE()),
           ('E-Interna-Temporal', 'Exhibición temporal coordinada por el museo', 1, GETDATE()),
           ('E-Externa-Permanente', 'Exhibición permanente coordinada por externos', 1, GETDATE()),
           ('E-Externa-Temporal', 'Exhibición temporal coordinada por externos', 1, GETDATE()),
           ('E-IE-Permanente', 'Exhibición permanente coordinada por el museo y externos', 1, GETDATE()),
           ('E-IE-Temporal', 'Exhibición temporal coordinada por el museo y externos', 1, GETDATE()),
           ('E-Galería', 'Exhibición de obras de artistas locales', 1, GETDATE()),
           ('E-Interna-Itinerante', 'Exhibición intinerante coordinada por el museo', 1, GETDATE()),
           ('E-Externa-Itinerante', 'Exhibición itinerante coordinada por externos', 1, GETDATE()),
           ('E-IE-Itinerante', 'Exhibición intinerante coordinada por el museo y externos', 1, GETDATE())
GO

INSERT INTO TipoGrupo (nombre, numeroMaximo, numeroMinimo, idUsuarioCrea, fechaCrea)
    VALUES ('Profesores-Estudiantes-Educación básica', 8, 5, 1, GETDATE()),
           ('Profesores-Estudiantes-Educación media superior', 10, 8, 1, GETDATE()),
           ('Profesores-Estudiantes-Educacion superior', 15, 10, 1, GETDATE()),
           ('Prensa', 5, 3, 1, GETDATE()),
           ('Corporativo', 10, 5, 1, GETDATE()),
           ('Estándar-Extranjero', 10, 8, 1, GETDATE()),
           ('Premium-Extranjero', 5, 3, 1, GETDATE()),
           ('Estandar-Nacional', 10, 8, 1, GETDATE()),
           ('Premium-Nacional', 5, 3, 1, GETDATE()),
           ('Adultos mayores y educación especial', 5, 3, 1, GETDATE())
GO

INSERT INTO TipoObjeto (nombre, descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('Carta', 'Carta enviada a un/por el artista', 1, GETDATE()),
           ('Herramienta', 'Herramienta usada en un periodo específico', 1, GETDATE()),
           ('Utensilio', 'Utensilios usados por un artista', 1, GETDATE()),
           ('Boceto', 'Boceto hecho por un artista', 1, GETDATE()),
           ('Ropa', 'Ropa que usó un artista', 1, GETDATE()),
           ('Cuaderno de trabajo', 'Cuaderno de trabajo de un artista', 1, GETDATE()),
           ('Vestuario', 'Vestuario usado en una película', 1, GETDATE()),
           ('Premio', 'Premio ganado por un artista', 1, GETDATE()),
           ('Modelo a escala', 'Modelo a escala de edificios arquitectónicos', 1, GETDATE()),
           ('Guión', 'Guión original de una película', 1, GETDATE())
GO

INSERT INTO TipoSala (nombre, descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('Auditorio', 'Auditorio para evento con gran cantidad de personas', 1, GETDATE()),
           ('Sala de usos múltiples', 'Sala para evento con asistencia limitada', 1, GETDATE()),
           ('Pabellón', 'Espacio para evento al aire libre', 1, GETDATE()),
           ('Sala de proyeccion', 'Sala para proyección', 1, GETDATE()),
           ('Teatro al aire libre', 'Foro para presentación al aire libre', 1, GETDATE()),
           ('Sala de exhibición', 'Sala para exhibición de obras', 1, GETDATE()),
           ('Sala interactiva', 'Sala con exposiciones interactivas', 1, GETDATE()),
           ('Salón de taller infantil', 'Sala especial para taller de niños', 1, GETDATE()),
           ('Sala de recepción', 'Sala para recibir visitantes', 1, GETDATE()),
           ('Salón de taller', 'Sala para taller', 1, GETDATE())
GO

INSERT INTO TipoTaller (nombre, modalidad, numeroMaximo, numeroMinimo, idUsuarioCrea, fechaCrea)
    VALUES ('Infantil', 'P', 30, 25, 1, GETDATE()),
           ('Verano', 'G', 30, 20, 1, GETDATE()),
           ('Infanitl-Especial', 'G', 15, 10, 1, GETDATE()),
           ('Educativo', 'P', 20, 15, 1, GETDATE()),
           ('Pedagógico', 'G', 15, 10, 1, GETDATE()),
           ('Teórico', 'G', 25, 20, 1, GETDATE()),
           ('Seminario', 'P', 40, 20, 1, GETDATE()),
           ('Literario', 'G', 20, 15, 1, GETDATE()),
           ('Artesanal', 'P', 15, 10, 1, GETDATE()),
           ('Artístico', 'P', 15, 10, 1, GETDATE())
GO

INSERT INTO TipoTienda (nombre, descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('Básica', 'Tienda de souvenirs', 1, GETDATE()),
           ('Especial', 'Tienda de souvenirs y otros proveedores', 1, GETDATE()),
           ('Librería', 'Venta de libros de arte y papelería', 1, GETDATE()),
           ('Independiente', 'Vendedores independientes', 1, GETDATE()),
           ('Multitienda', 'Venta deonde se encuentran todos los articulos', 1, GETDATE()),
           ('Outlet', 'Tienda de descuentos', 1, GETDATE()),
           ('Showroom', 'Espacio donde se expone producto para vender en espacios minoristas.', 1, GETDATE()),
           ('Corner', 'Tienda de empresa externa en espacio pequeño', 1, GETDATE()),
           ('Pop-up', 'Tienda temporal para publicidad de marca', 1, GETDATE()),
           ('Mercado', 'Tienda temporal en evento del museo', 1, GETDATE())
GO

INSERT INTO TipoVisita (nombre, descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('Educativa', 'Visita de grupos de estudiantes', 1, GETDATE()),
           ('Turística', 'Visita de turista con empresa de viajes', 1, GETDATE()),
           ('Prensa', 'Visita de medios de comunicación', 1, GETDATE()),
           ('Corporativa', 'Visita de miemboros administrativos del museo', 1, GETDATE()),
           ('Empresarial', 'Visita organizada para empleados de una empresa', 1, GETDATE()),
           ('Discapacitado', 'Visita de persona discapacitada', 1, GETDATE()),
           ('Ordinaria completa', 'Visita al museo completo', 1, GETDATE()),
           ('Ordinaria específica', 'Visita a exhibiciones específicas', 1, GETDATE()),
           ('Evento', 'Visita por evento realizado en el museo', 1, GETDATE()),
           ('Cortesía', 'Visita con entrada gratuita', 1, GETDATE())
GO

INSERT INTO Ubicacion (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Piso 1', 1, GETDATE()),
           ('Piso 2', 1, GETDATE()),
           ('Piso 3', 1, GETDATE()),
           ('Piso 4', 1, GETDATE()),
           ('Piso 5', 1, GETDATE()),
           ('Jardín', 1, GETDATE()),
           ('Recepción', 1, GETDATE())
GO

INSERT INTO Visitante (nombre, apellidoPaterno, apellidoMaterno, correo, telefono, fechaNacimiento, idUsuarioCrea, fechaCrea)
    VALUES ('Namjoon', 'Kim', '', 'namgreen@gmail.com', '8226672918', '1994-09-12', 1, GETDATE()),
           ('Seokjin', 'Kim', '', 'wwhuknow@hotmail.com', '8220964892', '1992-12-04', 1, GETDATE()),
           ('Yoongi', 'Min', '', 'tangerinedark@gmail.com', '8223902765', '1993-03-09', 1, GETDATE()),
           ('Hoseok', 'Jung', '', 'urhope@yahoo.com', '8226397201', '1994-02-18', 1, GETDATE()),
           ('Jimin', 'Park', '', 'lachimolala@hotmail.com', '8228495027', '1995-10-13', 1, GETDATE()),
           ('Taehyung', 'Kim', '', 'blueandgrey@hotmail.com', '8224839672', '1995-12-30',  1, GETDATE()),
           ('Jungkook', 'Jung', '', 'lovearmy@hotmail.com', '8225362500', '1997-09-01', 1, GETDATE()),
           ('Micol', 'Alanis', 'López', 'alanismicol@hotmail.com', '8661397396', '1995-04-20', 1, GETDATE()),
           ('Max', 'Alanis', 'López', 'maxiblue@hotmail.com', '8661245790', '1989-12-13', 1, GETDATE()),
           ('Adele', 'Blue', 'Adkins', 'easyonmail@hotmail.com', '0203827156', '1988-05-05', 1, GETDATE())
GO

INSERT INTO Articulo (codigo, nombreArticulo, descripcion, precio, idCategoria, idTipoArticulo, idProveedor, idUsuarioCrea, fechaCrea)
    VALUES ('H-401', 'Taza van Gogh', 'Taza de peltre-van Gogh', 120, 4, 1, 3, 1, GETDATE()),
           ('R-301', 'Playera Almendro', 'Playera para adulto', 280, 3, 5, 4, 1, GETDATE()),
           ('P-601', 'Agenda Pintoras', 'Agenda 2020, Colección Pintoras', 350, 1, 6, 3, 1, GETDATE()),
           ('RN-81', 'Playera Monet', 'Playera para niño', 250, 8, 4, 3, 1, GETDATE()),
           ('A-901', 'Llavero All Too Well', 'Llavero de resina epóxica', 75, 9, 10, 6, 1, GETDATE()),
           ('CP-11', 'Pintura Las Dos Fridas', 'Pintura imitación 2m x 1m', 650, 1, 9, 9, 1, GETDATE()),
           ('N-701', 'Ajolote', 'Peluche', 250, 7, 6, 1, 1, GETDATE()),
           ('S-010', 'Mermelada de durazno', 'Mermelada artesanal orgánica', 150, 10, 2, 6, 1, GETDATE()),
           ('E-201', 'Taza Jane Austen', 'Taza cónica', 120, 2, 1, 4, 1, GETDATE()),
           ('CP-12', 'Pintura Judith decapitando a Holofernes', 'Pintura imitación 2m x 1m', 850, 1, 9, 8, 1, GETDATE())
GO

INSERT INTO Artista (nombre, apellidoPaterno, apellidoMaterno, ciudad, pais, añoNacimiento, añoMuerte, idTipoArtista, idUsuarioCrea, fechaCrea)
    VALUES ('Vincent Willem', '', 'van Gogh', 'Zundert', 'Países Bajos', '1853', '1890', 6, 1, GETDATE()),
           ('Claude', 'Monet', '', 'Paris', 'Francia', '1840', '1926', 6, 1, GETDATE()),
           ('Frida', 'Kahlo', 'Calderon', 'Ciudad de México', 'México', '1907', '1954', 6, 1, GETDATE()),
           ('Vasili Vasílievich', 'Kandinsky', '', 'Odessa', 'Ucrania', '1866', '1944', 6, 1, GETDATE()),
           ('Artemisia Lomi', 'Gentileschi ', '', 'Roma', 'Italia', '1593', '1653', 6, 1, GETDATE()),
           ('Berthe Marie Pauline', 'Morisot ', '', 'Bourges', 'Francia', '1841', '1895', 6, 1, GETDATE()),          
           ('Michelangelo', 'Buonarroti', '', 'Caprese Michelangelo', 'Italia', '1475', '1564', 2, 1, GETDATE()),
           ('Auguste', 'Rodin', '', 'París', 'Francia', '1840', '1917', 1, 1, GETDATE()),
           ('Alberto', 'Giacometti', '', 'Borgonovo', 'Suiza', '1901', '1966', 1, 1, GETDATE()),
           ('Marcel', 'Duchamp', '', 'Blainville-Crevon', 'Francia', '1887', '1968', 1, 1, GETDATE()),
           ('Donatello', '', '', '', 'República de Florencia', '1386', '1466', 2, 1, GETDATE()),
           ('Gian Lorenzo', 'Bernini', '', 'Nápoles', 'Italia', '1598', '1680', 2, 1, GETDATE()),
           ('Jane', 'Austen', '', 'Steventon', 'Reino Unido', '1775', '1817', 4, 1, GETDATE()),
           ('Charlotte', 'Brontë', '', 'Thornton', 'Reino Unido', '1816', '1855', 4, 1, GETDATE()),
           ('Emily', 'Brontë', '', 'Thornton', 'Reino Unido', '1818', '1848', 4, 1, GETDATE()),
           ('Anne', 'Brontë', '', 'Thornton', 'Reino Unido', '1820', '1849', 4, 1, GETDATE()),
           ('Virginia', 'Stephen', '', 'Kensington', 'Londres', '1882', '1841', 4, 1, GETDATE()),
           ('Emily', 'Dickinson', '', 'Amherst', 'Estados Unidos', '1830', '1886', 5, 1, GETDATE()),
           ('Mary', 'Wollstonecraft', '', 'Londres', 'Reino Unido', '1797', '1851', 4, 1, GETDATE()),
           ('Alfonso', 'Cuarón', 'Orozco', 'Ciudad de México', 'México', '1961', '', 3, 1, GETDATE()),
           ('Guillermo', 'del Toro', 'Gómez', 'Guadalajara', 'Jalisco', '1964', '', 3, 1, GETDATE()),
           ('Dorota', 'Kobiela', '', 'Bytom', 'Polonia', '1978', '', 3, 1, GETDATE()),
           ('Hugh', 'Whelchman', '', 'Bracknell', 'Reino Unido', '1975', '', 3, 1, GETDATE()),
           ('Lana', 'Wilson', '', 'Kirkland', 'Washington', '1983', '', 3, 1, GETDATE()),
           ('Greta', 'Gerwig', '', 'California', 'Estados Unidos', '1983', '', 3, 1, GETDATE()),
           ('Joonho', 'Bong', '', 'Daegu', 'Corea del Sur', '1969', '', 3, 1, GETDATE()),
           ('Berenice', 'Abbot', '', 'Springfield', 'Estados Unidos', '1898', '1991', 7, 1, GETDATE()),
           ('Zanele', 'Muhoil', '', 'Umlazi', 'Sudáfrica', '1972', '', 7, 1, GETDATE()),
           ('Zoe', 'Strauss', '', 'Filadelfia', 'Estados Unidos', '1970', '', 7, 1, GETDATE()), 
           ('Kay', 'Lahusen', '', 'Cincinnati', 'Estados Unidos', '1930', '2021', 7, 1, GETDATE()),
           ('Annie', 'Leibovitz', '', 'Waterbury', 'Estados Unidos', '1949', '', 7, 1, GETDATE()),
           ('Dorothea', 'Lange', '', 'Nueva Jersey', 'Estados Unidos', '1895', '1965', 7, 1, GETDATE())
GO

INSERT INTO Empleado (numero, nombre, apellidoPaterno, apellidoMaterno, genero, ciudad, pais, fechaNacimiento, rfc, idTipoEmpleado, idUsuarioCrea, fechaCrea)
    VALUES ('12345', 'Antonia', 'García', 'Navarro', 'FEM', 'Morelia', 'México', '1982-05-20', 'NAGA820520JGS', 4, 1, GETDATE()),
           ('67891', 'Juan Jesús', 'López', 'Castillo', 'MAS', 'Chiuhauha', 'México', '1978-08-10', 'LOCJ780810', 2, 1, GETDATE()),
           ('01112', 'Laura', 'Benavides', 'Páez', 'FEM', 'Managua', 'Nicaragua', '1995-07-22', 'BEPL950722FRE', 7, 1, GETDATE()),
           ('13141', 'Pamela', 'Morales', 'Gómez', 'FEM', 'San Marcos', 'Guatemala', '1989-12-13', 'MOGP89123LJE', 5, 1, GETDATE()),
           ('51617', 'Oscar', 'Osorio', 'García', 'MAS', 'Ciudad de México', 'México', '1989-12-30', 'OSGO891230PIR', 4, 1, GETDATE()),
           ('18192', 'Homero', 'Hernández', 'Pérez', 'MAS', 'Puebla', 'México', '1979-01-02', 'HEPH790102EDS', 8, 1, GETDATE()),
           ('02122', 'Alejandra', 'León', 'Ávila', 'FEM', 'Monterrey', 'México', '1990-09-16', 'LEAA900916TRE', 3, 1, GETDATE()),
           ('23242', 'Flor', 'Ortíz', 'Pineda', 'FEM', 'Mexicali', 'México', '1988-03-30', 'PIOF880330', 1, 1, GETDATE()),
           ('52627', 'Alex', 'Martínez', 'Piñeiro', 'MAS', 'Monterrey', 'México', '1978-02-27', 'MAPA780227LKA', 11, 1, GETDATE()),
           ('28293', 'Jorge', 'Pérez', 'Sánchez', 'MAS', 'Monterrey', 'México', '1988-05-14', 'PESJ880514CSZ', 8, 1, GETDATE())
GO

INSERT INTO Audioguia (codigo, idioma, idEmpleado, idUsuarioCrea, fechaCrea)
    VALUES ('AG-01', 'S', 5, 1, GETDATE()),
           ('AG-02', 'E', 1, 1, GETDATE()),
           ('AG-03', 'F', 1, 1, GETDATE()),
           ('AG-04', 'E', 1, 1, GETDATE()),
           ('AG-05', 'F', 5, 1, GETDATE()),
           ('AG-06', 'S', 5, 1, GETDATE()),
           ('AG-07', 'F', 5, 1, GETDATE()),
           ('AG-08', 'S', 1, 1, GETDATE()),
           ('AG-09', 'E', 1, 1, GETDATE()),
           ('AG-10', 'E', 5, 1, GETDATE())
GO

INSERT INTO Boleto (codigo, precio, fechaCompra, idTipoBoleto, idRegalo, idAudioguia, idUsuarioCrea, fechaCrea)
    VALUES ('B-101', 349, GETDATE(), 5, 2, 4, 1, GETDATE()),
           ('B-102', 819, GETDATE(), 1, 7, 4, 1, GETDATE()),
           ('B-103', 1499, GETDATE(), 2, 8, 8, 1, GETDATE()),
           ('B-104', 819, GETDATE(), 1, 7, 6, 1, GETDATE()),
           ('B-105', 179, GETDATE(), 5, 4, 10, 1, GETDATE()),
           ('B-106', 179, GETDATE(), 5, 4, 2, 1, GETDATE()),
           ('B-107', 189, GETDATE(), 10, 8, 2, 1, GETDATE()),
           ('B-108', 189, GETDATE(), 10, 7, 2, 1, GETDATE()),
           ('B-109', 359, GETDATE(), 7, 8, 2, 1, GETDATE()),
           ('B-110', 359, GETDATE(), 7, 10, 9, 1, GETDATE())
GO

INSERT INTO Escultura (nombre, idArtista, idCorrienteArtistica, idTecnicaEscultura, idPais, idPeriodo, idUsuarioCrea, fechaCrea)
    VALUES ('David', 7, 10, 1, 9, 3, 1, GETDATE()),
           ('La Piedad del Vaticano', 7, 10, 1, 9, 3, 1, GETDATE()),
           ('El beso', 8, 1, 7, 7, 5, 1, GETDATE()),
           ('La eterna primavera', 8, 1, 7, 7, 5, 1, GETDATE()),
           ('Hombre que señala', 9, 7, 5, 12, 8, 1, GETDATE()),
           ('Figura alta', 9, 7, 5, 12, 8, 1, GETDATE()),
           ('Mujer de pie', 9, 7, 5, 12, 8, 1, GETDATE()),
           ('Fuente', 10, 5, 1, 7, 7, 1, GETDATE()),
           ('María Magdalena penitente', 11, 10, 3, 9, 3, 1, GETDATE()),
           ('Éxtasis de Santa Teresa', 12, 9, 1, 9, 4, 1, GETDATE())
GO

INSERT INTO Evento (codigo, nombre, descripcion, fechaInicio, fechaFinal, idTipoEvento, idUsuarioCrea, fechaCrea)
    VALUES ('E-178', 'Salud y Arte', 'Conferencia educativa sobre ambos temas', '2021-11-30', '2021-11-30', 1, 1, GETDATE()),
           ('E-179', 'Arte y Ambiente', 'Seminario universitario sobre el medio ambiente y el arte', '2021-12-08', '2021-12-08', 4, 1, GETDATE()),
           ('E-180', 'Bailes de México', 'Presentación de bailes folklóricos mexicanos', '2021-11-20', '2021-11-20', 6, 1, GETDATE()),
           ('E-181', 'Concurso de Ajedrez', 'Concurso de ajedrez de niños y jóvenes', '2021-11-10', '2021-11-12', 9, 1, GETDATE()),
           ('E-182', 'Desayuno de Inauguración', 'Inauguración de exhibición temporal', '2021-12-01', '2021-12-01', 2, 1, GETDATE()),
           ('E-183', 'Loving, Vincent', 'Obra de teatro sobre la vida de van Gogh', '2022-01-05', '2022-01-05', 8, 1, GETDATE()),
           ('E-184', 'Querida Jane', 'Conferencia sobre la vida de Jane Austen y sus obras', '2022-01-28', '2022-01-28', 1, 1, GETDATE()),
           ('E-185', 'Llámame Viginia', 'Seminario sobre el manifiesto feminista de Virginia Woolf', '2021-11-15', '2021-11-17', 4, 1, GETDATE()),
           ('E-186', 'Cultura pop y música', 'Concierto de música pop que ha marcado la década', '2021-12-25', '2021-12-25', 7, 1, GETDATE()),
           ('E-187', 'Miss Americana', 'Conferencia sobre el impaco de Taylor Swift en la cultura actual', '2021-12-13', '2021-12-13', 1, 1, GETDATE())
GO

INSERT INTO Exhibicion (nombre, descripcion, fechaInicio, fechaFinal, idDirectorDeExhibicion, idTipoExhibicion, idUsuarioCrea, fechaCrea)
    VALUES ('Suiza y el arte', 'Impacto de esculturas suizas', '2022-12-10', '2022-01-10', 9, 2, 1, GETDATE()),
           ('Miguel Ángel, el artista', 'Cómo nadie ha igualado al artista', '2022-01-12', '2022-02-14', 9, 2, 1, GETDATE()),
           ('El Arte LGBTTTIQ+', 'Artistas LGBT y su presencia en el arte', '2022-02-20', '2022-03-30', 1, 9, 1, GETDATE()),
           ('Una Habitación Propia', 'Mujeres escritoras', '2022-03-08', '2022-03-20', 9, 2, 1, GETDATE()),
           ('El mundo por la cámara', 'La fotografía a lo largo del tiempo.', '2022-01-30', '2022-02-28', 9, 5, 1, GETDATE())
GO

INSERT INTO Exhibicion (nombre, descripcion, fechaInicio, fechaFinal, idDirectorDeExhibicionExterno, idTipoExhibicion, idUsuarioCrea, fechaCrea)
    VALUES ('Mujeres y música', 'Mujeres y su impacto musical.', '2022-03-20', '2022-03-10', 9, 4, 1, GETDATE()),
           ('Cine mexicano', 'Importancia del cine mexicano actual.', '2022-02-01', '2022-02-28', 8, 9, 1, GETDATE()),
           ('¿Gracias, España?', 'Los efectos de la colonización en el México actual.', '2022-10-10', '2022-10-20', 7, 8, 1, GETDATE()),
           ('De Grecia al Campamento', 'El impacto de Rick Riordan en cómo se percibe la Cultura Griega en la actualidad.','2022-01-27', '2022-03-20', 1, 3, 1, GETDATE()),
           ('Feminismo visual', 'Exposición de artistas locales por el Día de la Mujer', '2022-03-08', '2022-03-08', 10, 7, 1, GETDATE()),
           ('Impresionismo impresionado', 'Exposicion sobre el impresionismo', '2022-03-15', '2022-04-01', 10, 7, 1, GETDATE())
GO

INSERT INTO Fotografia (nombre, idFotografo, idFormatoDeCamara, idClasificacion, idPais,  idUsuarioCrea, fechaCrea)
    VALUES ('Eugène Atget', 27, 3, 2, 11, 1, GETDATE()),
           ('George Antheil', 27, 3, 2, 11, 1, GETDATE()),
           ('Janet Flanner', 27, 3, 2, 7, 1, GETDATE()),
           ('ID Crisis', 28, 4, 2, 13, 1, GETDATE()),
           ('Xana Nyilenda, Newtown, Johannesburg', 28, 4, 2, 13, 1, GETDATE()),
           ('Sazi Jali, Durban, KwaZulu Natal', 28, 4, 2, 13, 1, GETDATE()),
           ('Sindile II, Room 206 Fjord Hotel, Berlin', 28, 4, 2, 13, 1, GETDATE()),
           ('La madre migrante', 32, 3, 2, 11, 1, GETDATE()),
           ('Black Blizzards', 32, 3, 6, 11, 1, GETDATE()),
           ('Campesinos', 32, 3, 8, 11, 1, GETDATE())
GO

INSERT INTO Grupo (codigo, numeroIntegrantes, idTipoGrupo, idUsuarioCrea, fechaCrea)
    VALUES ('G-101', 8, 1, 1, GETDATE()),
           ('G-102', 4, 4, 1, GETDATE()),
           ('G-103', 8, 6, 1, GETDATE()),
           ('G-104', 10, 8, 1, GETDATE()),
           ('G-105', 10, 5, 1, GETDATE()),
           ('G-106', 10, 5, 1, GETDATE()),
           ('G-107', 5, 9, 1, GETDATE()),
           ('G-108', 5, 10, 1, GETDATE()),
           ('G-109', 4, 10, 1, GETDATE()),
           ('G-110', 4, 9, 1, GETDATE())
GO

INSERT INTO Libro (nombre, año, idAutor, idTipoEdicion, idEditorial, idClasificacion, idIdioma, idPais,  idUsuarioCrea, fechaCrea)
    VALUES ('Sense and Sensibility', '1811', 13, 2, 1, 7, 2, 6, 1, GETDATE()),
           ('Pride and Prejudice', '1813', 13, 1, 1, 7, 2, 6, 1, GETDATE()),
           ('Emma', '1815', 13, 1, 1, 7, 2, 6, 1, GETDATE()),
           ('The Professor', '1857',  14, 1, 2, 7, 2, 6, 1, GETDATE()),
           ('Mrs. Dalloway', '1925', 17, 4, 10, 7, 2, 6, 1, GETDATE()),
           ('Carta a un joven poeta', '1932', 17, 4, 10, 8, 2, 6, 1, GETDATE()),
           ('Una habitación propia', '1929', 17, 4, 10, 8, 2, 6, 1, GETDATE()),
           ('Herbario & antología botánica', '1900', 18, 2, 3, 4, 6, 11, 1, GETDATE()),
           ('The Tenant of Wildfell Hall', '1848', 16, 1, 2, 7, 2, 6, 1, GETDATE()),
           ('A Vindication of the Rights of Woman', '1792', 19, 4, 10, 8, 2, 6, 1, GETDATE())
GO

INSERT INTO Objeto (nombre, descripcion, idTipoObjeto, idPeriodo, idPais, idUsuarioCrea, fechaCrea)
    VALUES ('Cartas de van Gogh', 'Cartas que Vincent y Theo se enviaban.', 1, 5, 3, 1, GETDATE()),
           ('Cámara', 'Cámara perteneciente a Berenice Abbot.', 2, 8, 11,  1, GETDATE()),
           ('Herramientas barrocas', 'Herramientas usadas en el periodo barroco.', 2, 4, 2, 1, GETDATE()),
           ('Capilla sixtina', 'Maqueta de la capilla hecha por Miguel Ángel.', 9, 3, 9, 1, GETDATE()),
           ('Sombrero', 'Sombrero que perteneció a Vincent van Gogh.', 5, 5, 3, 1, GETDATE()),
           ('Bocetos de la capilla', 'Bocetos que Miguel Ángel hizo de la Capilla Sixtina.', 4, 3, 9, 1, GETDATE()),
           ('Cintas fotográficas', 'Citas ya reveladas de las fotografías de Berenice Abbot.', 3, 8, 11,  1, GETDATE()),
           ('Scrapbook', 'Cuaderno de trabajo de Guillermo del Toro.', 6, 10, 1, 1, GETDATE()),
           ('Guión ROMA', 'Primera impresión del guión terminado por Alfonso Cuarón.', 10, 10, 1, 1, GETDATE()),
           ('Pinceles y óleos', 'Herramienta de arte de Frida Kahlo.', 3, 5, 1, 1, GETDATE())
GO

INSERT INTO Pelicula (nombre, año, duracion, tipo, idDirector, idFormatoDeCamara, idClasificacion, idIdioma, idPais, idDistribuidora, idProductora, idUsuarioCrea, fechaCrea)
    VALUES ('Roma', '2018', 120, 'L', 20, 10, 11, 1, 1, 3, 2, 1, GETDATE()),
           ('Gravedad', '2013', 90, 'L', 20, 10, 10, 6, 11, 3, 2, 1, GETDATE()),
           ('Mujercitas', '2019', 120, 'L', 25, 10, 11, 6, 11, 10, 10, 1, GETDATE()),
           ('Lady Bird', '2017', 90, 'L', 25, 10, 10, 6, 6, 10, 10, 1, GETDATE()),
           ('Loving, Vincent', '2017', 95, 'L', 22, 10, 8, 9, 3, 1, 1, 1, GETDATE()),
           ('La forma del agua', '2017', 120, 'L', 21, 10, 11, 6, 1, 3, 2, 1, GETDATE()),
           ('La cumbre escarlata', '2015', 120, 'L',  21, 9, 11, 6, 11, 3, 2, 1, GETDATE()),
           ('El laberinto del fauno', '2006', 110, 'L', 21, 7, 11, 1, 2, 7, 10, 1, GETDATE()),
           ('Parásitos', '2019', 150, 'L', 26, 10, 11, 5, 10, 5, 10, 1, GETDATE()),
           ('Niños del hombre', '2003', 109, 'L', 20, 10, 11, 1, 1, 3, 2, 1, GETDATE())
GO

INSERT INTO Pintura (nombre, idArtista, idClasificacion, idTecnicaPintura, idCorrienteArtistica, idPais, idPeriodo, idUsuarioCrea, fechaCrea)
    VALUES ('La noche estrellada', 1, 1, 9, 4, 3, 5, 1, GETDATE()),
           ('Terraza de café por la noche', 1, 1, 9, 4, 3, 5, 1, GETDATE()),
           ('La casa amarilla', 1, 1, 9, 4, 3, 5, 1, GETDATE()),
           ('Almendro en flor', 1, 1, 9, 4, 3, 5, 1, GETDATE()),
           ('Lirios', 1, 1, 9, 4, 3, 5, 1, GETDATE()),
           ('Las dos Fridas', 3, 3, 9, 5, 1, 7, 1, GETDATE()),
           ('La columna rota', 3, 3, 9, 5, 1, 7, 1, GETDATE()),
           ('Hospital Henry Ford', 3, 3, 9, 5, 1, 7, 1, GETDATE()),
           ('Un día de verano', 6, 1, 9, 4, 7, 5,  1, GETDATE()),
           ('Judit decapitando a Holofernes', 5, 2, 9, 9, 7, 4, 1, GETDATE())
GO

INSERT INTO Sala (nombre, codigo, idUbicacion, idTipoSala, idUsuarioCrea, fechaCrea)
    VALUES ('Auditorio Kahlo', 'S-101', 1, 1, 1, GETDATE()),
           ('Sala HYBE', 'S-102', 4, 2, 1, GETDATE()),
           ('Sala Big Hit', 'S-103', 5, 4, 1, GETDATE()),
           ('Mikrokosmos', 'S-104', 1, 10, 1, GETDATE()),
           ('Teatro Carvajo', 'S-105', 6, 5, 1, GETDATE()),
           ('Persona', 'S-106', 1, 6, 1, GETDATE()),
           ('Shadow', 'S-107', 3, 6, 1, GETDATE()),
           ('Ego', 'S-108', 4, 6, 1, GETDATE()),
           ('HOME', 'S-109', 6, 3, 1, GETDATE()),
           ('MAR', 'S-110', 6, 3, 1, GETDATE())
GO

INSERT INTO Taller (nombre, descripcion, fechaInicio, fechaFinal, idTipoTaller, idUsuarioCrea, fechaCrea)
    VALUES ('Cocina infantil', 'Cocina para niños', '2021-11-10', '2021-11-20', 1, 1, GETDATE()),
           ('Poesía feminista', 'Exclusivo mujeres', '2022-03-10', '2022-03-10', 8, 1, GETDATE()),
           ('Autopublicación', 'Sobre cómo autopublicar obras', '2022-03-21', '2022-03-21', 4, 1, GETDATE()),
           ('Impresionimo en el siglo XXI', 'Taller de técnicas impesionistas', '2022-01-28', '2022-02-28', 10, 1, GETDATE()),
           ('Realismo al 1000', 'Taller de técnicas hiperrealistas', '2022-02-10', '2022-03-30', 10, 1, GETDATE()),
           ('Literatura francesa', 'Estudio de obras románticas de Francia', '2022-02-16', '2022-03-14', 8, 1, GETDATE()),
           ('Pintura especial', 'Clases de pintura para niños', '2022-01-10', '2022-01-30', 3, 1, GETDATE()),
           ('Texturas en óleo', 'Creación de texturas en óleo', '2022-03-20', '2022-04-30', 10, 1, GETDATE()),
           ('Tejido All Too Well', 'Clases de tejido', '2021-11-12', '2021-12-13', 9, 1, GETDATE()),
           ('Música y sensaciones', 'Taller sensorial infantil', '2022-04-30', '2022-04-30', 3, 1, GETDATE())
GO

INSERT INTO Tienda (codigo, nombre, idUbicacion, idTipoTienda, idUsuarioCrea, fechaCrea)
    VALUES ('T-101', 'Tienda 1', 1, 1, 1, GETDATE()),
           ('T-102', 'Tienda 2', 2, 1, 1, GETDATE()),
           ('T-103', 'Magic Shop', 6, 3, 1, GETDATE()),
           ('T-104', 'MikrokosTienda', 4, 2, 1, GETDATE()),
           ('T-105', 'Persona', 3, 5, 1, GETDATE()),
           ('T-106', 'Tienda 3', 6, 1, 1, GETDATE()),
           ('T-107', 'Wings', 5, 3, 1, GETDATE()),
           ('T-108', 'Almendra', 6, 5, 1, GETDATE()),
           ('T-109', 'Travil', 6, 10, 1, GETDATE()),
           ('T-110', 'Travesía', 6, 10, 1, GETDATE())
GO

INSERT INTO Visita (codigo, fecha, idTipoVisita, idVisitante, idBoleto, idGrupo, idGuia, idUsuarioCrea, fechaCrea)
    VALUES ('VI-10', '2021-11-20', 7, 1, 3, 10, 1, 1, GETDATE()),
           ('VI-12', '2021-11-20', 7, 8, 3, 10, 1, 1, GETDATE()),
           ('VI-13', '2021-12-01', 7, 3, 9, 3, 4, 1, GETDATE()),
           ('VI-14', '2021-12-01', 7, 2, 9, 3, 4, 1, GETDATE()),
           ('VI-15', '2021-12-07', 8, 3, 3, 4, 4, 1, GETDATE()),
           ('VI-16', '2021-12-07', 8, 9, 3, 4, 4, 1, GETDATE()),
           ('VI-17', '2021-12-10', 7, 7, 1, 7, 1, 1, GETDATE()),
           ('VI-18', '2021-12-10', 7, 1, 3, 7, 1, 1, GETDATE()),
           ('VI-19', '2021-12-10', 7, 2, 3, 7, 1, 1, GETDATE()),
           ('VI-20', '2021-12-10', 7, 10, 2, 7, 1, 1, GETDATE())
GO

INSERT INTO ArticuloTienda (idArticulo, idTienda, idUsuarioCrea, fechaCrea)
    VALUES (1, 3, 1, GETDATE()),
           (1, 4, 1, GETDATE()),
           (2, 1, 1, GETDATE()),
           (6, 6, 1, GETDATE()),
           (3, 4, 1, GETDATE()),
           (3, 3, 1, GETDATE()),
           (8, 9, 1, GETDATE()),
           (8, 10, 1, GETDATE()),
           (7, 4, 1, GETDATE()),
           (9, 4, 1, GETDATE())
GO

INSERT INTO EmpleadoExhibicion (idEmpleado, idExhibicion, idUsuarioCrea, fechaCrea)
    VALUES (1, 1, 1, GETDATE()),
           (6, 3, 1, GETDATE()),
           (7, 9, 1, GETDATE()),
           (7, 3, 1, GETDATE()),
           (7, 1, 1, GETDATE()),
           (8, 9, 1, GETDATE()),
           (3, 1, 1, GETDATE()),
           (3, 2, 1, GETDATE()),
           (5, 10, 1, GETDATE()),
           (1, 1, 1, GETDATE())
GO

INSERT INTO EmpleadoTaller (idEmpleado, idTaller, idUsuarioCrea, fechaCrea)
    VALUES (4, 1, 1, GETDATE()),
           (10, 2, 1, GETDATE()),
           (10, 3, 1, GETDATE()),
           (4, 10, 1, GETDATE()),
           (4, 9, 1, GETDATE()),
           (10, 4, 1, GETDATE()),
           (4, 7, 1, GETDATE()),
           (10, 7, 1, GETDATE()),
           (10, 5, 1, GETDATE()),
           (1, 6, 1, GETDATE())
GO

INSERT INTO EmpleadoTienda (idEmpleado, idTienda, fechaHoraEntrada, fechaHoraSalida, idUsuarioCrea, fechaCrea)
    VALUES (2, 2, '2021-12-08 09:00', '2021-12-08 05:00', 1, GETDATE()),
           (2, 2, '2021-12-09 09:00', '2021-12-09 05:00', 1, GETDATE()),
           (6, 1, '2021-12-08 09:10', '2021-12-08 05:15', 1, GETDATE()),
           (6, 1, '2021-12-09 09:00', '2021-12-09 05:00', 1, GETDATE()),
           (2, 2, '2021-12-10 09:04', '2021-12-10 05:00', 1, GETDATE()),
           (2, 2, '2021-12-11 09:00', '2021-12-11 05:25', 1, GETDATE()),
           (6, 1, '2021-12-10 09:25', '2021-12-10 05:30', 1, GETDATE()),
           (6, 1, '2021-12-11 09:01', '2021-12-11 05:05', 1, GETDATE()),
           (2, 1, '2021-12-12 09:00', '2021-12-12 05:00', 1, GETDATE()),
           (6, 1, '2021-12-12 09:01', '2021-12-12 05:05', 1, GETDATE())
GO

INSERT INTO EsculturaExhibicion (idEscultura, idExhibicion, fechaInicio, fechaFinal, idUsuarioCrea, fechaCrea)
    VALUES (5, 1, '2022-12-10', '2022-01-10', 1, GETDATE()),
           (6, 1, '2022-12-10', '2022-01-10', 1, GETDATE()),
           (7, 1, '2022-12-10', '2022-01-10', 1, GETDATE()),
           (1, 2, '2022-01-12', '2022-02-14', 1, GETDATE()),
           (2, 2, '2022-01-12', '2022-02-14', 1, GETDATE()),
           (4, 3, '2022-02-20', '2022-03-30', 1, GETDATE()),
           (8, 3, '2022-02-20', '2022-03-30', 1, GETDATE()),
           (3, 4, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (10, 4, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (9, 4, '2022-03-08', '2022-03-20', 1, GETDATE())
GO

INSERT INTO EventoSala (idEvento, idSala, fechaHoraInicio, fechaHoraFinal, idUsuarioCrea, fechaCrea)
    VALUES (1, 1, '2021-11-30 11:00', '2021-11-30 13:30', 1, GETDATE()),
           (2, 2, '2021-12-08 09:00', '2021-12-08 16:00', 1, GETDATE()),
           (3, 5, '2021-11-20 19:00', '2021-11-20 21:00', 1, GETDATE()),
           (4, 9, '2021-11-10 09:00', '2021-11-12 14:00', 1, GETDATE()),
           (4, 10, '2021-11-10 09:00', '2021-11-12 14:00', 1, GETDATE()),
           (6, 5, '2022-01-05 20:00', '2022-01-05 22:00', 1, GETDATE()),
           (5, 10, '2021-12-01 08:00', '2021-12-01 10:30', 1, GETDATE()),
           (9, 5, '2021-12-25 20:00', '2021-12-25 22:00', 1, GETDATE()),
           (10, 1, '2021-12-13 17:00', '2021-12-13 19:30', 1, GETDATE()),
           (8, 1, '2021-11-15 09:00', '2021-11-17 14:00', 1, GETDATE())
GO

INSERT INTO ExhibicionFotografia (idExhibicion, idFotografia, fechaInicio, fechaFinal, idUsuarioCrea, fechaCrea)
    VALUES (3, 1, '2022-02-20', '2022-03-30', 1, GETDATE()),
           (3, 2, '2022-02-20', '2022-03-30', 1, GETDATE()),
           (3, 3, '2022-02-20', '2022-03-30', 1, GETDATE()),
           (5, 4, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (5, 5, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (5, 6, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (5, 7, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (6, 8, '2022-01-30', '2022-02-28', 1, GETDATE()),
           (6, 9, '2022-01-30', '2022-02-28', 1, GETDATE()),
           (6, 10, '2022-01-30', '2022-02-28', 1, GETDATE())
GO

INSERT INTO ExhibicionLibro (idExhibicion, idLibro, fechaInicio, fechaFinal, idUsuarioCrea, fechaCrea)
    VALUES (4, 1, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (4, 2, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (4, 3, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (4, 4, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (4, 5, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (4, 6, '2022-03-08', '2022-03-20',1, GETDATE()),
           (4, 7, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (4, 8, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (4, 9, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (4, 10, '2022-03-08', '2022-03-20', 1, GETDATE())
GO

INSERT INTO ExhibicionObjeto (idExhibicion, idObjeto, fechaInicio, fechaFinal, idUsuarioCrea, fechaCrea)
    VALUES (11, 1, '2022-03-15', '2022-04-01', 1, GETDATE()),
           (5, 2, '2022-01-30', '2022-02-18', 1, GETDATE()),
           (5, 7, '2022-01-30', '2022-02-08', 1, GETDATE()),
           (4, 10, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (8, 10, '2022-10-10', '2022-10-20', 1, GETDATE()),
           (3, 2, '2022-02-20', '2022-03-30', 1, GETDATE()),
           (3, 7, '2022-02-20', '2022-03-30', 1, GETDATE()),
           (2, 4, '2022-01-12', '2022-02-14', 1, GETDATE()),
           (2, 6, '2022-01-12', '2022-02-14', 1, GETDATE()),
           (7, 9, '2022-02-01', '2022-02-28', 1, GETDATE())
GO

INSERT INTO ExhibicionPelicula (idExhibicion, idPelicula, fechaInicio, fechaFinal, idUsuarioCrea, fechaCrea)
    VALUES (7, 1, '2022-02-01', '2022-02-28', 1, GETDATE()),
           (7, 10, '2022-02-01', '2022-02-28', 1, GETDATE()),
           (4, 3, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (4, 4, '2022-03-08', '2022-03-20', 1, GETDATE()),
           (8, 8, '2022-10-10', '2022-10-20', 1, GETDATE()),
           (8, 7, '2022-10-10', '2022-10-20', 1, GETDATE()),
           (5, 4, '2022-01-30', '2022-02-28', 1, GETDATE()),
           (11, 5, '2022-03-15', '2022-04-01', 1, GETDATE()),
           (5, 9, '2022-01-30', '2022-02-28', 1, GETDATE()),
           (10, 4, '2022-03-08', '2022-03-08', 1, GETDATE())
GO

INSERT INTO ExhibicionPintura (idExhibicion, idPintura, fechaInicio, fechaFinal, idUsuarioCrea, fechaCrea)
    VALUES (11, 1, '2022-03-15', '2022-04-01', 1, GETDATE()),
           (11, 2, '2022-03-15', '2022-04-01', 1, GETDATE()),
           (11, 3, '2022-03-15', '2022-04-01', 1, GETDATE()),
           (11, 4, '2022-03-15', '2022-04-01', 1, GETDATE()),
           (11, 5, '2022-03-15', '2022-04-01', 1, GETDATE()),
           (11, 9, '2022-03-15', '2022-04-01', 1, GETDATE()),
           (3, 6, '2022-02-20', '2022-03-06', 1, GETDATE()),
           (3, 7, '2022-02-20', '2022-03-30', 1, GETDATE()),
           (4, 6, '2022-03-08', '2022-03-20', 1, GETDATE())
GO

INSERT INTO ExhibicionSala (idExhibicion, idSala, fechaInicio, fechaFinal, idUsuarioCrea, fechaCrea)
    VALUES (6, 1, '2022-03-20', '2022-03-10', 1, GETDATE()),
           (6, 6, '2022-03-20', '2022-03-10',  1, GETDATE()),
           (6, 7, '2022-03-20', '2022-03-10', 1, GETDATE()),
           (6, 8, '2022-03-20', '2022-03-10', 1, GETDATE()),
           (10, 10, '2022-03-08', '2022-03-08', 1, GETDATE()),
           (11, 3, '2022-03-15', '2022-04-01', 1, GETDATE()),
           (3, 7, '2022-02-01', '2022-02-28',  1, GETDATE()),
           (3, 3, '2022-02-20', '2022-03-30', 1, GETDATE()),
           (3, 10, '2022-03-08', '2022-03-08', 1, GETDATE()),
           (2, 7, '2022-01-12', '2022-01-31', 1, GETDATE())
GO

INSERT INTO SalaTaller (idSala, idTaller, fechaInicio, fechaFinal, idUsuarioCrea, fechaCrea)
    VALUES (9, 2, '2022-03-10', '2022-03-10', 1, GETDATE()),
           (9, 9, '2021-11-12', '2021-12-13', 1, GETDATE()),
           (9, 10, '2022-04-30', '2022-04-30', 1, GETDATE()),
           (4, 1, '2021-11-10', '2021-11-20', 1, GETDATE()),
           (10, 1, '2021-11-10', '2021-11-20', 1, GETDATE()),
           (2, 3, '2022-03-21', '2022-03-21', 1, GETDATE()),
           (2, 4, '2022-01-28', '2022-02-28', 1, GETDATE()),
           (2, 5, '2022-02-10', '2022-03-30', 1, GETDATE()),
           (4, 10, '2021-11-10', '2021-11-20', 1, GETDATE()),
           (10, 8, '2022-01-10', '2022-01-30', 1, GETDATE())
GO

INSERT INTO ArtistaEscuela (idArtista, idEscuela, idUsuarioCrea, fechaCrea)
    VALUES (25, 7, 1, GETDATE()),
           (20, 6, 1, GETDATE()),
           (20, 9, 1, GETDATE()),
           (21, 6, 1, GETDATE()),
           (21, 9, 1, GETDATE()),
           (29, 3, 1, GETDATE()),
           (29, 4, 1, GETDATE()),
           (32, 1, 1, GETDATE()),
           (32, 4, 1, GETDATE()),
           (23, 10, 1, GETDATE())
GO

--VIEWS

CREATE VIEW ArticuloCategoriaInformacion AS SELECT a.codigo, a.nombreArticulo, c.nombre
FROM Articulo a INNER JOIN Categoria c ON a.idCategoria = c.idCategoria WHERE
c.idCategoria >= 1 GROUP BY a.codigo, a.nombreArticulo, c.nombre
GO

CREATE VIEW ArtistaEscuelaInformacion as 
SELECT a.idArtista,  CONCAT(a.nombre, ' ', a.apellidoPaterno, ' ', a.apellidoMaterno) AS 'Nombre Completo', e.nombre AS 'Nombre escuela'
FROM Artista a INNER JOIN ArtistaEscuela ae ON a.idArtista = ae.idArtista INNER JOIN Escuela e ON e.idEscuela = ae.idEscuela 
WHERE a.estatus = 1
GO

CREATE VIEW EmpleadoTiendaInformacion as 
SELECT e.idEmpleado,  CONCAT(e.nombre, ' ', e.apellidoPaterno, ' ', e.apellidoMaterno) AS 'Nombre Completo', t.codigo AS 'Tienda', et.fechaHoraEntrada, et.fechaHoraSalida
FROM Empleado e INNER JOIN EmpleadoTienda et ON e.idEmpleado = et.idEmpleado INNER JOIN Tienda t ON t.idTienda = et.idTienda
WHERE e.estatus = 1
GO

CREATE VIEW BoletoTipoRegalo as 
SELECT b.codigo, tb.descripcion AS 'Tipo de boleto', r.descripcion AS 'Regalo'
FROM Boleto b INNER JOIN TipoBoleto tb ON b.idTipoBoleto = tb.idTipoBoleto INNER JOIN Regalo r ON b.idRegalo = r.idRegalo
WHERE b.estatus = 1
GO

CREATE VIEW PinturaInformacion as 
SELECT p.nombre AS 'Nombre de pintura', CONCAT(a.nombre, ' ', a.apellidoPaterno, ' ', a.apellidoMaterno) AS 'Nombre del Artista', c.nombre AS 'Corriente Artística', pa.nombre AS 'País'
FROM Pintura p INNER JOIN Artista a ON p.idArtista = a.idArtista INNER JOIN CorrienteArtistica c ON p.idCorrienteArtistica = c.idCorrienteArtistica INNER JOIN Pais pa ON p.idPais = pa.idPais
WHERE p.estatus = 1
GO

CREATE VIEW EsculturaInformacion as 
SELECT e.nombre AS 'Nombre de la escultura', CONCAT(a.nombre, ' ', a.apellidoPaterno, ' ', a.apellidoMaterno) AS 'Nombre del Artista', c.nombre AS 'Corriente Artística', pa.nombre AS 'País'
FROM Escultura e INNER JOIN Artista a ON e.idArtista = a.idArtista INNER JOIN CorrienteArtistica c ON e.idCorrienteArtistica = c.idCorrienteArtistica INNER JOIN Pais pa ON e.idPais = pa.idPais
WHERE e.estatus = 1
GO

CREATE VIEW LibroInformacion as 
SELECT l.nombre AS 'Nombre del libro', l.año AS 'Año', CONCAT(a.nombre, ' ', a.apellidoPaterno, ' ', a.apellidoMaterno) AS 'Nombre de Autor', c.nombre AS 'Género', pa.nombre AS 'País'
FROM Libro l INNER JOIN Artista a ON l.idAutor = a.idArtista INNER JOIN Clasificacion c ON l.idClasificacion = c.idClasificacion INNER JOIN Pais pa ON l.idPais = pa.idPais
WHERE l.estatus = 1
GO

CREATE VIEW PeliculaInformacion as 
SELECT p.nombre AS 'Nombre de la película', p.año AS 'Año', CONCAT(a.nombre, ' ', a.apellidoPaterno, ' ', a.apellidoMaterno) AS 'Nombre del Director', c.nombre AS 'Género', pa.nombre AS 'País'
FROM Pelicula p INNER JOIN Artista a ON p.idDirector = a.idArtista INNER JOIN Clasificacion c ON p.idClasificacion = c.idClasificacion INNER JOIN Pais pa ON p.idPais = pa.idPais
WHERE p.estatus = 1
GO

CREATE VIEW FotografiaInformacion as 
SELECT f.nombre AS 'Nombre de la fotografia', CONCAT(a.nombre, ' ', a.apellidoPaterno, ' ', a.apellidoMaterno) AS 'Nombre del Fotógrafo', c.nombre AS 'Formato de Cámara', pa.nombre AS 'País'
FROM Fotografia f INNER JOIN Artista a ON f.idFotografo = a.idArtista INNER JOIN FormatoDeCamara c ON f.idFormatoDeCamara = c.idFormatoDeCamara INNER JOIN Pais pa ON f.idPais = pa.idPais
WHERE f.estatus = 1
GO

CREATE VIEW ObjetoInformacion as 
SELECT o.nombre AS 'Nombre del objeto', o.descripcion AS 'Descripción', p.idPeriodo AS 'Periodo', pa.nombre AS 'País'
FROM Objeto o INNER JOIN Periodo p ON o.idPeriodo = p.idPeriodo INNER JOIN Pais pa ON o.idPais = pa.idPais
WHERE o.estatus = 1
GO

CREATE VIEW VisitaInformacion as 
SELECT v.codigo AS 'Código', v.fecha AS 'Fecha', CONCAT(vi.nombre, ' ', vi.apellidoPaterno, ' ', vi.apellidoMaterno) AS 'Nombre del Visitante', b.codigo AS 'Boleto'
FROM Visita v INNER JOIN Visitante vi ON v.idVisitante = vi.idVisitante INNER JOIN Boleto b ON v.idBoleto = b.idBoleto
WHERE v.estatus = 1
GO

CREATE VIEW ArticuloPrecioMaximo AS
SELECT a.nombreArticulo AS 'Nombre', a.precio AS 'Precio Máximo'
FROM Articulo a 
WHERE a.precio = (SELECT MAX(precio) FROM Articulo) 
GO

CREATE VIEW ArtículoPrecioMinimo AS
SELECT a.nombreArticulo AS 'Nombre', a.precio AS 'Precio Mínimo'
FROM Articulo a 
WHERE a.precio = (SELECT MIN(precio) FROM Articulo) 
GO

CREATE VIEW BoletoPrecioMaximo AS
SELECT b.codigo AS 'Código', tb.idTipoBoleto AS 'Tipo de Boleto', b.precio AS 'Precio Máximo'
FROM Boleto b INNER JOIN TipoBoleto  tb ON b.idTipoBoleto = tb.idTipoBoleto
WHERE b.precio = (SELECT MAX(precio) FROM Boleto) 
GO

CREATE VIEW BoletoPrecioMinimo AS
SELECT b.codigo AS 'Código', tb.idTipoBoleto AS 'Tipo de Boleto', b.precio AS 'Precio Minimo'
FROM Boleto b INNER JOIN TipoBoleto  tb ON b.idTipoBoleto = tb.idTipoBoleto
WHERE b.precio = (SELECT MIN(precio) FROM Boleto) 
GO