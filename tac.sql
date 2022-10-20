CREATE DATABASE taccuino;
USE taccuino;

CREATE TABLE taccuino_voti (
	data_voto DATE,
	matricola_registro INT,
	nome NVARCHAR(30),
	cognome NVARCHAR(30),
	materia NVARCHAR(20),
	voto DECIMAL,
	nome_docente NVARCHAR(30),
	cognome_docente NVARCHAR(30),
	classe NVARCHAR(1),
	sezione NVARCHAR(1),
	note NVARCHAR(40)
);

CREATE TABLE class (
	id INT IDENTITY(1,1) PRIMARY KEY,
	year_class NVARCHAR(1) NOT NULL,
	year_section NVARCHAR(1) NOT NULL,
);

INSERT INTO class(year_class, year_section)
SELECT DISTINCT classe, sezione
FROM taccuino_voti;

CREATE TABLE student (
	id INT PRIMARY KEY,
	name NVARCHAR(30) NOT NULL,
	surname NVARCHAR(30) NOT NULL,
	class INT FOREIGN KEY REFERENCES class(id),
);

INSERT INTO student (id, name, surname, class)
SELECT DISTINCT tv.matricola_registro, tv.nome, tv.cognome, c.id 
FROM taccuino_voti tv 
LEFT JOIN class c ON tv.classe  = c.year_class AND tv.sezione = c.year_section;  

CREATE TABLE subject (
	id INT IDENTITY(1,1) PRIMARY KEY,
	description NVARCHAR(30) NOT NULL,
);

INSERT INTO subject (description)
SELECT DISTINCT materia
FROM taccuino_voti;

CREATE TABLE teacher (
	id INT IDENTITY(1,1) PRIMARY KEY,
	name NVARCHAR(30) NOT NULL,
	surname NVARCHAR(30) NOT NULL,
);

INSERT INTO teacher (name, surname)
SELECT DISTINCT nome_docente, cognome_docente
FROM taccuino_voti;

CREATE TABLE mark(
	id INT IDENTITY(1,1) PRIMARY KEY,
	mark_date DATE NOT NULL,
	id_student INT FOREIGN KEY REFERENCES student(id),
	id_subject INT FOREIGN KEY REFERENCES subject(id),
	mark DECIMAL NOT NULL,
	id_teacher INT FOREIGN KEY REFERENCES teacher(id),
	note NVARCHAR(40),
);

INSERT INTO mark(mark_date, id_student, id_subject, mark, id_teacher, note)
SELECT tv.data_voto, s.id, sj.id, tv.voto, t.id, tv.note 
FROM taccuino_voti tv
LEFT JOIN student s ON s.id = tv.matricola_registro 
LEFT JOIN subject sj ON tv.materia = sj.description 
LEFT JOIN teacher t ON t.name = tv.nome_docente AND t.surname = tv.cognome_docente; 

SELECT m.mark_date AS 'Data', s.id AS 'Matricola Registro' ,s.name AS 'Nome', s.surname AS 'Cognome', sj.description AS 'Materia', m.mark AS 'Voto', t.name AS 'Nome Docente', t.surname AS 'Cognome Docente', c.year_class AS 'Classe', c.year_section AS 'Section', m.note AS 'Note'
FROM mark m 
LEFT JOIN student s ON m.id_student = s.id 
LEFT JOIN subject sj ON sj.id = m.id_subject 
LEFT JOIN teacher t ON t.id = m.id_teacher
LEFT JOIN class c ON c.id = s.class;
