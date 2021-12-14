USE master
GO

IF DB_ID (N'ConsecionarioDeAutos') IS NOT NULL
DROP DATABASE ConsecionarioDeAutos;
GO
CREATE DATABASE ConsecionarioDeAutos
ON 
(NAME = ConsecionarioDeAutos_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ConsecionarioDeAutos.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = ConsecionarioDeAutos_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ConsecionarioDeAutos.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE ConsecionarioDeAutos
GO

CREATE TABLE Cliente
(
    idCliente int IDENTITY (1,1),
    rfc char (13) not null,
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
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCliente PRIMARY KEY(idCliente)
)

CREATE TABLE CocheUsado
(
    idCocheUsado int IDENTITY (1,1),
    marca varchar (50) not null,
    modelo varchar (50) not null,
    matricula varchar (10) not null,
    precio numeric (10,2) not null,
    fecha datetime not null,
    idCliente int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCocheUsado PRIMARY KEY(idCocheUsado)
)

CREATE TABLE Opcion
(
    idOpcion int IDENTITY (1,1),
    nombre varchar (50) not null,
    descripcion varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKOpcion PRIMARY KEY(idOpcion)
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

CREATE TABLE Vehiculo
(
    idVehiculo int IDENTITY (1,1),
    marca varchar (50) not null,
    modelo varchar (50) not null,
    cilindros int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKVehiculo PRIMARY KEY(idVehiculo)
)

CREATE TABLE Vendedor
(
    idVendedor int IDENTITY (1,1),
    rfc char (13),
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
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKVendedor PRIMARY KEY(idVendedor)
)

CREATE TABLE Venta 
(
    idVenta int IDENTITY (1,1),
    fecha datetime not null,
    matricula varchar (10) not null,
    idVendedor int not null,
    idCliente int not null,
    idVehiculo int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKVenta PRIMARY KEY(idVenta)
)

CREATE TABLE OpcionVehiculo
(
    idOpcionVehiculo int IDENTITY (1,1),
    idOpcion int not null,
    idVehiculo int not null,
    precio numeric (10,2) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKOpcionVehiculo PRIMARY KEY(idOpcionVehiculo)
)

CREATE TABLE OpcionVenta
(
    idOpcionVenta int IDENTITY (1,1),
    idOpcion int not null,
    idVenta int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKOpcionVenta PRIMARY KEY(idOpcionVenta)
)

--INDEX

CREATE INDEX IXCliente ON Cliente(idCliente)
GO
CREATE INDEX IXCocheUsado ON CocheUsado(idCocheUsado)
GO
CREATE INDEX IXOpcion ON Opcion(idOpcion)
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario)
GO
CREATE INDEX IXVehiculo ON Vehiculo(idVehiculo)
GO
CREATE INDEX IXVendedor ON Vendedor(idVendedor)
GO
CREATE INDEX IXVenta ON Venta(idVenta)
GO
CREATE INDEX IXOpcionVehiculo ON OpcionVehiculo(idOpcionVehiculo)
GO
CREATE INDEX IXOpcionVenta ON OpcionVenta(idOpcionVenta)
GO

--RELACIONES

ALTER TABLE Cliente
ADD CONSTRAINT FKClienteUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cliente
ADD CONSTRAINT FKClienteUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE CocheUsado
ADD CONSTRAINT FKCocheUsadoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE CocheUsado
ADD CONSTRAINT FKCocheUsadoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Opcion
ADD CONSTRAINT FKOpcionUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Opcion
ADD CONSTRAINT FKOpcionUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Vehiculo
ADD CONSTRAINT FKVehiculoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Vehiculo
ADD CONSTRAINT FKVehiculoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Vendedor
ADD CONSTRAINT FKVendedorUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Vendedor
ADD CONSTRAINT FKVendedorUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Venta
ADD CONSTRAINT FKVentaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Venta
ADD CONSTRAINT FKVentaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE OpcionVehiculo
ADD CONSTRAINT FKOpcionVehiculoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE OpcionVehiculo
ADD CONSTRAINT FKOpcionVehiculoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE OpcionVenta
ADD CONSTRAINT FKOpcionVentaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE OpcionVenta
ADD CONSTRAINT FKOpcionVentaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE CocheUsado
ADD CONSTRAINT FKCocheUsadoCliente FOREIGN KEY (idCliente)
REFERENCES Cliente(idCliente)

ALTER TABLE Venta 
ADD CONSTRAINT FKVentaCliente FOREIGN KEY (idCliente)
REFERENCES Cliente(idCliente)

ALTER TABLE Venta 
ADD CONSTRAINT FKVentaVehiculo FOREIGN KEY (idVehiculo)
REFERENCES Vehiculo(idVehiculo)

ALTER TABLE Venta
ADD CONSTRAINT FKVentaVendedor FOREIGN KEY (idVendedor)
REFERENCES Vendedor(idVendedor)

ALTER TABLE OpcionVehiculo 
ADD CONSTRAINT FKOpcionVehiculoOpcion FOREIGN KEY (idOpcion)
REFERENCES Opcion(idOpcion)

ALTER TABLE OpcionVehiculo 
ADD CONSTRAINT FKOpcionVehiculoVehiculo FOREIGN KEY (idVehiculo)
REFERENCES Vehiculo(idVehiculo)

--INSERTAR

INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Camila', 'Cabrera', 'Mendez', 'camilac@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Luisa', 'Saavedra', 'Castillo', 'luisas@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Deborah', 'Valencia', 'López', 'deborahv@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Jessica','Lago', 'Pedraza', 'jessical@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Karolina', 'Ochoa', 'García', 'karoo@gmail.com', 'Cons123.', 1, GETDATE())
GO

INSERT INTO Cliente (rfc, nombre, apellidoPaterno, apellidoMaterno, calle, numeroExterior, cp, colonia, estado, ciudad, pais, telefono, idUsuarioCrea, fechaCrea)
    VALUES ('ROSA981208JGC','Amaia', 'Romero', 'Soto', 'Calle 1','12345','25740','C 1', 'Monclova', 'Coahuila', 'Mexico', '8661792540', 1, GETDATE()),
           ('OCFA990723LCF','Aitana','Ocaña', 'Fernandez', 'Calle 2','67890','25740','C 2', 'Monclova', 'Coahuila', 'Mexico', '8661954678', 1, GETDATE()),
           ('ROGM940927AGV','Miriam', 'Rodríguez', 'Guix','Calle 2','09876','25740','C 1', 'Monclova', 'Coahuila', 'Mexico','8662387952', 1, GETDATE()),
           ('ROGN990628YUB','Nerea', 'Rodríguez', 'Galera', 'Calle 3','54321','25740','C 1', 'Monclova', 'Coahuila', 'Mexico', '8667894525', 1, GETDATE()),
           ('GART951208JUG','Thalia', 'Garrido', 'Rosenthal', 'Calle 1','85462','25740','C 3', 'Monclova','Coahuila', 'Mexico', '8661742358', 1, GETDATE())
GO

INSERT INTO CocheUsado (marca, modelo, matricula, precio, fecha, idCliente, idUsuarioCrea, fechaCrea)
    VALUES ('Marca1', 'Modelo1', 'JK9-980', 120000.00, GETDATE(), 1, 1, GETDATE()),
           ('Marca2', 'Modelo2', 'GH3-741', 114000.00, GETDATE(), 1, 1, GETDATE()),
           ('Marca3', 'Modelo3', 'OR7-712', 100000.00, GETDATE(), 3, 1, GETDATE()),
           ('Marca4', 'Modelo4', 'ADE3-740', 220000.00, GETDATE(), 4, 1, GETDATE()),
           ('Marca5', 'Modelo5', 'LSD7-04E', 111500.00, GETDATE(), 5, 1, GETDATE())
GO

INSERT INTO Opcion (nombre, descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('Opcion 1', 'Descripcion 1', 1, GETDATE()),
           ('Opcion 2', 'Descripcion 2', 1, GETDATE()),
           ('Opcion 3', 'Descripcion 3', 1, GETDATE()),
           ('Opcion 4', 'Descripcion 4', 1, GETDATE()),
           ('Opcion 5', 'Descripcion 5', 1, GETDATE())
GO

INSERT INTO Vehiculo (marca, modelo, cilindros, idUsuarioCrea, fechaCrea)
    VALUES ('Marca2', 'Modelo6', 8, 1, GETDATE()),
           ('Marca2', 'Modelo7', 8, 1, GETDATE()),
           ('Marca3', 'Modelo8', 8, 1, GETDATE()),
           ('Marca5', 'Modelo9', 8, 1, GETDATE()),
           ('Marca5', 'Modelo10', 8, 1, GETDATE())
GO

INSERT INTO Vendedor (rfc, nombre, apellidoPaterno, apellidoMaterno, calle, numeroExterior, cp, colonia, ciudad, estado, pais, idUsuarioCrea, fechaCrea)
    VALUES ('GACA970414MNB','Alfred', 'Garcia', 'Castillo', 'Calle 4','14725','25780','C 6', 'Monclova', 'Coahuila', 'Mexico', 1, GETDATE()),
           ('CEFL890928AST','Luis','Cepeda', 'Fernandez', 'Calle 6','98521','25700','C 7', 'Monclova', 'Coahuila', 'Mexico', 1, GETDATE()),
           ('VILJ921005','Juan Pablo', 'Villamil', 'Lorente','Calle 5','74125','25740','C 2', 'Monclova', 'Coahuila', 'Mexico', 1, GETDATE()),
           ('VAGR960305DES','Raoul', 'Vázquez', 'Guerra', 'Calle 8','78912','25780','C 6', 'Monclova', 'Coahuila', 'Mexico', 1, GETDATE()),
           ('MEMR850614LND','Ricardo', 'Merino', 'Mass', 'Calle 45','78214','25745','C 9', 'Monclova', 'Coahuila', 'Mexico', 1, GETDATE())
GO

INSERT INTO Venta (fecha, matricula, idCliente, idVendedor, idVehiculo, idUsuarioCrea, fechaCrea)
    VALUES ('2021-11-18', 'FRE-6715', 1, 1, 5, 1, GETDATE()),
           ('2021-11-18', 'FR7A-745', 2, 1, 3, 1, GETDATE()),
           ('2021-11-18', 'HFTI-745', 2, 1, 1, 1, GETDATE()),
           ('2021-11-18', 'LKHP-254', 4, 2, 4, 1, GETDATE()),
           ('2021-11-18', 'DER4-78', 3, 5, 2, 1, GETDATE())
GO

INSERT INTO OpcionVehiculo (idOpcion, idVehiculo, precio, idUsuarioCrea, fechaCrea)
    VALUES (2, 5, 800.00, 1, GETDATE()),
           (5, 5, 1250.95, 1, GETDATE()),
           (3, 5, 355.50, 1, GETDATE()),
           (2, 3, 1359.00, 1, GETDATE()),
           (2, 2, 1856.97, 1, GETDATE())
GO

INSERT INTO OpcionVenta (idOpcion, idVenta, idUsuarioCrea, fechaCrea)
    VALUES (2, 1, 1, GETDATE()),
           (5, 1, 1, GETDATE()),
           (5, 2, 1, GETDATE()),
           (4, 3, 1, GETDATE()),
           (3, 2, 1, GETDATE())
GO

--SELECT

SELECT * FROM Cliente
SELECT * FROM CocheUsado
SELECT * FROM Opcion
SELECT * FROM Usuario
SELECT * FROM Vehiculo
SELECT * FROM Vendedor
SELECT * FROM Venta
SELECT * FROM OpcionVehiculo
SELECT * FROM OpcionVenta

--DELETE

DELETE FROM Opcion WHERE idOpcion=1
DELETE FROM Vendedor WHERE idVendedor=4

--SELECT AFTER DELETE

SELECT * FROM Opcion
SELECT * FROM Vendedor

--VIEWS

CREATE VIEW OpcionesVentas AS SELECT o.idOpcion, o.nombre, v.idVehiculo, v.modelo, ov.precio
FROM Opcion o INNER JOIN OpcionVehiculo ov ON o.idOpcion = ov.idOpcion INNER JOIN Vehiculo v ON ov.idVehiculo = v.idVehiculo WHERE
o.idOpcion >= 1 GROUP BY o.idOpcion, o.nombre, v.idVehiculo, v.modelo, ov.precio
GO

CREATE VIEW ClienteVenta AS SELECT c.idCliente, c.nombre, c.apellidoPaterno, v.matricula
FROM Cliente c INNER JOIN Venta v ON c.idCliente = v.idCliente WHERE
c.idCliente >= 1 GROUP BY c.idCliente, c.nombre, c.apellidoPaterno, v.matricula
GO

CREATE VIEW VendedorVenta AS SELECT ve.idVendedor, ve.nombre, ve.apellidoPaterno, v.matricula
FROM Vendedor ve INNER JOIN Venta v ON ve.idVendedor = v.idVendedor WHERE
ve.idVendedor >= 1 GROUP BY ve.idVendedor, ve.nombre, ve.apellidoPaterno, v.matricula
GO

CREATE VIEW VendedoresVentas AS
SELECT v.idVendedor, count (ve.idVendedor) as cantidad
FROM Vendedor ve INNER JOIN Venta v ON ve.idVendedor = v.idVendedor WHERE
ve.idVendedor >= 1 GROUP BY v.idVendedor
GO

CREATE VIEW ClienteVentaCantidad AS
SELECT v.idCliente, count (c.idCliente) as cantidad
FROM Cliente c INNER JOIN Venta v ON c.idCliente = v.idCliente WHERE
v.idCliente >= 1 GROUP BY v.idCliente
GO