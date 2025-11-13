USE DB_II_TURNOS_CLINICA
GO

-- Detalle de medicos con sus especialidades
CREATE VIEW V_Medicos_Especialidades
AS
SELECT 
    M.IdMedico,
    M.Nombre AS NombreMedico,
    M.Apellido AS ApellidoMedico,
    M.Matricula,
    E.IdEspecialidad,
    E.Descripcion,
    EXM.IdEspecialidadXMedico
FROM Medicos M
INNER JOIN EspecialidadesXMedicos EXM ON M.IdMedico = EXM.IdMedico
INNER JOIN Especialidades E ON EXM.IdEspecialidad = E.IdEspecialidad;
GO

-- Horarios completos de los médicos
CREATE VIEW V_Horarios_Detallados
AS
SELECT
    M.IdMedico,
    M.Nombre,
    M.Apellido,
    M.Matricula,
    E.Descripcion,
    TT.Tipo AS TipoTurno,
    DS.Dia AS DiaSemana,
    HDM.HoraEntrada,
    HDM.HoraSalida,
    HDM.IdHorariosDeMedico,
    EXM.IdEspecialidadXMedico,
    TT.IdTipoTurno,
    DS.IdDiaSemana
FROM HorariosDeMedicos HDM
INNER JOIN EspecialidadesXMedicos EXM ON HDM.IdEspecialidadXMedico = EXM.IdEspecialidadXMedico
INNER JOIN Especialidades E ON EXM.IdEspecialidad = E.IdEspecialidad
INNER JOIN Medicos M ON EXM.IdMedico = M.IdMedico
INNER JOIN TiposTurno TT ON HDM.IdTipoTurno = TT.IdTipoTurno
INNER JOIN DiasSemana DS ON HDM.IdDiaSemana = DS.IdDiaSemana;
GO
