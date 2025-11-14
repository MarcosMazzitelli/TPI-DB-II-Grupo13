USE DB_II_TURNOS_CLINICA
GO

DELETE FROM HistoriasClinicas;
DELETE FROM Turnos;
DELETE FROM HorariosDeMedicos;
DELETE FROM EspecialidadesXMedicos;
DELETE FROM Medicos;
DELETE FROM Pacientes;
DELETE FROM Usuarios;
DELETE FROM Permisos;
DELETE FROM Estados;
DELETE FROM DiasSemana;
DELETE FROM TiposTurno;
DELETE FROM Especialidades;
GO

-- Resetear el IDENTITY (empezar a contar desde 0, para que el primer ID sea 1)
DBCC CHECKIDENT ('[HistoriasClinicas]', RESEED, 0);
DBCC CHECKIDENT ('[Turnos]', RESEED, 0);
DBCC CHECKIDENT ('[HorariosDeMedicos]', RESEED, 0);
DBCC CHECKIDENT ('[EspecialidadesXMedicos]', RESEED, 0);
DBCC CHECKIDENT ('[Medicos]', RESEED, 0);
DBCC CHECKIDENT ('[Pacientes]', RESEED, 0);
DBCC CHECKIDENT ('[Usuarios]', RESEED, 0);
DBCC CHECKIDENT ('[Permisos]', RESEED, 0);
DBCC CHECKIDENT ('[Estados]', RESEED, 0);
DBCC CHECKIDENT ('[DiasSemana]', RESEED, 0);
DBCC CHECKIDENT ('[TiposTurno]', RESEED, 0);
DBCC CHECKIDENT ('[Especialidades]', RESEED, 0);
GO
