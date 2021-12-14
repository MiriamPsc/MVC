USE master
GO

IF DB_ID (N'FutbolSoccer') IS NOT NULL
DROP DATABASE FutbolSoccer;
GO
CREATE DATABASE FutbolSoccer
ON 
(NAME = FutbolSoccer_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\FutbolSoccer.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = FutbolSoccer_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\FutbolSoccer.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE FutbolSoccer
GO

--TABLAS

CREATE TABLE Arbitro
(
    idArbitro int IDENTITY (1,1),
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKArbitro PRIMARY KEY(idArbitro)
)

CREATE TABLE Equipo
(
    idEquipo int IDENTITY (1,1),
    nombre varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKEquipo PRIMARY KEY(idEquipo)
)

CREATE TABLE Jugador
(
    idJugador int IDENTITY (1,1),
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    nacionalidad varchar (50) not null,
    fechaNacimiento datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKJugador PRIMARY KEY(idJugador)
)

CREATE TABLE Partido
(
    idPartido int IDENTITY (1,1),
    fecha datetime not null,
    nombreEstadio varchar (50) not null,
    idEquipoLocal int not null,
    idEquipoVisita int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPartido PRIMARY KEY(idPartido)
)

CREATE TABLE Posicion
(
    idPosicion int IDENTITY (1,1),
    nombre varchar (50) not null,
    descripcion varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPosicion PRIMARY KEY(idPosicion)
)

CREATE TABLE TipoArbitro
(
    idTipoArbitro int IDENTITY (1,1),
    nombre varchar (50) not null,
    descripcion varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTipoArbitro PRIMARY KEY(idTipoArbitro)
)

CREATE TABLE Usuario
(
    idUsuario int IDENTITY (1,1),
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

CREATE TABLE ArbitroTipoArbitro
(
    idArbitroTipoArbitro int IDENTITY (1,1),
    idArbitro int not null,
    idTipoArbitro int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKArbitroTipoArbitro PRIMARY KEY(idArbitroTipoArbitro)
)

CREATE TABLE ArbitroPartido
(
    idArbitroPartido int IDENTITY (1,1),
    idArbitro int not null,
    idPartido int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKArbitroPartido PRIMARY KEY(idArbitroPartido)
)

CREATE TABLE JugadorPartido
(
    idJugadorPartido int IDENTITY (1,1),
    idJugador int not null,
    idPartido int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKJugadorPartido PRIMARY KEY(idJugadorPartido)
)

CREATE TABLE JugadorPosicion
(
    idJugadorPosicion int IDENTITY (1,1),
    idJugador int not null,
    idPosicion int not null,
    fecha datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKJugadorPosicion PRIMARY KEY(idJugadorPosicion)
)

--INDEX

CREATE INDEX IXArbitro ON Arbitro(idArbitro)
GO
CREATE INDEX IXEquipo ON Equipo(idEquipo)
GO
CREATE INDEX IXJugador ON Jugador(idJugador)
GO
CREATE INDEX IXPartido ON Partido(idPartido)
GO
CREATE INDEX IXPosicion ON Posicion(idPosicion)
GO
CREATE INDEX IXTipoÁrbitro ON TipoArbitro(idTipoArbitro)
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario)
GO
CREATE INDEX IXÁrbitroTipoÁrbitro ON ArbitroTipoArbitro(idArbitroTipoArbitro)
GO
CREATE INDEX IXArbitroPartido ON ArbitroPartido(idArbitroPartido)
GO
CREATE INDEX IXJugadorPartido ON JugadorPartido(idJugadorPartido)
GO
CREATE INDEX IXJugadorPosicion ON JugadorPosicion(idJugadorPosicion)
GO

--RELACIONES

ALTER TABLE Arbitro
ADD CONSTRAINT FKArbitroUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Arbitro
ADD CONSTRAINT FKArbitroUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Equipo
ADD CONSTRAINT FKEquipoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Equipo
ADD CONSTRAINT FKEquipoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Jugador
ADD CONSTRAINT FKJugadorUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Jugador
ADD CONSTRAINT FKJugadorUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Partido
ADD CONSTRAINT FKPartidoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Partido
ADD CONSTRAINT FKPartidoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Posicion
ADD CONSTRAINT FKPosicionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Posicion
ADD CONSTRAINT FKPosicionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoArbitro
ADD CONSTRAINT FKTipoArbitroUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE TipoArbitro
ADD CONSTRAINT FKTipoArbitroUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ArbitroTipoArbitro
ADD CONSTRAINT FKArbitroTipoArbitroUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ArbitroTipoArbitro
ADD CONSTRAINT FKArbitroTipoArbitroUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ArbitroPartido
ADD CONSTRAINT FKArbitroPartidoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ArbitroPartido
ADD CONSTRAINT FKArbitroPartidoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE JugadorPartido
ADD CONSTRAINT FKJugadorPartidoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE JugadorPartido
ADD CONSTRAINT FKJugadorPartidoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE JugadorPosicion
ADD CONSTRAINT FKJugadorPosicionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE JugadorPosicion
ADD CONSTRAINT FKJugadorPosicionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Partido
ADD CONSTRAINT FKPartidoEquipoLocal FOREIGN KEY (idEquipoLocal)
REFERENCES Equipo(idEquipo)

ALTER TABLE Partido
ADD CONSTRAINT FKPartidoEquipoVisita FOREIGN KEY (idEquipoVisita)
REFERENCES Equipo(idEquipo)

ALTER TABLE ArbitroTipoArbitro
ADD CONSTRAINT FKArbitroTipoArbitroArbitro FOREIGN KEY (idArbitro)
REFERENCES Arbitro(idArbitro)

ALTER TABLE ArbitroTipoArbitro
ADD CONSTRAINT FKArbitroTipoArbitroTipoArbitro FOREIGN KEY (idTipoArbitro)
REFERENCES TipoArbitro(idTipoArbitro)

ALTER TABLE ArbitroPartido
ADD CONSTRAINT FKArbitroPartidoArbitro FOREIGN KEY (idArbitro)
REFERENCES Arbitro(idArbitro)

ALTER TABLE ArbitroPartido
ADD CONSTRAINT FKArbitroPartidoPartido FOREIGN KEY (idPartido)
REFERENCES Partido(idPartido)

ALTER TABLE JugadorPartido
ADD CONSTRAINT FKJugadorPartidoJugador FOREIGN KEY (idJugador)
REFERENCES Jugador(idJugador)

ALTER TABLE JugadorPartido
ADD CONSTRAINT FKJugadorPartidoPartido FOREIGN KEY (idPartido)
REFERENCES Partido(idPartido)

ALTER TABLE JugadorPosicion
ADD CONSTRAINT FKJugadorPosicionJugador FOREIGN KEY (idJugador)
REFERENCES Jugador(idJugador)

ALTER TABLE JugadorPosicion
ADD CONSTRAINT FKJugadorPosicionPosicion FOREIGN KEY (idPosicion)
REFERENCES Posicion(idPosicion)

--INSERTAR

INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Camila', 'Cabrera', 'Mendez', 'camilac@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Luisa', 'Saavedra', 'Castillo', 'luisas@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Deborah', 'Valencia', 'López', 'deborahv@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Jessica','Lago', 'Pedraza', 'jessical@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Karolina', 'Ochoa', 'García', 'karoo@gmail.com', 'Cons123.', 1, GETDATE())
GO

INSERT INTO Arbitro (nombre, apellidoPaterno, apellidoMaterno, idUsuarioCrea, fechaCrea)
    VALUES ('Alfred', 'Garcia', 'Castillo', 1, GETDATE()),
           ('Luis','Cepeda', 'Fernandez', 1, GETDATE()),
           ('Juan Pablo', 'Villamil', 'Lorente', 1, GETDATE()),
           ('Raoul', 'Vázquez', 'Guerra', 1, GETDATE()),
           ('Ricardo', 'Merino', 'Mass', 1, GETDATE())
GO

INSERT INTO Equipo (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Equipo 1', 1, GETDATE()),
           ('Equipo 2', 1, GETDATE()),
           ('Equipo 3', 1, GETDATE()),
           ('Equipo 4', 1, GETDATE()),
           ('Equipo 5', 1, GETDATE())
GO

INSERT INTO Jugador (nombre, apellidoPaterno, apellidoMaterno, nacionalidad, fechaNacimiento, idUsuarioCrea, fechaCrea)
    VALUES ('Alfred', 'Garcia', 'Castillo', 'Español', '1997-04-14', 1, GETDATE()),
           ('Luis','Cepeda', 'Fernandez', 'Español', '1989-08-28',  1, GETDATE()),
           ('Juan Pablo', 'Villamil', 'Lorente', 'Colombiano', '1991-03-09', 1, GETDATE()),
           ('Raoul', 'Vázquez', 'Guerra', 'Español', '1996-11-28', 1, GETDATE()),
           ('Ricardo', 'Merino', 'Mass', 'Español', '1987-12-21', 1, GETDATE())
GO

INSERT INTO Partido (fecha, nombreEstadio, idEquipoLocal, idEquipoVisita, idUsuarioCrea, fechaCrea)
    VALUES ('2021-11-20', 'Estadio 1', 2, 3, 1, GETDATE()),
           ('2021-11-21', 'Estadio 2', 3, 2, 1, GETDATE()),
           ('2021-11-27', 'Estadio 4', 1, 5, 1, GETDATE()),
           ('2021-11-28', 'Estadio 3', 5, 1, 1, GETDATE()),
           ('2021-12-04', 'Estadio 5', 5, 3, 1, GETDATE())
GO

INSERT INTO Posicion (nombre, descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('Posición 1', 'Posición', 1, GETDATE()),
           ('Posición 2', 'Posición', 1, GETDATE()),
           ('Posición 3', 'Posición', 1, GETDATE()),
           ('Posición 4', 'Posición', 1, GETDATE()),
           ('Posición 5', 'Posición', 1, GETDATE())
GO

INSERT INTO TipoArbitro (nombre, descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('Tipo Árbitro 1', 'Árbitro', 1, GETDATE()),
           ('Tipo Árbitro 2', 'Árbitro', 1, GETDATE()),
           ('Tipo Árbitro 3', 'Árbitro', 1, GETDATE()),
           ('Tipo Árbitro 4', 'Árbitro', 1, GETDATE()),
           ('Tipo Árbitro 5', 'Árbitro', 1, GETDATE())
GO

INSERT INTO ArbitroTipoArbitro (idArbitro, idTipoArbitro, idUsuarioCrea, fechaCrea)
    VALUES (1, 2, 1, GETDATE()),
           (1, 3, 1, GETDATE()),
           (2, 3, 1, GETDATE()),
           (5, 1, 1, GETDATE()),
           (3, 2, 1, GETDATE())
GO

INSERT INTO ArbitroPartido (idArbitro, idPartido, idUsuarioCrea, fechaCrea)
    VALUES (1, 2, 1, GETDATE()),
           (1, 3, 1, GETDATE()),
           (2, 1, 1, GETDATE()),
           (2, 5, 1, GETDATE()),
           (3, 4, 1, GETDATE())
GO

INSERT INTO JugadorPartido (idJugador, idPartido, idUsuarioCrea, fechaCrea)
    VALUES (1, 1, 1, GETDATE()),
           (3, 1, 1, GETDATE()),
           (2, 1, 1, GETDATE()),
           (4, 2, 1, GETDATE()),
           (3, 2, 1, GETDATE())
GO

INSERT INTO JugadorPosicion (idJugador, idPosicion, fecha, idUsuarioCrea, fechaCrea)
    VALUES (1, 2, '2021-11-29', 1, GETDATE()),
           (5, 3, '2021-11-29', 1, GETDATE()),
           (3, 2, '2021-11-30', 1, GETDATE()),
           (1, 1, '2021-12-04', 1, GETDATE()),
           (3, 1, '2021-12-06', 1, GETDATE())
GO

--SELECT

SELECT * FROM Arbitro
SELECT * FROM Equipo
SELECT * FROM Jugador
SELECT * FROM Partido
SELECT * FROM Posicion
SELECT * FROM TipoArbitro
SELECT * FROM Usuario
SELECT * FROM ArbitroTipoArbitro
SELECT * FROM ArbitroPartido
SELECT * FROM JugadorPartido
SELECT * FROM JugadorPosicion

--DELETE 

DELETE FROM Jugador WHERE idJugador = 5
DELETE FROM Partido WHERE idPartido = 5

--SELECT AFTER DELETE

SELECT * FROM Jugador
SELECT * FROM Partido

--VIEWS

CREATE VIEW PartidoEquipoLocal AS SELECT p.idPartido, p.fecha, p.nombreEstadio, e.idEquipo, e.nombre
FROM Partido p INNER JOIN Equipo e ON p.idEquipoLocal = e.idEquipo WHERE
e.idEquipo >= 1 GROUP BY  p.idPartido, p.fecha, p.nombreEstadio, e.idEquipo, e.nombre
GO

CREATE VIEW PartidoEquipoVisitante AS SELECT p.idPartido, p.fecha, p.nombreEstadio, e.idEquipo, e.nombre
FROM Partido p INNER JOIN Equipo e ON p.idEquipoVisita = e.idEquipo WHERE
e.idEquipo >= 1 GROUP BY  p.idPartido, p.fecha, p.nombreEstadio, e.idEquipo, e.nombre
GO

CREATE VIEW ArbitroTipoArbitroInformacion AS SELECT ta.idArbitroTipoArbitro, a.idArbitro, a.nombre, a.apellidoPaterno, a.apellidoMaterno, t.descripcion
FROM Arbitro a INNER JOIN ArbitroTipoArbitro ta ON a.idArbitro = ta.idArbitro INNER JOIN TipoArbitro t ON t.idTipoArbitro = ta.idTipoArbitro WHERE
a.idArbitro >= 1 GROUP BY ta.idArbitroTipoArbitro, a.idArbitro, a.nombre, a.apellidoPaterno, a.apellidoMaterno, t.descripcion
GO

CREATE VIEW JugadorPartidoInformacion AS SELECT jp.idJugadorPartido, j.nombre, j.apellidoPaterno, j.nacionalidad, p.fecha
FROM Jugador j INNER JOIN JugadorPartido jp ON j.idJugador = jp.idJugador INNER JOIN Partido p ON jp.idPartido = p.idPartido WHERE
j.idJugador >= 1 GROUP BY jp.idJugadorPartido, j.nombre, j.apellidoPaterno, j.nacionalidad, p.fecha
GO

CREATE VIEW JugadorPosicionInformacion AS SELECT jp.idJugadorPosicion, j.nombre, j.apellidoPaterno, j.nacionalidad, p.descripcion, jp.fecha
FROM Jugador j INNER JOIN JugadorPosicion jp ON j.idJugador = jp.idJugador INNER JOIN Posicion p ON jp.idPosicion = p.idPosicion WHERE
j.idJugador >= 1 GROUP BY jp.idJugadorPosicion, j.nombre, j.apellidoPaterno, j.nacionalidad, p.descripcion, jp.fecha
GO