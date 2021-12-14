USE master
GO

IF DB_ID (N'Banco') IS NOT NULL
DROP DATABASE Banco;
GO
CREATE DATABASE Banco
ON 
(NAME = Banco_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Banco.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = Banco_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Banco.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE Banco
GO

--TABLAS

CREATE TABLE Cliente
(
    idCliente int IDENTITY,
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

CREATE TABLE ClienteCuentaPrivilegio
(
    idClienteCuentaPrivilegio int IDENTITY,
    idCliente int not null,
    idCuenta int not null,
    idPrivilegio int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKClienteCuentaPrivilegio PRIMARY KEY(idClienteCuentaPrivilegio)
)

CREATE TABLE Cuenta
(
    idCuenta int IDENTITY,
    numero char (16) not null,
    idSucursal int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCuenta PRIMARY KEY(idCuenta)
)

CREATE TABLE Domiciliacion
(
    idDomiciliacion int IDENTITY,
    descripcion varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKDomiciliacion PRIMARY KEY(idDomiciliacion)
)

CREATE TABLE Prestamo
(
    idPrestamo int IDENTITY,
    monto int not null,
    plazo varchar (50) not null,
    interes numeric (5) not null,
    idCliente int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPrestamo PRIMARY KEY(idPrestamo)
)

CREATE TABLE Privilegio
(
    idPrivilegio int IDENTITY,
    nombre varchar (50) not null,
    descripcion varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPrivilegio PRIMARY KEY(idPrivilegio)
)

CREATE TABLE Sucursal
(
    idSucursal int IDENTITY,
    codigo char (5) not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKSucursal PRIMARY KEY(idSucursal)
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
    idUsuarioCrea int not null,
    fechaCrea datetime not null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKUsuario PRIMARY KEY(idUsuario)
)

CREATE TABLE ClienteCuenta
(
    idClienteCuenta int IDENTITY,
    idCliente int not null,
    idCuenta int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKClienteCuenta PRIMARY KEY(idClienteCuenta)
)

CREATE TABLE CuentaDomiciliacion
(
    idCuentaDomiciliacion int IDENTITY,
    idCuenta int not null,
    idDomiciliacion int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKClienteDomiciliacion PRIMARY KEY(idCuentaDomiciliacion)
)

--INDEX

CREATE INDEX IXCliente ON Cliente(idCliente)
GO
CREATE INDEX IXClienteCuentaPrivilegio ON ClienteCuentaPrivilegio(idClienteCuentaPrivilegio)
GO
CREATE INDEX IXCuenta ON Cuenta(idCuenta)
GO
CREATE INDEX IXDomiciliacion ON Domiciliacion(idDomiciliacion)
GO
CREATE INDEX IXPrestamo ON Prestamo(idPrestamo)
GO
CREATE INDEX IXPrivilegio ON Privilegio(idPrivilegio)
GO
CREATE INDEX IXSucursal ON Sucursal(idSucursal)
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario);
GO
CREATE INDEX IXClienteCuenta ON ClienteCuenta(idClienteCuenta)
GO
CREATE INDEX IXCuentaDomiciliacion ON CuentaDomiciliacion(idCuentaDomiciliacion)
GO

--RELACIONES

ALTER TABLE Cliente
ADD CONSTRAINT FKClienteUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cliente
ADD CONSTRAINT FKClienteUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ClienteCuentaPrivilegio
ADD CONSTRAINT FKClienteCuentaPrivilegioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ClienteCuentaPrivilegio
ADD CONSTRAINT FKClienteCuentaPrivilegioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cuenta
ADD CONSTRAINT FKCuentaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cuenta
ADD CONSTRAINT FKCuentaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Domiciliacion
ADD CONSTRAINT FKDomiciliacionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Domiciliacion
ADD CONSTRAINT FKDomiciliacionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Prestamo
ADD CONSTRAINT FKPrestamoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Prestamo
ADD CONSTRAINT FKPrestamoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Privilegio
ADD CONSTRAINT FKPrivilegioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Privilegio
ADD CONSTRAINT FKPrivilegioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Sucursal
ADD CONSTRAINT FKSucursalUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Sucursal
ADD CONSTRAINT FKSucursalUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ClienteCuenta
ADD CONSTRAINT FKClienteCuentaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ClienteCuenta
ADD CONSTRAINT FKClienteCuentaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE CuentaDomiciliacion
ADD CONSTRAINT FKCuentaDomiciliacionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE CuentaDomiciliacion
ADD CONSTRAINT FKCuentaDomiciliacionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ClienteCuentaPrivilegio
ADD CONSTRAINT FKClienteCuentaPrivilegioCliente FOREIGN KEY (idCliente)
REFERENCES Cliente(idCliente)

ALTER TABLE ClienteCuentaPrivilegio
ADD CONSTRAINT FKClienteCuentaPrivilegioCuenta FOREIGN KEY (idCuenta)
REFERENCES Cuenta(idCuenta)

ALTER TABLE ClienteCuentaPrivilegio
ADD CONSTRAINT FKClienteCuentaPrivilegioPrivilegio FOREIGN KEY (idPrivilegio)
REFERENCES Privilegio(idPrivilegio)

ALTER TABLE Cuenta
ADD CONSTRAINT FKCuentaSucursal FOREIGN KEY (idSucursal)
REFERENCES Sucursal(idSucursal)

ALTER TABLE Prestamo
ADD CONSTRAINT FKPrestamoCliente FOREIGN KEY (idCliente)
REFERENCES Cliente(idCliente)

ALTER TABLE ClienteCuenta
ADD CONSTRAINT FKClienteCuentaCliente FOREIGN KEY (idCliente)
REFERENCES Cliente(idCliente)

ALTER TABLE ClienteCuenta
ADD CONSTRAINT FKClienteCuentaCuenta FOREIGN KEY (idCuenta)
REFERENCES Cuenta(idCuenta)

ALTER TABLE CuentaDomiciliacion
ADD CONSTRAINT FKCuentaDomiciliacionCuenta FOREIGN KEY (idCuenta)
REFERENCES Cliente(idCliente)

ALTER TABLE CuentaDomiciliacion
ADD CONSTRAINT FKCuentaDomiciliacionDomiciliacion FOREIGN KEY (idDomiciliacion)
REFERENCES Domiciliacion(idDomiciliacion)

--INSERT

INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Camila', 'Cabrera', 'Mendez', 'camilac@gmail.com', 'Banco123.', 1, GETDATE()),
           ('Luisa', 'Saavedra', 'Castillo', 'luisas@gmail.com', 'Banco123.', 1, GETDATE()),
           ('Deborah', 'Valencia', 'López', 'deborahv@gmail.com', 'Banco123.', 1, GETDATE()),
           ('Jessica','Lago', 'Pedraza', 'jessical@gmail.com', 'Banco123.', 1, GETDATE()),
           ('Karolina', 'Ochoa', 'García', 'karoo@gmail.com', 'Banco123.', 1, GETDATE())
GO

INSERT INTO Cliente (nombre, apellidoPaterno, apellidoMaterno, telefono, idUsuarioCrea, fechaCrea)
    VALUES ('Amaia', 'Romero', 'Soto', '8661792540', 1, GETDATE()),
           ('Aitana','Ocaña', 'Fernandez', '8661954678', 1, GETDATE()),
           ('Miriam', 'Rodríguez', 'Guix','8662387952', 1, GETDATE()),
           ('Nerea', 'Rodríguez', 'Galera', '8667894525', 1, GETDATE()),
           ('Thalia', 'Garrido', 'Rosenthal', '8661742358', 1, GETDATE())
GO

INSERT INTO Sucursal (codigo, idUsuarioCrea, fechaCrea)
    VALUES ('SB123', 1, GETDATE()),
           ('SB124', 1, GETDATE()),
           ('SB125', 1, GETDATE()),
           ('SB126', 1, GETDATE()),
           ('SB127', 1, GETDATE())
GO

INSERT INTO Cuenta (numero, idSucursal, idUsuarioCrea, fechaCrea)
    VALUES ('3135253678452536', 1, 1, GETDATE()),
           ('3135748512010398', 1, 1, GETDATE()),
           ('3135748675001200', 3, 1, GETDATE()),
           ('3135842680001259', 4, 1, GETDATE()),
           ('3135784154040007', 4, 1, GETDATE())
GO

INSERT INTO Privilegio (nombre, descripcion, idUsuarioCrea, fechaCrea)     
    VALUES ('Privilegio1', 'P1', 1, GETDATE()),
           ('Privilegio2', 'P2', 1, GETDATE()),
           ('Privilegio3', 'P3', 1, GETDATE()),
           ('Privilegio4', 'P4', 1, GETDATE()),
           ('Privilegio5', 'P5', 1, GETDATE())
GO

INSERT INTO ClienteCuentaPrivilegio (idCliente, idCuenta, idPrivilegio, idUsuarioCrea, fechaCrea)
    VALUES (1, 3, 4, 1, GETDATE()),
           (1, 4, 4, 1, GETDATE()),
           (1, 1, 5, 1, GETDATE()),
           (5, 4, 5, 1, GETDATE()),
           (5, 1, 3, 1, GETDATE())
GO

INSERT INTO Domiciliacion (descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('Domiciliacion1', 1, GETDATE()),
           ('Domiciliacion2', 1, GETDATE()),
           ('Domiciliacion3', 1, GETDATE()),
           ('Domiciliacion4', 1, GETDATE()),
           ('Domiciliacion5', 1, GETDATE())
GO

INSERT INTO Prestamo (monto, plazo, interes,idCliente, idUsuarioCrea, fechaCrea)
    VALUES ('100000', '24 meses', '10', 1, 1, GETDATE()),
           ('150000', '15 meses', '15', 2, 1, GETDATE()),
           ('300000', '36 meses', '30', 1, 1, GETDATE()),
           ('105000', '30 meses', '15', 4, 1, GETDATE()),
           ('450000', '40 meses', '44.67', 2, 1, GETDATE())
GO

INSERT INTO ClienteCuenta (idCliente, idCuenta, idUsuarioCrea, fechaCrea)
    VALUES (1, 3, 1, GETDATE()),
           (2, 3, 1, GETDATE()),
           (4, 1, 1, GETDATE()),
           (5, 4, 1, GETDATE()),
           (5, 1, 1, GETDATE())
GO

INSERT INTO CuentaDomiciliacion (idCuenta, idDomiciliacion, idUsuarioCrea, fechaCrea)
    VALUES (1, 3, 1, GETDATE()),
           (1, 3, 1, GETDATE()),
           (2, 1, 1, GETDATE()),
           (4, 4, 1, GETDATE()),
           (5, 1, 1, GETDATE())
GO

--SELECT

SELECT * FROM Cliente
SELECT * FROM ClienteCuentaPrivilegio
SELECT * FROM Cuenta
SELECT * FROM Domiciliacion
SELECT * FROM Prestamo
SELECT * FROM Privilegio
SELECT * FROM Sucursal
SELECT * FROM Usuario
SELECT * FROM ClienteCuenta
SELECT * FROM CuentaDomiciliacion

--DELETE

DELETE FROM Cliente WHERE idCliente=3
DELETE FROM Domiciliacion WHERE idDomiciliacion=2

--SELECT AFTER DELETE

SELECT * FROM Cliente
SELECT * FROM Domiciliacion

--VIEWS

CREATE VIEW CuentaSucursal AS SELECT c.idCuenta, c.numero, s.idSucursal, s.codigo
FROM Cuenta c INNER JOIN Sucursal s ON c.idSucursal = s.idSucursal WHERE
s.idSucursal = 4 GROUP BY c.idCuenta, c.numero, s.idSucursal, s.codigo
GO

CREATE VIEW ClientePrestamo AS SELECT c.idCliente, c.nombre, c.apellidoPaterno, p.idPrestamo, p.plazo
FROM Cliente c INNER JOIN Prestamo p ON c.idCliente = p.idCliente WHERE
c.idCliente >= 1 GROUP BY c.idCliente, c.nombre, c.apellidoPaterno, p.idPrestamo, p.plazo
GO

CREATE VIEW ClienteCuentas AS SELECT c.idCliente, c.nombre, c.apellidoPaterno, cc.idCuenta
FROM Cliente c INNER JOIN ClienteCuenta cc ON c.idCliente = cc.idCliente WHERE
c.idCliente >= 1 GROUP BY c.idCliente, c.nombre, c.apellidoPaterno, cc.idCuenta
GO

CREATE VIEW CuentasPorSucursal AS
Select c.idSucursal, count (s.idSucursal) as cantidad
FROM Cuenta c INNER JOIN Sucursal s ON c.idSucursal = s.idSucursal WHERE
s.idSucursal >= 3 GROUP BY c.idSucursal
GO

CREATE VIEW PrestamosPorCliente AS
Select p.idCliente, count (c.idCliente) as cantidad
FROM Prestamo p INNER JOIN Cliente c ON p.idCliente = c.idCliente WHERE
c.idCliente >= 1 GROUP BY p.idCliente
GO