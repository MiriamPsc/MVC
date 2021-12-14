USE master
GO

IF DB_ID (N'GestionDeExamenes') IS NOT NULL
DROP DATABASE GestionDeExamenes;
GO
CREATE DATABASE GestionDeExamenes
ON 
(NAME = GestionDeExamenes_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\GestionDeExamenes.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = GestionDeExamenes_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\GestionDeExamenes.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE GestionDeExamenes
GO

--TABLAS

CREATE TABLE Alumno
(
    idAlumno int IDENTITY (1,1),
    matricula char (5) not null,
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    grupo varchar (20) not null,
    fechaIngreso datetime default null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKAlumno PRIMARY KEY(idAlumno)
)

CREATE TABLE Examen
(
    idExamen int IDENTITY (1,1),
    numero char (10) not null,
    numeroPreguntas int not null,
    fecha datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKExamen PRIMARY KEY(idExamen)
)

CREATE TABLE Practica
(
    idPractica int IDENTITY (1,1),
    titulo varchar (50) not null,
    gradoDificultad varchar (10) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPractica PRIMARY KEY(idPractica)
)

CREATE TABLE Profesor
(
    idProfesor int IDENTITY (1,1),
    matricula char (5) not null,
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKProfesor PRIMARY KEY(idProfesor)
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

CREATE TABLE AlumnoExamen
(
    idAlumnoExamen int IDENTITY (1,1),
    idAlumno int not null,
    idExamen int not null,
    nota numeric (5,2) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKAlumnoExamen PRIMARY KEY(idAlumnoExamen)
	)

CREATE TABLE AlumnoPractica
(
    idAlumnoPractica int IDENTITY (1,1),
    idAlumno int not null,
    idPractica int not null,
    nota numeric (5,2) not null,
    fecha datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKAlumnoPractica PRIMARY KEY(idAlumnoPractica)
)

CREATE TABLE ProfesorPractica
(
    idProfesorPractica int IDENTITY (1,1),
    idProfesor int not null,
    idPractica int not null,
    fecha datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKProfesorPractica PRIMARY KEY(idProfesorPractica)
)

--INDEX
CREATE INDEX IXAlumno ON Alumno(idAlumno);
GO
CREATE INDEX IXExamen ON Examen(idExamen);
GO
CREATE INDEX IXPractica ON Practica(idPractica);
GO
CREATE INDEX IXProfesor ON Profesor(idProfesor);
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario);
GO
CREATE INDEX IXAlumnoExamen ON AlumnoExamen(idAlumnoExamen);
GO
CREATE INDEX IXAlumnoPractica ON AlumnoPractica(idAlumnoPractica);
GO
CREATE INDEX IXProfesorPractica ON ProfesorPractica(idProfesorPractica);
GO

--RELACIONES

ALTER TABLE Alumno
ADD CONSTRAINT FKAlumnoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Alumno
ADD CONSTRAINT FKAlumnoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Examen
ADD CONSTRAINT FKExamenUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Examen
ADD CONSTRAINT FKExamenUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Practica
ADD CONSTRAINT FKPracticaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Practica
ADD CONSTRAINT FKPracticaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
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

ALTER TABLE AlumnoExamen
ADD CONSTRAINT FKAlumnoExamenUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE AlumnoExamen
ADD CONSTRAINT FKAlumnoExamenUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE AlumnoPractica
ADD CONSTRAINT FKAlumnoPracticaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE AlumnoPractica
ADD CONSTRAINT FKAlumnoPracticaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE ProfesorPractica
ADD CONSTRAINT FKProfesorPracticaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE ProfesorPractica
ADD CONSTRAINT FKProfesorPracticaUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE AlumnoExamen
ADD CONSTRAINT FKAlumnoExamenAlumno FOREIGN KEY (idAlumno)
REFERENCES Alumno(idAlumno)

ALTER TABLE AlumnoExamen
ADD CONSTRAINT FKAlumnoExamenExamen FOREIGN KEY (idExamen)
REFERENCES Examen(idExamen)

ALTER TABLE AlumnoPractica
ADD CONSTRAINT FKAlumnoPracticaAlumno FOREIGN KEY (idAlumno)
REFERENCES Alumno(idAlumno)

ALTER TABLE AlumnoPractica
ADD CONSTRAINT FKAlumnoPracticaPractica FOREIGN KEY (idPractica)
REFERENCES Practica(idPractica)

ALTER TABLE ProfesorPractica
ADD CONSTRAINT FKProfesorPracticaProfesor FOREIGN KEY (idProfesor)
REFERENCES Profesor(idProfesor)

ALTER TABLE ProfesorPractica
ADD CONSTRAINT FKProfesorPracticaPractica FOREIGN KEY (idPractica)
REFERENCES Practica(idPractica)

--INSERTAR

INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Camila', 'Cabrera', 'Mendez', 'camilac@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Luisa', 'Saavedra', 'Castillo', 'luisas@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Deborah', 'Valencia', 'López', 'deborahv@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Jessica','Lago', 'Pedraza', 'jessical@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Karolina', 'Ochoa', 'García', 'karoo@gmail.com', 'Cons123.', 1, GETDATE())
GO

INSERT INTO Alumno (matricula, nombre, apellidoPaterno, apellidoMaterno, grupo, fechaIngreso, idUsuarioCrea, fechaCrea)
    VALUES ('A1234','Alfred', 'Garcia', 'Castillo', 'A',GETDATE(), 1, GETDATE()),
           ('A5678','Luis','Cepeda', 'Fernandez', 'A',GETDATE(), 1, GETDATE()),
           ('A9101','Juan Pablo', 'Villamil', 'Lorente','B',GETDATE(), 1, GETDATE()),
           ('A1121','Raoul', 'Vázquez', 'Guerra', 'C',GETDATE(), 1, GETDATE()),
           ('A3141','Ricardo', 'Merino', 'Mass', 'C',GETDATE(), 1, GETDATE())
GO

INSERT INTO Examen (numero, numeroPreguntas, fecha, idUsuarioCrea, fechaCrea)
    VALUES ('58963', 25, GETDATE(), 1, GETDATE()),
           ('58964', 30, GETDATE(), 1, GETDATE()),
           ('58965', 15, GETDATE(), 1, GETDATE()),
           ('58966', 20, GETDATE(), 1, GETDATE()),
           ('58967', 25, GETDATE(), 1, GETDATE())
GO

INSERT INTO Practica (titulo, gradoDificultad, idUsuarioCrea, fechaCrea)
    VALUES ('Practica1', 'Alto', 1, GETDATE()),
           ('Practica2', 'Bajo', 1, GETDATE()),
           ('Practica3', 'Bajo', 1, GETDATE()),
           ('Practica4', 'Alto', 1, GETDATE()),
           ('Practica5', 'Medio', 1, GETDATE())
GO

INSERT INTO Profesor (matricula, nombre, apellidoPaterno, apellidoMaterno, idUsuarioCrea, fechaCrea)
    VALUES ('P1893','Amaia', 'Romero', 'Soto', 1, GETDATE()),
           ('P1894','Aitana','Ocaña', 'Fernandez', 1, GETDATE()),
           ('P1895','Miriam', 'Rodríguez', 'Guix', 1, GETDATE()),
           ('P1896','Nerea', 'Rodríguez', 'Galera', 1, GETDATE()),
           ('P1896','Thalia', 'Garrido', 'Rosenthal', 1, GETDATE())
GO

INSERT INTO AlumnoExamen (idAlumno, idExamen, nota, idUsuarioCrea, fechaCrea)
    VALUES (1, 1, 78.30, 1, GETDATE()),
           (2, 4, 96.45, 1, GETDATE()),
           (3, 4, 100.00, 1, GETDATE()),
           (3, 1, 96.30, 1, GETDATE()),
           (3, 2, 65.00, 1, GETDATE())
GO

INSERT INTO AlumnoPractica (idAlumno, idPractica, nota, fecha, idUsuarioCrea, fechaCrea)
    VALUES (1, 1, 36.78, GETDATE(), 1, GETDATE()),
           (4, 5, 100.00, GETDATE(), 1, GETDATE()),
           (2, 4, 78.36, GETDATE(), 1, GETDATE()),
           (3, 1, 78.58, GETDATE(), 1, GETDATE()),
           (3,1, 98.63, GETDATE(), 1, GETDATE())
GO

INSERT INTO ProfesorPractica (idProfesor, idPractica, fecha, idUsuarioCrea, fechaCrea)
    VALUES (5, 5, GETDATE(), 1, GETDATE()),
           (1, 2, GETDATE(), 1, GETDATE()),
           (3, 4, GETDATE(), 1, GETDATE()),
           (1, 3, GETDATE(), 1, GETDATE()),
           (1, 5, GETDATE(), 1, GETDATE())
GO

--SELECT

SELECT * FROM Alumno
SELECT * FROM Examen
SELECT * FROM Practica
SELECT * FROM Profesor
SELECT * FROM Usuario
SELECT * FROM AlumnoExamen
SELECT * FROM AlumnoPractica
SELECT * FROM ProfesorPractica

--DELETE

DELETE FROM Alumno WHERE idAlumno=5
DELETE FROM Examen WHERE idExamen=5

--SELECT AFTER DELETE

SELECT * FROM Alumno
SELECT * FROM Examen

--VIEW

CREATE VIEW AlumnoExamenNota AS SELECT a.idAlumno, a.matricula, a.nombre, a.apellidoPaterno, a.apellidoMaterno, e.numero, ae.nota
FROM Alumno a INNER JOIN AlumnoExamen ae ON a.idAlumno = ae.idAlumno INNER JOIN Examen e ON ae.idExamen = e.idExamen WHERE
a.idAlumno >= 1 GROUP BY a.idAlumno, a.matricula, a.nombre, a.apellidoPaterno, a.apellidoMaterno, e.numero, ae.nota
GO

CREATE VIEW AlumnoPracticaNota AS SELECT a.idAlumno, a.matricula, a.nombre, a.apellidoPaterno, a.apellidoMaterno, p.titulo, ap.nota
FROM Alumno a INNER JOIN AlumnoPractica ap ON a.idAlumno = ap.idAlumno INNER JOIN Practica p ON ap.idPractica = p.idPractica WHERE
a.idAlumno >= 1 GROUP BY a.idAlumno, a.matricula, a.nombre, a.apellidoPaterno, a.apellidoMaterno, p.titulo, ap.nota
GO

CREATE VIEW ProfesorPracticaFecha AS SELECT p.idProfesor, p.matricula, p.nombre, p.apellidoPaterno, p.apellidoMaterno, a.titulo, f.fecha
FROM Profesor p INNER JOIN ProfesorPractica f ON p.idProfesor = f.idProfesor INNER JOIN Practica a ON f.idPractica = a.idPractica WHERE
p.idProfesor >= 1 GROUP BY p.idProfesor, p.matricula, p.nombre, p.apellidoPaterno, p.apellidoMaterno, a.titulo, f.fecha
GO

CREATE VIEW AlumnoExamenCantidad AS
SELECT a.idAlumno, count (e.idAlumno) as cantidad
FROM Alumno a INNER JOIN AlumnoExamen e ON a.idAlumno = e.idAlumno WHERE
e.idAlumno >= 1 GROUP BY a.idAlumno
GO

CREATE VIEW AlumnoPracticaCantidad AS
SELECT a.idAlumno, count (p.idAlumno) as cantidad
FROM Alumno a INNER JOIN AlumnoPractica p ON a.idAlumno = p.idAlumno WHERE
p.idAlumno >= 1 GROUP BY a.idAlumno
GO