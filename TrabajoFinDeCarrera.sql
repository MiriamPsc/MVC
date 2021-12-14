USE master
GO

IF DB_ID (N'TrabajoFinDeCarrera') IS NOT NULL
DROP DATABASE TrabajoFinDeCarrera;
GO
CREATE DATABASE TrabajoFinDeCarrera
ON 
(NAME = TrabajoFinDeCarrera_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\TrabajoFinDeCarrera.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = TrabajoFinDeCarrera_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\TrabajoFinDeCarrera.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE TrabajoFinDeCarrera
GO

--TABLAS

CREATE TABLE Alumno
(
    idAlumno int IDENTITY (1,1),
    matricula char (5) not null,
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    rfc char (13) not null,
    idGrupo int default null,
    fechaIngreso datetime default null,
    idProfesor int null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKAlumno PRIMARY KEY(idAlumno)
)

CREATE TABLE Grupo
(
    idGrupo int IDENTITY (1,1),
    nombre varchar (50) not null,
    numeroComponentes int default null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKGrupo PRIMARY KEY(idGrupo)
)

CREATE TABLE Profesor
(
    idProfesor int IDENTITY (1,1),
    rfc char (13) not null,
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    calle varchar (50) not null,
    numeroExterior CHAR (5) not null,
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
    CONSTRAINT PKProfesor PRIMARY KEY(idProfesor)
)

CREATE TABLE TFC
(
    idTFC int IDENTITY (1,1),
    numeroOrden int not null,
    fecha datetime not null,
    tema varchar (50) not null,
    idAlumno int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTfc PRIMARY KEY(idTfc)
)

CREATE TABLE Tribunal
(
    idTribunal int IDENTITY (1,1),
    numeroComponentes int not null,
    fecha datetime not null,
    edificio int not null,
    aula varchar (5) not null,
    idAlumno int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKTribunal PRIMARY KEY(idTribunal)
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

CREATE TABLE AlumnoProfesor
(
    idAlumnoProfesor int IDENTITY (1,1),
    idAlumno int not null,
    idProfesor int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKAlumnoProfesor PRIMARY KEY(idAlumnoProfesor)
)

CREATE TABLE ProfesorTribunal
(
    idProfesorTribunal int IDENTITY (1,1),
    idProfesor int not null,
    idTribunal int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKProfesorTribunal PRIMARY KEY(idProfesorTribunal)
)

--INDEX

CREATE INDEX IXAlumno ON Alumno(idAlumno);
GO
CREATE INDEX IXGrupo ON Grupo(idGrupo);
GO
CREATE INDEX IXProfesor ON Profesor(idProfesor);
GO
CREATE INDEX IXTFC ON TFC(idTFC);
GO
CREATE INDEX IXTribunal ON Tribunal(idTribunal);
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario);
GO
CREATE INDEX IXAlumnoProfesor ON AlumnoProfesor(idAlumnoProfesor);
GO
CREATE INDEX IXProfesorTribunal ON ProfesorTribunal(idProfesorTribunal)
GO

--RELACIONES

ALTER TABLE Alumno
ADD CONSTRAINT FKAlumnoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Alumno
ADD CONSTRAINT FKAlumnoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Grupo
ADD CONSTRAINT FKGrupoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Grupo
ADD CONSTRAINT FKGrupoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Profesor
ADD CONSTRAINT FKProfesorUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Profesor
ADD CONSTRAINT FKProfesorUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Tfc
ADD CONSTRAINT FKTfcUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Tfc
ADD CONSTRAINT FKTfcUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Tribunal
ADD CONSTRAINT FKPTribunalUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Tribunal
ADD CONSTRAINT FKTribunalUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE AlumnoProfesor
ADD CONSTRAINT FKAlumnoProfesorUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE AlumnoProfesor
ADD CONSTRAINT FKAlumnoProfesorUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ProfesorTribunal
ADD CONSTRAINT FKProfesorTribunalUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ProfesorTribunal
ADD CONSTRAINT FKProfesorTribunalUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Alumno
ADD CONSTRAINT FKAlumnoGrupo FOREIGN KEY (idGrupo)
REFERENCES Grupo(idGrupo)

ALTER TABLE Alumno
ADD CONSTRAINT FKAlumnoProfesor FOREIGN KEY (idProfesor)
REFERENCES Profesor(idProfesor)

ALTER TABLE Tfc
ADD CONSTRAINT FKTfcAlumno FOREIGN KEY (idAlumno)
REFERENCES Alumno(idAlumno)

ALTER TABLE Tribunal
ADD CONSTRAINT FKTribunalAlumno FOREIGN KEY (idAlumno)
REFERENCES Alumno(idAlumno)

ALTER TABLE AlumnoProfesor
ADD CONSTRAINT FKAlumnoProfesorAlumno FOREIGN KEY (idAlumno)
REFERENCES Alumno(idAlumno)

ALTER TABLE AlumnoProfesor
ADD CONSTRAINT FKAlumnoProfesorProfesor FOREIGN KEY (idProfesor)
REFERENCES Profesor(idProfesor)

ALTER TABLE ProfesorTribunal
ADD CONSTRAINT FKProfesorTribunalProfesor FOREIGN KEY (idProfesor)
REFERENCES Profesor(idProfesor)

ALTER TABLE ProfesorTribunal
ADD CONSTRAINT FKProfesorTribunalTribunal FOREIGN KEY (idTribunal)
REFERENCES Tribunal(idTribunal)

--INSERTAR

INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Camila', 'Cabrera', 'Mendez', 'camilac@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Luisa', 'Saavedra', 'Castillo', 'luisas@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Deborah', 'Valencia', 'López', 'deborahv@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Jessica','Lago', 'Pedraza', 'jessical@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Karolina', 'Ochoa', 'García', 'karoo@gmail.com', 'Cons123.', 1, GETDATE())
GO


INSERT INTO Profesor (rfc, nombre, apellidoPaterno, apellidoMaterno, calle, numeroExterior, cp, colonia, estado, ciudad, pais, idUsuarioCrea, fechaCrea)
    VALUES ('ROSA981208JGC','Amaia', 'Romero', 'Soto', 'Calle 1','12345','25740','C 1', 'Monclova', 'Coahuila', 'Mexico', 1, GETDATE()),
           ('OCFA990723LCF','Aitana','Ocaña', 'Fernandez', 'Calle 2','67890','25740','C 2', 'Monclova', 'Coahuila', 'Mexico', 1, GETDATE()),
           ('ROGM940927AGV','Miriam', 'Rodríguez', 'Guix','Calle 2','09876','25740','C 1', 'Monclova', 'Coahuila', 'Mexico', 1, GETDATE()),
           ('ROGN990628YUB','Nerea', 'Rodríguez', 'Galera', 'Calle 3','54321','25740','C 4', 'Monclova', 'Coahuila', 'Mexico', 1, GETDATE()),
           ('GART951208JUG','Thalia', 'Garrido', 'Rosenthal', 'Calle 1','85462','25740','C 5', 'Monclova','Coahuila', 'Mexico', 1, GETDATE())
GO

INSERT INTO Alumno (matricula, nombre, apellidoPaterno, apellidoMaterno, rfc, idProfesor, idUsuarioCrea, fechaCrea)
    VALUES ('A1234','Alfred', 'Garcia', 'Castillo', 'GACA970414MNB', 1, 1, GETDATE())
           ('A5678','Luis','Cepeda', 'Fernandez', 'CEFL890928AST', 2, 1, GETDATE()),
           ('A9101','Juan Pablo', 'Villamil', 'Lorente','VILJ921005', 3, 1, GETDATE()),
           ('A1121','Raoul', 'Vázquez', 'Guerra', 'VAGR960305DES', 4, 1, GETDATE()),
           ('A3141','Ricardo', 'Merino', 'Mass', 'MEMR850614LND', 3, 1, GETDATE())
GO

INSERT INTO Grupo (nombre, numeroComponentes, idUsuarioCrea, fechaCrea)
    VALUES('Grupo1', '12', 1, GETDATE()),
          ('Grupo2', '11', 1, GETDATE()),
          ('Grupo3', '06', 1, GETDATE()),
          ('Grupo4', '05', 1, GETDATE()),
          ('Grupo5', '08', 1, GETDATE())
GO

INSERT INTO TFC (numeroOrden, fecha, tema, idAlumno, idUsuarioCrea, fechaCrea)
    VALUES('1285', GETDATE(), 'Tema 1', 1, 1, GETDATE()),
          ('5475', GETDATE(), 'Tema 2', 2, 1, GETDATE()),
          ('1455', GETDATE(), 'Tema 3', 3, 1, GETDATE()),
          ('7854', GETDATE(), 'Tema 4', 4, 1, GETDATE()),
          ('9854', GETDATE(), 'Tema 5', 5, 1, GETDATE())
GO

INSERT INTO Tribunal (numeroComponentes, fecha, edificio, aula, idAlumno, idUsuarioCrea, fechaCrea)
    VALUES('6', GETDATE(), '101', '10112', 1, 1, GETDATE()),
          ('5', GETDATE(), '102', '10208', 2, 1, GETDATE()),
          ('7', GETDATE(), '103', '10304', 3, 1, GETDATE()),
          ('6', GETDATE(), '104', '10409', 4, 1, GETDATE()),
          ('5', GETDATE(), '105', '10501', 5, 1, GETDATE())
GO

INSERT INTO AlumnoProfesor (idAlumno, idProfesor, idUsuarioCrea, fechaCrea)
    VALUES(1, 2, 1, GETDATE()),
          (2, 4, 1, GETDATE()),
          (5, 1, 1, GETDATE()),
          (1, 1, 1, GETDATE()),
          (2, 4, 1, GETDATE())
GO

INSERT INTO ProfesorTribunal (idProfesor, idTribunal, idUsuarioCrea, fechaCrea)
    VALUES(2, 1, 1, GETDATE()),
          (4, 4, 1, GETDATE()),
          (1, 5, 1, GETDATE()),
          (3, 4, 1, GETDATE()),
          (3, 2, 1, GETDATE())
GO

--SELECT

SELECT * FROM Alumno
SELECT * FROM Grupo
SELECT * FROM Profesor
SELECT * FROM TFC
SELECT * FROM Tribunal
SELECT * FROM Usuario
SELECT * FROM AlumnoProfesor
SELECT * FROM ProfesorTribunal

--DELETE

DELETE FROM Profesor WHERE idProfesor=5
DELETE FROM Tribunal WHERE idTribunal=3

--SELECT AFTER DELETE

SELECT * FROM Profesor
SELECT * FROM Tribunal

--VIEWS

CREATE VIEW AlumnoTFCInformación AS SELECT a.idAlumno, a.matricula, a.nombre, a.apellidoPaterno, a.apellidoMaterno, t.fecha, t.tema
FROM Alumno a INNER JOIN TFC T ON t.idAlumno = a.idAlumno
WHERE a.idAlumno >= 1 GROUP BY a.idAlumno, a.matricula, a.nombre, a.apellidoPaterno, a.apellidoMaterno, t.fecha, t.tema
GO

CREATE VIEW TribunalAlumnoInformación AS SELECT a.idAlumno, a.matricula, a.nombre, a.apellidoPaterno, a.apellidoMaterno, t.fecha, t.edificio, t.aula
FROM Alumno a INNER JOIN Tribunal t ON t.idAlumno = a.idAlumno
WHERE a.idAlumno >= 1 GROUP BY a.idAlumno, a.matricula, a.nombre, a.apellidoPaterno, a.apellidoMaterno, t.fecha, t.edificio, t.aula
GO

CREATE VIEW AlumnoProfesorInformacion AS SELECT a.idAlumno, a.matricula, a.nombre, a.apellidoPaterno, ap.idProfesor 
FROM Alumno a INNER JOIN AlumnoProfesor ap ON a.idAlumno = ap.idAlumno INNER JOIN Profesor p ON ap.idProfesor = p.idProfesor WHERE
a.idAlumno >= 1 GROUP BY a.idAlumno, a.matricula, a.nombre, a.apellidoPaterno, ap.idProfesor 
GO

CREATE VIEW ProfesorTribunalInformación AS SELECT p.idProfesor, p.nombre, p.apellidoPaterno, pt.idTribunal, t.numeroComponentes
FROM Profesor p INNER JOIN ProfesorTribunal pt ON p.idProfesor = pt.idProfesor INNER JOIN Tribunal t ON pt.idTribunal = t.idTribunal WHERE
p.idProfesor >= 1 GROUP BY  p.idProfesor, p.nombre, p.apellidoPaterno, pt.idTribunal, t.numeroComponentes
GO

CREATE VIEW AlumnoTFCCantidad AS
Select a.idAlumno, count(t.idTFC) as cantidad
FROM Alumno a INNER JOIN TFC t ON a.idAlumno = t.idAlumno
WHERE t.idAlumno >= 1 GROUP BY a.idAlumno
GO