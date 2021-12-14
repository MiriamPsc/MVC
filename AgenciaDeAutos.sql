USE master
GO

IF DB_ID (N'AgenciaDeAutos') IS NOT NULL
DROP DATABASE AgenciaDeAutos;
GO
CREATE DATABASE AgenciaDeAutos
ON 
(NAME = AgenciaDeAutos_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\AgenciaDeAutos.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = AgenciaDeAutos_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\AgenciaDeAutos.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE AgenciaDeAutos
GO

CREATE TABLE Agencia
(
    idAgencia int IDENTITY,
    codigoa char (5) not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKAgencia PRIMARY KEY(idAgencia)
)

CREATE TABLE Coche
(
    idCoche int IDENTITY,
    codigo char (5) not null,
    marca varchar (50) not null,
    modelo varchar (50) not null,
    matricula char (8) not null,
    precio numeric (10) not null,
    garage char (3) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCoche PRIMARY KEY(idCoche)
)

CREATE TABLE Cliente
(
    idCliente int IDENTITY,
    codigo char (5) not null,
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    telefono char (10) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCliente PRIMARY KEY(idCliente)
)

CREATE TABLE Reserva
(
    idReserva int IDENTITY,
    codigo char (5) not null,
    monto int not null,
    idAgencia int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKReserva PRIMARY KEY(idReserva)
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

CREATE TABLE ClienteReserva
(
    idClienteReserva int IDENTITY,
    idCliente int not null,
    idReserva int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKClienteReserva PRIMARY KEY(idClienteReserva)
)

CREATE TABLE CocheReserva
(
    idCocheReserva int IDENTITY,
    idCoche int not null,
    idReserva int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCocheReserva PRIMARY KEY(idCocheReserva)
)

--INDEX

CREATE INDEX IXAgencia ON Agencia(idAgencia)
GO
CREATE INDEX IXCliente ON Cliente(idCliente)
GO
CREATE INDEX IXCoche ON Coche(idCoche)
GO
CREATE INDEX IXReserva ON Reserva(idReserva)
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario)
GO
CREATE INDEX IXClienteReserva ON ClienteReserva(idClienteReserva)
GO
CREATE INDEX IXCocheReserva ON CocheReserva(idCocheReserva)
GO

--TABLAS

ALTER TABLE Agencia
ADD CONSTRAINT FKAgenciaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Agencia
ADD CONSTRAINT FKAgenciaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Coche
ADD CONSTRAINT FKCocheUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Coche
ADD CONSTRAINT FKCocheUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cliente
ADD CONSTRAINT FKClienteUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cliente
ADD CONSTRAINT FKClienteUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Reserva
ADD CONSTRAINT FKReservaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Reserva
ADD CONSTRAINT FKReservaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ClienteReserva
ADD CONSTRAINT FKClienteReservaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ClienteReserva
ADD CONSTRAINT FKClienteReservaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE CocheReserva
ADD CONSTRAINT FKCocheReservasuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE CocheReserva
ADD CONSTRAINT FKCocheReservaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Reserva
ADD CONSTRAINT FKReservaAgencia FOREIGN KEY (idAgencia)
REFERENCES Agencia(idAgencia)

ALTER TABLE ClienteReserva
ADD CONSTRAINT FKClienteReservaCliente FOREIGN KEY (idCliente)
REFERENCES Cliente(idCliente)

ALTER TABLE ClienteReserva
ADD CONSTRAINT FKClienteReservaReserva FOREIGN KEY (idReserva)
REFERENCES Reserva(idReserva)

ALTER TABLE CocheReserva
ADD CONSTRAINT FKCocheReservaCoche FOREIGN KEY (idCoche)
REFERENCES Coche(idCoche)

ALTER TABLE CocheReserva
ADD CONSTRAINT FKCocheReservaReserva FOREIGN KEY (idReserva)
REFERENCES Reserva(idReserva)

--INSERT

INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Camila', 'Cabrera', 'Mendez', 'camilac@gmail.com', 'Agencia123.', 1, GETDATE()),
           ('Luisa', 'Saavedra', 'Castillo', 'luisas@gmail.com', 'Agencia123.', 1, GETDATE()),
           ('Deborah', 'Valencia', 'López', 'deborahv@gmail.com', 'Agencia123.', 1, GETDATE()),
           ('Jessica','Lago', 'Pedraza', 'jessical@gmail.com', 'Agencia123.', 1, GETDATE()),
           ('Karolina', 'Ochoa', 'García', 'karoo@gmail.com', 'Agencia123.', 1, GETDATE())
GO

INSERT INTO Agencia (codigoa, idUsuarioCrea, fechaCrea)
    VALUES ('AC987', 1, GETDATE()),
           ('AC986', 1, GETDATE()),
           ('AC985', 1, GETDATE()),
           ('AC984', 1, GETDATE()),
           ('AC982', 1, GETDATE())
GO

INSERT INTO Cliente (codigo, nombre, apellidoPaterno, apellidoMaterno, telefono, idUsuarioCrea, fechaCrea)
    VALUES ('AR234','Amaia', 'Romero', 'Soto', '8661792540', 1, GETDATE()),
           ('AO235','Aitana','Ocaña', 'Fernandez', '8661954678', 1, GETDATE()),
           ('MR236','Miriam', 'Rodríguez', 'Guix', '8662387952', 1, GETDATE()),
           ('NR237','Nerea', 'Rodríguez', 'Galera', '8667894525', 1, GETDATE()),
           ('TG238','Thalia', 'Garrido', 'Rosenthal', '8661742358', 1, GETDATE())
GO

INSERT INTO Coche (codigo, marca, modelo, matricula, precio, garage, idUsuarioCrea, fechaCrea)
    VALUES ('CH678', 'Marca1', 'Modelo1', 'JKR-9890', 120000.00, '101', 1, GETDATE()),
           ('CH679', 'Marca2', 'Modelo2', 'GHE-7441', 114000.00, '102', 1, GETDATE()),
           ('CH680', 'Marca3', 'Modelo3', 'ORS-7122', 100000.00, '103', 1, GETDATE()),
           ('CH681', 'Marca4', 'Modelo4', 'ADE-7550', 220000.00, '104', 1, GETDATE()),
           ('CH682', 'Marca5', 'Modelo5', 'LSD-0482', 111500.00, '105', 1, GETDATE())
GO

INSERT INTO Reserva (codigo, monto, idAgencia, idUsuarioCrea, fechaCrea)
    VALUES ('RS443', 5000.00, 1, 1, GETDATE()),
           ('RS443', 8000.00, 3, 1, GETDATE()),
           ('RS443', 9500.00, 4, 1, GETDATE()),
           ('RS443', 15000.00, 3, 1, GETDATE()),
           ('RS443', 15685.00, 3, 1, GETDATE())
GO 

INSERT INTO ClienteReserva (idCliente, idReserva, idUsuarioCrea, fechaCrea)
    VALUES (1, 2, 1, GETDATE()),
           (2, 4, 1, GETDATE()),
           (2, 5, 1, GETDATE()),
           (3, 1, 1, GETDATE()),
           (4, 4, 1, GETDATE())
GO

INSERT INTO CocheReserva (idCoche, idReserva, idUsuarioCrea, fechaCrea)
    VALUES (3, 1, 1, GETDATE()),
           (1, 4, 1, GETDATE()),
           (2, 5, 1, GETDATE()),
           (4, 2, 1, GETDATE())
GO

--SELECT

SELECT * FROM Agencia
SELECT * FROM Cliente
SELECT * FROM Coche
SELECT * FROM Reserva
SELECT * FROM Usuario
SELECT * FROM ClienteReserva
SELECT * FROM CocheReserva

--DELETE

DELETE FROM Coche WHERE idCoche = 5
DELETE FROM Reserva WHERE idReserva = 3;

--SELECT AFTER DELETE


SELECT * FROM Coche
SELECT * FROM Reserva

--VIEWS

CREATE VIEW ReservaAgencia AS SELECT r.idReserva, r.codigo, a.idAgencia, a.codigoa
FROM Reserva r INNER JOIN Agencia a ON r.idAgencia = a.idAgencia WHERE
a.idAgencia = 1 GROUP BY r.idReserva, r.codigo, a.idAgencia, a.codigoa
GO

CREATE VIEW ReservaAgenciaNumero4 AS SELECT r.idReserva, r.codigo, a.idAgencia, a.codigoa
FROM Reserva r INNER JOIN Agencia a ON r.idAgencia = a.idAgencia WHERE
a.idAgencia = 4 GROUP BY r.idReserva, r.codigo, a.idAgencia, a.codigoa
GO

CREATE VIEW ReservaAgenciaCantidad AS
Select r.idAgencia, count (a.idAgencia) as cantidad
FROM Reserva r INNER JOIN Agencia a ON r.idAgencia = a.idAgencia WHERE
a.idAgencia = 3 GROUP BY r.idAgencia
GO

CREATE VIEW ClienteReservaCantidad AS
Select cr.idCliente, count (c.idCliente) as cantidad
FROM ClienteReserva cr INNER JOIN Cliente c ON cr.idCliente = c.idCliente WHERE
c.idCliente = 2 GROUP BY cr.idCliente
GO

CREATE VIEW ClienteReservaCantidad2 AS
Select cr.idCliente, count (c.idCliente) as cantidad
FROM ClienteReserva cr INNER JOIN Cliente c ON cr.idCliente = c.idCliente WHERE
c.idCliente = 1 GROUP BY cr.idCliente
GO