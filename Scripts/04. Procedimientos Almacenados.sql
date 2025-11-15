USE DB_II_TURNOS_CLINICA
GO

-- Alta de horarios x medico
CREATE PROCEDURE SP_Agregar_Horarios_De_Medicos(
    @IdMedico INT,
    @IdEspecialidad TINYINT,
    @IdTipoTurno TINYINT,
    @IdDiaSemana TINYINT,
    @HoraEntrada TIME,
    @HoraSalida TIME
)
AS
BEGIN
    BEGIN TRY
        IF @IdMedico NOT IN (SELECT IdMedico FROM Medicos) BEGIN
            RAISERROR('Medico inexistente.', 16, 1);
        END 
        IF @IdEspecialidad NOT IN (SELECT IdEspecialidad FROM Especialidades) BEGIN
            RAISERROR('Especialidad inexistente.', 16, 1);
        END 
        IF @IdTipoTurno NOT IN (SELECT IdTipoTurno FROM TiposTurno) BEGIN
            RAISERROR('Tipo de turno inexistente.', 16, 1);
        END 
        IF @IdDiaSemana NOT IN (SELECT IdDiaSemana FROM DiasSemana) BEGIN
            RAISERROR('Dia de semana inexistente.', 16, 1);
        END 

        IF @HoraEntrada >= @HoraSalida BEGIN
            RAISERROR('No puede haber un turno con duracion menor o igual a 0.', 16, 1);
        END 
        

        IF (SELECT COUNT(*) FROM EspecialidadesXMedicos WHERE IdMedico = @IdMedico  AND IdEspecialidad = @IdEspecialidad) = 0 BEGIN
            RAISERROR('El medico no esta dado de alta en esta especialidad.', 16, 1);
        END
        ELSE BEGIN
            DECLARE @IdEspecialidadXMedico INT
            SELECT @IdEspecialidadXMedico = IdEspecialidadXMedico FROM EspecialidadesXMedicos WHERE IdMedico = @IdMedico  AND IdEspecialidad = @IdEspecialidad
        END

        IF (SELECT COUNT(*) FROM HorariosDeMedicos 
                WHERE IdTipoTurno = @IdTipoTurno 
                AND IdEspecialidadXMedico = @IdEspecialidadXMedico 
                AND IdDiaSemana = @IdDiaSemana
                AND HoraEntrada < @HoraSalida
                AND HoraSalida > @HoraEntrada) > 0 
        BEGIN
            RAISERROR('El horario seleccionado interfiere con otro horario establecido.', 16, 1);
        END

       INSERT INTO HorariosDeMedicos (IdEspecialidadXMedico, IdTipoTurno, IdDiaSemana, HoraEntrada, HoraSalida) 
                            VALUES (@IdEspecialidadXMedico, @IdTipoTurno, @IdDiaSemana, @HoraEntrada, @HoraSalida)

 END TRY 
    BEGIN CATCH 
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        -- PRINT @msg;
        THROW 50000, @msg, 1;   -- EL THROW PERMITE LEERLO DESDE C#. INTENTE PONER UN CODIGO 400 (BAD REQUEST) PERO MINIMO PIDE 50000
    END CATCH
END
GO
-- --                                  -- IdMedico, IdEspecialidad, IdTipoTurno, IdDiaSemana, HoraEntrada, HoraSalida
-- -- EXEC SP_Agregar_Horarios_De_Medicos 1, 1, 1, 1, '12:00:00', '13:00:00'
-- -- EXEC SP_Agregar_Horarios_De_Medicos 1, 1, 2, 1, '12:00:00', '13:00:00'
-- -- EXEC SP_Agregar_Horarios_De_Medicos 1, 5, 2, 1, '12:00:00', '13:00:00'

CREATE PROCEDURE SP_Registrar_Turno
    @IdPaciente INT,
    @IdEspecialidadXMedico INT,
    @IdTipoTurno TINYINT,
    @Fecha DATETIME,
    @Observaciones VARCHAR(255) = NULL,
    @EsSobreTurno BIT
AS
BEGIN

    
    BEGIN TRY

        BEGIN TRANSACTION;
			DECLARE @HoraTurno TIME;
			DECLARE @IdEstadoPendiente TINYINT;
			DECLARE @IdEstadoCancelado TINYINT;
			DECLARE @IdEstadoAtendido TINYINT;

			SET @HoraTurno = CONVERT(TIME, @Fecha);

			IF (SELECT COUNT (*) FROM Pacientes WHERE IdPaciente = @IdPaciente) = 0
			BEGIN
				RAISERROR('El paciente especificado no existe.', 16, 1);
				ROLLBACK TRANSACTION;
				RETURN;
			END

			-- Validacion que el medico tenga esa especialidad asignada.
			IF (SELECT COUNT (*) FROM EspecialidadesXMedicos WHERE IdEspecialidadXMedico = @IdEspecialidadXMedico) = 0
			BEGIN
				RAISERROR('La combinacion de medico y especialidad no existe.', 16, 1);
				ROLLBACK TRANSACTION;
				RETURN;
			END

            IF @Fecha <= GETDATE()
			BEGIN
				RAISERROR('No se puede registrar un turno en el pasado.', 16, 1);
				ROLLBACK TRANSACTION;
				RETURN;
			END

			-- Validacion que el medico tenga esa fecha y horario asignado con esa especialidad y ese tipo de turno
			SET DATEFIRST 1;  -- para que el weekday 1 sea lunes.
			IF (SELECT COUNT (*) FROM HorariosDeMedicos H 
				INNER JOIN DiasSemana DS ON H.IdDiaSemana = DS.IdDiaSemana
				WHERE H.IdEspecialidadXMedico = @IdEspecialidadXMedico
				  AND H.IdTipoTurno = @IdTipoTurno
				  AND DATEPART(WEEKDAY, @Fecha) = DS.IdDiaSemana
				  AND @HoraTurno BETWEEN H.HoraEntrada AND H.HoraSalida) = 0
			BEGIN
				RAISERROR('El medico no atiende en el dia y hora seleccionados, o el tipo de turno no es correcto.', 16, 1);
				ROLLBACK TRANSACTION;
				RETURN;
			END
		
			-- Validacion que el medico no tenga un turno asignado en esa fecha y 30 minutos antes y despues
			DECLARE @FechaInicioRango DATETIME = DATEADD(MINUTE, -29, @Fecha); --  29 min antes que comience el nuevo turno
			DECLARE @FechaFinRango DATETIME = DATEADD(MINUTE, 29, @Fecha);     --  29  min despues del nuevo turno
			SET @IdEstadoCancelado = (SELECT IdEstado FROM Estados WHERE Descripcion = 'Cancelado');
			SET @IdEstadoAtendido = (SELECT IdEstado FROM Estados WHERE Descripcion = 'Atendido');

			IF (SELECT COUNT (*) FROM Turnos T 
				WHERE T.IdEspecialidadXMedico = @IdEspecialidadXMedico
				  AND T.Fecha BETWEEN @FechaInicioRango AND @FechaFinRango
				  AND T.IdEstado NOT IN (@IdEstadoCancelado, @IdEstadoAtendido) ) > 0
			BEGIN
				RAISERROR('El medico ya tiene un turno asignado en esa fecha y hora.', 16, 1);
				ROLLBACK TRANSACTION;
				RETURN;
			END

			SET @IdEstadoPendiente = (SELECT IdEstado FROM Estados WHERE Descripcion = 'Pendiente');

			INSERT INTO Turnos (IdPaciente, IdEspecialidadXMedico, IdEstado, IdTipoTurno, Fecha, Observaciones, EsSobreTurno)
			VALUES (@IdPaciente, @IdEspecialidadXMedico, @IdEstadoPendiente, @IdTipoTurno, @Fecha, @Observaciones, @EsSobreTurno);

		COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW;
    END CATCH
END
GO

CREATE PROCEDURE SP_Reporte_Historia_Paciente(
@IdPaciente INT)
AS
BEGIN

    SELECT 
		HC.IdHistoriaClinica AS Id,
        HC.Fecha,
        P.Nombre AS NombrePaciente,
        P.Apellido AS ApellidoPaciente,
		P.FechaNacimiento AS FechaNacimiento,
		dbo.CalcularEdad(P.FechaNacimiento, GETDATE()) AS Edad,
		P.Documento,
        M.Nombre AS NombreMedico,
        M.Apellido AS ApellidoMedico,
        E.Descripcion AS Especialidad,
        HC.Descripcion AS DescripcionHistoria
    FROM HistoriasClinicas HC
    INNER JOIN Pacientes P ON HC.IdPaciente = P.IdPaciente
    INNER JOIN EspecialidadesXMedicos EXM ON HC.IdEspecialidadXMedico = EXM.IdEspecialidadXMedico
    INNER JOIN Medicos M ON EXM.IdMedico = M.IdMedico
    INNER JOIN Especialidades E ON EXM.IdEspecialidad = E.IdEspecialidad
    WHERE HC.IdPaciente = @IdPaciente
    ORDER BY 
        HC.Fecha DESC;
END
GO
