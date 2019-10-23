CREATE DATABASE Hospital
USE Hospital

--!!!! CREATE THE 3 TABLES
CREATE TABLE Doctor
(
Doctor_id int IDENTITY (1,1),
DoctorName varchar(60) not null,
Specialization varchar(70) not null
CONSTRAINT PK_Doctor Primary Key(Doctor_id)
)

SELECT * FROM Doctor

CREATE TABLE Patient
(
Patient_id int IDENTITY (1,1),
PatientName varchar(60) not null,
Address varchar(70) not null,
CONSTRAINT PK_Patient Primary Key(Patient_id)
)

SELECT * FROM Patient

CREATE TABLE Schedule
(
Doctor_id int not null,
Patient_id int not null,
Hour datetime not null, 
CONSTRAINT PK_Schedule PRIMARY KEY (Doctor_id,Patient_id),
CONSTRAINT FK_Schedule_Doctor FOREIGN KEY (Doctor_id) REFERENCES Doctor(Doctor_id),
CONSTRAINT FK_Schedule_Patient FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id) 
)

SELECT * FROM Schedule

--!!! ADD COLUM ADDRESS IN TABLE DOCTOR
ALTER TABLE Doctor
	ADD Address varchar(60) null

--!!! ISNERT VALEUS INTO TABLES
INSERT INTO Doctor(Doctor_id, DoctorName,Specialization)
 VALUES (123,'Ivan Dragunov', 'Cardiosurgery')

 INSERT INTO Doctor(Doctor_id, DoctorName,Specialization,Address)
 VALUES (124,'Iliyana Kalashnikova', 'Orthopedics','Skopie 206 Str')

 INSERT INTO Doctor(Doctor_id, DoctorName,Specialization,Address)
 VALUES (125,'Stoyan Granatov', 'General Practitioner','Gladstone 34 Str')

 DELETE FROM Doctor
	WHERE Doctor_id = 125

SELECT * FROM Patient

INSERT INTO Patient(Patient_id, PatientName, Address)
 VALUES (001,'Peter Parker','Hristo Botev 88 Str')

INSERT INTO Patient(Patient_id, PatientName, Address)
 VALUES (002,'John Smith','Vasil Levski 37 Str')

INSERT INTO Patient(Patient_id, PatientName, Address)
 VALUES (003,'Jane Doe','Ivan Vazov 55 Str')

SELECT * FROM Doctor

INSERT INTO Schedule (Doctor_id,Patient_id)
 VALUES (123,002)

 INSERT INTO Schedule (Doctor_id,Patient_id,Hour)
 VALUES (124,001, '2019-03-15')

 INSERT INTO Schedule (Doctor_id,Patient_id,Hour)
 VALUES (125,003, '2019-04-01')

 --!!! CHANGE DOCTOR INFO WHERE ID = 123
 UPDATE Doctor 
  SET DoctorName = 'Dimitar Dragunov', Address = 'Tzar Boris 57 Blvd'
  WHERE Doctor_id = 123

  --!!! DELETE DOCTOR WITH NAME STARTING WITH 'I'
  SELECT * FROM Schedule

 DELETE FROM Schedule
   WHERE Doctor_id = 124

DELETE FROM Doctor
	WHERE DoctorName LIKE 'I%'

SELECT * FROM Doctor
--!!! END OF TASK ONE

--!!! START OF TASK TWO

--!!! Select by name different surgeons
INSERT INTO Doctor(Doctor_id, DoctorName,Specialization)
 VALUES (126,'Martin Markov', 'Brainsurgery')

INSERT INTO Doctor(Doctor_id, DoctorName,Specialization)
 VALUES (127,'Zlatan Popovich', 'Neurosurgery')

 INSERT INTO Doctor(Doctor_id, DoctorName,Specialization)
 VALUES (128,'Ronaldo Georgiev', 'Ortopepedcics')

SELECT DoctorName FROM Doctor
 WHERE Specialization LIKE '%surgery'
 ORDER BY DoctorName DESC

 --!!! SELECT PATIENTS AND RESERVED HOURS
 INSERT INTO Patient(Patient_id, PatientName, Address)
 VALUES (004,'Giovanni Petrelli','Tzar Simeon 14 Str')

 INSERT INTO Patient(Patient_id, PatientName, Address)
 VALUES (005,'Mike Wazovski','Strahil 44 Str')

 SELECT PatientName, Hour
 FROM Patient LEFT JOIN Schedule on Patient.Patient_id = Schedule.Patient_id
 
 --!!! Select Name of Patient and number of reserved hours
 DROP TABLE Schedule

 INSERT INTO Schedule (Doctor_id,Patient_id,Hour)
 VALUES (126,003, '2019-04-04')

 INSERT INTO Schedule (Doctor_id,Patient_id,Hour)
 VALUES (127,003, '2019-04-05')

 INSERT INTO Schedule (Doctor_id,Patient_id,Hour)
 VALUES (123,003, '2019-04-06')

 INSERT INTO Schedule (Doctor_id,Patient_id,Hour)
 VALUES (128,003, '2019-04-07')

 SELECT * FROM Schedule

 SELECT PatientName, COUNT(Schedule.Hour)
 FROM Patient LEFT JOIN Schedule ON Patient.Patient_id = Schedule.Patient_id
 GROUP BY PatientName
 HAVING COUNT(Schedule.Hour)>=5

--!!! END OF TASK TWO

--!!! START OF TASK THREE
CREATE VIEW FinishedExamination
AS
 SELECT Doctor.DoctorName, COUNT(Schedule.Hour) as Finished_Examinations
 FROM Doctor LEFT JOIN Schedule ON Doctor.Doctor_id = Schedule.Doctor_id
 WHERE Schedule.Hour > 2019-03-10
 GROUP BY Doctor.DoctorName

 ALTER VIEW FinishedExamination
 AS
  SELECT Doctor.DoctorName, COUNT(Schedule.Hour) as Finished_Examinations
  FROM Doctor LEFT JOIN Schedule ON Doctor.Doctor_id = Schedule.Doctor_id
  GROUP BY Doctor.DoctorName

 SELECT * FROM FinishedExamination
 SELECT * FROM Schedule
 SELECT * FROM Doctor
 SELECT * FROM Patient