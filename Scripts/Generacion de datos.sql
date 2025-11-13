USE DB_II_TURNOS_CLINICA
GO

INSERT INTO Permisos (Tipo) VALUES ('Admin'), ('Medico'), ('Paciente'), ('Recepcionista');
GO

INSERT INTO Especialidades (Descripcion) VALUES 
('Cardiología'), ('Dermatología'), ('Traumatología'), ('Pediatría'), ('Clínica Médica');
GO

INSERT INTO TiposTurno (Tipo) VALUES 
('Presencial'), ('Teleconsulta'), ('Urgencia');
GO

INSERT INTO DiasSemana (Dia) VALUES 
('Lunes'), ('Martes'), ('Miércoles'), ('Jueves'), ('Viernes'), ('Sábado'), ('Domingo');
GO

INSERT INTO Estados (Descripcion) VALUES 
('Pendiente'), ('Confirmado'), ('Cancelado'), ('Atendido');
GO

-- Insertar Usuarios (con permisos)
INSERT INTO Usuarios (Usuario, Contrasenia, Activo, IdPermiso) VALUES 
('admin', 'admin', 1, 1), 
('dr.gomez', 'gomez123', 1, 2), 
('dr.perez', 'perez123', 1, 2), 
('jperez', 'jperez123', 1, 3);
GO

-- Insertar Pacientes
INSERT INTO Pacientes (Nombre, Apellido, Documento, FechaNacimiento, IdUsuario) VALUES 
('Juan', 'Perez', '30111222', '1985-05-15', 4),
('Maria', 'Lopez', '32333444', '1990-11-01', NULL),
('Carlos', 'Garcia', '28555666', '1980-03-22', NULL);
GO

-- Insertar Medicos
INSERT INTO Medicos (Nombre, Apellido, Documento, FechaNacimiento, Matricula, IdUsuario) VALUES 
('Roberto', 'Gomez', '25111222', '1975-08-20', 'MN-1001', 2),
('Ana', 'Perez', '27333444', '1982-01-10', 'MN-1002', 3);
GO

--Tablas con relaciones
INSERT INTO EspecialidadesXMedicos (IdEspecialidad, IdMedico) VALUES 
(1, 1), -- Dr. Gomez (1) es Cardiologo (1) -> IdEspecialidadXMedico = 1
(5, 1), -- Dr. Gomez (1) es Clínico (5) -> IdEspecialidadXMedico = 2
(3, 2), -- Dra. Perez (2) es Traumatologa (3) -> IdEspecialidadXMedico = 3
(5, 2); -- Dra. Perez (2) es Clínica (5) -> IdEspecialidadXMedico = 4
GO

INSERT INTO HorariosDeMedicos (IdEspecialidadXMedico, IdTipoTurno, IdDiaSemana, HoraEntrada, HoraSalida) VALUES 
(1, 1, 1, '09:00', '12:00'), -- Gomez, Cardiologia, Presencial(1), Lunes(1), 9 a 12
(1, 2, 1, '14:00', '17:00'), -- Gomez, Cardiologia, Teleconsulta(2), Lunes(1), 14 a 17
(3, 1, 3, '10:00', '14:00'), -- Perez, Traumatologia, Presencial(1), Miércoles(3), 10 a 14
(3, 1, 5, '08:00', '12:00'); -- Perez, Traumatologia, Presencial(1), Viernes(5), 8 a 12
GO

-- Turno 1: Dr. Gomez (Cardio) el Lunes 2024-10-14 a las 10:30
INSERT INTO Turnos (IdPaciente, IdEspecialidadXMedico, IdEstado, IdTipoTurno, Fecha, Observaciones, EsSobreTurno)
VALUES (1, 1, 1, 1, '2024-10-14 10:30:00', 'Paciente refiere dolor de pecho.', 0);

-- Turno 2: Dra. Perez (Trauma) el Miércoles 2024-10-16 a las 11:00 
INSERT INTO Turnos (IdPaciente, IdEspecialidadXMedico, IdEstado, IdTipoTurno, Fecha, Observaciones, EsSobreTurno)
VALUES (2, 3, 1, 1, '2024-10-16 11:00:00', 'Control de rodilla.', 0);

-- Turno 3: Dr. Gomez (Cardio, Telec.) el Lunes 2024-10-14 a las 15:00 
INSERT INTO Turnos (IdPaciente, IdEspecialidadXMedico, IdEstado, IdTipoTurno, Fecha, Observaciones, EsSobreTurno)
VALUES (3, 1, 1, 2, '2024-10-14 15:00:00', 'Revisión de estudios online.', 0);

-- Turno 4: Dra. Perez (Trauma) el Viernes 2024-10-18 a las 09:00 
INSERT INTO Turnos (IdPaciente, IdEspecialidadXMedico, IdEstado, IdTipoTurno, Fecha, Observaciones, EsSobreTurno)
VALUES (1, 3, 2, 1, '2024-10-18 09:00:00', 'Paciente confirmado.', 0);
GO

-- Insertar Historia Clínica
INSERT INTO HistoriasClinicas (Fecha, IdPaciente, IdEspecialidadXMedico, Descripcion)
VALUES ('2023-10-01', 1, 2, 'Paciente refiere tos seca. Se receta jarabe.');
GO

