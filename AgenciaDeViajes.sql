USE master
GO

IF DB_ID (N'AgenciaDeViajes') IS NOT NULL
DROP DATABASE AgenciaDeViajes;
GO
CREATE DATABASE AgenciaDeViajes
ON 
(NAME = AgenciaDeViajes_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\AgenciaDeViajes.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = AgenciaDeViajes_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\AgenciaDeViajes.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE AgenciaDeViajes
GO

--TABLAS

CREATE TABLE Hotel
(
    idHotel int IDENTITY (1,1),
    nombre varchar (50) not null,
    calle varchar (50) not null,
    numeroExterior char (5) not null,
    cp char (5) not null,
    colonia varchar (50) not null,
    ciudad varchar (50) not null,
    estado varchar (50) not null,
    pais varchar (50) not null,
    telefono char (10) not null,
    plazasDisponibles int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKHotel PRIMARY KEY(idHotel)
)

CREATE TABLE Sucursal
(
    idSucursal int IDENTITY (1,1),
    codigo char (5) not null,
    calle varchar (50) not null,
    numeroExterior char (5) not null,
    cp char (5) not null,
    colonia varchar (50) not null,
    ciudad varchar (50) not null,
    estado varchar (50) not null,
    pais varchar (50) not null,
    telefono char (10) not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKSucursal PRIMARY KEY(idSucursal)
)

CREATE TABLE Turista
(
    idTurista int IDENTITY (1,1),
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    calle varchar (50) not null,
    numeroExterior char (5) not null,
    cp char (5) not null,
    colonia varchar (50) not null,
    ciudad varchar (50) not null,
    estado varchar (50) not null,
    pais varchar (50) not null,
    telefono char (10) not null,
    idSucursal int not null,
    idHotel int not null,
    idVuelo int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTurista PRIMARY KEY(idTurista)
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

CREATE TABLE Vuelo
(
    idVuelo int IDENTITY (1,1),
    fecha date not null,
    ciudadOrigen varchar (50) not null,
    estadoOrigen varchar (50) not null,
    paisOrigen varchar (50) not null,
    ciudadDestino varchar (50) not null,
    estadoDestino varchar (50) not null,
    paisDestino varchar (50) not null,
    plazasTotales int not null,
    plazasClaseTurista int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKVuelo PRIMARY KEY(idVuelo)
)

--INDEX

CREATE INDEX IXHotel ON Hotel(idHotel);
GO
CREATE INDEX IXSucursal ON Sucursal(idSucursal);
GO
CREATE INDEX IXTurista ON Turista(idTurista);
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario);
GO
CREATE INDEX IXVuelo ON Vuelo(idVuelo);
GO

--RELACIONES

ALTER TABLE Hotel
ADD CONSTRAINT FKHotelUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Hotel
ADD CONSTRAINT FKHotelUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Sucursal
ADD CONSTRAINT FKSucursalUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Sucursal
ADD CONSTRAINT FKSucursalUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Turista
ADD CONSTRAINT FKTuristaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Turista
ADD CONSTRAINT FKTuristaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Vuelo
ADD CONSTRAINT FKVueloUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Vuelo
ADD CONSTRAINT FKVueloUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Turista
ADD CONSTRAINT FKTuristaSucursal FOREIGN KEY (idSucursal)
REFERENCES Sucursal(idSucursal)

ALTER TABLE Turista
ADD CONSTRAINT FKTuristaHotel FOREIGN KEY (idHotel)
REFERENCES Hotel(idHotel)

ALTER TABLE Turista
ADD CONSTRAINT FKTuristaVuelo FOREIGN KEY (idVuelo)
REFERENCES Vuelo(idVuelo)

--INSERTAR

INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Alfred', 'Garcia', 'Castillo', 'alfredgarcia@gmail.com', 'Agencia123.', 1, GETDATE()),
           ('Luis','Cepeda', 'Fernandez', 'luiscepeda@gmail.com','Agencia123.', 1, GETDATE()),
           ('Juan Pablo', 'Villamil', 'Lorente','juanpablovillamil@gmail.com', 'Agencia123.', 1, GETDATE()),
           ('Raoul', 'Vázquez', 'Guerra', 'raoulzaquez@gmail.com', 'Agencia123.', 1, GETDATE()),
           ('Ricardo', 'Merino', 'Mass', 'ricardomerino@gmail.com', 'Agencia123.', 1, GETDATE())
GO


INSERT INTO Hotel (nombre, calle, numeroExterior, cp, colonia, ciudad, estado, pais, telefono, plazasDisponibles, idUsuarioCrea, fechaCrea)
    VALUES ('Hotel1', 'Calle 1','12345','44100','Col 1', 'Guadalajara', 'Jalisco', 'Mexico', '1234567890', '35', 1, GETDATE()),
           ('Hotel2', 'Calle 45', '48156','64000','Col 2', 'Monterrey', 'Nuevo León','Mexico', '4854378236', '40', 1, GETDATE()),
           ('Hotel3', 'Calle 71','32851','83000','Col 3', 'Hermosillo', 'Sonora','Mexico', '1536975423', '15', 1, GETDATE()),
           ('Hotel4', 'Calle 35','79246','25740','Col 4', 'Monclova', 'Coahuila','Mexico', '3692145789', '10', 1, GETDATE()),
           ('Hotel5', 'Calle 3','92487','25740','Col 5', 'Monclova', 'Coahuila','Mexico', '1234767890', '8', 1, GETDATE())
GO

INSERT INTO Sucursal (codigo, calle, numeroExterior, cp, colonia, ciudad, estado, pais, telefono, idUsuarioCrea, fechaCrea)
    VALUES ('S1234', 'Calle 1','39674','44100','Col 1', 'Guadalajara', 'Jalisco', 'Mexico', '3697845216', 1, GETDATE()),
           ('S1235', 'Calle 57', '78215','64000','Col 2', 'Monterrey', 'Nuevo León','Mexico', '3647812456', 1, GETDATE()),
           ('S1236', 'Calle 19','12976','83000','Col 3', 'Hermosillo', 'Sonora','Mexico', '3641002379', 1, GETDATE()),
           ('S1237', 'Calle 31','96478','25740','Col 4', 'Monclova', 'Coahuila','Mexico', '2459378945', 1, GETDATE()),
           ('S1238', 'Calle 9','31254','25740','Col 5', 'Monclova', 'Coahuila','Mexico', '3214501236', 1, GETDATE())
GO

INSERT INTO Vuelo (fecha, ciudadOrigen, estadoOrigen, paisOrigen, ciudadDestino, estadoDestino, paisDestino, plazasTotales, plazasClaseTurista, idUsuarioCrea, fechaCrea)
    VALUES (GETDATE(), 'Apodaca','Nuevo León','México', 'Guadalajara', 'Jalisco', 'Mexico', 85, 70, 1, GETDATE()),
           (GETDATE(), 'Saltillo','Coahuila','México', 'Ciudad de México', 'Ciudad de Mexico', 'Mexico', 60, 50, 1, GETDATE()),
           (GETDATE(), 'Ciudad de México','Ciudad de México','México', 'Apodaca', 'Nuevo León', 'Mexico', 100, 80, 1, GETDATE()),
		   (GETDATE(), 'Guadalajara', 'Jalisco', 'Mexico', 'Apodaca', 'Nuevo León', 'Mexico', 100, 80, 1, GETDATE()),
           (GETDATE(), 'Apodaca','Nuevo León','México', 'Guadalajara', 'Jalisco', 'Mexico', 85, 70, 1, GETDATE())
GO

INSERT INTO Turista (nombre, apellidoPaterno, apellidoMaterno, telefono, calle, numeroExterior, cp, colonia, ciudad, estado, pais, idSucursal, idHotel, idVuelo, idUsuarioCrea, fechaCrea)
    VALUES ('Amaia', 'Romero', 'Soto', '4785123692', 'Calle 1','12345','25740','C 1', 'Monclova', 'Coahuila', 'Mexico', 4, 1, 1, 1, GETDATE()),
           ('Aitana','Ocaña', 'Fernandez', '1452369874', 'Calle 7','67890','25740','C 2', 'Monclova', 'Coahuila', 'Mexico', 5, 1, 5, 1, GETDATE()),
           ('Miriam', 'Rodríguez', 'Guix', '1425396019', 'Calle 9','09876','25740','C 1', 'Monclova', 'Coahuila', 'Mexico', 5, 1, 2, 1, GETDATE()),
           ('Nerea', 'Rodríguez', 'Galera', '1237418602', 'Calle 75','54321','25740','C 4', 'Monclova', 'Coahuila', 'Mexico', 4, 1, 1, 1, GETDATE()),
           ('Thalia', 'Garrido', 'Rosenthal', '1039758462', 'Calle 95', '85462','25740','C 5', 'Monclova','Coahuila', 'Mexico', 4, 1, 5, 1, GETDATE())
GO


--SELECT

SELECT * FROM Hotel
SELECT * FROM Sucursal
SELECT * FROM Turista
SELECT * FROM Vuelo
SELECT * FROM Usuario

--DELETE

DELETE FROM Hotel WHERE idHotel=3
DELETE FROM Vuelo WHERE idVuelo=2

--SELECT AFTER DELETE

SELECT * FROM Hotel
SELECT * FROM Vuelo

--VIEWS

CREATE VIEW TuristaVuelo AS SELECT t.idTurista, t.nombre, v.idVuelo 
FROM Turista t INNER JOIN Vuelo v ON t.idVuelo = v.idVuelo WHERE
v.idVuelo = 1 GROUP BY t.idTurista, t.nombre, v.idVuelo 
GO

CREATE VIEW TuristaHotel AS SELECT t.idTurista, t.nombre, h.idHotel
FROM Turista t INNER JOIN Hotel h ON t.idHotel = h.idHotel WHERE
h.idHotel = 1 GROUP BY t.idTurista, t.nombre, h.idHotel
GO

CREATE VIEW TuristaVueloNumero5 AS SELECT t.idTurista, t.nombre, v.idVuelo 
FROM Turista t INNER JOIN Vuelo v ON t.idVuelo = v.idVuelo WHERE
v.idVuelo = 5 GROUP BY t.idTurista, t.nombre, v.idVuelo 
GO

CREATE VIEW TuristaSucursal AS SELECT t.idTurista, t.nombre, s.idSucursal
FROM Turista t INNER JOIN Sucursal s ON t.idSucursal = s.idSucursal WHERE
s.idSucursal = 4 GROUP BY t.idTurista, t.nombre, s.idSucursal
GO

CREATE VIEW TuristaDestino AS SELECT t.idTurista, t.nombre, v.idVuelo, v.paisDestino
FROM Turista t INNER JOIN Vuelo v ON t.idVuelo = v.idVuelo WHERE
v.idVuelo = 2
GO