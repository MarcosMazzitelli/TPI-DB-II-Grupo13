USE DB_II_TURNOS_CLINICA
GO

-- Detalle de medicos con sus especialidades
CREATE VIEW V_Medicos_Especialidades
AS
SELECT 
    M.Apellido + ', ' + M.Nombre AS 'Nombre Completo Medico',
    M.Matricula,
    E.Descripcion AS Especialidad
FROM Medicos M
INNER JOIN EspecialidadesXMedicos EXM ON M.IdMedico = EXM.IdMedico
INNER JOIN Especialidades E ON EXM.IdEspecialidad = E.IdEspecialidad;
GO

-- Horarios completos de los médicos
CREATE VIEW V_Horarios_Detallados
AS
SELECT
    M.Apellido + ', ' + M.Nombre AS 'Nombre Completo Medico',
    M.Matricula,
    E.Descripcion AS Especialidad,
    TT.Tipo AS TipoTurno,
    DS.Dia AS DiaSemana,
    HDM.HoraEntrada,
    HDM.HoraSalida,
    DS.IdDiaSemana
FROM HorariosDeMedicos HDM
INNER JOIN EspecialidadesXMedicos EXM ON HDM.IdEspecialidadXMedico = EXM.IdEspecialidadXMedico
INNER JOIN Especialidades E ON EXM.IdEspecialidad = E.IdEspecialidad
INNER JOIN Medicos M ON EXM.IdMedico = M.IdMedico
INNER JOIN TiposTurno TT ON HDM.IdTipoTurno = TT.IdTipoTurno
INNER JOIN DiasSemana DS ON HDM.IdDiaSemana = DS.IdDiaSemana;
GO

-- Detalle de turnos de pacientes
CREATE VIEW V_Pacientes_Turnos
AS
SELECT
    P.Nombre AS NombrePaciente,
    P.Apellido AS ApellidoPaciente,
    P.Documento AS Documento,
    EP.Descripcion AS Especialidad,
    M.Nombre AS NombreMedico,
    M.Apellido AS ApellidoMedico,
    T.Fecha AS FechaYHora,
    TT.Tipo AS TipoDeTurno,
    T.EsSobreTurno AS EsSobreTurno,
    ES.Descripcion AS Estado
FROM Pacientes P
INNER JOIN Turnos T ON P.IdPaciente = T.IdPaciente
INNER JOIN Estados ES ON ES.IdEstado = T.IdEstado
INNER JOIN TiposTurno TT ON TT.IdTipoTurno = T.IdTipoTurno
INNER JOIN EspecialidadesXMedicos EXM ON EXM.IdEspecialidadXMedico = T.IdEspecialidadXMedico
INNER JOIN Medicos M ON M.IdMedico = EXM.IdMedico
INNER JOIN Especialidades EP ON EP.IdEspecialidad = EXM.IdEspecialidad;
GO
