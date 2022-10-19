CREATE DATABASE school_register;
USE school_register;

CREATE TABLE student (
	id INT IDENTITY(1,1) PRIMARY KEY,
	name NVARCHAR(30) NOT NULL,
	surname NVARCHAR(30) NOT NULL,
);

CREATE TABLE teacher (
	id INT IDENTITY(1,1) PRIMARY KEY,
	name NVARCHAR(30) NOT NULL,
	surname NVARCHAR(30) NOT NULL,
);

CREATE TABLE subject (
	id INT IDENTITY(1,1) PRIMARY KEY,
	description NVARCHAR(40) NOT NULL,
);

CREATE TABLE class (
	id INT IDENTITY(1,1) PRIMARY KEY,
	class_year INT NOT NULL,
	class_section NVARCHAR(1) NOT NULL,
);

CREATE TABLE class_student (
	id_class INT FOREIGN KEY REFERENCES class(id), /* Le chiavi esterne garantiscono l'integrità referenziale */
	id_student INT FOREIGN KEY REFERENCES student(id), 
	CONSTRAINT pk_student_class PRIMARY KEY(id_class, id_student), 
);

CREATE TABLE teacher_class_subject (
	id_teacher INT FOREIGN KEY REFERENCES teacher(id), 
	id_class INT FOREIGN KEY REFERENCES class(id), 
	id_subject INT FOREIGN KEY REFERENCES subject(id),
	CONSTRAINT pk_s_c_t PRIMARY KEY(id_teacher, id_class, id_subject),
);
