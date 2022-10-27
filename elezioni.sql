CREATE DATABASE elezioni;
USE elezioni;

CREATE TABLE anagrafic (
	id INT IDENTITY(1,1) PRIMARY KEY,
	name NVARCHAR(30) NOT NULL,
	surname NVARCHAR(30) NOT NULL,
);

CREATE TABLE electoral_card (
	id INT IDENTITY(1,1) PRIMARY KEY,
	id_anagrafic INT FOREIGN KEY REFERENCES anagrafic(id),
);

CREATE TABLE register (
	id INT IDENTITY(1,1) PRIMARY KEY,
);

CREATE TABLE card (
	id_scheda INT IDENTITY(1,1) PRIMARY KEY,
);

CREATE TABLE electoral_site (
	id INT IDENTITY(1,1) PRIMARY KEY,
);

ALTER TABLE register
ADD id_site INT FOREIGN KEY REFERENCES electoral_site(id);

ALTER TABLE anagrafic 
ADD id_site INT FOREIGN KEY REFERENCES electoral_site(id);

ALTER TABLE card 
ADD id_site INT FOREIGN KEY REFERENCES electoral_site(id);