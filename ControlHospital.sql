USE master
GO

IF DB_ID (N'ControlHospital') IS NOT NULL
DROP DATABASE ControlHospital;
GO
CREATE DATABASE ControlHospital
ON 
(NAME = ControlHospital_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ControlHospital.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
( NAME = ControlHospital_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ControlHospital.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB) ;
GO

USE ControlHospital
GO

--TABLAS

CREATE TABLE Cama
(
    idCama int IDENTITY (1,1),
    numero char (3) not null,
    idPlanta int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCama PRIMARY KEY(idCama)
)

CREATE TABLE Diagnostico
(
    idDiagnostico int IDENTITY (1,1),
    codigo char (5) not null,
    descripcion varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKDiagnostico PRIMARY KEY(idDiagnostico)
)

CREATE TABLE Medico
(
    idMedico int IDENTITY (1,1),
    ficha char (5) not null,
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKMedico PRIMARY KEY(idMedico)
)

CREATE TABLE Paciente
(
    idPaciente int IDENTITY (1,1),
    nss char (11) not null,
    rfc varchar (13) not null,
    nombre varchar (50) not null,
    apellidoPaterno varchar (50) not null,
    apellidoMaterno varchar (50) not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPaciente PRIMARY KEY(idPaciente)
)

CREATE TABLE Pase
(
    idPase int IDENTITY (1,1),
    numero char (3) not null,
    horaInicio datetime not null,
    horafinal datetime not null,
    idPaciente int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPase PRIMARY KEY(idPase)
)

CREATE TABLE Planta
(
    idPlanta int IDENTITY (1,1),
    numero int not null,
    nombre varchar (50) not null,
    numeroCamas int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKPlanta PRIMARY KEY(idPlanta)
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

CREATE TABLE DiagnosticoMedico
(
    idDiagnosticoMedico int IDENTITY (1,1),
    idDiagnostico int not null,
    idMedico int not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKDiagnosticoMedico PRIMARY KEY(idDiagnosticoMedico)
)

CREATE TABLE DiagnosticoPaciente
(
    idDiagnosticoPaciente int IDENTITY (1,1),
    idDiagnostico int not null,
    idPaciente int not null,
    fecha datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKDiagnosticoPaciente PRIMARY KEY(idDiagnosticoPaciente)
)

CREATE TABLE MedicoPaciente
(
    idMedicoPaciente int IDENTITY (1,1),
    idMedico int not null,
    idPaciente int not null,
    fecha datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKMedicoPaciente PRIMARY KEY(idMedicoPaciente)
)

CREATE TABLE CamaPaciente
(
    idCamaPaciente int IDENTITY (1,1),
    idCama int not null,
    idPaciente int not null,
    fecha datetime not null,
    estatus bit default 1,
    idUsuarioCrea int null,
    fechaCrea datetime null,
    idUsuarioModifica int default null,
    fechaModifica datetime default null,
    CONSTRAINT PKCamaPaciente PRIMARY KEY(idCamaPaciente)
)

--INDEX

CREATE INDEX IXCama ON Cama(idCama)
GO
CREATE INDEX IXDiagnostico ON Diagnostico(idDiagnostico)
GO
CREATE INDEX IXMedico ON Medico(idMedico)
GO
CREATE INDEX IXPaciente ON Paciente(idPaciente)
GO
CREATE INDEX IXPase ON Pase(idPase)
GO
CREATE INDEX IXPlanta ON Planta(idPlanta)
GO
CREATE INDEX IXUsuario ON Usuario(idUsuario)
GO
CREATE INDEX IXDiagnosticoMedico ON DiagnosticoMedico(idDiagnosticoMedico)
GO
CREATE INDEX IXDiagnosticoPaciente ON DiagnosticoPaciente(idDiagnosticoPaciente)
GO
CREATE INDEX IXMedicoPaciente ON MedicoPaciente(idMedicoPaciente)
GO
CREATE INDEX IXCamaPaciente ON CamaPaciente(idCamaPaciente)
GO

--RELACIONES

ALTER TABLE Cama
ADD CONSTRAINT FKCamaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cama
ADD CONSTRAINT FKCamaUsuarioModifica FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Diagnostico
ADD CONSTRAINT FKDiagnosticoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Diagnostico
ADD CONSTRAINT FKDiagnosticoUsuarioModifica FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Medico
ADD CONSTRAINT FKMedicoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Medico
ADD CONSTRAINT FKMedicoUsuarioModifica FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Paciente
ADD CONSTRAINT FKPacienteUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Paciente
ADD CONSTRAINT FKPacienteUsuarioModifica FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Pase
ADD CONSTRAINT FKPaseUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Pase
ADD CONSTRAINT FKPaseUsuarioModifica FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Planta
ADD CONSTRAINT FKPlantaUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Planta
ADD CONSTRAINT FKPlantaUsuarioModifica FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE Usuario
ADD CONSTRAINT FKUsuarioUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE DiagnosticoMedico
ADD CONSTRAINT FKDiagnosticoMedicoUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE DiagnosticoMedico
ADD CONSTRAINT FKDiagnosticoMedicoUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE DiagnosticoPaciente
ADD CONSTRAINT FKDiagnosticoPacienteUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE DiagnosticoPaciente
ADD CONSTRAINT FKDiagnosticoPacienteUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE MedicoPaciente
ADD CONSTRAINT FKMedicoPacienteUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE MedicoPaciente
ADD CONSTRAINT FKMedicoPacienteUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE CamaPaciente
ADD CONSTRAINT FKCamaPacienteUsuarioCrea FOREIGN KEY (idUsuarioCrea)
REFERENCES Usuario(idUsuario)

ALTER TABLE CamaPaciente
ADD CONSTRAINT FKCamaPacienteUsuarioModifica FOREIGN KEY (idUsuarioModifica)
REFERENCES Usuario(idUsuario)

ALTER TABLE Cama
ADD CONSTRAINT FKCamaPlanta FOREIGN KEY (idPlanta)
REFERENCES Planta(idPlanta)

ALTER TABLE Pase
ADD CONSTRAINT FKPasePaciente FOREIGN KEY (idPaciente)
REFERENCES Paciente(idPaciente)

ALTER TABLE DiagnosticoMedico
ADD CONSTRAINT FKDiagnosticoMedicoDiagnostico FOREIGN KEY (idDiagnostico)
REFERENCES Diagnostico(idDiagnostico)

ALTER TABLE DiagnosticoMedico
ADD CONSTRAINT FKDiagnosticoMedicoMedico FOREIGN KEY (idMedico)
REFERENCES Medico(idMedico)

ALTER TABLE DiagnosticoPaciente
ADD CONSTRAINT FKDiagnosticoPacienteDiagnostico FOREIGN KEY (idDiagnostico)
REFERENCES Diagnostico(idDiagnostico)

ALTER TABLE DiagnosticoPaciente
ADD CONSTRAINT FKDiagnosticoPacientePaciente FOREIGN KEY (idPaciente)
REFERENCES Paciente(idPaciente)

ALTER TABLE MedicoPaciente
ADD CONSTRAINT FKMedicoPacienteMedico FOREIGN KEY (idMedico)
REFERENCES Medico(idMedico)

ALTER TABLE MedicoPaciente
ADD CONSTRAINT FKDMedicoPacientePaciente FOREIGN KEY (idPaciente)
REFERENCES Paciente(idPaciente)

ALTER TABLE CamaPaciente
ADD CONSTRAINT FKCamaPacienteCama FOREIGN KEY (idCama)
REFERENCES Cama(idCama)

ALTER TABLE CamaPaciente
ADD CONSTRAINT FKCamaPacientePaciente FOREIGN KEY (idPaciente)
REFERENCES Paciente(idPaciente)

--INSERTAR

INSERT INTO Usuario (nombre, apellidoPaterno, apellidoMaterno, correo, clave, idUsuarioCrea, fechaCrea)
    VALUES ('Camila', 'Cabrera', 'Mendez', 'camilac@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Luisa', 'Saavedra', 'Castillo', 'luisas@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Deborah', 'Valencia', 'López', 'deborahv@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Jessica','Lago', 'Pedraza', 'jessical@gmail.com', 'Cons123.', 1, GETDATE()),
           ('Karolina', 'Ochoa', 'García', 'karoo@gmail.com', 'Cons123.', 1, GETDATE())
GO

INSERT INTO Planta (numero, nombre, numeroCamas, idUsuarioCrea, fechaCrea)
    VALUES (1, 'Planta 1', 0, 1, GETDATE()),
           (2, 'Planta 2', 0, 1, GETDATE()),
           (3, 'Planta 3', 25, 1, GETDATE()),
           (4, 'Planta 4', 10, 1, GETDATE()),
           (5, 'Planta 5', 10, 1, GETDATE())
GO

INSERT INTO Cama (numero, idPlanta, idUsuarioCrea, fechaCrea)
    VALUES (301, 3, 1, GETDATE()),
           (402, 4, 1, GETDATE()),
           (201, 2, 1, GETDATE()),
           (406, 4, 1, GETDATE()),
           (202, 2, 1, GETDATE())
GO

INSERT into Diagnostico (codigo, descripcion, idUsuarioCrea, fechaCrea)
    VALUES ('D-685', 'D 1', 1, GETDATE()),
           ('D-686', 'D 2', 1, GETDATE()),
           ('D-687', 'D 3', 1, GETDATE()),
           ('D-688', 'D 4', 1, GETDATE()),
           ('D-689', 'D 5', 1, GETDATE())
GO

INSERT INTO Medico (ficha, nombre, apellidoPaterno, apellidoMaterno, idUsuarioCrea, fechaCrea)
    VALUES ('M7825','Alfred', 'Garcia', 'Castillo', 1, GETDATE()),
           ('M6847','Luis','Cepeda', 'Fernandez', 1, GETDATE()),
           ('M5457','Juan Pablo', 'Villamil', 'Lorente', 1, GETDATE()),
           ('M2571','Raoul', 'Vázquez', 'Guerra', 1, GETDATE()),
           ('M7454','Ricardo', 'Merino', 'Mass', 1, GETDATE())
GO

INSERT INTO Paciente (nss, rfc, nombre, apellidoPaterno, apellidoMaterno, idUsuarioCrea, fechaCrea)
    VALUES ('47856974123', 'ROSA981208JGC','Amaia', 'Romero', 'Soto', 1, GETDATE()),
           ('32789412547', 'OCFA990723LCF','Aitana','Ocaña', 'Fernandez', 1, GETDATE()),
           ('14257896351', 'ROGM940927AGV','Miriam', 'Rodríguez', 'Guix', 1, GETDATE()),
           ('21478536951', 'ROGN990628YUB','Nerea', 'Rodríguez', 'Galera', 1, GETDATE()),
           ('1478523456', 'GART951208JUG','Thalia', 'Garrido', 'Rosenthal', 1, GETDATE())
GO

INSERT into Pase (numero, horaInicio, horafinal, idPaciente, idUsuarioCrea, fechaCrea)
    VALUES ('302', GETDATE(), GETDATE(), 1, 1, GETDATE()),
           ('303', GETDATE(), GETDATE(), 1, 1, GETDATE()),
           ('402', GETDATE(), GETDATE(), 5, 1, GETDATE()),
           ('306', GETDATE(), GETDATE(), 2, 1, GETDATE()),
           ('406', GETDATE(), GETDATE(), 3, 1, GETDATE())
GO

INSERT INTO DiagnosticoMedico (idDiagnostico, idMedico, idUsuarioCrea, fechaCrea)
    VALUES (1, 2, 1, GETDATE()),
           (1, 3, 1, GETDATE()),
           (2, 3, 1, GETDATE()),
           (5, 1, 1, GETDATE()),
           (3, 2, 1, GETDATE())
GO

INSERT INTO DiagnosticoPaciente (idDiagnostico, idPaciente, fecha, idUsuarioCrea, fechaCrea)
    VALUES (2, 2, GETDATE(), 1, GETDATE()),
           (2, 4, GETDATE(), 1, GETDATE()),
           (1, 3, GETDATE(), 1, GETDATE()),
           (1, 5, GETDATE(), 1, GETDATE()),
           (3, 2, GETDATE(), 1, GETDATE())
GO

INSERT INTO MedicoPaciente (idMedico, idPaciente, fecha, idUsuarioCrea, fechaCrea)
    VALUES (2, 2, GETDATE(), 1, GETDATE()),
           (3, 2, GETDATE(), 1, GETDATE()),
           (2, 3, GETDATE(), 1, GETDATE()),
           (5, 5, GETDATE(), 1, GETDATE()),
           (3, 2, GETDATE(), 1, GETDATE())
GO

INSERT INTO CamaPaciente (idCama, idPaciente, fecha, idUsuarioCrea, fechaCrea)
    VALUES (1, 3, '2021-11-30', 1, '2021-11-30'),
           (2, 4,'2021-11-30', 1, '2021-11-30'),
           (1, 1, GETDATE(), 1, GETDATE()),
           (4, 5, GETDATE(), 1, GETDATE()),
           (2, 2, GETDATE(), 1, GETDATE())          
GO        

--SELECT

SELECT * FROM Cama
SELECT * FROM Diagnostico
SELECT * FROM Medico
SELECT * FROM Paciente
SELECT * FROM Pase
SELECT * FROM Planta
SELECT * FROM Usuario
SELECT * FROM DiagnosticoMedico
SELECT * FROM DiagnosticoPaciente
SELECT * FROM MedicoPaciente
SELECT * FROM CamaPaciente

--DELETE 

DELETE FROM Diagnostico WHERE idDiagnostico=4
DELETE FROM Pase WHERE idPase=3

--SELECT AFTER DELETE

SELECT * FROM Diagnostico
SELECT * FROM Pase

--VIEW

CREATE VIEW CamaPlanta AS SELECT c.idCama, c.numero, p.idPlanta, p.nombre
FROM Cama c INNER JOIN Planta p ON c.idPlanta = p.idPlanta WHERE
c.idCama >= 1 GROUP BY  c.idCama, c.numero, p.idPlanta, p.nombre
GO

CREATE VIEW DiagnosticoMedicoNombres AS SELECT d.idDiagnostico, d.codigo, m.ficha, m.nombre, m.apellidoPaterno
FROM Diagnostico d INNER JOIN DiagnosticoMedico dm ON d.idDiagnostico = dm.idDiagnostico INNER JOIN Medico m ON dm.idMedico = m.idMedico WHERE
d.idDiagnostico >= 1 GROUP BY  d.idDiagnostico, d.codigo, m.ficha, m.nombre, m.apellidoPaterno
GO

CREATE VIEW PacientePase AS SELECT p.idPaciente, p.nss, p.nombre, a.idPase, a.numero
FROM Paciente p INNER JOIN Pase a ON p.idPaciente = a.idPaciente WHERE
p.idPaciente >= 1 GROUP BY  p.idPaciente, p.nss, p.nombre, a.idPase, a.numero
GO

CREATE VIEW CamaPlantaCantidad AS
SELECT c.idPlanta, count (p.idPlanta) as cantidad
FROM Cama c INNER JOIN Planta p ON c.idPlanta = p.idPlanta WHERE
p.idPlanta >= 1 GROUP BY c.idPlanta
GO

CREATE VIEW PacientePaseCantidad AS
SELECT a.idPaciente, count (p.idPaciente) as cantidad
FROM Paciente p INNER JOIN Pase a ON p.idPaciente = a.idPaciente WHERE
p.idPaciente >= 1 GROUP BY a.idPaciente
GO