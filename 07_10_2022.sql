CREATE DATABASE registro;
USE registro;

CREATE TABLE taccuino(
	data_voto date,
	id INT NOT NULL,
	nome NVARCHAR(20) NOT NULL,
	cognome NVARCHAR(20) NOT NULL,
	materia NVARCHAR(20) NOT NULL,
	voto DECIMAL NOT NULL,
	nome_doc NVARCHAR(25) NOT NULL,
	cognome_doc NVARCHAR(25) NOT NULL,
	classe SMALLINT NOT NULL,
	sezione NVARCHAR(1) NOT NULL,
	note NVARCHAR(100),
);

CREATE TABLE students(
	id INT PRIMARY KEY,
	name NVARCHAR(20) NOT NULL,
	surname NVARCHAR(20) NOT NULL,
);

ALTER TABLE students 
ADD class SMALLINT, sezione NVARCHAR(1);

CREATE TABLE subjects(
	id INT IDENTITY(1,1) PRIMARY KEY,
	subject_name NVARCHAR(15) NOT NULL,
);

CREATE TABLE teachers(
	id INT IDENTITY(1,1) PRIMARY KEY,
	name NVARCHAR(25) NOT NULL,
	surname NVARCHAR(25) NOT NULL,
);

INSERT INTO students (id, name, surname)
SELECT DISTINCT id, nome, cognome 
FROM taccuino;

UPDATE s 	
SET 
s.class = t.classe,
s.sezione = t.sezione
FROM students s LEFT JOIN taccuino t 
ON s.id = t.id;

INSERT INTO subjects(subject_name)
SELECT DISTINCT materia
FROM taccuino;

INSERT INTO teachers (name, surname)
SELECT DISTINCT nome_doc, cognome_doc
FROM taccuino;

CREATE TABLE marks (
	id INT IDENTITY(1,1) PRIMARY KEY,
	mark_date date NOT NULL,
	mark SMALLINT NOT NULL,
	id_student INT NOT NULL, 
	subject NVARCHAR(25) NOT NULL,
	teacher_n NVARCHAR(25) NOT NULL,
	teacher_s NVARCHAR(25) NOT NULL,
);

ALTER TABLE marks 
ALTER COLUMN mark DECIMAL;

INSERT INTO marks (mark_date, mark, id_student, subject, teacher_n, teacher_s)
SELECT data_voto, voto, id, materia, nome_doc, cognome_doc
FROM taccuino;

ALTER TABLE marks 
ADD id_teacher INT, id_subject INT;

ALTER TABLE marks 
ADD notes NVARCHAR(100);

UPDATE m
SET	
	m.id_teacher = t.id,
	m.id_subject = s.id 
FROM marks m LEFT JOIN teachers t 
ON m.teacher_n = t.name AND m.teacher_s = t.surname
LEFT JOIN subjects s 
ON m.subject = s.subject_name;

UPDATE m
SET	
	m.notes = t.note
FROM marks m LEFT JOIN taccuino t 
ON m.mark_date  = t.data_voto;

ALTER TABLE marks  
DROP COLUMN teacher_n, teacher_s, subject;


SELECT m.mark_date AS 'Data', s.id AS 'Matricola', s.name AS 'Nome', s.surname AS 'Cognome', sj.subject_name AS 'Materia', m.mark AS 'Voto', t.name AS 'Nome Decente', t.surname AS 'Cognome Docente', s.class AS 'Classe', s.sezione AS 'Sezione', M.notes AS 'Note' 
FROM marks m 
LEFT JOIN students s ON m.id_student = s.id
LEFT JOIN teachers t ON m.id_teacher = t.id
LEFT JOIN subjects sj ON m.id_subject = sj.id; 

