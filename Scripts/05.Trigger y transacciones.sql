USE DB_II_TURNOS_CLINICA
GO
-- Trigger: medico inactivos - cancelacion de turnos
CREATE TRIGGER TR_MedicoInactivado_CancelarTurnos ON Medicos
INSTEAD OF DELETE
AS
BEGIN

	DECLARE @IdUsuario INT = (SELECT IdUsuario FROM DELETED);
	DECLARE @IdMedico INT = (SELECT IdMedico FROM Deleted);
	DECLARE @IdEstadoCancelado TINYINT = (SELECT IdEstado FROM Estados WHERE Descripcion = 'Cancelado');
	DECLARE @IdEstadoPendiente TINYINT = (SELECT IdEstado FROM Estados WHERE Descripcion = 'Pendiente');
	
	-- Seteamos el usuario en 0 para inactivarlo.
	UPDATE Usuarios SET Activo = 0 WHERE IdUsuario = @IdUsuario;

	  -- Actualizamos los estados de los turnos pendientes futuros de este medico a Cancelado
	UPDATE Turnos
	SET 
		IdEstado = @IdEstadoCancelado,
		Observaciones ='Turno cancelado por baja del medico.'
	WHERE 
		IdEspecialidadXMedico IN (SELECT IdEspecialidadXMedico FROM EspecialidadesXMedicos WHERE IdMedico = @IdMedico)
		AND Fecha > GETDATE()  -- (Solo para turnos futuros y con estado pendiente)
		AND IdEstado = @IdEstadoPendiente;
END
GO