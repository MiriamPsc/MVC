USE master
GO

IF DB_ID (N'AgenciaDeViajesII') IS NOT NULL
DROP DATABASE AgenciaDeViajesII;
GO
CREATE DATABASE AgenciaDeViajesII
ON 
(NAME = AgenciaDeViajesII_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\AgenciaDeViajesII.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = AgenciaDeViajes_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\AgenciaDeViajesII.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE AgenciaDeViajesII
GO

--TABLAS

CREATE TABLE Cliente
(
    idCliente int IDENTITY,
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    telefono char (10) not null,
    idHotel int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCliente PRIMARY KEY(idCliente)
)

CREATE TABLE Hotel
(
    idHotel int IDENTITY,
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

CREATE TABLE PuntoDeRuta
(
    idPuntoDeRuta int IDENTITY,
    nombre varchar (50) not null,
    tipo char (1) not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPuntoDeRuta PRIMARY KEY(idPuntoDeRuta)
)

CREATE TABLE Tour
(
    idTour int IDENTITY,
    fecha datetime not null,
    tipo varchar (50) not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTour PRIMARY KEY(idTour)
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

CREATE TABLE ClienteTour
(
    idClienteTour int IDENTITY,
    idCliente int not null,
    idTour int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKClienteTour PRIMARY KEY(idClienteTour)
)

CREATE TABLE HotelPuntoDeRuta
(
    idHotelPuntoDeRuta int IDENTITY,
    idHotel int not null,
    idPuntoDeRuta int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKHotelPuntoDeRuta PRIMARY KEY(idHotelPuntoDeRuta)
)

CREATE TABLE PuntoDeRutaTour
(
    idPuntoDeRutaTour int IDENTITY,
    idPuntoDeRuta int not null,
    idTour int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPuntoDeRutaTour PRIMARY KEY(idPuntoDeRutaTour)
)

--INDEX

CREATE INDEX IXCliente ON Cliente(idCliente)
GO
CREATE INDEX IXHotel ON Hotel(idHotel)
GO
CREATE INDEX IXPuntoDeRuta ON PuntoDeRuta(idPuntoDeRuta)
GO
CREATE INDEX IXTour ON Tour(idTour)
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario)
GO
CREATE INDEX IXClienteTour ON ClienteTour(idClienteTour)
GO
CREATE INDEX IXHotelPuntoDeRuta ON HotelPuntoDeRuta(idHotelPuntoDeRuta)
GO
CREATE INDEX IXPuntoDeRutaTour ON PuntoDeRutaTour(idPuntoDeRutaTour)
GO

--RELACIONES

ALTER TABLE Cliente
ADD CONSTRAINT FKClienteUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cliente
ADD CONSTRAINT FKClienteUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Hotel
ADD CONSTRAINT FKHotelUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Hotel
ADD CONSTRAINT FKHotelUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE PuntoDeRuta
ADD CONSTRAINT FKPuntoDeRutaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE PuntoDeRuta
ADD CONSTRAINT FKPuntoDeRutaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Tour
ADD CONSTRAINT FKTourUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Tour
ADD CONSTRAINT FKTourUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ClienteTour
ADD CONSTRAINT FKClienteTourUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ClienteTour
ADD CONSTRAINT FKClienteTourUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE HotelPuntoDeRuta
ADD CONSTRAINT FKHotelPuntoDeRutaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE HotelPuntoDeRuta
ADD CONSTRAINT FKHotelPuntoDeRutaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE PuntoDeRutaTour
ADD CONSTRAINT FKPuntoDeRutaTourUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE PuntoDeRutaTour
ADD CONSTRAINT FKPuntoDeRutaTourUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cliente
ADD CONSTRAINT FKClienteHotel FOREIGN KEY (idHotel)
REFERENCES Hotel(idHotel)

ALTER TABLE ClienteTour
ADD CONSTRAINT FKClienteTourCliente FOREIGN KEY (idCliente)
REFERENCES Cliente(idCliente)

ALTER TABLE ClienteTour
ADD CONSTRAINT FKClienteTourTour FOREIGN KEY (idTour)
REFERENCES Tour(idTour)

ALTER TABLE HotelPuntoDeRuta
ADD CONSTRAINT FKHotelPuntoDeRutaHotel FOREIGN KEY (idHotel)
REFERENCES Hotel(idHotel)

ALTER TABLE HotelPuntoDeRuta
ADD CONSTRAINT FKHotelPuntoDeRutaPuntoDeRuta FOREIGN KEY (idPuntoDeRuta)
REFERENCES PuntoDeRuta(idPuntoDeRuta)

ALTER TABLE PuntoDeRutaTour
ADD CONSTRAINT FKPuntoDeRutaTourPuntoDeRuta FOREIGN KEY (idPuntoDeRuta)
REFERENCES PuntoDeRuta(idPuntoDeRuta)

ALTER TABLE PuntoDeRutaTour
ADD CONSTRAINT FKPuntoDeRutaTourTour FOREIGN KEY (idTour)
REFERENCES Tour(idTour)

--INSERTAR

INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Camila', 'Cabrera', 'Mendez', 'camilac@gmail.com', 'Agencia123.', 1, GETDATE()),
           ('Luisa', 'Saavedra', 'Castillo', 'luisas@gmail.com', 'Agencia123.', 1, GETDATE()),
           ('Deborah', 'Valencia', 'López', 'deborahv@gmail.com', 'Agencia123.', 1, GETDATE()),
           ('Jessica','Lago', 'Pedraza', 'jessical@gmail.com', 'Agencia123.', 1, GETDATE()),
           ('Karolina', 'Ochoa', 'García', 'karoo@gmail.com', 'Agencia123.', 1, GETDATE())
GO

INSERT INTO Hotel (nombre, calle, numeroExterior, cp, colonia, ciudad, estado, pais, telefono, plazasDisponibles, idUsuarioCrea, fechaCrea)
    VALUES ('Hotel1', 'Calle 1','12345','44100','Col 1', 'Guadalajara', 'Jalisco', 'Mexico', '1234567890', '35', 1, GETDATE()),
           ('Hotel2', 'Calle 45', '48156','64000','Col 2', 'Monterrey', 'Nuevo León','Mexico', '4854378236', '40', 1, GETDATE()),
           ('Hotel3', 'Calle 71','32851','83000','Col 3', 'Hermosillo', 'Sonora','Mexico', '1536975423', '15', 1, GETDATE()),
           ('Hotel4', 'Calle 35','79246','25740','Col 4', 'Monclova', 'Coahuila','Mexico', '3692145789', '10', 1, GETDATE()),
           ('Hotel5', 'Calle 3','92487','25740','Col 5', 'Monclova', 'Coahuila','Mexico', '1234767890', '8', 1, GETDATE())
GO

INSERT INTO Cliente (nombre, apellidoPaterno, apellidoMaterno, telefono, idHotel, idUsuarioCrea, fechaCrea)
    VALUES ('Amaia', 'Romero', 'Soto', '8661792540', 3, 1, GETDATE()),
           ('Aitana','Ocaña', 'Fernandez', '8661954678', 4, 1, GETDATE()),
           ('Miriam', 'Rodríguez', 'Guix','8662387952', 5, 1, GETDATE()),
           ('Nerea', 'Rodríguez', 'Galera', '8667894525', 4, 1, GETDATE()),
           ('Thalia', 'Garrido', 'Rosenthal', '8661742358', 1, 1, GETDATE())
GO

INSERT INTO PuntoDeRuta (nombre, tipo, idUsuarioCrea, fechaCrea)
    VALUES ('Punto1', 'V', 1, GETDATE()),
           ('Punto2', 'E', 1, GETDATE()),
           ('Punto3', 'E', 1, GETDATE()),
           ('Punto4', 'E', 1, GETDATE()),
           ('Punto5', 'V', 1, GETDATE())
GO

INSERT INTO Tour (fecha, tipo, idUsuarioCrea, fechaCrea)
    VALUES (GETDATE(), 'Histórico', 1, GETDATE()),
           (GETDATE(), 'Deportivo', 1, GETDATE()),
           (GETDATE(), 'Histórico', 1, GETDATE()),
           (GETDATE(), 'Histórico', 1, GETDATE()),
           (GETDATE(), 'Cultural', 1, GETDATE())
GO

INSERT INTO ClienteTour (idCliente, idTour, idUsuarioCrea, fechaCrea)
    VALUES (1, 3, 1, GETDATE()),
           (2, 4, 1, GETDATE()),
           (3, 5, 1, GETDATE()),
           (4, 5, 1, GETDATE()),
           (5, 1, 1, GETDATE())
GO

INSERT INTO HotelPuntoDeRuta (idHotel, idPuntoDeRuta, idUsuarioCrea, fechaCrea)
    VALUES (1, 2, 1, GETDATE()),
           (2, 3, 1, GETDATE()),
           (3, 2, 1, GETDATE()),
           (4, 3, 1, GETDATE()),
           (5, 4, 1, GETDATE())
GO

INSERT INTO PuntoDeRutaTour (idPuntoDeRuta, idTour, idUsuarioCrea, fechaCrea)
    VALUES (2, 4, 1, GETDATE()),
           (2, 3, 1, GETDATE()),
           (3, 5, 1, GETDATE()),
           (4, 2, 1, GETDATE()),
           (5, 3, 1, GETDATE())
GO

--SELECT

SELECT * FROM Cliente
SELECT * FROM Hotel
SELECT * FROM PuntoDeRutaTour
SELECT * FROM Tour
SELECT * FROM Usuario
SELECT * FROM ClienteTour
SELECT * FROM HotelPuntoDeRuta
SELECT * FROM PuntoDeRutaTour

--DELETE

DELETE FROM PuntoDeRuta WHERE idPuntoDeRuta=1
DELETE FROM HotelPuntoDeRuta WHERE idHotelPuntoDeRuta=5

--SELECT AFTER DELETE

SELECT * FROM PuntoDeRuta
SELECT * FROM HotelPuntoDeRuta

--VIEWS

CREATE VIEW  ClienteHotel AS SELECT c.idCliente, c.nombre, h.idHotel 
FROM Cliente c INNER JOIN Hotel h ON c.idHotel = h.idHotel WHERE
h.idHotel = 1 GROUP BY c.idCliente, c.nombre, h.idHotel
GO

CREATE VIEW ClienteHotelCantidad AS 
SELECT c.idHotel, count (h.idHotel) as cantidad
FROM Cliente c INNER JOIN Hotel h ON c.idHotel = h.idHotel WHERE
c.idCliente = 1 GROUP BY c.idHotel
GO

CREATE VIEW  ClienteHotelCuatro AS SELECT c.idCliente, c.nombre, h.idHotel 
FROM Cliente c INNER JOIN Hotel h ON c.idHotel = h.idHotel WHERE
h.idHotel = 4 GROUP BY c.idCliente, c.nombre, h.idHotel
GO

CREATE VIEW ClienteHotelCantidadCuatro AS 
SELECT c.idHotel, count (h.idHotel) as cantidad
FROM Cliente c INNER JOIN Hotel h ON c.idHotel = h.idHotel WHERE
c.idCliente = 4 GROUP BY c.idHotel
GO

CREATE VIEW PuntoDeRutaTourCantidad AS 
SELECT pr.idPuntoDeRuta, count (p.idPuntoDeRuta) as cantidad
FROM PuntoDeRutaTour pr INNER JOIN PuntoDeRuta p ON pr.idPuntoDeRuta = p.idPuntoDeRuta WHERE
p.idPuntoDeRuta >= 1 GROUP BY pr.idPuntoDeRuta
GO