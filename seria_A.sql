CREATE DATABASE campionato;

USE campionato;

CREATE TABLE seria_a (
	id_atleta INT,
	nome NVARCHAR(30),
	squadra NVARCHAR(30),
	id_squadra INT,	
);

CREATE TABLE stipendi (
	id_atleta INT,
	mese NVARCHAR(15),
	anno INT,
	stipendio INT,
);

CREATE TABLE atleta (
	id INT PRIMARY KEY,
	nome NVARCHAR(30) NOT NULL,
);

INSERT INTO atleta (id, nome)
SELECT id_atleta, nome
FROM seria_a;

CREATE TABLE squadra (
	id INT PRIMARY KEY,
	nome NVARCHAR(30) NOT NULL,
);

INSERT INTO squadra (id, nome)
SELECT DISTINCT id_squadra, squadra
FROM seria_a; 

CREATE TABLE tesseramento (
	id_atleta INT FOREIGN KEY REFERENCES atleta(id),
	id_squadra INT FOREIGN KEY REFERENCES squadra(id),
);


INSERT INTO tesseramento (id_atleta, id_squadra)
SELECT id_atleta, id_squadra
FROM seria_a;


CREATE TABLE stipendio (
	id_atleta INT FOREIGN KEY REFERENCES atleta(id),
	mese NVARCHAR(15) NOT NULL,
	anno INT NOT NULL,
	stipendio INT NOT NULL,
);

ALTER TABLE stipendio 
ADD id INT IDENTITY(1,1) PRIMARY KEY;

INSERT INTO stipendio (id_atleta, mese, anno, stipendio)
SELECT id_atleta, mese, anno, stipendio
FROM stipendi;


-- ordine alfabetico
SELECT *
FROM atleta a ORDER BY(a.nome);

-- squadre
SELECT *
FROM squadra s ORDER BY(s.nome);

--unione atleti e squadre attraverso tesseramento 
SELECT *
FROM tesseramento t 
INNER JOIN squadra s ON s.id = t.id_squadra 
INNER JOIN atleta a ON a.id = t.id_atleta;


--unione atleti e squadre attraverso tesseramento con selezione verticale
SELECT a.nome, s.nome 
FROM tesseramento t 
INNER JOIN squadra s ON s.id = t.id_squadra 
INNER JOIN atleta a ON a.id = t.id_atleta;

-- quanti calciatori per squadra
SELECT s.nome, COUNT(s.nome) 
FROM tesseramento t 
INNER JOIN squadra s ON s.id = t.id_squadra 
INNER JOIN atleta a ON a.id = t.id_atleta
GROUP BY(s.nome)
ORDER BY COUNT(s.nome);

-- stipendio totale versato dalla società per i proprio atleti
SELECT s.nome, SUM(st.stipendio) AS 'Stipendio totale', AVG(st.stipendio) AS 'Stipendio medio'
FROM tesseramento t 
INNER JOIN squadra s ON s.id = t.id_squadra 
INNER JOIN stipendio st ON st.id_atleta = t.id_atleta 
GROUP BY(s.nome)
ORDER BY COUNT(s.nome);