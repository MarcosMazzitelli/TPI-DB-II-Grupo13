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

CREATE TRIGGER TR_Observacion_Sobreturno ON Turnos
AFTER INSERT
AS 
BEGIN
	-- Se obtiene el id del turno que se acaba de crear
	DECLARE @IdTurno INT = (SELECT IdTurno FROM inserted);

	-- Si es sobre turno...
	IF (SELECT EsSobreTurno FROM inserted) = 1 BEGIN
		-- Agregar la etiqueta sobreturno en la observacion del turno.
		UPDATE Turnos SET Observaciones = 'SOBRETURNO: ' + Observaciones WHERE IdTurno = @IdTurno;
	END
END
GO

CREATE TRIGGER TR_No_Modificar_Turnos_Cerrados ON Turnos
AFTER UPDATE
AS 
BEGIN
	-- Obtengo los Ids de los estados Cancelado o Completado
	DECLARE @IdEstadoCancelado TINYINT = (SELECT IdEstado FROM Estados WHERE Descripcion = 'Cancelado');
	DECLARE @IdEstadoCompletado TINYINT = (SELECT IdEstado FROM Estados WHERE Descripcion = 'Completado');
	
    -- Si hay al menos un registro (> 0) donde el id de estado del registro corresponda a cancelado o completado...
	IF (SELECT COUNT(*) FROM inserted I JOIN deleted D ON I.IdTurno = D.IdTurno WHERE D.IdEstado IN (@IdEstadoCancelado, @IdEstadoCompletado)) > 0
	BEGIN
        -- Se muestra un error, y se hace rollback, cancelando la actualizacion de los registros.
		RAISERROR('Los turnos cerrados no pueden ser modificados.', 16, 1);
		ROLLBACK TRANSACTION;
		RETURN;
	END

END
GO
