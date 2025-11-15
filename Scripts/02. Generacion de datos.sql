USE DB_II_TURNOS_CLINICA
GO

INSERT INTO Permisos (Tipo)
VALUES ('Admin'), ('Medico'), ('Paciente'), ('Recepcionista');
GO

INSERT INTO Especialidades (Descripcion)
VALUES ('Cardiología'), ('Dermatología'), ('Traumatología'), ('Pediatría'), ('Clínica Médica');
GO

INSERT INTO TiposTurno (Tipo)
VALUES ('Presencial'), ('Virtual'), ('Urgencia');
GO

INSERT INTO DiasSemana (Dia)
VALUES ('Lunes'), ('Martes'), ('Miércoles'), ('Jueves'), ('Viernes'), ('Sábado'), ('Domingo');
GO

INSERT INTO Estados (Descripcion)
VALUES ('Pendiente'), ('Cancelado'), ('Completado');
GO

INSERT INTO Usuarios (Usuario, Contrasenia, Activo, IdPermiso) VALUES
('admin', 'admin123', 1, 1), -- ID 1 (Admin)
('recepcion', 'recep123', 1, 4), -- ID 2 (Recepcionista)
('rgomez', 'pass1', 1, 2), -- ID 3 (Medico)
('aperez', 'pass2', 1, 2), -- ID 4 (Medico)
('ldiaz', 'pass3', 1, 2), -- ID 5 (Medico)
('mlopez', 'pass4', 1, 2), -- ID 6 (Medico)
('csanchez', 'pass5', 1, 2), -- ID 7 (Medico)
('jperez', 'pac1', 1, 3), -- ID 8 (Paciente)
('mgarcia', 'pac2', 1, 3), -- ID 9 (Paciente)
('lrodriguez', 'pac3', 1, 3), -- ID 10 (Paciente)
('cmartinez', 'pac4', 1, 3), -- ID 11 (Paciente)
('dfernandez', 'pac5', 1, 3), -- ID 12 (Paciente)
('pgomez', 'pac6', 1, 3), -- ID 13 (Paciente)
('atorres', 'pac7', 1, 3), -- ID 14 (Paciente)
('rramirez', 'pac8', 1, 3), -- ID 15 (Paciente)
('flopez', 'pac9', 1, 3), -- ID 16 (Paciente)
('smoreno', 'pac10', 1, 3), -- ID 17 (Paciente)
('jgonzalez', 'pac11', 1, 3), -- ID 18 (Paciente)
('vromero', 'pac12', 1, 3), -- ID 19 (Paciente)
('aalvarez', 'pac13', 1, 3), -- ID 20 (Paciente)
('mbenitez', 'pac14', 1, 3), -- ID 21 (Paciente)
('ljuarez', 'pac15', 1, 3), -- ID 22 (Paciente)
('rcastillo', 'pac16', 1, 3), -- ID 23 (Paciente)
('omolina', 'pac17', 1, 3), -- ID 24 (Paciente)
('esosa', 'pac18', 1, 3), -- ID 25 (Paciente)
('mvega', 'pac19', 1, 3), -- ID 26 (Paciente)
('aruiz', 'pac20', 1, 3); -- ID 27 (Paciente)
GO
-- Insertar Pacientes
INSERT INTO Pacientes (Nombre, Apellido, Documento, FechaNacimiento, Email, Telefono, IdUsuario) VALUES
('Juan', 'Perez', '30111222', '1985-05-15', 'jperez@mail.com', '111-0001', 8),
('Maria', 'Garcia', '32333444', '1990-11-01', 'mgarcia@mail.com', '111-0002', 9),
('Luis', 'Rodriguez', '28555666', '1980-03-22', 'lrodriguez@mail.com', '111-0003', 10),
('Carlos', 'Martinez', '35123456', '1992-07-30', 'cmartinez@mail.com', '111-0004', 11),
('Daniel', 'Fernandez', '29888777', '1983-12-10', 'dfernandez@mail.com', '111-0005', 12),
('Pablo', 'Gomez', '31222333', '1988-02-18', 'pgomez@mail.com', '111-0006', 13),
('Ana', 'Torres', '33444555', '1995-09-05', 'atorres@mail.com', '111-0007', 14),
('Roberto', 'Ramirez', '30666777', '1986-04-12', 'rramirez@mail.com', '111-0008', 15),
('Florencia', 'Lopez', '34888999', '1993-11-30', 'flopez@mail.com', '111-0009', 16),
('Sergio', 'Moreno', '32111000', '1989-08-25', 'smoreno@mail.com', '111-0010', 17),
('Javier', 'Gonzalez', '36222111', '1998-01-07', 'jgonzalez@mail.com', '111-0011', 18),
('Valeria', 'Romero', '37333222', '2000-06-14', 'vromero@mail.com', '111-0012', 19),
('Alejandra', 'Alvarez', '38444333', '2001-03-20', 'aalvarez@mail.com', '111-0013', 20),
('Matias', 'Benitez', '39555444', '2002-10-28', 'mbenitez@mail.com', '111-0014', 21),
('Lucia', 'Juarez', '40666555', '2003-05-15', 'ljuarez@mail.com', '111-0015', 22),
('Raul', 'Castillo', '27777888', '1979-12-01', 'rcastillo@mail.com', '111-0016', 23),
('Oscar', 'Molina', '26888999', '1978-07-09', 'omolina@mail.com', '111-0017', 24),
('Estela', 'Sosa', '25999000', '1976-02-23', 'esosa@mail.com', '111-0018', 25),
('Marcos', 'Vega', '41111222', '2004-09-11', 'mvega@mail.com', '111-0019', 26),
('Andrea', 'Ruiz', '42222333', '2005-04-03', 'aruiz@mail.com', '111-0020', 27);
GO
-- Insertar Medicos
INSERT INTO Medicos (Nombre, Apellido, Documento, FechaNacimiento, Email, Telefono, Matricula, IdUsuario) VALUES 
('Roberto', 'Gomez', '25111222', '1975-08-20', 'rgomez@clinica.com', '222-0001', 'MN-1001', 3),
('Ana', 'Perez', '27333444', '1982-01-10', 'aperez@clinica.com', '222-0002', 'MN-1002', 4),
('Laura', 'Diaz', '28444555', '1984-06-25', 'ldiaz@clinica.com', '222-0003', 'MN-1003', 5),
('Miguel', 'Lopez', '26555666', '1979-03-15', 'mlopez@clinica.com', '222-0004', 'MN-1004', 6),
('Carla', 'Sanchez', '29666777', '1985-11-05', 'csanchez@clinica.com', '222-0005', 'MN-1005', 7);
GO

--Tablas con relaciones
INSERT INTO EspecialidadesXMedicos (IdEspecialidad, IdMedico) VALUES
(1, 1), -- 1: Gomez (Cardiología)
(5, 1), -- 2: Gomez (Clínica Médica)
(2, 2), -- 3: Perez (Dermatología)
(3, 2), -- 4: Perez (Traumatología)
(4, 3), -- 5: Diaz (Pediatría)
(5, 3), -- 6: Diaz (Clínica Médica)
(1, 4), -- 7: Lopez (Cardiología)
(5, 4), -- 8: Lopez (Clínica Médica)
(2, 5), -- 9: Sanchez (Dermatología)
(3, 5); -- 10: Sanchez (Traumatología)
GO

INSERT INTO HorariosDeMedicos (IdEspecialidadXMedico, IdTipoTurno, IdDiaSemana, HoraEntrada, HoraSalida) VALUES
(1, 1, 1, '09:00', '12:00'), -- Gomez, Cardio, Lunes (Presencial)
(1, 2, 1, '14:00', '17:00'), -- Gomez, Cardio, Lunes (Virtual)
(2, 1, 2, '08:00', '11:00'), -- Gomez, Clinica, Martes (Presencial)
(3, 1, 2, '15:00', '18:00'), -- Perez, Derma, Martes (Presencial)
(4, 1, 3, '10:00', '14:00'), -- Perez, Trauma, Miércoles (Presencial)
(4, 3, 3, '14:00', '16:00'), -- Perez, Trauma, Miércoles (Urgencia)
(5, 1, 4, '09:00', '13:00'), -- Diaz, Pedia, Jueves (Presencial)
(6, 1, 4, '15:00', '18:00'), -- Diaz, Clinica, Jueves (Presencial)
(7, 1, 5, '08:00', '12:00'), -- Lopez, Cardio, Viernes (Presencial)
(8, 2, 5, '13:00', '16:00'), -- Lopez, Clinica, Viernes (Virtual)
(9, 1, 1, '10:00', '13:00'), -- Sanchez, Derma, Lunes (Presencial)
(9, 1, 3, '10:00', '13:00'), -- Sanchez, Derma, Miércoles (Presencial)
(10, 1, 5, '15:00', '19:00'), -- Sanchez, Trauma, Viernes (Presencial)
(1, 1, 6, '09:00', '11:00'), -- Gomez, Cardio, Sábado (Presencial)
(5, 1, 6, '09:00', '12:00'); -- Diaz, Pedia, Sábado (Presencial)
GO


INSERT INTO Turnos (IdPaciente, IdEspecialidadXMedico, IdEstado, IdTipoTurno, Fecha, Observaciones, EsSobreTurno) VALUES
(1, 1, 3 , 1, '2024-10-07 09:00:00', 'Control anual.', 0),
(2, 1, 3, 1, '2024-10-07 09:30:00', 'Dolor de pecho.', 0),
(3, 1, 2, 1, '2024-10-07 10:00:00', 'Paciente cancela.', 0),
(4, 1, 3 , 1, '2024-10-07 10:30:00', 'Revisión estudios.', 0),
(5, 1, 3, 1, '2024-10-14 09:00:00', 'Electrocardiograma.', 0),
(6, 1, 3, 1, '2024-10-14 09:30:00', 'Control presión.', 0),
(7, 1, 3, 1, '2024-10-14 10:00:00', 'OK.', 0),
(8, 1, 2, 1, '2024-10-14 10:30:00', 'Paciente no asiste.', 0),
(9, 1, 3, 1, '2024-10-21 09:00:00', 'OK.', 0),
(10, 1, 1, 1, '2025-12-21 09:00:00', 'Turno futuro.', 0); -- Futuro

INSERT INTO Turnos (IdPaciente, IdEspecialidadXMedico, IdEstado, IdTipoTurno, Fecha, Observaciones, EsSobreTurno) VALUES
(11, 2, 3, 1, '2024-10-08 08:00:00', 'Chequeo general.', 0),
(12, 2, 3, 1, '2024-10-08 08:30:00', 'OK.', 0),
(13, 2, 3, 1, '2024-10-08 09:00:00', 'OK.', 0),
(14, 2, 3, 1, '2024-10-15 08:00:00', 'Apto físico.', 0),
(15, 2, 3, 1, '2024-10-15 08:30:00', 'OK.', 0),
(16, 2, 2, 1, '2024-10-15 09:00:00', 'Cancela por viaje.', 0),
(17, 2, 3, 1, '2024-10-22 08:00:00', 'OK.', 0),
(18, 2, 3, 1, '2024-10-22 08:30:00', 'OK.', 0),
(19, 2, 3, 1, '2024-10-22 09:00:00', 'OK.', 0),
(20, 2, 1, 1, GETDATE() + 8, 'Turno futuro.', 0); -- Futuro

INSERT INTO Turnos (IdPaciente, IdEspecialidadXMedico, IdEstado, IdTipoTurno, Fecha, Observaciones, EsSobreTurno) VALUES
(1, 3, 3, 1, '2024-10-08 15:00:00', 'Control lunar.', 0),
(3, 3, 3, 1, '2024-10-08 15:30:00', 'Erupción.', 0),
(5, 3, 3, 1, '2024-10-08 16:00:00', 'OK.', 0),
(7, 3, 3, 1, '2024-10-15 15:00:00', 'Control.', 0),
(9, 3, 3, 1, '2024-10-15 15:30:00', 'OK.', 0),
(11, 3, 3, 1, '2024-10-15 16:00:00', 'Verrugas.', 0),
(13, 3, 3, 1, '2024-10-22 15:00:00', 'OK.', 0),
(15, 3, 2, 1, '2024-10-22 15:30:00', 'Cancela.', 0),
(17, 3, 3, 1, '2024-10-22 16:00:00', 'OK.', 0),
(19, 3, 1, 1, GETDATE() + 8, 'Turno futuro.', 0); -- Futuro

INSERT INTO Turnos (IdPaciente, IdEspecialidadXMedico, IdEstado, IdTipoTurno, Fecha, Observaciones, EsSobreTurno) VALUES
(2, 4, 3, 1, '2024-10-09 10:00:00', 'Dolor rodilla.', 0),
(4, 4, 3, 1, '2024-10-09 10:30:00', 'Control post-yeso.', 0),
(6, 4, 3, 1, '2024-10-09 11:00:00', 'Tobillo.', 0),
(8, 4, 3, 1, '2024-10-16 10:00:00', 'Placa.', 0),
(10, 4, 3, 1, '2024-10-16 10:30:00', 'OK.', 0),
(12, 4, 2, 1, '2024-10-16 11:00:00', 'Cancela.', 0),
(14, 4, 3, 1, '2024-10-23 10:00:00', 'Muñeca.', 0),
(16, 4, 2, 1, '2024-10-23 10:30:00', 'Cancela.', 0),
(18, 4, 3, 1, '2024-10-23 11:00:00', 'OK.', 0);
GO

-- (IDs de Pacientes van del 1 al 20)
-- (IDs de EspecialidadXMedico van del 1 al 10)

INSERT INTO HistoriasClinicas (Fecha, IdPaciente, IdEspecialidadXMedico, Descripcion) VALUES
('2024-10-07 09:00:00', 1, 1, 'Paciente estable. Control de presión arterial OK. Se mantiene medicación.'),
('2024-10-07 09:30:00', 2, 1, 'Refiere dolor de pecho post-esfuerzo. Se solicita electrocardiograma y análisis.'),
('2024-10-07 10:30:00', 4, 1, 'Revisión de estudios. Todo en orden.'),
('2024-10-14 09:00:00', 5, 1, 'Electrocardiograma realizado. Sin anomalías.'),
('2024-10-14 09:30:00', 6, 1, 'Paciente hipertenso. Se ajusta dosis de medicación.'),
('2024-10-14 10:00:00', 7, 1, 'Control de rutina. Paciente asintomático.'),
('2024-10-21 09:00:00', 9, 1, 'Paciente presenta arritmia leve. Se deriva a estudio Holter.'),
('2024-10-08 08:00:00', 11, 2, 'Chequeo general anual. Sin particularidades.'),
('2024-10-08 08:30:00', 12, 2, 'Paciente con gripe. Se indica reposo y paracetamol.'),
('2024-10-08 09:00:00', 13, 2, 'Dolor de garganta. Faringitis. Se receta antibiótico.'),
('2024-10-15 08:00:00', 14, 2, 'Apto físico completado. Sin observaciones.'),
('2024-10-15 08:30:00', 15, 2, 'Control de diabetes. Glucosa estable.'),
('2024-10-22 08:00:00', 17, 2, 'Paciente refiere estrés laboral. Se recomienda reposo.'),
('2024-10-22 08:30:00', 18, 2, 'Revisión de análisis de sangre. Colesterol alto.'),
('2024-10-22 09:00:00', 19, 2, 'Consulta por mareos. Se deriva a neurología.'),
('2024-10-08 15:00:00', 1, 3, 'Control de lunar en espalda. Sin cambios.'),
('2024-10-08 15:30:00', 3, 3, 'Presenta erupción cutánea en brazos. Posible alergia. Se indica crema tópica.'),
('2024-10-08 16:00:00', 5, 3, 'Acné leve. Se indica tratamiento de limpieza facial.'),
('2024-10-15 15:00:00', 7, 3, 'Revisión de verruga. Se programa criocirugía.'),
('2024-10-15 15:30:00', 9, 3, 'Dermatitis atópica. Se refuerza tratamiento.'),
('2024-10-15 16:00:00', 11, 3, 'Paciente consulta por caída de cabello.'),
('2024-10-22 15:00:00', 13, 3, 'Quemadura solar leve. Se indica hidratación.'),
('2024-10-22 16:00:00', 17, 3, 'Urticaria. Se receta antihistamínico.'),
('2024-10-09 10:00:00', 2, 4, 'Dolor en rodilla derecha. Se sospecha esguince. Reposo.'),
('2024-10-09 10:30:00', 4, 4, 'Control post-yeso. Fractura consolidada. Inicia kinesiología.'),
('2024-10-09 11:00:00', 6, 4, 'Torcedura de tobillo. Se venda y se indica antiinflamatorio.'),
('2024-10-16 10:00:00', 8, 4, 'Revisión de radiografía de muñeca. Sin fractura.'),
('2024-10-16 10:30:00', 10, 4, 'Control de hombro. Movilidad reducida.'),
('2024-10-23 10:00:00', 14, 4, 'Dolor lumbar (lumbalgia). Se indica reposo y calor.'),
('2024-10-23 11:00:00', 18, 4, 'Paciente derivado por Clínica Médica. OK.'),
('2024-10-10 09:00:00', 19, 5, 'Control pediátrico 2 años. Desarrollo normal.'),
('2024-10-10 09:30:00', 20, 5, 'Calendario de vacunas completo.'),
('2024-10-10 10:00:00', 12, 5, 'Niño con fiebre alta. Otitis. Se receta antibiótico.'),
('2024-10-17 09:00:00', 14, 5, 'Control de peso y talla. OK.'),
('2024-10-17 09:30:00', 16, 5, 'Anginas. Se indica reposo.'),
('2024-10-17 10:00:00', 18, 5, 'Paciente con tos y mocos. Bronquiolitis leve.'),
('2024-10-24 09:00:00', 19, 5, 'Control. OK.'),
('2024-10-24 10:00:00', 12, 5, 'Revisión de otitis. Paciente recuperado.'),
('2024-10-11 08:00:00', 1, 7, 'Control cardiológico. OK.'),
('2024-10-11 08:30:00', 3, 7, 'Presión arterial normal.'),
('2024-10-11 09:00:00', 5, 7, 'Revisión pre-quirúrgica. Apto.'),
('2024-10-18 08:00:00', 7, 7, 'OK.'),
('2024-10-18 08:30:00', 9, 7, 'OK.'),
('2024-10-18 09:00:00', 11, 7, 'OK.'),
('2024-10-25 08:30:00', 15, 7, 'OK.'),
('2024-10-25 09:00:00', 17, 7, 'OK.'),
('2024-10-11 15:00:00', 2, 10, 'Colocación de yeso por fisura en muñeca.'),
('2024-10-11 15:30:00', 4, 10, 'Revisión de placa. OK.'),
('2024-10-11 16:00:00', 6, 10, 'OK.'),
('2024-10-18 15:00:00', 8, 10, 'OK.'),
('2024-10-18 15:30:00', 10, 10, 'OK.'),
('2024-10-18 16:00:00', 12, 10, 'OK.'),
('2024-10-25 15:00:00', 14, 10, 'OK.'),
('2024-10-25 16:00:00', 18, 10, 'OK.');
GO

