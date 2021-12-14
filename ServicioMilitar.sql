USE master
GO

IF DB_ID (N'ServicioMilitar') IS NOT NULL
DROP DATABASE ServicioMilitar;
GO

CREATE DATABASE ServicioMilitar
ON 
(NAME = ServicioMilitar_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ServicioMilitar.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = ServicioMilitar_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ServicioMilitar.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE ServicioMilitar
GO

--TABLAS

CREATE TABLE Compañia
(
    idCompañia int IDENTITY (1,1),
    actividad varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCompañia PRIMARY KEY (idCompañia)
)

CREATE TABLE Cuartel
(
    idCuartel int IDENTITY (1,1),
    nombre varchar (50) not null,
    ubicacion varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCuartel PRIMARY KEY (idCuartel)
)

CREATE TABLE Cuerpo
(
    idCuerpo int IDENTITY (1,1),
    denominacion varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCuerpo PRIMARY KEY (idCuerpo)
)

CREATE TABLE Servicio
(
    idServicio int IDENTITY (1,1),
    descripcion varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKServicio PRIMARY KEY (idServicio)
)

CREATE TABLE Soldado
(
    idSoldado int IDENTITY (1,1),
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    grado varchar (50) not null,
    idCuerpo int not null,
    idCompañia int not null,
    idCuartel int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKSoldado PRIMARY KEY (idSoldado)
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

CREATE TABLE ServicioSoldado
(
    idServicioSoldado int IDENTITY (1,1),
    idServicio int not null,
    idSoldado int not null,
    fecha date not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKServicioSoldado PRIMARY KEY (idServicioSoldado)
)

CREATE TABLE CompañiaCuartel
(
    idCompañiaCuartel int IDENTITY (1,1),
    idCompañia int not null,
    idCuartel int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime  null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCompañiaCuartel PRIMARY KEY (idCompañiaCuartel)
)

--INDEX

CREATE INDEX IXCompañia ON Compañia(idCompañia);
GO
CREATE INDEX IXCuartel ON Cuartel(idCuartel);
GO
CREATE INDEX IXCuerpo ON Cuerpo(idCuerpo);
GO
CREATE INDEX IXServicio ON Servicio(idServicio);
GO
CREATE INDEX IXSoldado ON Soldado(idSoldado);
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario);
GO
CREATE INDEX IXCompañiaCuartel ON CompañiaCuartel(idCompañiaCuartel);
GO
CREATE INDEX IXServicioSoldado ON ServicioSoldado(idServicioSoldado);
GO

--RELACIONES

ALTER TABLE Compañia
ADD CONSTRAINT FKCompañiaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Compañia
ADD CONSTRAINT FKCompañiaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cuartel
ADD CONSTRAINT FKCuartelUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cuartel
ADD CONSTRAINT FKCuartelUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cuerpo
ADD CONSTRAINT FKCuerpoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cuerpo
ADD CONSTRAINT FKCuerpoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Servicio
ADD CONSTRAINT FKServicioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Servicio
ADD CONSTRAINT FKServicioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Soldado
ADD CONSTRAINT FKSoldadoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Soldado
ADD CONSTRAINT FKSoldadoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ServicioSoldado
ADD CONSTRAINT FKServicioSoldadoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ServicioSoldado
ADD CONSTRAINT FKCServicioSoldadoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE CompañiaCuartel
ADD CONSTRAINT FKCompañiaCuartelUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE CompañiaCuartel
ADD CONSTRAINT FKCompañiaCuartelUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Soldado
ADD CONSTRAINT FKSoldadoCuerpo FOREIGN KEY (idCuerpo)
REFERENCES Cuerpo(idCuerpo)

ALTER TABLE Soldado
ADD CONSTRAINT FKSoldadoCompañia FOREIGN KEY (idCompañia)
REFERENCES Compañia(idCompañia)

ALTER TABLE Soldado
ADD CONSTRAINT FKSoldadoCuartel FOREIGN KEY (idCuartel)
REFERENCES Cuartel(idCuartel)

ALTER TABLE ServicioSoldado
ADD CONSTRAINT FKServicioSoldadoServicio FOREIGN KEY (idServicio)
REFERENCES Servicio(idServicio)

ALTER TABLE ServicioSoldado
ADD CONSTRAINT FKServicioSoldadoSoldado FOREIGN KEY (idSoldado)
REFERENCES Soldado(idSoldado)

ALTER TABLE CompañiaCuartel
ADD CONSTRAINT FKCompañiaCuartelCompañia FOREIGN KEY (idCompañia)
REFERENCES Compañia(idCompañia)

ALTER TABLE CompañiaCuartel
ADD CONSTRAINT FKCompañiaCuartelCuartel FOREIGN KEY (idCuartel)
REFERENCES Compañia(idCompañia)

--INSERTAR

INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Camila', 'Cabrera', 'Mendez', 'camilac@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Luisa', 'Saavedra', 'Castillo', 'luisas@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Deborah', 'Valencia', 'López', 'deborahv@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Jessica','Lago', 'Pedraza', 'jessical@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Karolina', 'Ochoa', 'García', 'karoo@gmail.com', 'Cons123.', 1, GETDATE())
GO

INSERT INTO Compañia (actividad, idUsuarioCrea, fechaCrea)
    VALUES ('A 1', 1, GETDATE()),
           ('A 2', 1, GETDATE()),
           ('A 3', 1, GETDATE()),
           ('A 4', 1, GETDATE()),
           ('A 5', 1, GETDATE())
GO
INSERT INTO Cuartel (nombre, ubicacion, idUsuarioCrea, fechaCrea)
    VALUES ('Cuartel1', 'U 1', 1, GETDATE()),
           ('Cuartel2', 'U 2', 1, GETDATE()),
           ('Cuartel3', 'U 3', 1, GETDATE()),
           ('Cuartel4', 'U 4', 1, GETDATE()),
           ('Cuartel5', 'U 5', 1, GETDATE())
GO
INSERT INTO Cuerpo (denominacion, idUsuarioCrea, fechaCrea)
    VALUES ('Denominacion1', 1, GETDATE()),
           ('Denominacion2', 1, GETDATE()),
           ('Denominacion3', 1, GETDATE()),
           ('Denominacion4', 1, GETDATE()),
           ('Denominacion5', 1, GETDATE())
GO
INSERT INTO Servicio (descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('Descripcion1', 1, GETDATE()),
           ('Descripcion2', 1, GETDATE()),
           ('Descripcion3', 1, GETDATE()),
           ('Descripcion4', 1, GETDATE()),
           ('Descripcion5', 1, GETDATE())
GO       
INSERT INTO Soldado (nombre, apellidoPaterno, apellidoMaterno, grado, idCuerpo, idCompañia, idCuartel, idUsuarioCrea, fechaCrea)
    VALUES ('Alfred', 'Garcia', 'Castillo', 'G 1', 1, 2, 2, 1, GETDATE()),
           ('Luis', 'Cepeda', 'Fernandez', 'G 2', 2, 3, 2, 1, GETDATE()),
           ('Juan Pablo', 'Villamil', 'Lorente', 'G 1', 3, 2, 3, 1, GETDATE()),
           ('Raoul', 'Vázquez', 'Guerra', 'G 3', 5, 2, 5, 1, GETDATE()),
           ('Ricardo', 'Merino', 'Mass', 'G 5', 1, 1, 3, 1, GETDATE())
GO   
INSERT INTO CompañiaCuartel (idCompañia, idCuartel, idUsuarioCrea, fechaCrea)
    VALUES (2, 3, 1, GETDATE()),
           (5, 1, 1, GETDATE()),
           (1, 3, 1, GETDATE()),
           (4, 3, 1, GETDATE()),
           (3, 5, 1, GETDATE())
GO

INSERT INTO ServicioSoldado (idServicio, idSoldado, fecha, idUsuarioCrea, fechaCrea)
    VALUES (4, 1, '2020-12-05', 1, GETDATE()),
           (3, 1, '2020-10-01', 1, GETDATE()),
           (1, 5, '2020-08-10', 1, GETDATE()),
           (1, 2, '2021-01-31', 1, GETDATE()),
           (2, 3, '2021-02-18', 1, GETDATE())
GO

--SELECT
SELECT * FROM Compañia
SELECT * FROM Cuartel
SELECT * FROM Cuerpo
SELECT * FROM Servicio
SELECT * FROM Soldado
SELECT * FROM Usuario
SELECT * FROM CompañiaCuartel
SELECT * FROM ServicioSoldado

--DELETE
DELETE FROM Cuerpo WHERE idCuerpo=4
DELETE FROM Compañia WHERE idCompañia=5

--SELECT AFTER DELETE

SELECT * FROM Cuerpo
SELECT * FROM Compañia

--VIEWS

CREATE VIEW InformacionSoldadoCuerpo AS SELECT s.idSoldado, s.nombre, c.denominacion 
FROM Soldado s INNER JOIN Cuerpo c ON s.idCuerpo = c.idCuerpo
WHERE c.idCuerpo >= 1 GROUP BY s.idSoldado, s.nombre, c.denominacion
GO

CREATE VIEW InformacionSoldadoCompañia AS SELECT s.idSoldado, s.nombre, c.actividad 
FROM Soldado s INNER JOIN Compañia c ON s.idCompañia = c.idCompañia
WHERE c.idCompañia >= 1 GROUP BY s.idSoldado, s.nombre, c.actividad
GO

CREATE VIEW InformacionSoldadoCuartel AS SELECT s.idSoldado, s.nombre, c.idCuartel, c.ubicacion
FROM Soldado s INNER JOIN Cuartel c ON s.idCuartel = c.idCuartel
WHERE c.idCuartel >= 1 GROUP BY s.idSoldado, s.nombre, c.idCuartel, c.ubicacion
GO

CREATE VIEW SoldadosCompañiaCantidad AS
Select c.idCompañia, count(s.idSoldado) as cantidad
FROM Soldado s INNER JOIN Compañia c ON s.idCompañia = c.idCompañia
WHERE c.idCompañia >= 1 GROUP BY c.idCompañia
GO

CREATE VIEW SoldadosCuartelCantidad AS
Select c.idCuartel, count(s.idSoldado) as cantidad
FROM Soldado s INNER JOIN Cuartel c ON s.idCuartel = c.idCuartel
WHERE c.idCuartel >= 1 GROUP BY c.idCuartel
GO