USE master
GO

IF DB_ID (N'Universidad') IS NOT NULL
DROP DATABASE Universidad;
GO
CREATE DATABASE Universidad
ON 
(NAME = Universidad_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Universidad.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = Universidad_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Universidad.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE Universidad
GO

--TABLAS

CREATE TABLE AreaDeConocimiento
(
    idAreaDeConocimiento int IDENTITY,
    nombre varchar (50) not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKAreaDeConocimiento PRIMARY KEY(idAreaDeConocimiento)
)

CREATE TABLE Catedra
(
    idCatedra int IDENTITY,
    nombre varchar (50) not null,
    idDepartamento int not null,
    idFacultad int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCatedra PRIMARY KEY(idCatedra)
)

CREATE TABLE Departamento
(
    idDepartamento int IDENTITY,
    nombreDepartamento varchar (50) not null,
    idAreaDeConocimiento int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKDepartamento PRIMARY KEY(idDepartamento)
)

CREATE TABLE Facultad
(
    idFacultad int IDENTITY,
    nombreFacultad varchar (50) not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKFacultad PRIMARY KEY(idFacultad)
)

CREATE TABLE Profesor
(
    idProfesor int IDENTITY,
    matricula char (5) not null,
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    idDepartamento int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKProfesor PRIMARY KEY(idProfesor)
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

CREATE TABLE CatedraProfesor
(
    idCatedraProfesor int IDENTITY,
    idCatedra int not null,
    idProfesor int not null,
    fecha datetime not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCatedraProfesor PRIMARY KEY(idCatedraProfesor)
)

CREATE TABLE DepartamentoFacultad
(
    idDepartamentoFacultad int IDENTITY,
    idDepartamento int not null,
    idFacultad int not null,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKDepartamentoFacultad PRIMARY KEY(idDepartamentoFacultad)
)

--INDEX

CREATE INDEX IXAreaDeConocimiento ON AreaDeConocimiento(idAreaDeConocimiento)
GO
CREATE INDEX IXCatedra ON Catedra(idCatedra)
GO
CREATE INDEX IXDepartamento ON Departamento(idDepartamento)
GO
CREATE INDEX IXFacultad ON Facultad(idFacultad)
GO
CREATE INDEX IXProfesor ON Profesor(idProfesor)
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario)
GO
CREATE INDEX IXDepartamentoFacultad ON DepartamentoFacultad(idDepartamentoFacultad)
GO
CREATE INDEX IXCatedraProfesor ON CatedraProfesor(idCatedraProfesor)
GO

--Relaciones

ALTER TABLE AreaDeConocimiento
ADD CONSTRAINT FKAreaDeConocimientoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE AreaDeConocimiento
ADD CONSTRAINT FKAreaDeConocimientoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Catedra
ADD CONSTRAINT FKCatedraUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Catedra
ADD CONSTRAINT FKCatedraUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Departamento
ADD CONSTRAINT FKDepartamentoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Departamento
ADD CONSTRAINT FKDepartamentoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Facultad
ADD CONSTRAINT FKFacultadUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Facultad
ADD CONSTRAINT FKFacultadUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Profesor
ADD CONSTRAINT FKProfesorUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Profesor
ADD CONSTRAINT FKProfesorUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE DepartamentoFacultad
ADD CONSTRAINT FKDepartamentoFacultadUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE DepartamentoFacultad
ADD CONSTRAINT FKDepartamentoFacultadUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE CatedraProfesor
ADD CONSTRAINT FKCatedraProfesorUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE CatedraProfesor
ADD CONSTRAINT FKCatedraProfesorUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Catedra
ADD CONSTRAINT FKCatedraDepartamento FOREIGN KEY (idDepartamento)
REFERENCES Departamento(idDepartamento)

ALTER TABLE Catedra
ADD CONSTRAINT FKCatedraFacultad FOREIGN KEY (idFacultad)
REFERENCES Facultad(idFacultad)

ALTER TABLE Departamento
ADD CONSTRAINT FKDepartamentoAreaDeConocimiento FOREIGN KEY (idAreaDeConocimiento)
REFERENCES AreaDeConocimiento(idAreaDeConocimiento)

ALTER TABLE Profesor
ADD CONSTRAINT FKProfesorDepartamento FOREIGN KEY (idDepartamento)
REFERENCES Departamento(idDepartamento)

ALTER TABLE CatedraProfesor
ADD CONSTRAINT FKCatedraProfesorProfesor FOREIGN KEY (idProfesor)
REFERENCES Profesor(idProfesor)

ALTER TABLE CatedraProfesor
ADD CONSTRAINT FKCatedraProfesorCatedra FOREIGN KEY (idCatedra)
REFERENCES Catedra(idCatedra)

ALTER TABLE DepartamentoFacultad
ADD CONSTRAINT FKDepartamentoFacultadDepartamento FOREIGN KEY (idDepartamento)
REFERENCES Departamento(idDepartamento)

ALTER TABLE DepartamentoFacultad
ADD CONSTRAINT FKDepartamentoFacultadFacultad FOREIGN KEY (idFacultad)
REFERENCES Facultad(idFacultad)

--INSERT 

INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Camila', 'Cabrera', 'Mendez', 'camilac@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Luisa', 'Saavedra', 'Castillo', 'luisas@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Deborah', 'Valencia', 'López', 'deborahv@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Jessica','Lago', 'Pedraza', 'jessical@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Karolina', 'Ochoa', 'García', 'karoo@gmail.com', 'Cons123.', 1, GETDATE())
GO


INSERT INTO AreaDeConocimiento (nombre, idUsuarioCrea, fechaCrea)
    VALUES ('Area De Conocimiento 1', 1, GETDATE()),
           ('Area De Conocimiento 2', 1, GETDATE()),
           ('Area De Conocimiento 3', 1, GETDATE()),
           ('Area De Conocimiento 4', 1, GETDATE()),
           ('Area De Conocimiento 5', 1, GETDATE())
GO

INSERT INTO Departamento (nombreDepartamento, idAreaDeConocimiento, idUsuarioCrea, fechaCrea)
    VALUES ('Departamento 1', 1, 1, GETDATE()),
           ('Departamento 2', 2, 1, GETDATE()),
           ('Departamento 3', 3, 1, GETDATE()),
           ('Departamento 4', 4, 1, GETDATE()),
           ('Departamento 5', 5, 1, GETDATE())
GO

INSERT INTO Facultad (nombreFacultad, idUsuarioCrea, fechaCrea)
    VALUES ('Facultad 1', 1, GETDATE()),
           ('Facultad 2', 1, GETDATE()),
           ('Facultad 3', 1, GETDATE()),
           ('Facultad 4', 1, GETDATE()),
           ('Facultad 5', 1, GETDATE())

INSERT INTO Catedra (nombre, idDepartamento, idFacultad, idUsuarioCrea, fechaCrea)
    VALUES ('Catedra 1', 1, 1, 1, GETDATE()),
           ('Catedra 2', 1, 2, 1, GETDATE()),
           ('Catedra 3', 1, 1, 1, GETDATE()),
           ('Catedra 4', 2, 5, 1, GETDATE()),
           ('Catedra 5', 2, 5, 1, GETDATE())
GO

INSERT INTO Profesor (matricula, nombre, apellidoPaterno, apellidoMaterno, idDepartamento, idUsuarioCrea, fechaCrea)
    VALUES ('P7842', 'Amaia', 'Romero', 'Soto', 1, 1, GETDATE()),
           ('P4411', 'Aitana','Ocaña', 'Fernandez', 2, 1, GETDATE()),
           ('P4412', 'Miriam', 'Rodríguez', 'Guix', 1, 1, GETDATE()),
           ('P4123', 'Nerea', 'Rodríguez', 'Galera', 2, 1, GETDATE()),
           ('P4154', 'Thalia', 'Garrido', 'Rosenthal', 4, 1, GETDATE())
GO

INSERT INTO CatedraProfesor (idCatedra, idProfesor, fecha, idUsuarioCrea, fechaCrea)
    VALUES (1, 1, '2021-10-18', 1, GETDATE()),
           (4, 2, '2021-10-19', 1, GETDATE()),
           (1, 3, '2021-11-20', 1, GETDATE()),
           (5, 4, '2021-09-13', 1, GETDATE()),
           (5, 2, '2021-08-17', 1, GETDATE())
GO

INSERT INTO DepartamentoFacultad (idDepartamento, idFacultad, idUsuarioCrea, fechaCrea)
    VALUES (1, 1, 1, GETDATE()),
           (2, 1, 1, GETDATE()),
           (3, 3, 1, GETDATE()),
           (4, 4, 1, GETDATE()),
           (5, 2, 1, GETDATE())
GO

--SELECT

SELECT * FROM AreaDeConocimiento
SELECT * FROM Catedra
SELECT * FROM Departamento
SELECT * FROM Facultad
SELECT * FROM Profesor
SELECT * FROM Usuario
SELECT * FROM DepartamentoFacultad
SELECT * FROM CatedraProfesor

--DELETE

DELETE FROM Catedra WHERE idCatedra = 2
DELETE FROM Profesor WHERE idProfesor = 5

--SELECT AFTER DELETE

SELECT * FROM Catedra
SELECT * FROM Profesor

--VIEWS

CREATE VIEW DepartamentoAreaDeConocimientoInformación AS SELECT d.idDepartamento, d.nombreDepartamento, a.nombre
FROM AreaDeConocimiento a INNER JOIN Departamento d ON a.idAreaDeConocimiento = d.idAreaDeConocimiento
WHERE a.idAreaDeConocimiento >= 1 GROUP BY d.idDepartamento, d.nombreDepartamento, a.nombre
GO

CREATE VIEW CatedraDepartamentoFacultad AS SELECT c.idCatedra, c.nombre, d.idDepartamento, d.nombreDepartamento, f.idFacultad, f.nombreFacultad
FROM Catedra C INNER JOIN Departamento d ON c.idDepartamento = d.idDepartamento INNER JOIN Facultad f ON c.idFacultad = f.idFacultad
WHERE c.idCatedra >= 1 GROUP BY  c.idCatedra, c.nombre, d.idDepartamento, d.nombreDepartamento, f.idFacultad, f.nombreFacultad
GO

CREATE VIEW ProfesorDepartamentoInformación AS SELECT p.idProfesor, p.matricula, p.nombre, p.apellidoPaterno, p.apellidoMaterno, d.nombreDepartamento
FROM Profesor p INNER JOIN Departamento d ON p.idDepartamento = d.idDepartamento
WHERE p.idProfesor >= 1 GROUP BY p.idProfesor, p.matricula, p.nombre, p.apellidoPaterno, p.apellidoMaterno, d.nombreDepartamento
GO

CREATE VIEW CatedraProfesorInformación AS SELECT c.idCatedra, p.matricula, p.nombre, p.apellidoPaterno, p.apellidoMaterno, cp.fecha
FROM Catedra C INNER JOIN CatedraProfesor cp ON c.idCatedra = cp.idCatedra INNER JOIN Profesor p ON p.idProfesor = cp.idProfesor
WHERE cp.idCatedra >= 1 GROUP BY c.idCatedra, p.matricula, p.nombre, p.apellidoPaterno, p.apellidoMaterno, cp.fecha
GO

CREATE VIEW ProfesorDepartamentoCantidad AS
SELECT c.idPlanta, count (p.idPlanta) as cantidad
FROM Profesor p INNER JOIN Departamento d ON p.idDepartamento = d.idDepartamento WHERE
d.idDepartamento >= 1 GROUP BY p.idDepartamento
GO