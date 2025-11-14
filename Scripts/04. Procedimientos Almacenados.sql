USE DB_II_TURNOS_CLINICA
GO

-- Alta de horarios x medico
ALTER PROCEDURE SP_Agregar_Horarios_De_Medicos(
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
            RAISERROR('El m�dico no est� dado de alta en esta especialidad.', 16, 1);
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
        THROW 50000, @msg, 1;   -- EL THROW PERMITE LEERLO DESDE C#. INTENTÉ PONER UN CODIGO 400 (BAD REQUEST) PERO MINIMO PIDE 50000
    END CATCH
END



-- --                                  -- IdMedico, IdEspecialidad, IdTipoTurno, IdDiaSemana, HoraEntrada, HoraSalida
-- -- EXEC SP_Agregar_Horarios_De_Medicos 1, 1, 1, 1, '12:00:00', '13:00:00'
-- -- EXEC SP_Agregar_Horarios_De_Medicos 1, 1, 2, 1, '12:00:00', '13:00:00'
-- -- EXEC SP_Agregar_Horarios_De_Medicos 1, 5, 2, 1, '12:00:00', '13:00:00'
