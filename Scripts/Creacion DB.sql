CREATE DATABASE DB_II_TURNOS_CLINICA
GO
USE DB_II_TURNOS_CLINICA

CREATE TABLE Permisos (
    IdPermiso INT PRIMARY KEY IDENTITY (1, 1),
    Tipo VARCHAR(28) NOT NULL UNIQUE
)
GO

CREATE TABLE Usuarios (
    IdUsuario INT PRIMARY KEY IDENTITY (1, 1),
    Usuario VARCHAR(28) NOT NULL UNIQUE,
    Contrasenia VARCHAR(28) NOT NULL,
    Activo BIT NOT NULL,
    IdPermiso INT NOT NULL FOREIGN KEY REFERENCES Permisos(IdPermiso)
)
GO

CREATE TABLE Especialidades (
    IdEspecialidad TINYINT PRIMARY KEY IDENTITY (1, 1),
    Descripcion VARCHAR(50) NOT NULL UNIQUE
)
GO

CREATE TABLE TiposTurno (
    IdTipoTurno TINYINT PRIMARY KEY IDENTITY (1, 1),
    Tipo VARCHAR(20) NOT NULL UNIQUE
)
GO

CREATE TABLE DiasSemana (
    IdDiaSemana TINYINT PRIMARY KEY IDENTITY (1, 1),
    Dia VARCHAR(10) NOT NULL UNIQUE
)
GO

CREATE TABLE Estados (
    IdEstado TINYINT PRIMARY KEY IDENTITY (1, 1),
    Descripcion VARCHAR(20) NOT NULL UNIQUE
)
GO

CREATE TABLE Pacientes (
    IdPaciente INT PRIMARY KEY IDENTITY (1, 1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Documento VARCHAR(8) NOT NULL UNIQUE,
    FechaNacimiento DATE NOT NULL,
    Email VARCHAR(100) NULL,
    Telefono VARCHAR(20) NULL,
    IdUsuario INT NULL FOREIGN KEY REFERENCES Usuarios(IdUsuario)
)
GO

CREATE TABLE Medicos (
    IdMedico INT PRIMARY KEY IDENTITY (1, 1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Documento VARCHAR(8) NOT NULL UNIQUE,
    FechaNacimiento DATE NOT NULL,
    Email VARCHAR(100) NULL,
    Telefono VARCHAR(20) NULL,
    Matricula VARCHAR(10) NOT NULL UNIQUE,
    IdUsuario INT NULL FOREIGN KEY REFERENCES Usuarios(IdUsuario)
)
GO


CREATE TABLE EspecialidadesXMedicos (
    IdEspecialidadXMedico INTEGER PRIMARY KEY IDENTITY (1, 1),
	IdEspecialidad TINYINT NOT NULL FOREIGN KEY REFERENCES Especialidades(IdEspecialidad),
    IdMedico INT NOT NULL FOREIGN KEY REFERENCES Medicos(IdMedico),
    CONSTRAINT UQ_Especialidad_Medico UNIQUE (IdEspecialidad, IdMedico)
)
GO

CREATE TABLE HorariosDeMedicos (
    IdHorariosDeMedico INT PRIMARY KEY IDENTITY (1, 1),
	IdEspecialidadXMedico INT NOT NULL FOREIGN KEY REFERENCES EspecialidadesXMedicos(IdEspecialidadXMedico),
	IdTipoTurno TINYINT NOT NULL FOREIGN KEY REFERENCES TiposTurno(IdTipoTurno),
	IdDiaSemana TINYINT NOT NULL FOREIGN KEY REFERENCES DiasSemana(IdDiaSemana),
    HoraEntrada TIME NOT NULL,
    HoraSalida TIME NOT NULL,
	CONSTRAINT UQ_Horario_Unico UNIQUE (IdEspecialidadXMedico, IdTipoTurno, IdDiaSemana, HoraEntrada, HoraSalida)
)
GO


CREATE TABLE Turnos (
    IdTurno INT PRIMARY KEY IDENTITY (1, 1),
    IdPaciente INT NOT NULL FOREIGN KEY REFERENCES Pacientes(IdPaciente),
	IdEspecialidadXMedico INT NOT NULL FOREIGN KEY REFERENCES EspecialidadesXMedicos(IdEspecialidadXMedico),
    IdEstado TINYINT NOT NULL FOREIGN KEY REFERENCES Estados(IdEstado),
    IdTipoTurno TINYINT NOT NULL FOREIGN KEY REFERENCES TiposTurno(IdTipoTurno),
    Fecha DATETIME NOT NULL,
    Observaciones VARCHAR(255) NULL,
    EsSobreTurno BIT NOT NULL
)
GO

CREATE TABLE HistoriasClinicas (
    IdHistoriaClinica INT PRIMARY KEY IDENTITY (1, 1),
    Fecha DATETIME NOT NULL,
    IdPaciente INT NOT NULL FOREIGN KEY REFERENCES Pacientes(IdPaciente),
	IdEspecialidadXMedico INT NOT NULL FOREIGN KEY REFERENCES EspecialidadesXMedicos(IdEspecialidadXMedico),
    Descripcion VARCHAR(255) NOT NULL
)
GO

USE DB_II_TURNOS_CLINICA

SELECT * FROM Turnos
select * from Pacientes
select * from DiasSemana
select * from Especialidades
select * from EspecialidadesXMedicos
select * from Estados
select * from HistoriasClinicas
select * from HorariosDeMedicos
select * from Medicos
select * from Pacientes
select * from Permisos
select * from TiposTurno
select * from Turnos
select * from Usuarios

