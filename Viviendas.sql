USE master
GO

IF DB_ID (N'Viviendas') IS NOT NULL
DROP DATABASE Viviendas;
GO
CREATE DATABASE Viviendas
ON 
(NAME = Viviendas_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Viviendas.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = Viviendas_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Viviendas.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE Viviendas
GO

--TABLAS

CREATE TABLE Persona
(
    idPersona int IDENTITY (1,1),
    nombrePersona varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    idCabezaDeFamilia int not null,
    idVivienda int not null,
    idMunicipio int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPersona PRIMARY KEY(idPersona)
)

CREATE TABLE Municipio
(
    idMunicipio int IDENTITY (1,1),
    nombre varchar (100) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null
    CONSTRAINT PKMunicipio PRIMARY KEY(idMunicipio)
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

CREATE TABLE Vivienda
(
    idVivienda int IDENTITY (1,1),
    calle varchar (50) not null,
    numeroExterior char (5) not null,
    cp char (5) not null,
    colonia varchar (50) not null,
    idMunicipio int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKVivienda PRIMARY KEY(idVivienda)
)

CREATE TABLE PersonaVivienda
(
    idPersonaVivienda int IDENTITY (1,1),
    idPersona int not null,
    idVivienda int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPersonaVivienda PRIMARY KEY(idPersonaVivienda)
)

--INDEX

CREATE INDEX IXPersona ON Persona(idPersona);
GO
CREATE INDEX IXMunicipio ON Municipio(idMunicipio);
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario);
GO
CREATE INDEX IXVivienda ON Vivienda(idVivienda);
GO
CREATE INDEX IXPersonaVivienda ON PersonaVivienda(idPersonaVivienda);
GO

--RELACIONES

ALTER TABLE Persona
ADD CONSTRAINT FKPersonaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Persona
ADD CONSTRAINT FKPersonaUsuarioModifica FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Municipio
ADD CONSTRAINT FKMunicipioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Municipio
ADD CONSTRAINT FKMunicipioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Vivienda
ADD CONSTRAINT FKViviendaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Vivienda
ADD CONSTRAINT FKViviendaUsuarioModifica FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE PersonaVivienda
ADD CONSTRAINT FKPersonaViviendaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE PersonaVivienda
ADD CONSTRAINT FKPersonaViviendaUsuarioModifica FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Persona
ADD CONSTRAINT FKPersonaCabezaDeFamilia FOREIGN KEY (idCabezaDeFamilia)
REFERENCES Persona(idPersona)

ALTER TABLE Persona
ADD CONSTRAINT FKPersonaVivienda FOREIGN KEY (idVivienda)
REFERENCES Vivienda(idVivienda)

ALTER TABLE Persona
ADD CONSTRAINT FKPersonaMunicipio FOREIGN KEY (idMunicipio)
REFERENCES Municipio(idMunicipio)

ALTER TABLE Vivienda
ADD CONSTRAINT FKViviendaMunicipio FOREIGN KEY (idMunicipio)
REFERENCES Municipio(idMunicipio)

ALTER TABLE PersonaVivienda
ADD CONSTRAINT FKPersonaViviendaPersona FOREIGN KEY (idPersona)
REFERENCES Persona(idPersona)

ALTER TABLE PersonaVivienda
ADD CONSTRAINT FKPersonaViviendaVivienda FOREIGN KEY (idVivienda)
REFERENCES Vivienda(idVivienda)

--INSERT

INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Camila', 'Cabrera', 'Mendez', 'camilac@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Luisa', 'Saavedra', 'Castillo', 'luisas@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Deborah', 'Valencia', 'López', 'deborahv@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Jessica','Lago', 'Pedraza', 'jessical@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Karolina', 'Ochoa', 'García', 'karoo@gmail.com', 'Cons123.', 1, GETDATE())
GO


INSERT INTO Municipio (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Municipio 1', 1, GETDATE()),
           ('Municipio 2', 1, GETDATE()),
           ('Municipio 3', 1, GETDATE()),
           ('Municipio 4', 1, GETDATE()),
           ('Municipio 5', 1, GETDATE())
GO

INSERT INTO Vivienda (calle, numeroExterior, cp, colonia, idMunicipio, idUsuarioCrea, fechaCrea)
    VALUES ('Calle 1','39674','44100','Col 1', 1, 1, GETDATE()),
           ('Calle 57', '78215','45250','Col 2', 2, 1, GETDATE()),
           ('Calle 19','12976','45245','Col 3', 1, 1, GETDATE()),
           ('Calle 31','96478','45259','Col 4', 3, 1, GETDATE()),
           ('Calle 9','31254','45010','Col 5', 1, 1, GETDATE())
GO

INSERT INTO Persona (nombrePersona, apellidoPaterno, apellidoMaterno, idCabezaDeFamilia, idVivienda, idMunicipio, idUsuarioCrea, fechaCrea)
    VALUES ('Alfred', 'Garcia', 'Castillo', 1, 4, 3, 1, GETDATE()),
           ('Luis','Cepeda', 'Fernandez', 2, 3, 1, 1, GETDATE()),
           ('Juan Pablo', 'Villamil', 'Lorente', 3, 1, 1, 1, GETDATE()),
           ('Raoul', 'Vázquez', 'Guerra', 5, 2, 2, 1, GETDATE()),
           ('Ricardo', 'Merino', 'Mass', 5, 2, 2, 1, GETDATE())
GO

INSERT INTO PersonaVivienda (idPersona, idVivienda, idUsuarioCrea, fechaCrea)
    VALUES (1, 4, 1, GETDATE()),
           (1, 5, 1, GETDATE()),
           (2, 3, 1, GETDATE()),
           (3, 1, 1, GETDATE())
GO

--SELECT 

SELECT * FROM Persona
SELECT * FROM Municipio
SELECT * FROM Usuario
SELECT * FROM Vivienda
SELECT * FROM PersonaVivienda

--DELETE

DELETE FROM Persona WHERE idPersona=4
DELETE FROM Municipio WHERE idMunicipio=5

--SELECT AFTER DELETE

SELECT * FROM Persona
SELECT * FROM Municipio

--VIEWS

CREATE VIEW ViviendaMunicipioInformacion AS SELECT v.idVivienda, v.calle, v.numeroExterior, v.cp, v.colonia, m.nombre
FROM Vivienda v INNER JOIN Municipio m ON v.idMunicipio = m.idMunicipio
WHERE m.idMunicipio >= 1 GROUP BY v.idVivienda, v.calle, v.numeroExterior, v.cp, v.colonia, m.nombre
GO

CREATE VIEW PersonaViviendaInformacion AS SELECT p.nombrePersona, p.apellidoPaterno, p.apellidoMaterno, v.calle, v.numeroExterior, v.cp, v.colonia, m.nombre
FROM Persona p INNER JOIN  Vivienda v ON p.idVivienda = v.idVivienda INNER JOIN Municipio m ON v.idMunicipio = m.idMunicipio
WHERE p.idPersona >= 1 GROUP BY p.nombrePersona, p.apellidoPaterno, p.apellidoMaterno, v.calle, v.numeroExterior, v.cp, v.colonia, m.nombre
GO

CREATE VIEW ViviendaMunicipioCantidad AS
SELECT v.idMunicipio, count (m.idMunicipio) as cantidad
FROM Vivienda v INNER JOIN Municipio m ON v.idMunicipio = m.idMunicipio WHERE
m.idMunicipio >= 1 GROUP BY v.idMunicipio
GO

CREATE VIEW PersonaViviendaCantidad AS
SELECT p.idVivienda, count (v.idVivienda) as cantidad
FROM Persona p INNER JOIN Vivienda v ON p.idVivienda = v.idVivienda WHERE
v.idVivienda >= 1 GROUP BY p.idVivienda
GO

CREATE VIEW PersonaMunicipioCantidad AS
SELECT p.idMunicipio, count (m.idMunicipio) as cantidad
FROM Persona p INNER JOIN Municipio m ON p.idMunicipio = m.idMunicipio WHERE
m.idMunicipio >= 1 GROUP BY p.idMunicipio
GO