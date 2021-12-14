USE master
GO

IF DB_ID (N'USE LineasDelMetro') IS NOT NULL
DROP DATABASE  LineasDelMetro
GO
CREATE DATABASE  LineasDelMetro
ON 
(NAME = LineasDelMetro_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\LineasDelMetro.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = LineasDelMetro_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\LineasDelMetro.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE LineasDelMetro
GO

--TABLAS

CREATE TABLE Acceso
(
    idAcceso int IDENTITY,
    nombre varchar (50) not null,
    idEstacion int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKAcceso PRIMARY KEY(idAcceso)
)

CREATE TABLE Cochera
(
    idCochera int IDENTITY,
    numero char (5) not null,
    idEstacion int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCochera PRIMARY KEY(idCochera)
)

CREATE TABLE Estacion
(
    idEstacion int IDENTITY,
    nombre varchar (50) not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKEstacion PRIMARY KEY(idEstacion)
)

CREATE TABLE Linea
(
    idLinea int IDENTITY,
    nombre varchar (50) not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKLinea PRIMARY KEY(idLinea)
)

CREATE TABLE Tren
(
    idTren int IDENTITY,
    modelo varchar (50) not null,
    matricula char (8) not null,
	idLinea int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTren PRIMARY KEY(idTren)
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

CREATE TABLE AccesoLinea
(
    idAccesoLinea int IDENTITY,
    idAcceso int not null,
    idLinea int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKAccesoLinea PRIMARY KEY(idAccesoLinea)
)

CREATE TABLE CocheraTren
(
    idCocheraTren int IDENTITY,
    idCochera int not null,
    idTren int not null,
    fechaInicio datetime not null,
    fechaFinal date not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCocheraTren PRIMARY KEY(idCocheraTren)
)

CREATE TABLE EstacionLinea
(
    idEstacionLinea int IDENTITY,
    idEstacion int not null,
    idLinea int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKEstacionLinea PRIMARY KEY(idEstacionLinea)
)

--INDEX

CREATE INDEX IXAcceso ON Acceso(idAcceso)
GO
CREATE INDEX IXCochera ON Cochera(idCochera)
GO
CREATE INDEX IXEstacion ON Estacion(idEstacion)
GO
CREATE INDEX IXLinea ON Linea(idLinea)
GO
CREATE INDEX IXTren ON Tren(idTren)
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario)
GO
CREATE INDEX IXAccesoLinea ON AccesoLinea(idAccesoLinea)
GO
CREATE INDEX IXCocheraTren ON CocheraTren(idCocheraTren)
GO
CREATE INDEX IXEstacionLinea ON EstacionLinea(idEstacionLinea)
GO

--RELACIONES

ALTER TABLE Acceso
ADD CONSTRAINT FKAccesoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Acceso
ADD CONSTRAINT FKAccesoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cochera
ADD CONSTRAINT FKCocheraUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cochera
ADD CONSTRAINT FKCocheraUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Estacion
ADD CONSTRAINT FKEstacionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Estacion
ADD CONSTRAINT FKEstacionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Linea
ADD CONSTRAINT FKLineaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Linea
ADD CONSTRAINT FKLineaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Tren
ADD CONSTRAINT FKTrenUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Tren
ADD CONSTRAINT FKTrenUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE AccesoLinea
ADD CONSTRAINT FKAccesoLineaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE AccesoLinea
ADD CONSTRAINT FKAccesoLineaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE CocheraTren
ADD CONSTRAINT FKCocheraTrenUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE CocheraTren
ADD CONSTRAINT FKCocheraTrenUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE EstacionLinea
ADD CONSTRAINT FKEstacionLineaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE EstacionLinea
ADD CONSTRAINT FKEstacionLineaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Acceso
ADD CONSTRAINT FKAccesoEstacion FOREIGN KEY (idEstacion)
REFERENCES Estacion(idEstacion)

ALTER TABLE Cochera
ADD CONSTRAINT FKCocheraEstacion FOREIGN KEY (idEstacion)
REFERENCES Estacion(idEstacion)

ALTER TABLE Tren
ADD CONSTRAINT FKTrenLinea FOREIGN KEY (idLinea)
REFERENCES Linea(idLinea)

ALTER TABLE AccesoLinea
ADD CONSTRAINT FKAccesoLineaAcceso FOREIGN KEY (idAcceso)
REFERENCES Acceso(idAcceso)

ALTER TABLE AccesoLinea
ADD CONSTRAINT FKAccesoLineaLinea FOREIGN KEY (idLinea)
REFERENCES Acceso(idAcceso)

ALTER TABLE CocheraTren
ADD CONSTRAINT FKCocheraTrenCochera FOREIGN KEY (idCochera)
REFERENCES Cochera(idCochera)

ALTER TABLE CocheraTren
ADD CONSTRAINT FKCocheraTrenTren FOREIGN KEY (idTren)
REFERENCES Tren(idTren)

ALTER TABLE EstacionLinea
ADD CONSTRAINT FKEstacionLineaEstacion FOREIGN KEY (idEstacion)
REFERENCES Estacion(idEstacion)

ALTER TABLE EstacionLinea
ADD CONSTRAINT FKEstacionLineaLinea FOREIGN KEY (idLinea)
REFERENCES Linea(idLinea)

--INSERTAR

INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Camila', 'Cabrera', 'Mendez', 'camilac@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Luisa', 'Saavedra', 'Castillo', 'luisas@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Deborah', 'Valencia', 'López', 'deborahv@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Jessica','Lago', 'Pedraza', 'jessical@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Karolina', 'Ochoa', 'García', 'karoo@gmail.com', 'Cons123.', 1, GETDATE())
GO

INSERT INTO Estacion (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Estación 1', 1, GETDATE()),
           ('Estación 2', 1, GETDATE()),
           ('Estación 3', 1, GETDATE()),
           ('Estación 4', 1, GETDATE()),
           ('Estación 5', 1, GETDATE())
GO

INSERT INTO Acceso (nombre, idEstacion, idUsuarioCrea, fechaCrea)
    VALUES ('Acceso 1', 1, 1, GETDATE()),
           ('Acceso 2', 1, 1, GETDATE()),
           ('Acceso 3', 2, 1, GETDATE()),
           ('Acceso 4', 3, 1, GETDATE()),
           ('Acceso 5', 3, 1, GETDATE())
GO

INSERT INTO Cochera (numero, idEstacion, idUsuarioCrea, fechaCrea)
    VALUES ('1-101', 1, 1, GETDATE()),
           ('1-102', 1, 1, GETDATE()),
           ('1-103', 1, 1, GETDATE()),
           ('1-104', 1, 1, GETDATE()),
           ('1-105', 1, 1, GETDATE())
GO

INSERT INTO Linea (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Linea 1', 1, GETDATE()),
           ('Linea 2', 1, GETDATE()),
           ('Linea 3', 1, GETDATE()),
           ('Linea 4', 1, GETDATE()),
           ('Linea 5', 1, GETDATE())
GO

INSERT INTO Tren (modelo, matricula, idLinea, idUsuarioCrea, fechaCrea)
    VALUES ('Modelo 2', 'ADE-1452', 1, 1, GETDATE()),
           ('Modelo 2', 'FRG-4841', 2, 1, GETDATE()),
           ('Modelo 2', 'DFE-1846', 4, 1, GETDATE()),
           ('Modelo 3', 'RED-1846', 5, 1, GETDATE()),
           ('Modelo 4', 'FEF-4613', 2, 1, GETDATE())
GO

INSERT INTO AccesoLinea (idAcceso, idLinea, idUsuarioCrea, fechaCrea)
    VALUES (1, 1, 1, GETDATE()),
           (1, 2, 1, GETDATE()),
           (2, 2, 1, GETDATE()),
           (2, 3, 1, GETDATE()),
           (3, 3, 1, GETDATE())
GO

INSERT INTO CocheraTren (idCochera, idTren, fechaInicio, fechaFinal, idUsuarioCrea, fechaCrea)
    VALUES (1, 2, '2021-11-25', GETDATE(), 1, GETDATE()),
           (2, 4, '2021-11-27', GETDATE(), 1, GETDATE()),
           (2, 2, '2021-11-29', '2021-11-30', 1, GETDATE()),
           (2, 3,'2021-11-29', GETDATE(), 1, GETDATE()),
           (3, 3, '2021-11-30', GETDATE(), 1, GETDATE())
GO


INSERT INTO EstacionLinea (idEstacion, idLinea, idUsuarioCrea, fechaCrea)
    VALUES (1, 1, 1, GETDATE()),
           (1, 2, 1, GETDATE()),
           (3, 1, 1, GETDATE()),
           (1, 4, 1, GETDATE()),
           (5, 3, 1, GETDATE())
GO

--SELECT

SELECT * FROM Acceso
SELECT * FROM Cochera
SELECT * FROM Estacion
SELECT * FROM Linea
SELECT * FROM Tren
SELECT * FROM Usuario
SELECT * FROM AccesoLinea
SELECT * FROM CocheraTren
SELECT * FROM EstacionLinea

--DELETE 

DELETE FROM CocheraTren WHERE idCocheraTren = 5
DELETE FROM AccesoLinea WHERE idAccesoLinea=2

--SELECT AFTER DELETE

SELECT * FROM CocheraTren
SELECT * FROM AccesoLinea

--VIEWS

CREATE VIEW CocheraEstacion AS SELECT c.idCochera, c.numero, e.idEstacion, e.nombre
FROM Cochera c INNER JOIN Estacion e ON c.idEstacion = e.idEstacion WHERE
e.idEstacion = 1 GROUP BY c.idCochera, c.numero, e.idEstacion, e.nombre
GO

CREATE VIEW TrenLinea AS SELECT t.idTren, t.matricula, l.idLinea, l.nombre
FROM Tren t INNER JOIN Linea l ON t.idLinea = l.idLinea WHERE
l.idLinea >= 1 GROUP BY t.idTren, t.matricula, l.idLinea, l.nombre
GO

CREATE VIEW AccesoEstacion AS SELECT a.idAcceso, a.nombre, e.idEstacion
FROM Acceso a INNER JOIN Estacion e ON a.idEstacion = e.idEstacion WHERE
e.idEstacion >= 1 GROUP BY a.idAcceso, a.nombre, e.idEstacion
GO

CREATE VIEW TrenLineaCantidad AS
SELECT l.idLinea, count (t.idLinea) as cantidad
FROM Linea l INNER JOIN Tren t ON l.idLinea = t.idLinea WHERE
t.idLinea >= 1 GROUP BY l.idLinea
GO

CREATE VIEW CocheraEstacionCantidad AS
SELECT e.idEstacion, count (c.idEstacion) as cantidad
FROM Estacion e INNER JOIN Cochera c ON c.idEstacion = e.idEstacion WHERE
c.idEstacion >= 1 GROUP BY e.idEstacion
GO