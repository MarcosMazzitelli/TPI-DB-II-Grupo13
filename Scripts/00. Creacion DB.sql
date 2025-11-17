USE master
GO
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
    Usuario VARCHAR(35) NOT NULL UNIQUE,
    Contrasenia VARCHAR(255) NOT NULL,
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
    Email VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NULL,
    IdUsuario INT NOT NULL FOREIGN KEY REFERENCES Usuarios(IdUsuario)
)
GO

CREATE FUNCTION dbo.CalcularEdad(@fechaNacimiento DATE, @fechaActual DATE)
RETURNS INT
AS
BEGIN
	DECLARE @edad INT;
	-- Calcular la diferencia en años entre las dos fechas
	SET @edad = DATEDIFF(YEAR, @fechaNacimiento, @fechaActual);

	--restar un año si la persona aun no ha cumplido años en el año actual
	IF (MONTH (@fechaActual) < MONTH (@fechaNacimiento) )
	OR (MONTH (@fechaActual) = MONTH(@fechaNacimiento) ) 
	AND (DAY (@fechaActual) < DAY(@fechaNacimiento) )
	BEGIN
	SET @edad = @edad - 1;
	END;

	RETURN @edad;
END;
GO

CREATE TABLE Medicos (
    IdMedico INT PRIMARY KEY IDENTITY (1, 1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Documento VARCHAR(8) NOT NULL UNIQUE,
    FechaNacimiento DATE NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NULL,
    Matricula VARCHAR(10) NOT NULL UNIQUE,
    IdUsuario INT NOT NULL FOREIGN KEY REFERENCES Usuarios(IdUsuario)
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
