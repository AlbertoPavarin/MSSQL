CREATE DATABASE campionato;

USE campionato;

CREATE TABLE society(
	id INT PRIMARY KEY,
	description NVARCHAR(20) NOT NULL,
);

CREATE TABLE person_role(
	id INT IDENTITY(1,1) PRIMARY KEY,
	description NVARCHAR(20) NOT NULL,
);

CREATE TABLE person(
	id INT PRIMARY KEY,
	name NVARCHAR (40) NOT NULL,
	surname NVARCHAR(40) NOT NULL,
	id_role INT FOREIGN KEY REFERENCES person_role(id),
	id_society INT FOREIGN KEY REFERENCES society(id),
);